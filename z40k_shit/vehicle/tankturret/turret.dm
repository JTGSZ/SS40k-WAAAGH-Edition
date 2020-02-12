#define STATUS_REMOVE 1
#define STATUS_ADD 2

//The turrets another object, ayep.
/obj/groundturret
	name = "\improper groundturret"
	desc = "A turret attached to a tank."
	icon = 'z40k_shit/icons/lemanruss.dmi'
	icon_state = "turret"
	density = 0 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	lockflags = NO_DIR_FOLLOW
	var/hatch_open = 0
	var/list/occupants = list()
	var/list/actions_types = list()
	var/list/actions_types_pilot = list() //Actions to create when a pilot boards, deleted upon leaving
	var/list/actions = list()
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/health = 400
	var/maxHealth = 400
	var/movement_delay = 2
	
	var/obj/item/device/vehicle_equipment/weaponry/selected //The selected Weapon
	var/weapon_toggle = FALSE //Do we have a weapon toggled?
	var/list/attached_equipment = list()

/obj/groundturret/New()
	. = ..()
	bound_width = 2*WORLD_ICON_SIZE
	bound_height = 2*WORLD_ICON_SIZE

	for(var/path in actions_types)
		var/datum/action/A = new path(src)
		actions.Add(A)

/obj/groundturret/Destroy()
	. = ..()
	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()
	if(actions.len)
		for(var/datum/action/A in actions)
			actions.Remove(A)
			qdel(A)

/obj/groundturret/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != get_pilot()) //If user is not pilot return false
		return 0 //Stop hogging the wheel!
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false. Delay
		return 0

	set_glide_size(DELAY2GLIDESIZE(movement_delay))
	switch(direction)
		if(NORTH)
			return 0
		if(SOUTH)
			return 0	
		if(EAST)
			src.dir = turn(src.dir, -90) //Technically its reversed too
		if(WEST)
			src.dir = turn(src.dir, 90) //Tank controls

	move_delayer.delayNext(round(3,world.tick_lag)) //Delay

/obj/groundturret/proc/adjust_health(var/damage)
	var/oldhealth = health
	health = clamp(health-damage,0, maxHealth)
	var/percentage = (health / initial(health)) * 100
	var/mob/pilot = get_pilot()
	if(pilot && oldhealth > health && percentage <= 25 && percentage > 0)
		pilot.playsound_local(pilot, 'sound/effects/engine_alert2.ogg', 50, 0, 0, 0, 0)
	if(pilot && oldhealth > health && !health)
		var/mob/living/L = pilot
		L.playsound_local(L, 'sound/effects/engine_alert1.ogg', 50, 0, 0, 0, 0)
	if(health <= 0)
		spawn(0)
			var/mob/living/L = get_pilot()
			if(L)

				to_chat(L, "<big><span class='warning'>Critical damage to the vessel detected, core explosion imminent!</span></big>")
			for(var/i = 10, i >= 0; --i)
				if(L)
					to_chat(L, "<span class='warning'>[i]</span>")
				if(i == 0)
					explosion(loc, 2, 4, 8)
				sleep(10)

	update_icons()

/obj/groundturret/proc/update_icons()

/obj/groundturret/attackby(obj/item/W, mob/user)
	if(iscrowbar(W))
		hatch_open = !hatch_open
		to_chat(user, "<span class='notice'>You [hatch_open ? "open" : "close"] the maintenance hatch.</span>")
		return
	if(health < maxHealth && iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.do_weld(user, src, 30, 5))
			to_chat(user, "<span class='notice'>You patch up \the [src].</span>")
			adjust_health(-rand(15,30))
			return
	if(istype(W, /obj/item/device/vehicle_equipment))
		var/obj/item/device/vehicle_equipment/VE = W
		if(!hatch_open)
			return ..()
		if(istype(W, /obj/item/device/vehicle_equipment/weaponry))
			if(user.drop_item(W, src))
				to_chat(user, "<span class='notice'>You insert \the [W] into the equipment system.</span>")
				attached_equipment += W
				actions_types_pilot += VE.tied_action
				
				var/pilot = get_pilot()
				if(pilot)
					refresh_actions(pilot)
				
				return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)

/obj/groundturret/attack_hand(mob/user as mob)

	if(!hatch_open)
		return ..()
	if(!attached_equipment.len)
		to_chat(user, "<span class='warning'>The [src] has no vehicle parts in it, and the hatch is open.</span>")
		return
	
	var/PEEPEE = input(user,"Remove which equipment?", "", "Cancel") as null|anything in attached_equipment
	if(PEEPEE != "Cancel")
		var/obj/item/device/vehicle_equipment/SCREE = PEEPEE
		if(user.put_in_any_hand_if_possible(SCREE))
			to_chat(user, "<span class='notice'>You remove \the [SCREE] from the equipment system, and turn any systems off.</span>")
			if(SCREE.tied_action)
				weapon_toggle = FALSE
				actions_types_pilot -= SCREE.tied_action
				
				var/pilot = get_pilot()
				if(pilot)
					refresh_actions(pilot)
		else
			to_chat(user, "<span class='warning'>You need an open hand to do that.</span>")

/obj/groundturret/verb/attempt_move_inside()
	set category = "groundturret"
	set name = "Enter / Exit Turret"
	set src in oview(1)

	if(occupants.Find(usr))
		move_outside(usr, get_turf(src))
		return

	if(usr.incapacitated() || usr.lying) //are you cuffed, dying, lying, stunned or other
		return
	if (!ishigherbeing(usr))
		return

	visible_message("<span class='notice'>[usr] starts to climb into \the [src].</span>")

	if(do_after(usr, src, 4 SECONDS))
		if(!get_pilot())
			move_into_vehicle(usr)
		else
			to_chat(usr, "<span class = 'warning'>Not enough room inside \the [src].</span>")
	else
		to_chat(usr, "You stop entering \the [src].")
	return

/obj/groundturret/proc/move_into_vehicle(var/mob/living/L)
	if(L && L.client && L in range(1))
		L.reset_view(src)
		L.stop_pulling()
		L.forceMove(src)
		adjust_occupants(L, STATUS_ADD)
		return 1
	return 0

/obj/groundturret/proc/adjust_occupants(var/mob/user, var/status)
	if(status == STATUS_REMOVE)
		var/pilot = get_pilot()
		if(user == pilot) //They're the pilot
			for(var/datum/action/S in actions)
				if(istype (S, /datum/action/groundturret/pilot)) //Keep these
					S.Remove(user)
				else if(S.owner == user) //Remove these
					qdel(S)
					actions.Remove(S)
		else //They're a passenger
			for(var/datum/action/groundturret/S in actions)
				if(S.owner == user) //Remove these
					qdel(S)
					actions.Remove(S)
		occupants.Remove(user)
		if(get_pilot() && pilot != get_pilot()) //NEW PILOT
			var/mob/living/new_pilot = get_pilot()
			if(!new_pilot)
				return
			to_chat(new_pilot, "<span class = 'notice'>You are now the gunner of \the [src].</span>")
			for(var/datum/action/groundturret/S in actions)
				if(S.owner == new_pilot) //Remove these
					qdel(S)
					actions.Remove(S)
			for(var/datum/action/groundturret/pilot/P in actions)
				P.Grant(new_pilot)
			for(var/path in actions_types_pilot)
				var/datum/action/A = new path(src)
				actions.Add(A)
				A.Grant(new_pilot)
	else if(status == STATUS_ADD)
		occupants.Add(user)
		if(user == get_pilot()) //They're the new pilot
			for(var/datum/action/groundturret/pilot/P in actions)
				P.Grant(user)
			for(var/path in actions_types_pilot)
				var/datum/action/A = new path(src)
				actions.Add(A)
				A.Grant(user)

/obj/groundturret/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/obj/groundturret/proc/refresh_actions(var/mob/occupant)
	adjust_occupants(occupant, STATUS_REMOVE)
	
	sleep(1)
	
	adjust_occupants(occupant, STATUS_ADD)

/obj/groundturret/proc/move_outside(var/mob/occupant, var/turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	adjust_occupants(occupant, STATUS_REMOVE)
	occupant.forceMove(exit_turf)

#undef STATUS_REMOVE
#undef STATUS_ADD
