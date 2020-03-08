/datum/job/general
	title = "General"
	flag = GENERAL
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the emperor, and the imperium of man"
	selection_color = "#78DB7D"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 30
	wage_payout = 100
	landmark_job_override = TRUE

	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/general

	relationship_chance = HUMAN_SUPER_RARE

/datum/job/general/get_access()
	return get_all_accesses()

/datum/outfit/general

	outfit_name = "General"
	associated_job = /datum/job/general
	no_backpack = TRUE

	//backpack_types = list(
	//	BACKPACK_STRING = /obj/item/weapon/storage/backpack/captain,
	//	SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_cap,
	//	SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
	//	MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/com,
	//)

	items_to_spawn = list( 
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/captain,
			slot_w_uniform_str = /obj/item/clothing/under/iguard/ig_guard,
			slot_shoes_str = /obj/item/clothing/shoes/iguard/IG_cadian_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/commanderarmor,
		)
	)
	
	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/captain
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id/gold

/datum/outfit/general/post_equip(var/mob/living/carbon/human/H)
	to_chat(world, "<b>[H.real_name] is the General!</b>")

/datum/outfit/general/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/new_general = new 
	new_general.AssignToRole(M.mind,TRUE)
	new_general.mind_storage(M.mind)
