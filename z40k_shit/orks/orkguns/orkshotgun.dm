
/obj/item/weapon/gun/projectile/shotgun/complexweapon/shotta
	name = "shotta"
	desc = "A crude shotgun, what more is there to say?"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "shotta"
	item_state = "slugga" //Lame but I can't be assed to spend time on this atm.
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/ork_guns_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/ork_guns_right.dmi')
	origin_tech = Tc_COMBAT + "=6;" + Tc_MATERIALS + "=3"
	ammo_type = "/obj/item/ammo_casing/shotgun"
	mag_type = "/obj/item/ammo_storage/magazine/shottamag"
	max_shells = 5
	load_method = 2
	slot_flags = 0
	gun_flags = EMPTYCASINGS 

/obj/item/weapon/gun/projectile/shotgun/complexweapon/shotta/update_icon()
	..()
	icon_state = "shotta[stored_magazine ? "" : "-e"]"
