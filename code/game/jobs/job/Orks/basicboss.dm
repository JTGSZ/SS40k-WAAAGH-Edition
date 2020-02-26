/datum/job/orkwarboss
	title = "Ork Warboss"
	flag = ORKWARBOSS
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 0
	supervisors = "YA SELF"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/orkwarboss

/datum/outfit/orkwarboss

	outfit_name = "Ork Warboss"
	associated_job = /datum/job/orkwarboss
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
		/datum/species/ork/warboss = list( 
			slot_w_uniform_str = /obj/item/clothing/under/ork/warboss/pants,
			slot_shoes_str = /obj/item/clothing/shoes/ork/bossboots,
			slot_gloves_str = /obj/item/clothing/gloves/ork/warboss/armorbracers,
			slot_belt_str = /obj/item/weapon/storage/belt/ork/warboss,
			slot_head_str = /obj/item/clothing/head/ork/warboss/bossarmorhelmet,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/ork/warboss/platearmor,
			slot_back_str = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		)
	)

/datum/outfit/orkwarboss/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Warboss")

/datum/outfit/orkwarboss/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orkwarboss/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boss = new
	new_boss.AssignToRole(H.mind,TRUE)