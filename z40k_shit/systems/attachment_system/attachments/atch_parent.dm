
/*
	ATTACHMENTS
				*/
/obj/item/weapon/attachment
	name = "the great ancestor"
	desc = "If you see this object, say something on discord."
	icon = 'z40k_shit/icons/obj/gun_attachments.dmi'
	icon_state = "bayonet"
	item_state = "bayonet"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	siemens_coefficient = 1
	sharpness = 1.5
	w_class = W_CLASS_SMALL
	starting_materials = list(MAT_IRON = 12000)
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = Tc_MATERIALS + "=1"
	sharpness_flags = SHARP_TIP | SHARP_BLADE
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/fire_sound //Holder for firesound path on attachments, mostly for the flag.
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	
	//---------ATTACHMENT CONTROL VARIABLES---------//
	var/atch_total_limit = 0 //0 is infinity, basically how many of an attachment you can have.
	var/atch_effect_flags = 0 //FLAGS go here to determine how the effects system handles something.
	var/atch_possible = TRUE //Can we even attach this to the other object?
	var/tied_action //The action we will attach to the object
	