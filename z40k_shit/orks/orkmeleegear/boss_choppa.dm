/obj/item/weapon/boss_choppa
	name = "large choppa"
	desc = "It seems to be a hammer, made from scrap.."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64huge_choppa_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64huge_choppa_right.dmi')
	icon = 'z40k_shit/icons/obj/orks/32x64_ork_obj.dmi'
	icon_state = "big_choppa"
	item_state = "big_choppa"
	hitsound = 'z40k_shit/sounds/big_choppa.ogg'
	flags = TWOHANDABLE | MUSTTWOHAND
	siemens_coefficient = 1
	force = 90
	throwforce = 50
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_LARGE
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK
	attack_verb = list("attacks", "smashes",  "bludgeons", "tenderizes", "whams", "bops", "slamdunks")

