/datum/species/ork // /ss40k/ heres mr ork, or really their only gender should be male
	name = "Ork"
	icobase = 'icons/mob/human_races/r_ork.dmi'
	deform = 'icons/mob/human_races/r_def_ork.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "ork_eyes_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | IS_WHITELISTED | NO_SCAN | NO_SKIN
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	// Both must be set or it's only a 45% chance of manifesting.
	default_mutations=list(M_STRONG | M_RUN | M_LOUD)
	default_block_names=list("STRONGBLOCK","LOUDBLOCK","INCREASERUNBLOCK")

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	has_organ = list(
		"heart" =    /datum/organ/internal/heart,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons = 'icons/mob/species/ork/orkgearMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'icons/mob/species/ork/orkgearMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'icons/mob/species/ork/orkgearMOB.dmi'
	head_icons          = 'icons/mob/species/ork/orkgearMOB.dmi'
	belt_icons          = 'icons/mob/species/ork/orkgearMOB.dmi'
	wear_suit_icons     = 'icons/mob/species/ork/orkgearMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'icons/mob/species/ork/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/gib(mob/living/carbon/human/H)
	..()
	H.default_gib()