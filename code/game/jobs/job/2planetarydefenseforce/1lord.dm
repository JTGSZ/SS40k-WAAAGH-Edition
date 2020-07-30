
/datum/job/lord
	title = "Lord"
	flag = LORD
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "yourself, and maybe the imperium"
	selection_color = "#f8cb69"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 30
	wage_payout = 100
	landmark_job_override = TRUE

	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/general

	relationship_chance = HUMAN_SUPER_RARE

/datum/job/lord/get_access()
	return get_all_accesses()

/datum/outfit/lord

	outfit_name = "Lord"
	associated_job = /datum/job/lord
	no_backpack = TRUE

	items_to_spawn = list( 
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
			slot_shoes_str = /obj/item/clothing/shoes/IG_cadian_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/commanderarmor,
			slot_r_hand = /obj/item/weapon/powersword,
			slot_r_store_str = /obj/item/weapon/shield/energy,
			slot_s_store_str = /obj/item/weapon/gun/projectile/automatic/boltpistol,
		)
	)
	 
	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/lord/post_equip(var/mob/living/carbon/human/H)
	to_chat(world, "<b>[H.real_name] is the Lord of these lands!</b>")

