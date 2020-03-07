//Within is the imperial guard ranged stuff for the moment. Lasguns etc

/*
	MAGAZINES/AMMO
					*/
/obj/item/weapon/cell/lasgunmag //Our magazine
	name = "lasgun mag"
	origin_tech = Tc_POWERSTORAGE + "=8"
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "lasgunmag"
	maxcharge = 4500
	starting_materials = list(MAT_IRON = 700, MAT_GLASS = 80)

/obj/item/weapon/gun/energy/complexweapon/lasgun
	name = "M-Galaxy Pattern Lasgun"
	desc = "Standard issue ranged weapon given to Guardsmen of the Imperial Guard."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "lasgun100-nby-nscp"
	item_state = "lasgun" //We jsut auto change neways
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IG_lasgun_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IG_lasgun_right.dmi')
	cell_type = "/obj/item/weapon/cell/lasgunmag" //Lasgunmag
	fire_sound = 'z40k_shit/sounds/Lasgun0.ogg'
	projectile_type = /obj/item/projectile/beam/lowpower
	charge_cost = 75
	icon_charge_multiple = 25 //Do I really need icon charge multiples for the lasgun.
	var/lasgun_shot_strength = 1 //For this we will use 1 to 3 to determine what state its set to.
	var/degradation_state = 10 //We will use this to keep track of the lasgun degradation, If it hits 1 we explode or fail.
	var/gunheat = 0 //The heat of the lasgun.
	var/scoped = FALSE //Are we zoomed in?
	actions_types = (/datum/action/item_action/warhams/adjust_power)
	defective = 1

/obj/item/weapon/gun/energy/complexweapon/lasgun/examine(mob/user)
	..()
	switch(gunheat)
		if(60 to 120)
			to_chat(user, "The [src] is pretty hot.")
		if(121 to 151)
			to_chat(user, "<span class='warning'>The [src] is VERY hot.</span>")

/obj/item/weapon/gun/energy/complexweapon/lasgun/New()
	..()
	processing_objects.Add(src)
	update_icon()

/obj/item/weapon/gun/energy/complexweapon/lasgun/Destroy()
	processing_objects.Remove(src)
	..()

/obj/item/weapon/gun/energy/complexweapon/lasgun/verb/rename_gun() //I could add possession here later for funs.
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

/datum/action/item_action/warhams/adjust_power //This adjusts the strength of the lasgun shot.
	name = "Adjust Power"
	button_icon_state = "power_setting"

/datum/action/item_action/warhams/adjust_power/Trigger()
	var/obj/item/weapon/gun/energy/complexweapon/lasgun/LSG = target
	LSG.adjust_power(owner)

/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/adjust_power(var/mob/user)
	var/chargestrength = input(user, "Adjust Power Settings (Warning: Mishandling can result in misfires)", "Lasgun Power Setting") in list("Low Power","Medium Power","Maximum Power")
	if(chargestrength)
		if(chargestrength == "Low Power")
			src.lasgun_shot_strength = 1 //We set strength
			src.charge_cost = 75	//And we set charge cost - 60 shots
		if(chargestrength == "Medium Power")
			src.lasgun_shot_strength = 2 //Med STR
			src.charge_cost = 150 // 30 Shots
		if(chargestrength == "Maximum Power")
			src.lasgun_shot_strength = 3 //High STR
			src.charge_cost = 300 //15 shots
		src.setprojtype() //The verb calls this, we can add arguments later once we know what we need.

/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/setprojtype() // Yep
//This proc/verb set can be made into a generic on guns later with a actual list of choices.
	if(lasgun_shot_strength == 1) //So forgive me if its kinda ass
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/lowpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/lowpower
	if(lasgun_shot_strength == 2)
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/medpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/medpower
	if(lasgun_shot_strength == 3)
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/maxpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/maxpower
	in_chamber = null
		
/obj/item/weapon/gun/energy/complexweapon/lasgun/process() //In process we handle heat
	if(gunheat > 0) //If we are greater than 0
		gunheat -= 5 //We go down by 5 a tick.

/obj/item/weapon/gun/energy/complexweapon/lasgun/process_chambered()
	if(in_chamber)
		return 1
	if(!power_supply)
		return 0
	if(!power_supply.use(charge_cost)) 
		return 0
	if(!projectile_type)
		return 0
	switch(lasgun_shot_strength) //We change the projectile processed based on lasgun strength
		if(1) //Low-power
			gunheat += 5
		if(2) //Medium-power
			gunheat += 10
		if(3) //High-power
			gunheat += 30
	in_chamber = new projectile_type(src)
	return 1
	

/obj/item/weapon/gun/energy/complexweapon/lasgun/attackby(var/obj/item/A as obj, mob/user as mob) //Loading
	if(A.is_screwdriver(user))
		to_chat(user, "<span class='notice'>You adjust and repair the [src].</span>")
		degradation_state = 10
		setprojtype()
	if(istype(A, /obj/item/weapon/cell))
		var/obj/item/weapon/cell/AM = A
		if(!power_supply)
			LoadMag(AM, user)
		else
			to_chat(user, "<span class='warning'>There is already a magazine loaded in \the [src]!</span>")

/obj/item/weapon/gun/energy/complexweapon/lasgun/attack_self(mob/user as mob) //Unloading (Need special handler for unattaching.)
	if(target)
		return ..()
	if(power_supply) 
		RemoveMag(user)
	else
		to_chat(user, "<span class='warning'>There's no magazine loaded in \the [src]!</span>")
	

/obj/item/weapon/gun/energy/complexweapon/lasgun/update_icon() // welp
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
	var/scope = FALSE
	for(var/obj/item/weapon/attachment/ATCH in ATCHSYS.attachments)
		if(istype(ATCH, /obj/item/weapon/attachment/bayonet))
			bayonet = TRUE
		if(istype(ATCH, /obj/item/weapon/attachment/scope))
			scope = TRUE

	if(charge_states)
		icon_state = "lasgun[ratio][bayonet ? "-nby" : "-by"][scope ? "-nscp" : "-scp"][mag ? "" : "-e"]"
	
	
	item_state = "lasgun[wielded ? "-unwielded" : "wielded"][bayonet ? "-nby" : "-by"][scope ? "-nscp" : "-scp"]"


/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/LoadMag(var/obj/item/weapon/cell/AM, var/mob/user)
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

/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/RemoveMag(var/mob/user)
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


//In the failure check we will account for heat failures, along with weapon degradation.
/obj/item/weapon/gun/energy/complexweapon/lasgun/failure_check(var/mob/living/carbon/human/M)
	if(istext(projectile_type))
		projectile_type = text2path(projectile_type)
	switch(projectile_type)
		if(/obj/item/projectile/beam/lowpower, /obj/item/projectile/beam/lowpower/degraded)
			if(prob(2)) //2
				degradegun(M)
				return 1
		if(/obj/item/projectile/beam/medpower, /obj/item/projectile/beam/medpower/degraded)
			if(prob(5)) //5
				degradegun(M)
				return 1
		if(/obj/item/projectile/beam/maxpower, /obj/item/projectile/beam/maxpower/degraded)
			if(prob(20)) //20
				degradegun(M)
				return 1
			if(prob(5)) // 1
				to_chat(M, "<span class='danger'>\The [src] overloads and explodes!.</span>")
				explosion(get_turf(loc), -1, 0, 2)
				M.drop_item(src, force_drop = 1)
				qdel(src)
				return 0

	switch(gunheat) //Heat failure, we handle this on a increasing scale of probability.
		if(60 to 79)
			if(prob(50))
				spark(src)
				to_chat(M, "<span class='warning'>\The [src] sparks violently.</span>")
				return 1
		if(80 to 120)
			if(prob(10))
				fire_delay += rand(2, 6)
				M.drop_item()
				M.audible_scream()
				M.adjustFireLossByPart(rand(1, 3), LIMB_LEFT_HAND, src)
				M.adjustFireLossByPart(rand(1, 3), LIMB_RIGHT_HAND, src)
				to_chat(M, "<span class='danger'>\The [src] burns your hands!.</span>")
				return 0
		if(121 to 150)
			if(prob(50))
				fire_delay += rand(2, 6)
				M.drop_item()
				M.audible_scream()
				M.adjustFireLossByPart(rand(5, 10), LIMB_LEFT_HAND, src)
				M.adjustFireLossByPart(rand(5, 10), LIMB_RIGHT_HAND, src)
				to_chat(M, "<span class='danger'>\The [src] SCORCHES your hands!.</span>")
				return 0
			if(prob(25))
				var/turf/T = get_turf(loc)
				explosion(T, 0, 1, 3, 5)
				M.drop_item(src, force_drop = 1)
				qdel(src)
				to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
				return 0
		if(151 to INFINITY)
			var/turf/T = get_turf(loc)
			explosion(T, 0, 1, 3, 5)
			M.drop_item(src, force_drop = 1)
			qdel(src)
			to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
			return 0

	return ..()

//Right here is where the beam change occurs.
/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/degradegun(var/mob/living/carbon/human/M)
	if(degradation_state > 0)
		degradation_state--
		fire_delay +=3
		to_chat(M, "<span class='warning'>Something inside \the [src] pops.</span>")
	if(0 >= degradation_state)
		if(prob(50))
			var/turf/T = get_turf(loc)
			explosion(T, 0, 1, 3, 5)
			M.drop_item(src, force_drop = 1)
			qdel(src)
			to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
		else
			to_chat(M, "<span class='danger'>\The [src] breaks apart!.</span>")
			qdel(src)


/*
	BEAMLIST
			*/

/obj/item/projectile/beam/maxpower
	name = "powerful laser"
	damage = 30

/obj/item/projectile/beam/maxpower/degraded
	damage = 20
	
/obj/item/projectile/beam/medpower
	name = "average laser"
	damage = 15

/obj/item/projectile/beam/medpower/degraded
	damage = 10

/obj/item/projectile/beam/lowpower
	name = "low-power laser"
	damage = 10

/obj/item/projectile/beam/lowpower/degraded
	damage = 5