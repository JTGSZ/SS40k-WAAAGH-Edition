/obj/item/weapon/gun/projectile/automatic/complexweapon/slugga
	name = "\improper Shoota"
	desc = "What dis?"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "ork_shoota"
	item_state = "ork_shoota"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/ork_guns_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/ork_guns_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 30
	burst_count = 5
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/sluggamag"
	fire_sound = 'z40k_shit/sounds/Shoota1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/complexweapon/slugga/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "ork_shoota[stored_magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/automatic/complexweapon/slugga/Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0, struggle = 0)
	..()
	if(!isork(user))
		to_chat(user, "What even is this? How does it work? Does it work?")
		return
