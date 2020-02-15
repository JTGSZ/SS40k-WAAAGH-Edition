
//The turrets another object, ayep.
/obj/complex_vehicle/complex_turret
	name = "\improper turret"
	desc = "A turret attached to a vehicle."
	icon = 'z40k_shit/icons/complex_vehicle/Leman_Russ_128x128.dmi'
	icon_state = "turret_punisher"
	density = 0 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	lockflags = NO_DIR_FOLLOW
	hatch_open = 0
	occupants = list()
	datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	health = 400
	maxHealth = 400
	movement_delay = 2
	chassis_actions = list(
		/datum/action/complex_vehicle_equipment/enter_and_exit,
		) //These are actions innate to the object.
	datum/comvehicle/equipment/ES //Our equipment controller.

/obj/complex_vehicle/complex_turret/New()
	dir = EAST
	bound_width = 2*WORLD_ICON_SIZE
	bound_height = 2*WORLD_ICON_SIZE

	ES = new(src) //New equipment system in US

/obj/complex_vehicle/complex_turret/Destroy()
	qdel(ES) //We qdel it i guess

	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()

/obj/complex_vehicle/complex_turret/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
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

/obj/complex_vehicle/complex_turret/update_icons()
	return

/obj/complex_vehicle/complex_turret/attackby(obj/item/W, mob/user)
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
			return
		if(istype(W, /obj/item/device/vehicle_equipment/weaponry))
			if(user.drop_item(W, src))
				to_chat(user, "<span class='notice'>You insert the [W] into [src].</span>")
				ES.make_it_end(src, W, TRUE, get_pilot())
				return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)

/obj/complex_vehicle/complex_turret/attack_hand(mob/user as mob)
	if(!hatch_open)
		return
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

//Click Action
/obj/complex_vehicle/complex_turret/click_action_control(atom/target,mob/user)
	if(user != get_pilot()) //If user is not pilot return false
		return
	if(user.stat)
		return
	if(src == target)
		return
	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & src.dir))//wrong direction
		return
		if(!target)
			return
	if(get_dist(src, target)>1)
		if(ES.equipment_systems.len)
			for(var/obj/item/device/vehicle_equipment/weaponry/COCK in ES.equipment_systems)
				if(COCK.weapon_online)
					COCK.action(target)
					sleep(1)
