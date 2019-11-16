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
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/security
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_trooper
	species_whitelist = list("Human")
/datum/job/IG_trooper/get_total_positions()
	. = ..()

	var/datum/job/assistant = job_master.GetJob("Assistant")
	if(assistant.current_positions > 5)
		. = clamp(. + assistant.current_positions - 5, 0, 99)



//--------------Trooper Outfit Datum----------------//
/datum/outfit/IG_trooper

	outfit_name = "Trooper"
	associated_job = /datum/job/IG_trooper

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/security,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_sec,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/sec,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = /obj/item/clothing/under/rank/security,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/hos/jensen,
			slot_s_store_str = /obj/item/weapon/gun/energy/taser,
			slot_l_store_str = /obj/item/device/flash,
		),
	)

	items_to_collect = list(
		/obj/item/weapon/handcuffs = slot_r_store_str,
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/security
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/IG_trooper/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <b>Security:</b> [SEC_FREQ]<br/>")