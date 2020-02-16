// honk
#define DAMAGE			1
#define FIRE			2

#define COMPLEX_VEHICLE_LIGHTS_RANGE_ON 8
#define COMPLEX_VEHICLE_LIGHTS_RANGE_OFF 3 //one tile beyond the complex_vehicle itself, "cockpit glow"

/obj/complex_vehicle
	name = "\improper complex_vehicle"
	desc = "A ground tank meant for ground travel."
	icon = 'z40k_shit/icons/complex_vehicle/Leman_Russ_128x128.dmi'
	density = 1 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	infra_luminosity = 15
	internal_gravity = 1 // Can move in 0-gravity
	layer = VEHICLE_LAYER
	plane = ABOVE_HUMAN_PLANE

	var/passenger_limit = 1 //Upper limit for how many passengers are allowed
	var/passengers_allowed = 1 //If the pilot allows people to jump in the side seats.
	var/list/occupants = list()

	var/hatch_open = 0
	var/list/tank_overlays
	var/health = 5000
	var/maxHealth = 5000
	var/lights_enabled = FALSE
	light_power = 2
	light_range = COMPLEX_VEHICLE_LIGHTS_RANGE_OFF
	appearance_flags = LONG_GLIDE
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	
	var/engine_toggle = 0 //Whether the engine is on or off and our while loop is on.

	var/mainturret = /obj/complex_vehicle/complex_turret //What turret comes attached to us
	var/vehicle_width = 3 //We use this for action calculations
	var/vehicle_height = 3 //Basically its so it knows where the projectiles should appear.
	var/obj/complex_vehicle/GT

	var/list/chassis_actions = list(
		/datum/action/complex_vehicle_equipment/toggle_passengers,
		/datum/action/complex_vehicle_equipment/toggle_lights,
		/datum/action/complex_vehicle_equipment/toggle_engine,
		/datum/action/complex_vehicle_equipment/enter_and_exit,
		) //These are actions innate to the object, basically a reference list for what to add on.
	
	var/datum/comvehicle/equipment/ES //Our equipment controller and action holder.
	
/obj/complex_vehicle/New()
	. = ..()
	if(!tank_overlays)
		tank_overlays = new/list(2)
		tank_overlays[DAMAGE] = image(icon, icon_state="chassis_damage")
		tank_overlays[FIRE] = image(icon, icon_state="chassis_fire")
	bound_width = vehicle_width*WORLD_ICON_SIZE
	bound_height = vehicle_height*WORLD_ICON_SIZE
	dir = EAST

	ES = new(src) //New equipment system in US
	
	for(var/path in chassis_actions) //Mark 1
		new path(src) //We create the actions inside of this object. They should add themselve to held actions.

	if(ticker && ticker.current_state >= GAME_STATE_PREGAME)
		initialize() //We perform a coastal cleanse now that we are here.

/obj/complex_vehicle/initialize()
	..()
	GT = new mainturret(src.loc)
	lock_atom(GT)

/obj/complex_vehicle/Destroy()
	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()

	qdel(tank_overlays[DAMAGE])
	qdel(tank_overlays[FIRE])
	tank_overlays = null
	
	unlock_atom(GT)
	qdel(GT)

	..()

/obj/complex_vehicle/proc/update_icons()
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

/obj/complex_vehicle/bullet_act(var/obj/item/projectile/P)
	if(P.damage && !P.nodamage)
		adjust_health(P.damage)

/obj/complex_vehicle/proc/adjust_health(var/damage)
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

/obj/complex_vehicle/ex_act(severity)
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

/obj/complex_vehicle/attackby(obj/item/W, mob/user)
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
				ES.make_it_end(src, W, TRUE, get_pilot())
				return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)


/obj/complex_vehicle/attack_hand(mob/user as mob)
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
			ES.make_it_end(src, SCREE, FALSE, get_pilot())
		else
			to_chat(user, "<span class='warning'>You need an open hand to do that.</span>")

/obj/complex_vehicle/proc/toggle_lights()
	if(lights_enabled)
		set_light(COMPLEX_VEHICLE_LIGHTS_RANGE_OFF)
		to_chat(usr, "<span class='notice'>Lights disabled.</span>")
	else
		set_light(COMPLEX_VEHICLE_LIGHTS_RANGE_ON)
		to_chat(usr, "<span class='notice'>Lights enabled.</span>")
	lights_enabled = !lights_enabled

/obj/complex_vehicle/acidable()
	return 0

/obj/complex_vehicle/proc/move_into_vehicle(var/mob/living/user)
	if(user && user.client && user in range(1))
		user.reset_view(src)
		user.stop_pulling()
		user.forceMove(src)
		tight_fuckable_dickhole(user, TRUE)
		return 1
	return 0

/obj/complex_vehicle/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/obj/complex_vehicle/proc/get_maingunner()
	if(occupants.len)
		return occupants[2]
	return 0

/obj/complex_vehicle/proc/has_passengers()
	if(occupants.len > 1)
		return occupants.len-1
	return 0

/obj/complex_vehicle/proc/get_passengers()
	var/list/L = list()
	if(occupants.len > 1)
		L = occupants.Copy(2)
	return L

/obj/complex_vehicle/proc/toggle_passengers()
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

/obj/complex_vehicle/proc/move_outside(var/mob/user, var/turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	tight_fuckable_dickhole(user, FALSE)
	user.forceMove(exit_turf)

/obj/complex_vehicle/proc/tight_fuckable_dickhole(var/mob/user, var/GIVIESorTAKIES)
	var/pilot = get_pilot()
	if(GIVIESorTAKIES) //GIVIES
		occupants.Add(user) //WE GIVIES OCCUPANTS the USER
		for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage) //Our datum action holder
			if(actions.pilot_only && get_pilot() != user) //IF THE ACTION IS PILOT ONLY AND USER IS NOT PILOT
				actions.Remove(user)
			actions.Grant(user) //We grant the user all the actions on ES.actions_storage

		if(get_pilot() && pilot != get_pilot()) //NEW PILOT - Occurs if someone gets out and theres a passenger
			var/mob/living/new_pilot = get_pilot()
			if(!new_pilot)
				return	
			to_chat(new_pilot, "<span class = 'notice'>You are now the driver of \the [src].</span>")
			for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage)
				actions.Grant(new_pilot)
	
	else //TAKIES
		occupants.Remove(user) //WE TAKIES the user OUT of OCCUPANTS
		for(var/datum/action/complex_vehicle_equipment/actions in ES.action_storage)
			actions.Remove(user) //They just left we take ALL the shit.

/obj/complex_vehicle/proc/toggle_weapon(var/weapon_toggle, var/obj/item/device/vehicle_equipment/weaponry/mygun, var/datum/action/complex_vehicle_equipment/actionid)
	if(usr!=get_pilot())
		return
		
	for(mygun in ES.equipment_systems)
		if(mygun.id == actionid)
			if(weapon_toggle)
				mygun.weapon_online = TRUE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched off.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
			else
				mygun.weapon_online = FALSE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched on.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)


#undef DAMAGE
#undef FIRE

#undef COMPLEX_VEHICLE_LIGHTS_RANGE_ON
#undef COMPLEX_VEHICLE_LIGHTS_RANGE_OFF
