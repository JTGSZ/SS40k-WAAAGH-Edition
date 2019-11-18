//--------------Inquisitor---------------//
/datum/job/inquisitor //This will be inquisitor
	title = "Inquisitor"
	flag = INQUISITOR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "the Emperor"
	selection_color = "#ffeeee"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/inquisitor
	species_whitelist = list("Human")

//-------------Inquisitor Outfit Datums--------------//
/datum/outfit/inquisitor

	outfit_name = "Inquisitor"
	associated_job = /datum/job/inquisitor

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/sec,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = /obj/item/clothing/under/inquisitor,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/iguard/inqhat,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/inq,
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/detective
	pda_slot = slot_r_store
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/inquisitor/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <b>Security:</b> [SEC_FREQ]<br/>")