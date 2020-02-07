/datum/job/orknob
	title = "Ork Nob"
	flag = ORKNOB
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/orknob

/datum/outfit/orknob

	outfit_name = "Ork Nob"
	associated_job = /datum/job/orknob
	no_backpack = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/iguard/ig_guard,
		),
		/datum/species/ork/nob = list( 
			slot_w_uniform_str = /obj/item/clothing/under/ork/pants,
			slot_shoes_str = /obj/item/clothing/shoes/ork/orkboots,
			slot_back_str = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		)
	)

/datum/outfit/orknob/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Nob")

/datum/outfit/orknob/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

