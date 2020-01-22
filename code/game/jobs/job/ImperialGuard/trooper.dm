//---------------Trooper-----------------//
/datum/job/IG_trooper //This will be converted to the basic guardsman.
	title = "Trooper"
	flag = IGTROOPER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 50
	wage_payout = 45
	supervisors = "Commissar and your Platoon Sergeant."
	selection_color = "#A6EAA9"
	idtype = /obj/item/weapon/card/id/security
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_cadian_trooper
	species_whitelist = list("Human")
	landmark_job_override = TRUE

//--------------Trooper Outfit Datum----------------//
/datum/outfit/IG_cadian_trooper

	outfit_name = "Trooper"
	associated_job = /datum/job/IG_trooper

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/iguard/trooperbag,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/iguard/trooperbag,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/iguard/trooperbag,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/iguard/trooperbag,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = /obj/item/clothing/under/iguard/ig_guard,
			slot_head_str = /obj/item/clothing/head/iguard/IG_cadian_helmet,
			slot_shoes_str = /obj/item/clothing/shoes/iguard/IG_cadian_boots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/IG_cadian_armor,
			slot_s_store_str = /obj/item/weapon/gun/energy/laser/lasgun,
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
	)

	pda_type = /obj/item/device/pda/security
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/IG_trooper/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <b>Security:</b> [SEC_FREQ]<br/>")