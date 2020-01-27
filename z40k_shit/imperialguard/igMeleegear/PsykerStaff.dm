
/obj/item/weapon/complexweapon/psykerstaff
	name = "Psyker Staff"
	desc = "A staff that is important for a great many things to certain people."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64PsykerStaff.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64PsykerStaff.dmi')
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "psykerstaff"
	item_state = "psykerstaff"
	slot_flags = SLOT_BACK
	flags = FPRINT
	siemens_coefficient = 1
	force = 35
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = CUT_AIRLOCK
	attack_verb = list("attacks", "bludgeons",  "slams")

/obj/item/weapon/complexweapon/psykerstaff/New()
	. = ..()

