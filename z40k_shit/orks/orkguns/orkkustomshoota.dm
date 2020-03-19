
/obj/item/weapon/taperoll
	name = "Tape" //Perhaps one day.
	desc = "This is some incredible Ork technology right here."
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = W_CLASS_SMALL

/obj/item/weapon/gun/projectile/automatic/kustomshoota
	name = "\improper Kustom Shoota"
	desc = "A long but well defined shoota, ready for modifications."
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "kustom_shoota-nsg-nlsg"
	item_state = "kustom_shoota-nsg-nlsg"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64kustom_shoota_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64kustom_shoota_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 25
	burst_count = 5
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/kustom_shoota_belt"
	fire_sound = 'z40k_shit/sounds/slugga_1.ogg'
	recoil = 16
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	var/projectiles = 45
	var/totalguncount = 1 //We are the gun anon.
	var/projectile_type
	var/cooldown = 0
	var/basicbullets = 1 //Basic bullet types counting ourselves.
	var/laserbeams = 0 //Laser bullet types
	var/shotgunpellets = 0 //Shotgun bullet types
	var/taped = 1
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/automatic/kustomshoota/verb/rename_gun() //I could add possession here later for funs.
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

/obj/item/weapon/gun/projectile/automatic/kustomshoota/isHandgun()
	return FALSE //No Kustom Shoota Akimbo for us.

/obj/item/weapon/gun/projectile/automatic/kustomshoota/Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0, struggle = 0)
	..()
	if(!isork(user))
		to_chat(user, "<span class='warning'> What even is this? How does it work? Does it work? </span>")
		return

/obj/item/weapon/gun/projectile/automatic/kustomshoota/examine(mob/user)
	..()
	if(basicbullets)
		to_chat(user, "<span class='info'> There are currently [basicbullets] ballistics attached.</span>")
	if(laserbeams)
		to_chat(user, "<span class='info'> There are currently [laserbeams] laser guns attached.</span>")
	if(shotgunpellets)
		to_chat(user, "<span class='info'> There are currently [shotgunpellets] shotguns attached.</span>")

/obj/item/weapon/gun/projectile/automatic/kustomshoota/attackby(obj/item/I as obj, mob/user as mob)
	if(totalguncount > 29)
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
		if(istype(I, /obj/item/weapon/gun/projectile/automatic/kustomshoota) || \
			istype(I, /obj/item/weapon/gun/projectile/automatic/slugga) || \
			istype(I,/obj/item/weapon/gun/projectile/automatic/boltpistol))
			basicbullets++
			totalguncount++
		if(istype(I, /obj/item/weapon/gun/energy/lasgun))
			laserbeams++
			totalguncount++
		if(istype(I, /obj/item/weapon/gun/projectile/shotgun))
			shotgunpellets++
			totalguncount++
		qdel(I) //Basically this block will be executed no matter what is attached.
		taped = 0 //A gun not accounted for in here is a bug anyways.
		to_chat(user, "<span class='notice'> Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!</span>")
		update_icon()
		playsound(src, 'sound/machines/click.ogg', 25, 1)

	..()

/obj/item/weapon/gun/projectile/automatic/kustomshoota/update_icon()
	..()
	item_state = "kustom_shoota[wielded ? "-unwielded" : "-wielded"][shotgunpellets ? "-nsg" : "-sg"][laserbeams ? "-nlsg" : "-lsg"]"
	icon_state = "kustom_shoota[wielded ? "-unwielded" : "-wielded"][shotgunpellets ? "-nsg" : "-sg"][laserbeams ? "-nlsg" : "-lsg"][stored_magazine ? "" : "-e"]"
	

	//icon_state = "slugga[iconticker][stored_magazine ? "" : "-e"]"
	return

/obj/item/weapon/gun/projectile/automatic/kustomshoota/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params, struggle = FALSE)
	if(!cooldown)
		makethepainstop(target, user, params, struggle)
		return

	else if(cooldown)
		return

/obj/item/weapon/gun/projectile/automatic/kustomshoota/proc/makethepainstop(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, struggle = 0) //Burst fires don't work well except by calling Fire() multiple times
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
			fire_volume = clamp((3 * totalguncount), 20, 100) //Ouch my ears... well up to 90% vol anyways.
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
		
