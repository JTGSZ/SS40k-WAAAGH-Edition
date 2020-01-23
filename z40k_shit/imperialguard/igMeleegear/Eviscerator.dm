
/*
 * Eviscerator
 */
/obj/item/projectile/fire_breath/eviscerator //The fire projectile we will use, cap it to 3 turfs.
	fire_blast_type = /obj/effect/fire_blast/no_spread
	max_range = 4

/obj/item/weapon/gun/eviscerator
	name = "Eviscerator"
	desc = "A oversized chainsword. This one has a exterminator attached to it too."
	slot_flags = SLOT_BACK
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64eviscerator.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64eviscerator.dmi')
	icon_state = "eviscerator" 
	item_state = "eviscerator"
	throwforce = 35
	force = 50
	armor_penetration = 100
	throw_speed = 5
	throw_range = 10
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK //it's a really sharp blade m'kay
	w_class = W_CLASS_LARGE
	flags = FPRINT | TWOHANDABLE | MUSTTWOHAND
	mech_flags = MECH_SCAN_FAIL
	origin_tech = Tc_MAGNETS + "=4;" + Tc_COMBAT + "=5"

/obj/item/weapon/gun/eviscerator/IsShield()
	return 1

/obj/item/weapon/gun/eviscerator/process_chambered()
	in_chamber = new/obj/item/projectile/fire_breath/eviscerator(src)
	return 1
	