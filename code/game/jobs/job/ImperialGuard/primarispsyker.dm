//--------------Inquisitor---------------//
/datum/job/primarispsyker //This will be inquisitor
	title = "Primaris Psyker"
	flag = PRIMARISPSYKER 
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "the Emperor"
	selection_color = "#E0D68B"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/primarispsyker
	species_whitelist = list("Human")
	landmark_job_override = TRUE

//-------------Inquisitor Outfit Datums--------------//
/datum/outfit/primarispsyker

	outfit_name = "Primaris Psyker"
	associated_job = /datum/job/primarispsyker

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/sec,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/captain,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chaplain,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/iguard/primarispsykertop,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/primarispsykerrobe,
		),
	)
	items_to_collect = list(
		/obj/item/weapon/psykerstaff = GRASP_LEFT_HAND,
	)

	pda_type = /obj/item/device/pda/chaplain
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id

/datum/outfit/inquisitor/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Fuck you")
