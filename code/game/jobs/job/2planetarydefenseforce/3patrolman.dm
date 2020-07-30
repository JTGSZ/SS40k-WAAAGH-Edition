
/datum/job/patrolman //This will be converted to the basic guardsman.
	title = "Patrolman"
	flag = PATROLMAN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 50
	wage_payout = 45
	supervisors = "Knight Officers, and your lord."
	selection_color = "#f8cb69"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_cadian_trooper
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON


/datum/outfit/patrolman
	outfit_name = "patrolman"
	associated_job = /datum/job/patrolman

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/trooperbag,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
			slot_head_str = /obj/item/clothing/head/IG_cadian_helmet,
			slot_shoes_str = /obj/item/clothing/shoes/IG_cadian_boots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/IG_cadian_armor,
			slot_s_store_str = /obj/item/weapon/gun/energy/lasgun,
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/IG_cadian_trooper/post_equip(var/mob/living/carbon/human/H)

	