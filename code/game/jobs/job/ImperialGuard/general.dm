/datum/job/general
	title = "General"
	flag = GENERAL
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the emperor, and the imperium of man"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 30
	wage_payout = 100

	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/general


/datum/job/general/get_access()
	return get_all_accesses()

/datum/outfit/general

	outfit_name = "General"
	associated_job = /datum/job/general

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/captain,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_cap,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/com,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_helmet_str = /obj/item/clothing/head/caphat,
			slot_ears_str = /obj/item/device/radio/headset/heads/captain,
			slot_w_uniform_str = /obj/item/clothing/under/rank/captain,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/hos/jensen,
			slot_l_store_str = /obj/item/device/flash
		),
	)
	items_to_collect = list(
		/obj/item/weapon/storage/box/ids,
		/obj/item/weapon/gun/energy/gun
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/captain
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id/gold

/datum/outfit/IG_trooper_sergeant/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ] <br/> <b>Security:</b> [SEC_FREQ] <br/> <b>Medical:</b> [MED_FREQ] <br/> <b>Science:</b> [SCI_FREQ] <br/> <b>Engineering:</b> [ENG_FREQ] <br/> <b>Service:</b> [SER_FREQ] <b>Cargo:</b> [SUP_FREQ]<br/>")
	to_chat(world, "<b>[H.real_name] is the General!</b>")
