/obj/item/projectile/bullet/orkscrapbullet
	name = "\improper Ork Scrap Bullet"
	damage = 30
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.

/obj/item/ammo_casing/orkbullet
	name = "Slugga bullet"
	desc = "A bullet that looks of questionable quality."
	caliber = ORKSCRAPBULLET
	projectile_type = /obj/item/projectile/bullet/orkscrapbullet
	w_type = RECYK_METAL
	
/obj/item/ammo_storage/box/piles
	name = "A pile of something you shouldn't see"
	desc = "Someone fucked up."
	icon = 'icons/obj/orkstuff/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	max_ammo = 0
	pile = 1

/obj/item/ammo_storage/box/piles/sluggabulletpile
	name = "A pile of live slugga bullets"
	desc = "Its a pile of bullets alright."
	icon = 'icons/obj/orkstuff/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_storage/box/piles/buckshotpile
	name = "A pile of unspent buckshot"
	desc = "Its a pile of buckshot alright."
	icon = 'icons/obj/orkstuff/orkbulletpilesandmags.dmi'
	icon_state = "buckshotpile"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_storage/magazine/sluggamag
	name = "Slugga Mag"
	icon = 'icons/obj/orkstuff/orkbulletpilesandmags.dmi'
	icon_state = "sluggamag"
	desc = "A magazine for a slugga"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/orkbullet" //We don't use regular bullets here.
	max_ammo = 30
	multiple_sprites = 1
	sprite_modulo = 30

/obj/item/ammo_storage/magazine/shottamag
	name = "Shotta Mag"
	icon = 'icons/obj/orkstuff/orkbulletpilesandmags.dmi'
	icon_state = "shottamag"
	desc = "Why pump when you can just dump.... Up to 5 shots"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot" //For some reason it won't take the children, bitchass.
	max_ammo = 5
	multiple_sprites = 1
	sprite_modulo = 5
	exact = 0

/obj/item/weapon/taperoll
	name = "Tape" //Perhaps one day.
	desc = "This is some incredible Ork technology right here."
	icon = 'icons/obj/orkstuff/orkequipment.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = W_CLASS_SMALL

/obj/item/weapon/gun/projectile/automatic/slugga
	name = "\improper Slugga"
	desc = "What dis?"
	icon = 'icons/obj/orkstuff/orkequipment.dmi'
	icon_state = "slugga"
	item_state = "slugga"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/orkequipment.dmi', "right_hand" = 'icons/mob/in-hand/right/orkequipment.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 25
	burst_count = 5
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/sluggamag"
	fire_sound = 'sound/weapons/slugga_1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/slugga/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "slugga[stored_magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/automatic/slugga/Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0, struggle = 0)
	..()
	if(!isork(user))
		to_chat(user, "What even is this? How does it work? Does it work?")
		return

/obj/item/weapon/gun/projectile/shotgun/shotta
	name = "shotta"
	desc = "A crude shotgun, what more is there to say?"
	icon = 'icons/obj/orkstuff/orkequipment.dmi'
	icon_state = "shotta"
	item_state = "slugga" //Lame but I can't be assed to spend time on this atm.
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/orkequipment.dmi', "right_hand" = 'icons/mob/in-hand/right/orkequipment.dmi')
	origin_tech = Tc_COMBAT + "=6;" + Tc_MATERIALS + "=3"
	ammo_type = "/obj/item/ammo_casing/shotgun"
	mag_type = "/obj/item/ammo_storage/magazine/shottamag"
	max_shells = 5
	load_method = 2
	slot_flags = 0
	gun_flags = EMPTYCASINGS

/obj/item/weapon/gun/projectile/shotgun/shotta/update_icon()
	..()
	icon_state = "shotta[stored_magazine ? "" : "-e"]"
