// ------------ Sergeant --------------//
/datum/job/IG_trooper_sergeant
	title = "Sergeant"
	flag = IGSERGEANT
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_trooper_sergeant


// ------------ Sergeant Outfit Datum --------------//

/datum/outfit/IG_trooper_sergeant

	outfit_name = "Sergeant"
	associated_job = /datum/job/IG_trooper_sergeant

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/security,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_sec,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/sec,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = /obj/item/clothing/under/rank/warden,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_glasses_str = /obj/item/clothing/glasses/sunglasses/sechud,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/hos/jensen,
			slot_l_store_str = /obj/item/device/flash,
		),
	)

	items_to_collect = list(
		/obj/item/weapon/handcuffs = slot_r_store_str,
		/obj/item/weapon/gun/energy/taser = GRASP_LEFT_HAND,
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/warden
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/IG_trooper_sergeant/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/> <b>Security:</b> [SEC_FREQ]<br/>")