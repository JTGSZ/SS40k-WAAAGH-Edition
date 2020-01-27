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
	selection_color = "#A6EAA9"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_trooper_sergeant
	species_whitelist = list("Human")
	landmark_job_override = TRUE

// ------------ Sergeant Outfit Datum --------------//

/datum/outfit/IG_trooper_sergeant

	outfit_name = "Sergeant"
	associated_job = /datum/job/IG_trooper_sergeant

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
			slot_head_str = /obj/item/clothing/head/iguard/IG_cadian_sergeant_helmet,
			slot_shoes_str = /obj/item/clothing/shoes/iguard/IG_cadian_boots,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/IG_cadian_sergeant_armor,
			slot_s_store_str = /obj/item/weapon/gun/energy/complexweapon/lasgun,
		),
	)

	items_to_collect = list(
		/obj/item/weapon/complexweapon/chainsword = GRASP_LEFT_HAND,
	)

	implant_types = list(
	)

	pda_type = /obj/item/device/pda/warden
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/IG_trooper_sergeant/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/> <b>Security:</b> [SEC_FREQ]<br/>")