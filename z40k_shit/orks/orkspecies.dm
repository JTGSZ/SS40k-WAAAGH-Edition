/datum/species/ork // /ss40k/ heres mr ork, or really their only gender should be male
	name = "Ork"
	icobase = 'icons/mob/human_races/r_ork.dmi'
	deform = 'icons/mob/human_races/r_def_ork.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "ork_eyes_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN | IS_WHITELISTED
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	// Both must be set or it's only a 45% chance of manifesting.
	default_mutations = list(M_RUN | M_LOUD)
	default_block_names = list("STRONGBLOCK","LOUDBLOCK","INCREASERUNBLOCK")

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	spells = list(/spell/waaagh1)
	has_mutant_race = 0

	has_organ = list(
		"heart" =    /datum/organ/internal/heart,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'


/datum/species/ork/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets

/datum/species/ork/gib(mob/living/carbon/human/H)
	..()
	H.default_gib()

//This below segment normally belongs in human.dm
/mob/living/carbon/human/ork/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/datum/species/ork/nob
	name = "Ork Nob"
	icobase = 'icons/mob/human_races/r_orknob.dmi'
	deform = 'icons/mob/human_races/r_def_orknob.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	// Both must be set or it's only a 45% chance of manifesting.
	default_mutations=list(M_RUN | M_LOUD)
	default_block_names=list("STRONGBLOCK","LOUDBLOCK","INCREASERUNBLOCK")

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	spells = list(/spell/waaagh1)
	has_mutant_race = 0

	brute_mod = 0.8	// brute multiplier
	burn_mod = 0.8 // burn multiplier
	tox_mod	= 0.8	// toxin multiplier

	has_organ = list(
		"heart" =    /datum/organ/internal/heart,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearNOBMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearNOBMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/nob/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets


/mob/living/carbon/human/ork/nob/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork Nob")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/datum/species/ork/nob/handle_post_spawn(var/mob/living/carbon/human/H)
	if(myhuman != H)
		return
	H.maxHealth += 100
	H.health += 100
	H.update_icon()




/datum/species/ork/warboss
	name = "Ork Warboss"
	icobase = 'icons/mob/human_races/r_orkboss.dmi'
	deform = 'icons/mob/human_races/r_def_orkboss.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	// Both must be set or it's only a 45% chance of manifesting.
	default_mutations=list(M_RUN | M_LOUD)
	default_block_names=list("STRONGBLOCK","LOUDBLOCK","INCREASERUNBLOCK")

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	spells = list(/spell/waaagh1)
	has_mutant_race = 0

	brute_mod = 0.5	// brute multiplier
	burn_mod = 0.5 // burn multiplier
	tox_mod	= 0.5	// toxin multiplier

	has_organ = list(
		"heart" =    /datum/organ/internal/heart,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/warboss/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 5),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 5),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets

/mob/living/carbon/human/ork/nob/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork Warboss")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/datum/species/ork/nob/handle_post_spawn(var/mob/living/carbon/human/H)
	if(myhuman != H)
		return
	H.maxHealth += 200
	H.health += 200
	H.update_icon()
