/obj/item/weapon/gun/projectile/automatic/complexweapon/boltpistol
	name = "\improper Boltpistol"
	desc = "A boltpistol"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "boltpistol"
	item_state = "boltpistol"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 16
	burst_count = 1
	caliber = list(STANDARDBOLTER = 1)
	ammo_type = "/obj/item/ammo_casing/bolter"
	mag_type = "/obj/item/ammo_storage/magazine/boltpistol"
	fire_sound = 'z40k_shit/sounds/BoltPistol1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS

/obj/item/weapon/gun/projectile/automatic/complexweapon/boltpistol/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "boltpistolmag[stored_magazine ? "" : "-e"]"
