
//converts a uniform distributed random number into a normal distributed one
//since this method produces two random numbers, one is saved for subsequent calls
//(making the cost negligble for every second call)
//This will return +/- decimals, situated about mean with standard deviation stddev
//68% chance that the number is within 1stddev
//95% chance that the number is within 2stddev
//98% chance that the number is within 3stddev...etc
var/gaussian_next
#define ACCURACY 10000
/proc/gaussian(mean, stddev)
	var/R1;var/R2;var/working
	if(gaussian_next != null)
		R1 = gaussian_next
		gaussian_next = null
	else
		do
			R1 = rand(-ACCURACY,ACCURACY)/ACCURACY
			R2 = rand(-ACCURACY,ACCURACY)/ACCURACY
			working = R1*R1 + R2*R2
		while(working >= 1 || working==0)
		working = sqrt(-2 * log(working) / working)
		R1 *= working
		gaussian_next = R2 * working
	return (mean + stddev * R1)
#undef ACCURACY

/obj/item/weapon/taperoll
	name = "Tape" //Perhaps one day.
	desc = "This is some incredible Ork technology right here."
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = W_CLASS_SMALL

/obj/item/weapon/gun/projectile/automatic/kustomshoota
	name = "\improper Slugga"
	desc = "What dis?"
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "slugga"
	item_state = "slugga"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/orkequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/orkequipment_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 25
	burst_count = 5
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/sluggamag"
	fire_sound = 'z40k_shit/sounds/slugga_1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	var/projectiles = 45
	var/deviation = 0.1
	var/projectile
	var/cooldown = 0
	var/iconticker = 0
	var/state = 0
	var/las = 0
	var/shotgun = 0
	var/taped = 1

/obj/item/weapon/gun/projectile/automatic/kustomshoota/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "slugga[stored_magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/automatic/kustomshoota/Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0, struggle = 0)
	..()
	if(!isork(user))
		to_chat(user, "What even is this? How does it work? Does it work?")
		return 

/obj/item/weapon/gun/projectile/automatic/kustomshoota/attackby(obj/item/I as obj, mob/user as mob)
	if(state > 29)
		user << "Looks like there is no more room for that. Any more and only a cybork could lift it."
		return
	if(!istype(user, /mob/living/carbon/human/ork/))
		user << "What on earth are you trying to do?"
		return
	if(istype(I, /obj/item/weapon/taperoll))
		taped = 1
		//playsound(loc, 'sound/items/tape.ogg', 50, 0)
		return

	if(istype(I, /obj/item/weapon/gun/energy/laser/lasgun))
		taped = 0
		las++
		state++
		user << "Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!"
		qdel(I)
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)

	..()

/obj/item/weapon/gun/projectile/automatic/kustomshoota/update_icon()
	..()
	deviation = 0.1
	if(state >= 12)
		deviation = 0.2
	if(state >= 25)
		deviation = 0.3
	switch(state)
		if(0 to 2)
			iconticker = 1
			name = "Modified Slugga"
		if(3 to 4)
			iconticker = 2
			name = "TWO Sluggas"
		if(5 to 6)
			iconticker = 3
			name = "SLUGGAMANGA"
		if(7 to 8)
			iconticker = 4
			name = "BIG SLUGGAMANGA"
		if(9 to 10)
			iconticker = 5
			name = "KROOK"
		if(11 to 12)
			iconticker = 6
			name = "KROOK KRUMPA"
		if(13 to 15)
			iconticker = 7
			name = "KRUMPA KANNON"
		if(16 to 19)
			iconticker = 8
			name = "MEGAKANNON"
		if(20 to 25)
			iconticker = 9
			name = "FLASH"
		if(26 to 30)
			iconticker = 10
			name = "DAKKAMASTA"
	icon_state = "slugga[iconticker][stored_magazine ? "-[stored_magazine.max_ammo]" : ""][chambered ? "" : "-e"]"
	return

/obj/item/weapon/gun/projectile/automatic/kustomshoota/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(!istype(user, /mob/living/carbon/human/ork/))
		to_chat(user,"What even is this? How does it work? Does it work?")
		return
	if(!taped)
		user.visible_message("\red This needs to be taped up before it can be used!")
		return
	if(!cooldown)
		cooldown = 1
		var/turf/curloc = get_turf(user)
		var/turf/targloc = get_turf(target)
		var/target_x = targloc.x
		var/target_y = targloc.y
		var/target_z = targloc.z
		var/newlock = get_turf(user)	//Where are we? I wanna see if we moved later.
		if(cooldown >= 1)			//base slugga round
			projectile = /obj/item/projectile/bullet/orkscrapbullet
			for(var/i=1 to min(projectiles, cooldown))	//This instruction in the for loop is essential to the entire process and I have no idea why. -Norc
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				new /obj/item/ammo_casing/orkbullet (src.loc)
				playsound(src, 'sound/weapons/Gunshot.ogg', 50, 1)
				A.process()
		if(las >= 1)		//amount of lasguns
			projectile = /obj/item/projectile/beam/medpower
			for(var/i=1 to min(projectiles, las))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if (!targloc || !curloc)
					continue
				if (newlock != curloc) break
				if (targloc == curloc)
					continue
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(src, 'z40k_shit/sounds/Lasgun0.ogg', 50, 1)
				A.process()
				sleep(1)
		if(shotgun >= 1)	//amount of shotguns times 3
			projectile = /obj/item/projectile/bullet/buckshot
			deviation = 0.7
			for(var/i=1 to min(projectiles, shotgun))
				var/dx = round(gaussian(0,deviation),1)
				var/dy = round(gaussian(0,deviation),1)
				targloc = locate(target_x+dx, target_y+dy, target_z)
				if(!targloc || targloc == curloc)
					break
				var/obj/item/projectile/A = new projectile(curloc)
				A.firer = user
				A.original = target
				A.current = curloc
				A.yo = targloc.y - curloc.y
				A.xo = targloc.x - curloc.x
				playsound(loc, 'sound/weapons/Gunshot.ogg', 80, 1)
				A.process()
				sleep(1)
				deviation = 0.1
		sleep(8)
		cooldown = 0
	return
