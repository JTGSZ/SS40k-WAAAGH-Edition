/obj/item/weapon/iguard/ig_powerpack
	name = "Powerpack"
	desc = "Contains Hydrogen....Probably?"
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "powerpack"
	item_state = "powerpack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	var/max_fuel = 1500 //The max amount of fuel this can hold
	var/start_fueled = 1 // Do we start fueled
	var/my_gun //Where we store our gun ref if we link them together.

/obj/item/weapon/iguard/ig_powerpack/New()
	. = ..()

	create_reagents(max_fuel)
	if(start_fueled)
		reagents.add_reagent(HYDROGEN, max_fuel)

//If someone drops a plasma gun onto us, we tie ourselves together.
/obj/item/weapon/iguard/ig_powerpack/MouseDropTo(atom/movable/O as mob|obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/gun/ig_plasma_gun))
		var/obj/item/weapon/gun/ig_plasma_gun/ASS = O
		if(do_after(user,src,20))
			to_chat(user, "<span class='warning'>You attach hose to [src] and [O]</span>")
			ASS.my_pack = src
			my_gun = ASS
			ASS.update_icon()

//If someone pulls our powerpack off, we unlink them.
/obj/item/weapon/iguard/ig_powerpack/unequipped(mob/user)
	if(my_gun)
		var/obj/item/weapon/gun/ig_plasma_gun/ASS = locate(/obj/item/weapon/gun/ig_plasma_gun) in user.held_items
		if(ASS)
			ASS.my_pack = null
			my_gun = null
			ASS.update_icon()

//If we attack a hydrogen tank with our powerpack we refuel.
/obj/item/weapon/iguard/ig_powerpack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/structure/reagent_dispensers/hydrogen_tank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return

//If we want to locate how much fuel we have, we use this proc.
/obj/item/weapon/iguard/ig_powerpack/proc/get_fuel()
	return reagents.get_reagent_amount(HYDROGEN)

//We have three icon states
//plasma_gun-e   Which is empty
//plasma_gun     We have a regular fuel cell in
//plasma_gun-ppack     We are linked to a powerpack
//Our fuel cell state is plas_fuel_cell
/obj/item/weapon/gun/ig_plasma_gun
	name = "Plasma Gun"
	desc = "Its a Plasma Gun"
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64plasgun_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64plasgun_right.dmi')
	icon_state = "plasma_gun"
	item_state = "plasma_gun"
	var/obj/item/weapon/iguard/ig_powerpack/my_pack //The powerpack we are attached to if there is one. Basically a ref
	overcharged = FALSE //Are we overcharged or not?
	throw_range = 0
	throw_speed = 1
	fire_sound = null
	var/connection_type = 0 // 1 = No Connection, 2 = Cell connection, 3 = Ppack connection

/obj/item/weapon/gun/ig_plasma_gun/New()
	..()


/obj/item/weapon/gun/ig_plasma_gun/dropped(mob/user) //If we drop this, we return to pack.
	if(my_pack)
		my_pack.nozzleout = FALSE
		src.forceMove(my_pack)
		my_pack.update_icon()
		update_icon()

/obj/item/weapon/gun/ig_plasma_gun/update_icon()
	var/mob/living/carbon/human/H = loc

	if(istype(loc,/mob/living/carbon/human))
		switch(connection_type)
			if(1) //No connection
				icon_state = "burnanozzle_on"
				item_state = "burnanozzle_on"
				H.update_inv_hands()
			if(2) //Fuel Cell connection
				icon_state = "burnanozzle_off"
				item_state = "burnanozzle_off"
				H.update_inv_hands()
			if(3) //Powerpack hose connection
				icon_state = "burnanozzle_off"
				item_state = "burnanozzle_off"
				H.update_inv_hands()

/obj/item/weapon/gun/ig_plasma_gun/throw_impact(atom/hit_atom, mob/user) //If we throw this, we return to pack.
	..()
	if(isturf(hit_atom))

		update_icon()

	if(my_pack)
		//my_pack.nozzleout = FALSE
		my_pack.update_icon()

/obj/item/weapon/gun/ig_plasma_gun/attack_self(var/mob/user) //If we click this, we ignite it.
	..()

/obj/item/weapon/gun/ig_plasma_gun/process_chambered()
	if(in_chamber)
		return 1
	switch(connection_type)
		if(1)
			return 0
		if(2)
			return 0

		if(3)
			if(my_pack.get_fuel() > 0)
				my_pack.reagents.remove_reagent(HYDROGEN, 50)
				playsound(src, 'z40k_shit/sounds/flamer.ogg', 60, 1)
				in_chamber = new/obj/item/projectile/fire_breath/shuttle_exhaust(src)
				return 1
			else
				return
	return 0

/obj/structure/reagent_dispensers/hydrogen_tank
	name = "hydrogen tank"
	desc = "A tank filled with hydrogen."
	icon_state = "degreasertank"
	amount_per_transfer_from_this = 5

/obj/structure/reagent_dispensers/degreaser/New()
	. = ..()
	reagents.add_reagent(HYDROGEN, 1000)

/obj/item/projectile/plasma
	name = "plasma"
	damage_type = BRUTE
	flag = "bullet"
	kill_count = 100
	penetration = 20
	layer = PROJECTILE_LAYER
	damage = 60
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "plasma"
	animate_movement = 2
	custom_impact = 1
	linear_movement = 0
	fire_sound = 'z40k_shit/sounds/plasmagun.ogg'

/obj/item/projectile/plasma/OnFired()
	..()
	var/obj/item/weapon/gun/ig_plasma_gun/plasgun = shot_from
	if(!plasgun || !istype(plasgun))
		return
	if(plasgun.overcharged)
		icon_state = "spur_high"
		damage = 100
		kill_count = 20
