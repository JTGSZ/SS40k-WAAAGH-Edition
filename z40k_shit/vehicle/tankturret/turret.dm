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
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/health = 400
	var/maxHealth = 400
	var/movement_delay = 2
	var/list/chassis_actions = list() //These are actions innate to the object.
	var/datum/comvehicle/equipment/ES //Our equipment controller.

/obj/groundturret/New()
	. = ..()
	bound_width = 2*WORLD_ICON_SIZE
	bound_height = 2*WORLD_ICON_SIZE

	ES = new(src) //New equipment system in US

/obj/groundturret/Destroy()
	. = ..()

	qdel(ES) //We qdel it i guess

	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()

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
		if(!hatch_open)
			return ..()
		if(istype(W, /obj/item/device/vehicle_equipment/weaponry))
			if(user.drop_item(W, src))
				to_chat(user, "<span class='notice'>You insert the [W] into [src].</span>")
				ES.make_it_end(src, W, TRUE)
				return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)

/obj/groundturret/attack_hand(mob/user as mob)

	if(!hatch_open)
		return ..()
	if(!ES.equipment_systems.len)
		to_chat(user, "<span class='warning'>The [src] has no vehicle parts in it, and the hatch is open.</span>")
		return
	
	var/PEEPEE = input(user,"Remove which equipment?", "", "Cancel") as null|anything in ES.equipment_systems
	if(PEEPEE != "Cancel")
		var/obj/item/device/vehicle_equipment/SCREE = PEEPEE
		if(user.put_in_any_hand_if_possible(SCREE))
			to_chat(user, "<span class='notice'>You remove \the [SCREE] from the equipment system, and turn any systems off.</span>")
			ES.make_it_end(src, SCREE, FALSE)
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

/obj/groundturret/proc/move_into_vehicle(var/mob/living/user)
	if(user && user.client && user in range(1))
		user.reset_view(src)
		user.stop_pulling()
		user.forceMove(src)
		tight_fuckable_dickhole(user, TRUE)
		return 1
	return 0

/obj/groundturret/proc/tight_fuckable_dickhole(var/mob/user, var/GIVIESorTAKIES)
	var/pilot = get_pilot()
	if(GIVIESorTAKIES) //GIVIES
		occupants.Add(user) //WE GIVIES OCCUPANTS the USER
		for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage) //Our datum action holder
			if(actions.pilot_only && get_pilot() != user) //IF THE ACTION IS PILOT ONLY AND USER IS NOT PILOT
				actions.Remove(user)
			actions.Grant(user) //We grant the user all the actions on ES.actions_storage
		for(var/datum/action/complex_vehicle_equipment/actions in chassis_actions)
			actions.Grant(user)

		if(get_pilot() && pilot != get_pilot()) //NEW PILOT - Occurs if someone gets out and theres a passenger
			var/mob/living/new_pilot = get_pilot()
			if(!new_pilot)
				return	
			
			to_chat(new_pilot, "<span class = 'notice'>You are now the driver of \the [src].</span>")
			for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage)
				actions.Grant(new_pilot)
			for(var/datum/action/complex_vehicle_equipment/actions in chassis_actions)
				actions.Grant(new_pilot)
	
	else //TAKIES
		occupants.Remove(user) //WE TAKIES the user OUT of OCCUPANTS
		for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage)
			actions.Remove(user) //They just left we take ALL the shit.
		for(var/datum/action/complex_vehicle_equipment/actions in chassis_actions) //We take the chassis actions off too
			actions.Remove(user)

/obj/groundturret/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/obj/groundturret/proc/move_outside(var/mob/user, var/turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	tight_fuckable_dickhole(user, FALSE)
	user.forceMove(exit_turf)

#undef STATUS_REMOVE
#undef STATUS_ADD
