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
	alt_titles = list("Forensic Technician","Gumshoe")
	minimal_player_age = 7
	outfit_datum = /datum/outfit/inquisitor


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
			slot_w_uniform_str = list(
				"Forensic Technician" = /obj/item/clothing/under/det,
				"Gumshoe" = /obj/item/clothing/under/det/noir,
				"Inquisitor" = /obj/item/clothing/under/det,
			),
			slot_shoes_str = list(
				"Forensic Technician" = /obj/item/clothing/shoes/brown,
				"Gumshoe" = /obj/item/clothing/shoes/laceup,
				"Inquisitor" = /obj/item/clothing/shoes/brown,
			),
			slot_helmet_str = list(
				"Gumshoe" = /obj/item/clothing/head/det_hat/noir,
				"Inquisitor" = /obj/item/clothing/head/det_hat,
			),
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = list(
				"Forensic Technician" = /obj/item/clothing/suit/storage/forensics/blue,
				"Gumshoe" = /obj/item/clothing/suit/storage/det_suit/noir,
				"Inquisitor" = /obj/item/clothing/suit/storage/det_suit,
			),
			slot_l_store_str = /obj/item/weapon/lighter/zippo,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = list(
				"Forensic Technician" = /obj/item/clothing/under/det,
				"Gumshoe" = /obj/item/clothing/shoes/laceup,
				"Inquisitor" = /obj/item/clothing/under/det,
			),
			slot_shoes_str = list(
				"Forensic Technician" = /obj/item/clothing/shoes/brown,
				"Gumshoe" = /obj/item/clothing/shoes/laceup,
				"Inquisitor" = /obj/item/clothing/shoes/brown,
			),
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/security/detective,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/security/detective,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_l_store_str = /obj/item/weapon/lighter/zippo,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = list(
				"Forensic Technician" = /obj/item/clothing/under/det,
				"Gumshoe" = /obj/item/clothing/under/det/noir,
				"Inquisitor" = /obj/item/clothing/under/det,
			),
			slot_shoes_str = list(
				"Forensic Technician" = /obj/item/clothing/shoes/brown,
				"Gumshoe" = /obj/item/clothing/under/det/noir,
				"Inquisitor" = /obj/item/clothing/shoes/brown,
			),
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/security,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/security,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_l_store_str = /obj/item/weapon/lighter/zippo,
		),
	)

	items_to_collect = list(
		/obj/item/weapon/storage/box/evidence = GRASP_LEFT_HAND,
		/obj/item/device/detective_scanner =  slot_belt_str,
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/detective
	pda_slot = slot_r_store
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/inquisitor/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <b>Security:</b> [SEC_FREQ]<br/>")
	H.dna.SetSEState(SOBERBLOCK,1)
	H.mutations += M_SOBER
	if (H.mind.role_alt_title == "Gumshoe")
		H.mutations += M_NOIR
		H.dna.SetSEState(NOIRBLOCK,1)