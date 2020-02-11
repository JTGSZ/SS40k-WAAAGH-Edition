// honk
#define DAMAGE			1
#define FIRE			2

#define GROUNDTANK_LIGHTS_CONSUMPTION 2 //battery consumption per second with lights on
#define GROUNDTANK_LIGHTS_RANGE_ON 8
#define GROUNDTANK_LIGHTS_RANGE_OFF 3 //one tile beyond the groundtank itself, "cockpit glow"

#define STATUS_REMOVE 1
#define STATUS_ADD 2

/obj/groundtank
	name = "\improper groundtank"
	desc = "A ground tank meant for ground travel."
	icon = 'z40k_shit/icons/lemanruss.dmi'
	density = 1 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	layer = ABOVE_DOOR_LAYER
	infra_luminosity = 15
	internal_gravity = 1 // Can move in 0-gravity
	var/passenger_limit = 1 //Upper limit for how many passengers are allowed
	var/passengers_allowed = 1 //If the pilot allows people to jump in the side seats.
	var/list/occupants = list()
	var/datum/groundtank/equipment/ES
	var/obj/item/weapon/cell/battery
	var/datum/global_iterator/pr_lights_battery_use //passive battery use for the lights
	var/hatch_open = 0
	var/next_firetime = 0
	var/list/tank_overlays
	var/health = 400
	var/maxHealth = 400
	var/lights_enabled = FALSE
	light_power = 2
	light_range = GROUNDTANK_LIGHTS_RANGE_OFF
	appearance_flags = LONG_GLIDE
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/obj/groundturret/GT

	var/engine_toggle = 0 //Whether the engine is on or off and our while loop is on.
	var/passenger_fire = 0 //Whether or not a passenger can fire weapons attached to this vehicle
	var/list/actions_types = list( //Actions to create and hold for the pilot
		/datum/action/groundtank/pilot/toggle_passengers,
		/datum/action/groundtank/pilot/toggle_passenger_weaponry,
		/datum/action/groundtank/pilot/toggle_lights,
		/datum/action/groundtank/pilot/toggle_engine,
		)
	var/list/actions_types_pilot = list(/datum/action/groundtank/fire_weapons) //Actions to create when a pilot boards, deleted upon leaving
	var/list/actions_types_passenger = list(/datum/action/groundtank/fire_weapons) //Actions to create when a passenger boards, deleted upon leaving
	var/list/actions = list()

/obj/groundtank/get_cell()
	return battery

/obj/groundtank/New()
	. = ..()
	if(!tank_overlays)
		tank_overlays = new/list(2)
		tank_overlays[DAMAGE] = image(icon, icon_state="chassis_damage")
		tank_overlays[FIRE] = image(icon, icon_state="chassis_fire")
	bound_width = 2*WORLD_ICON_SIZE
	bound_height = 2*WORLD_ICON_SIZE
	dir = EAST
	battery = new /obj/item/weapon/cell/high()
	pr_lights_battery_use = new /datum/global_iterator/vehicle_lights_use_charge(list(src))
	ES = new(src)
	for(var/path in actions_types)
		var/datum/action/A = new path(src)
		actions.Add(A)
	
	GT = new /obj/groundturret(src.loc)
	lock_atom(GT)

/obj/groundtank/Destroy()
	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()
	if(actions.len)
		for(var/datum/action/A in actions)
			actions.Remove(A)
			qdel(A)
	qdel(pr_lights_battery_use)
	pr_lights_battery_use = null
	qdel(ES)
	ES = null
	qdel(battery)
	battery = null
	qdel(tank_overlays[DAMAGE])
	qdel(tank_overlays[FIRE])
	tank_overlays = null
	qdel(GT)
	GT = null
	
	..()

/obj/groundtank/proc/update_icons()
	if(!tank_overlays)
		tank_overlays = new/list(2)
		tank_overlays[DAMAGE] = image(icon, icon_state="chassis_damage")
		tank_overlays[FIRE] = image(icon, icon_state="chassis_fire")

	if(health <= round(initial(health)/2))
		overlays += tank_overlays[DAMAGE]
		if(health <= round(initial(health)/4))
			overlays += tank_overlays[FIRE]
		else
			overlays -= tank_overlays[FIRE]
	else
		overlays -= tank_overlays[DAMAGE]

/obj/groundtank/bullet_act(var/obj/item/projectile/P)
	if(P.damage && !P.nodamage)
		adjust_health(P.damage)

/obj/groundtank/proc/adjust_health(var/damage)
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

/obj/groundtank/ex_act(severity)
	switch(severity)
		if(1)
			if(has_passengers())
				for(var/mob/living/L in get_passengers())
					move_outside(L, get_turf(src))
					L.ex_act(severity + 1)
					to_chat(L, "<span class='warning'>You are forcefully thrown from \the [src]!</span>")
			var/mob/living/carbon/human/H = get_pilot()
			if(H)
				move_outside(H, get_turf(src))
				H.ex_act(severity + 1)
				to_chat(H, "<span class='warning'>You are forcefully thrown from \the [src]!</span>")
			qdel(src)
		if(2)
			adjust_health(100)
		if(3)
			if(prob(40))
				adjust_health(50)

/obj/groundtank/attackby(obj/item/W, mob/user)
	if(iscrowbar(W))
		hatch_open = !hatch_open
		to_chat(user, "<span class='notice'>You [hatch_open ? "open" : "close"] the maintenance hatch.</span>")
		if(hatch_open && contents.len)
			var/anyitem = 0
			for(var/atom/movable/AM in contents)
				if(istype(AM,/obj/item))
					if(AM == battery)
						continue //don't eject this particular item!
					anyitem++
					AM.forceMove(get_turf(user))
			if(anyitem)
				visible_message("<span class='warning'>With a clatter, [anyitem > 1 ? "some items land" : "an item lands"] at the feet of [user].</span>")
		return
	if(health < maxHealth && iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.do_weld(user, src, 30, 5))
			to_chat(user, "<span class='notice'>You patch up \the [src].</span>")
			adjust_health(-rand(15,30))
			return

	if(istype(W, /obj/item/weapon/cell))
		if(!hatch_open)
			return ..()
		if(battery)
			to_chat(user, "<span class='notice'>The [src] already has a battery.</span>")
			return
		if(user.drop_item(W, src))
			battery = W
			return
	if(istype(W, /obj/item/device/groundtank_equipment))
		if(!hatch_open)
			return ..()
		if(!ES)
			to_chat(user, "<span class='warning'>The [src] has no equipment datum, yell at pomf</span>")
			return
		if(istype(W, /obj/item/device/groundtank_equipment/weaponry))
			if(!ES.weapons_allowed)
				to_chat(user, "<span class='notice'>The [src] model does not allow for weapons to be installed.</span>")
				return
			if(ES.weapon_system)
				to_chat(user, "<span class='notice'>The [src] already has a weapon system, remove it first.</span>")
				return
			else
				if(user.drop_item(W, src))
					to_chat(user, "<span class='notice'>You insert \the [W] into the equipment system.</span>")
					ES.weapon_system = W
					ES.weapon_system.my_atom = src
					return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)


/obj/groundtank/attack_hand(mob/user as mob)
	if(!hatch_open)
		return ..()
	if(!ES || !istype(ES))
		to_chat(user, "<span class='warning'>The [src] has no equipment datum, or is the wrong type, yell at pomf.</span>")
		return
	var/list/possible = list()
	if(battery)
		possible.Add("Energy Cell")
	if(ES.weapon_system)
		possible.Add("Weapon System")
	
	var/obj/item/device/groundtank_equipment/SPE
	switch(input(user, "Remove which equipment?", null, null) as null|anything in possible)
		if("Energy Cell")
			if(user.put_in_any_hand_if_possible(battery))
				to_chat(user, "<span class='notice'>You remove \the [battery] from the [src]</span>")
				battery = null
		if("Weapon System")
			SPE = ES.weapon_system
			if(user.put_in_any_hand_if_possible(SPE))
				to_chat(user, "<span class='notice'>You remove \the [SPE] from the equipment system.</span>")
				SPE.my_atom = null
				ES.weapon_system = null
				verbs -= typesof(/obj/item/device/groundtank_equipment/weaponry/proc)
			else
				to_chat(user, "<span class='warning'>You need an open hand to do that.</span>")

/obj/groundtank/MouseDropTo(mob/M, mob/user)
	if(M != user)
		return
	if(!Adjacent(M) || !Adjacent(user))
		return
	attempt_move_inside(M, user)

/obj/groundtank/MouseDropFrom(atom/over)
	if(!usr || !over)
		return
	if(!Adjacent(usr) || !Adjacent(over))
		return
	var/turf/T = get_turf(over)
	if(!occupants.Find(usr))
		var/mob/pilot = get_pilot()
		visible_message("<span class='notice'>[usr] start pulling [pilot.name] out of \the [src].</span>")
		if(do_after(usr, src, 4 SECONDS))
			move_outside(pilot, T)
		return
	if(!Adjacent(T) || T.density)
		return
	for(var/atom/movable/A in T.contents)
		if(A.density)
			if((A == src) || istype(A, /mob))
				continue
			return
	if(occupants.Find(usr))
		move_outside(usr,T)

/obj/groundtank/verb/attempt_move_inside()
	set category = "groundtank"
	set name = "Enter / Exit Vehicle"
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
		var/list/passengers = get_passengers()
		if(!get_pilot() || passengers.len < passenger_limit)
			move_into_vehicle(usr)
		else
			to_chat(usr, "<span class = 'warning'>Not enough room inside \the [src].</span>")
	else
		to_chat(usr, "You stop entering \the [src].")
	return

/datum/global_iterator/vehicle_lights_use_charge
	delay = 10

	process(var/obj/groundtank/groundtank)
		if(groundtank.battery && groundtank.lights_enabled)
			if(groundtank.battery.charge > 0)
				groundtank.battery.use(GROUNDTANK_LIGHTS_CONSUMPTION)
			else
				groundtank.toggle_lights()
		return

/obj/groundtank/proc/toggle_lights()
	if(lights_enabled)
		set_light(GROUNDTANK_LIGHTS_RANGE_OFF)
		to_chat(usr, "<span class='notice'>Lights disabled.</span>")
	else
		set_light(GROUNDTANK_LIGHTS_RANGE_ON)
		to_chat(usr, "<span class='notice'>Lights enabled.</span>")
	lights_enabled = !lights_enabled

/obj/groundtank/acidable()
	return 0

/obj/groundtank/proc/move_into_vehicle(var/mob/living/L)
	if(L && L.client && L in range(1))
		L.reset_view(src)
		L.stop_pulling()
		L.forceMove(src)
		adjust_occupants(L, STATUS_ADD)
		return 1
	return 0

/obj/groundtank/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/obj/groundtank/proc/get_maingunner()
	if(occupants.len)
		return occupants[2]
	return 0

/obj/groundtank/proc/has_passengers()
	if(occupants.len > 1)
		return occupants.len-1
	return 0

/obj/groundtank/proc/get_passengers()
	var/list/L = list()
	if(occupants.len > 1)
		L = occupants.Copy(2)
	return L

/obj/groundtank/proc/toggle_passengers()
	if(usr!=get_pilot())
		return
	src.passengers_allowed = !passengers_allowed
	to_chat(src.get_pilot(), "<span class='notice'>Now [passengers_allowed?"allowing passengers":"disallowing passengers, and ejecting any current passengers"].</span>")
	if(!passengers_allowed && has_passengers())
		for(var/mob/living/L in get_passengers())
			to_chat(L, "<span class='warning'>Ejection sequence activated: Ejecting in 3 seconds</span>")
			spawn(30)
				if(occupants.Find(L) && L.loc == src)
					playsound(src, 'sound/weapons/rocket.ogg', 50, 1)
					var/turf/T = get_turf(src)
					var/turf/target_turf
					move_outside(L,T)
					target_turf = get_edge_target_turf(T, opposite_dirs[dir])
					L.throw_at(target_turf,100,3)

/obj/groundtank/proc/move_outside(var/mob/occupant, var/turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	adjust_occupants(occupant, STATUS_REMOVE)
	occupant.forceMove(exit_turf)

/obj/groundtank/proc/adjust_occupants(var/mob/user, var/status)
	if(status == STATUS_REMOVE)
		var/pilot = get_pilot()
		if(user == pilot) //They're the pilot
			for(var/datum/action/S in actions)
				if(istype (S, /datum/action/groundtank/pilot)) //Keep these
					S.Remove(user)
				else if(S.owner == user) //Remove these
					qdel(S)
					actions.Remove(S)
		else //They're a passenger
			for(var/datum/action/groundtank/S in actions)
				if(S.owner == user) //Remove these
					qdel(S)
					actions.Remove(S)
		occupants.Remove(user)
		if(get_pilot() && pilot != get_pilot()) //NEW PILOT
			var/mob/living/new_pilot = get_pilot()
			if(!new_pilot)
				return
			to_chat(new_pilot, "<span class = 'notice'>You are now the pilot of \the [src].</span>")
			for(var/datum/action/groundtank/S in actions)
				if(S.owner == new_pilot) //Remove these
					qdel(S)
					actions.Remove(S)
			for(var/datum/action/groundtank/pilot/P in actions)
				P.Grant(new_pilot)
			for(var/path in actions_types_pilot)
				var/datum/action/A = new path(src)
				actions.Add(A)
				A.Grant(new_pilot)
	else if(status == STATUS_ADD)
		occupants.Add(user)
		if(user == get_pilot()) //They're the new pilot
			for(var/datum/action/groundtank/pilot/P in actions)
				P.Grant(user)
			for(var/path in actions_types_pilot)
				var/datum/action/A = new path(src)
				actions.Add(A)
				A.Grant(user)
		else //They're a new passenger
			for(var/path in actions_types_passenger)
				var/datum/action/A = new path(src)
				actions.Add(A)
				A.Grant(user)

/obj/groundtank/proc/toggle_passenger_guns()
	if(usr!=get_pilot())
		return
	src.passenger_fire = !passenger_fire
	to_chat(src.get_pilot(), "<span class='notice'>Now [passenger_fire?"allowing passengers to fire groundtank weaponry":"disallowing passengers to fire groundtank weaponry"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)

#undef DAMAGE
#undef FIRE

#undef GROUNDTANK_LIGHTS_CONSUMPTION
#undef GROUNDTANK_LIGHTS_RANGE_ON
#undef GROUNDTANK_LIGHTS_RANGE_OFF

#undef STATUS_REMOVE
#undef STATUS_ADD
