

/obj/item/projectile/bullet/orkscrapbullet
	name = "\improper Ork Scrap Bullet"
	damage = 30
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.

/obj/item/ammo_casing/orkbullet
	name = "Scrapmetal Bullet"
	desc = "A bullet that looks of questionable quality."
	caliber = ORKSCRAPBULLET
	projectile_type = /obj/item/projectile/bullet/orkscrapbullet
	w_type = RECYK_METAL

/obj/item/ammo_casing/orkbullet/attackby(var/atom/A, var/mob/user) //now with loading
	..()
	var/obj/item/ammo_casing/AC = A
	if(istype(A,/obj/item/ammo_casing/orkbullet))
		if(!AC.BB) //We avoid the istype check by movin this up
			to_chat(user, "<span class='notice'>The bullet appears to be already spent.</span>")
			return
		var/PP = new /obj/item/ammo_storage/box/piles/sluggabulletpile(src.loc)
		qdel(A)
		user.put_in_any_hand_if_possible(PP) //pp hands lol

/obj/item/ammo_storage/box/piles
	name = "A pile of something you shouldn't see"
	desc = "Someone fucked up."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	max_ammo = 0
	pile = 1

/*
	SLUGGA BULLET PILES
						*/

/obj/item/ammo_storage/box/piles/sluggabulletpile
	name = "A pile of live bullets"
	desc = "Its a pile of bullets alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	multiple_sprites = 1
	starting_ammo = 2

/obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile
	name = "A pile of live bullets"
	desc = "Its a pile of bullets alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	multiple_sprites = 1


/*
	BUCKSHOT PILES AND BUCKSHOT ATTACKBY TO MAKE A PILE
														*/
/obj/item/ammo_storage/box/piles/buckshotpile
	name = "A pile of unspent buckshot"
	desc = "Its a pile of buckshot alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "buckshotpile"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot"
	max_ammo = 12
	multiple_sprites = 1
	starting_ammo = 2

/obj/item/ammo_storage/box/piles/buckshotpile/max_pile
	name = "A pile of unspent buckshot"
	desc = "Its a pile of buckshot alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "buckshotpile"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_casing/shotgun/buckshot/attackby(var/atom/A, var/mob/user) //now with loading
	..()
	var/obj/item/ammo_casing/AC = A
	if(!AC.BB) //We avoid the istype check by movin this up
		to_chat(user, "<span class='notice'>The bullet appears to be already spent.</span>")
		return
	if(istype(A,/obj/item/ammo_storage/box/piles/buckshotpile))
		var/PP = new /obj/item/ammo_storage/box/piles/sluggabulletpile(src.loc)	
		qdel(A)
		user.put_in_any_hand_if_possible(PP) //pp hands lol

/*
	MAGAZINES AND AMMO BELTS AND SHIT
										*/

/obj/item/ammo_storage/magazine/sluggamag
	name = "Magazine"
	desc = "Fits more than you"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggamag"
	desc = "A magazine for a slugga"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/orkbullet" //We don't use regular bullets here.
	max_ammo = 30
	multiple_sprites = 1
	sprite_modulo = 30

/obj/item/ammo_storage/magazine/shottamag
	name = "Shotta Mag"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "shottamag"
	desc = "Why pump when you can just dump.... Up to 5 shots"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot" //For some reason it won't take the children, bitchass.
	max_ammo = 5
	multiple_sprites = 1
	sprite_modulo = 5
	exact = 0

/obj/item/ammo_storage/magazine/kustom_shoota_belt
	name = "kustom shoota Belt"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "ammobelt"
	desc = "A ammobelt for feeding into a kustom shoota"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	sprite_modulo = 2
	multiple_sprites = TRUE
