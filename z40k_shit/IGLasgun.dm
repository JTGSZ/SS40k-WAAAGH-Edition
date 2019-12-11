//Within is the imperial guard ranged stuff for the moment. Lasguns etc

/*
	MAGAZINES/AMMO
					*/
/obj/item/weapon/cell/lasgunmag //Our magazine
	name = "lasgun mag"
	origin_tech = Tc_POWERSTORAGE + "=8"
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "lasgunmag"
	maxcharge = 4500
	starting_materials = list(MAT_IRON = 700, MAT_GLASS = 80)

/obj/item/weapon/gun/energy/laser/lasgun
	name = "M-Galaxy Pattern Lasgun"
	desc = "Standard issue ranged weapon given to Guardsmen of the Imperial Guard."
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "lasgun"
	item_state = "lasgun"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	cell_type = "/obj/item/weapon/cell/lasgunmag" //Lasgunmag
	projectile_type = /obj/item/projectile/beam
	charge_cost = 75
	icon_charge_multiple = 25 //Do I really need icon charge multiples for the lasgun.
	var/lasgun_shot_strength = 1 //For this we will use 1 to 3 to determine what state its set to.
	var/degradation_state = 1 //We will use this to keep track of the lasgun degradation.
	var/gunheat = 0 //The heat of the lasgun.

//Our Cell is power_supply and get_cell is ran on a parent.

/obj/item/weapon/gun/energy/laser/lasgun/verb/rename_gun() //I could add possession here later for funs.
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun."

	var/mob/M = usr
	if(!M.mind)
		return 0

	var/input = stripped_input(usr,"What do you want to name the gun?","", MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(src,M))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1

/obj/item/weapon/gun/energy/laser/lasgun/verb/adjust_power() //This adjusts the strength of the lasgun shot.
	set name = "Adjust Power Setting"
	set category = "Object"
	set desc = "Click to adjust the lasgun shot strength."

	var/mob/M = usr
	if(!M.mind)
		return 0

	var/chargestrength = input(usr, "Adjust Power Settings", "Lasgun Power Setting") in list("Low Power","Medium Power","Maximum Power")
	if(chargestrength)
		if("Low")
			src.lasgun_shot_strength = 1 //We set strength
			src.charge_cost = 75	//And we set charge cost - 60 shots
		if("Medium")
			src.lasgun_shot_strength = 2 //Med STR
			src.charge_cost = 150 // 30 Shots
		if("High")
			src.lasgun_shot_strength = 3 //High STR
			src.charge_cost = 300 //15 shots

/obj/item/weapon/gun/energy/laser/lasgun/process() //In process we handle heat
	if(gunheat > 0) //If we are greater than 0
		gunheat -= 5 //We go down by 5 a tick.
	if(gunheat >= 100) //If we are greater than or equal to 100
		to_chat(usr,"Boom") //bad things occur, perhaps gunheat handling and degradation can be on a combined proc.

/obj/item/weapon/gun/energy/laser/lasgun/process_chambered()
	if(in_chamber)
		return 1
	if(!power_supply)
		return 0
	if(!power_supply.use(charge_cost))
		return 0
	if(!projectile_type)
		return 0
	switch(lasgun_shot_strength) //We change the projectile processed based on lasgun strength
		if(1)
			power_supply.use(charge_cost) //Sets the charge cost based on the power neways
			gunheat += 5
			in_chamber = new projectile_type(src)
			return 1
		if(2)
			power_supply.use(charge_cost)
			gunheat += 10
			in_chamber = new projectile_type(src)
			return 1
		if(3)
			power_supply.use(charge_cost)
			gunheat += 50
			in_chamber = new projectile_type(src)
			return 1
	return 0
	

/obj/item/weapon/gun/energy/laser/lasgun/attackby(var/obj/item/A as obj, mob/user as mob) //Loading
	if(istype(A, /obj/item/weapon/cell))
		var/obj/item/weapon/cell/AM = A
		if(!power_supply)
			LoadMag(AM, user)
		else
			to_chat(user, "<span class='warning'>There is already a magazine loaded in \the [src]!</span>")
	if(istype(A, /obj/item/weapon/attachment))
		var/obj/item/weapon/attachment/ATCH = A
		GunAttachment(ATCH, user)

/obj/item/weapon/gun/energy/laser/lasgun/attack_self(mob/user as mob) //Unloading (Need special handler for unattaching.)
	if(target)
		return ..()
	if(power_supply) 
		RemoveMag(user)
	else
		to_chat(user, "<span class='warning'>There's no magazine loaded in \the [src]!</span>")
	

/obj/item/weapon/gun/energy/laser/lasgun/update_icon() // welp
	var/ratio = 0

	if(power_supply && power_supply.maxcharge > 0) //If the gun has a power cell, calculate how much % power is left in it
		ratio = power_supply.charge / power_supply.maxcharge

	//If there's no power cell, the gun looks as if it had an empty power cell

	ratio *= 100
	ratio = clamp(ratio, 0, 100) //Value between 0 and 100

	if(ratio >= 50)
		ratio = Floor(ratio, icon_charge_multiple)
	else
		ratio = Ceiling(ratio, icon_charge_multiple)

	var/mag //Mag String

	if(power_supply)
		mag = 1
	else
		mag = 0

	var/bayonet = FALSE
	for(var/obj/item/weapon/attachment/bayonet/ATCH in attachments)
		if(ATCH)
			bayonet = TRUE

	if(charge_states)
		icon_state = "[initial(icon_state)][ratio][mag ? "-mg" : "-nmg"][bayonet ? "-by" : "-nby"]"

/obj/item/weapon/gun/energy/laser/lasgun/proc/LoadMag(var/obj/item/weapon/cell/AM, var/mob/user)
	if(istype(AM, /obj/item/weapon/cell) && !power_supply)
		if(user)
			if(user.drop_item(AM, src))
				to_chat(user, "<span class='notice'>You load the magazine into \the [src].</span>")
			else
				return

		power_supply = AM
		AM.update_icon()
		update_icon()
		return 1
	return 0

/obj/item/weapon/gun/energy/laser/lasgun/proc/RemoveMag(var/mob/user)
	if(power_supply)
		power_supply.forceMove(get_turf(src.loc))
		if(user)
			user.put_in_hands(power_supply)
			to_chat(user, "<span class='notice'>You pull the magazine out of \the [src].</span>")
		power_supply.update_icon()
		power_supply = null
		update_icon()
		return 1
	return 0