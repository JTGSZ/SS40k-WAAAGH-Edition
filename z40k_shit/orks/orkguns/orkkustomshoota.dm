

/obj/item/weapon/taperoll
	name = "Tape" //Perhaps one day.
	desc = "This is some incredible Ork technology right here."
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = W_CLASS_SMALL

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota
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
	recoil = 16
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	var/projectiles = 45
	var/projectile_type
	var/cooldown = 0
	var/iconticker = 0
	var/state = 0
	var/basicbullets = 1 //Basic bullet types counting ourselves.
	var/laserbeams = 0 //Laser bullet types
	var/shotgunpellets = 0 //Shotgun bullet types
	var/taped = 1

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/isHandgun()
	return FALSE //No Kustom Shoota Akimbo for us.

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0, struggle = 0)
	..()
	if(!isork(user))
		to_chat(user, "<span class='warning'> What even is this? How does it work? Does it work? </span>")
		return

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/examine(mob/user)
	..()
	if(basicbullets)
		to_chat(user, "<span class='info'> There are currently [basicbullets] normal ballistics attached.</span>")
	if(laserbeams)
		to_chat(user, "<span class='info'> There are currently [laserbeams] laser guns attached.</span>")
	if(shotgunpellets)
		to_chat(user, "<span class='info'> There are currently [shotgunpellets] shotguns attached.</span>")

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/attackby(obj/item/I as obj, mob/user as mob)
	if(state > 29)
		to_chat(user,"<span class='warning'> Looks like there is no more room for that. Any more and only a cybork could lift it.</span>")
		return
	if(!isork(user))
		to_chat(user,"<span class='warning'> What on earth are you trying to do?</span>")
		return
	if(istype(I, /obj/item/weapon/taperoll))
		taped = 1
		playsound(loc, 'z40k_shit/sounds/tape.ogg', 50, 0)
		return
	if(istype(I, /obj/item/weapon/gun)) //I think I can nab any gun that can appear on the map.		
		if(istype(I, /obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota) || \
			istype(I, /obj/item/weapon/gun/projectile/automatic/complexweapon/slugga))
			basicbullets++
			state++
		if(istype(I, /obj/item/weapon/gun/energy/complexweapon/lasgun))
			laserbeams++
			state++
		if(istype(I, /obj/item/weapon/gun/projectile/shotgun))
			shotgunpellets++
			state++	
		qdel(I) //Basically this block will be executed no matter what is attached.
		taped = 0 //A gun not accounted for in here is a bug anyways.
		to_chat(user, "<span class='notice'> Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!</span>")
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)

	..()

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/update_icon()
	..()
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
		if(26 to INFINITY)
			iconticker = 10
			name = "DAKKAMASTA"
	icon_state = "slugga[iconticker][stored_magazine ? "" : "-e"]"
	return

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params, struggle = FALSE)
	if(!cooldown)
		makethepainstop(target, user, params, struggle)
		return

	else if(cooldown)
		return

/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota/proc/makethepainstop(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, struggle = 0) //Burst fires don't work well except by calling Fire() multiple times
	if(!isork(user))
		to_chat(user, "<span class='warning'> What even is this? How does it work? Does it work? </span>")
		return
	if(!taped)
		user.visible_message("\red This needs to be taped up before it can be used!")
		return
	if(!cooldown) //If we are not on cooldown
		if(getAmmo()) //If we have ammo
			var/atom/originaltarget = target //Our original target
			var/turf/targloc
			cooldown = 1
			fire_volume = clamp((3 * state), 20, 100) //Ouch my ears... well up to 90% vol anyways.
			if(basicbullets >= 1)
				projectile_type = "/obj/item/projectile/bullet/orkscrapbullet"
				for(var/i=1 to min(projectiles,basicbullets))
					target = get_inaccuracy(originaltarget, 1+recoil)
					targloc = get_turf(target)
					if(i>1 && !in_chamber)
						in_chamber = new projectile_type(src)
					Fire(targloc, user, params, struggle)
			if(laserbeams >= 1) //Laserbeam shit
				in_chamber = null
				projectile_type = "/obj/item/projectile/beam/medpower"
				for(var/i=1 to min(projectiles, laserbeams))
					target = get_inaccuracy(originaltarget, 1+recoil)
					targloc = get_turf(target)
					if(i>1 && !in_chamber)
						in_chamber = new projectile_type(src)
					Fire(targloc, user, params, struggle)
					sleep(1)
			if(shotgunpellets >= 1)
				in_chamber = null
				projectile_type = "/obj/item/projectile/bullet/buckshot"
				for(var/i=1 to min(projectiles, shotgunpellets))
					target = get_inaccuracy(originaltarget, 1+recoil)
					targloc = get_turf(target)
					if(i>1 && !in_chamber)
						in_chamber = new projectile_type(src)
					Fire(targloc, user, params, struggle)
					sleep(1)
		sleep(8)
	cooldown = 0
		
