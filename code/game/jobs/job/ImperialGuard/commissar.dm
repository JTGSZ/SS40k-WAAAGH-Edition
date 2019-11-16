//------------Commissar---------------//
/datum/job/commissar
	title = "Commissar"
	flag = COMMISSAR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Regiment General"
	selection_color = "#ffdddd"
	req_admin_notify = 1
	wage_payout = 80
	access = list() 
	minimal_access = list()
	minimal_player_age = 30

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/commissar

/datum/job/commissar/reject_new_slots()
	if(security_level == SEC_LEVEL_RED)
		return FALSE
	else
		return "Red Alert"


//-------------Commissar Outfit Datum--------------//
/datum/outfit/commissar

	outfit_name = "Commissar"
	associated_job = /datum/job/commissar

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/security,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_sec,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/sec,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/hos,
			slot_w_uniform_str = /obj/item/clothing/under/rank/head_of_security,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/knifeholster,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/hos/jensen,
			slot_s_store_str = /obj/item/weapon/gun/energy/gun,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/hos,
			slot_w_uniform_str = /obj/item/clothing/under/rank/head_of_security,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/knifeholster,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/security/hos,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/security/hos,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_s_store_str = /obj/item/weapon/gun/energy/gun,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/hos,
			slot_w_uniform_str = /obj/item/clothing/under/rank/head_of_security,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/knifeholster,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/security,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/security,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_s_store_str = /obj/item/weapon/gun/energy/gun,
		),
	)

	items_to_collect = list(
		/obj/item/weapon/handcuffs = slot_r_store_str,
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/heads/hos
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/hos

/datum/outfit/commissar/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ]<br/> <b>Security:</b> [SEC_FREQ]<br/>")