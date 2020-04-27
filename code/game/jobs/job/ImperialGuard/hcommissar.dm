//------------Commissar---------------//
/datum/job/commissar 
	title = "Commissar"
	flag = COMMISSAR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Regiment General"
	selection_color = "#E0D68B"
	req_admin_notify = 1
	wage_payout = 80
	access = list() 
	minimal_access = list()
	minimal_player_age = 30
	landmark_job_override = TRUE

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/commissar

	relationship_chance = HUMAN_NO_RELATIONS

//-------------Commissar Outfit Datum--------------//
/datum/outfit/commissar

	outfit_name = "Commissar"
	associated_job = /datum/job/commissar
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/hos,
			slot_w_uniform_str = /obj/item/clothing/under/iguard/commissar,
			slot_head_str = /obj/item/clothing/head/iguard/commissarcap,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/comissarcoat,
			slot_s_store_str = /obj/item/weapon/gun/projectile/automatic/boltpistol,
			slot_l_hand = /obj/item/weapon/chainsword
		),
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/heads/hos
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/hos

/datum/outfit/commissar/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ]<br/> <b>Security:</b> [SEC_FREQ]<br/>")

/datum/outfit/commissar/handle_faction(var/mob/living/M)
	var/datum/role/commissar/commissar = new
	commissar.AssignToRole(M.mind,TRUE)
	commissar.mind_storage(M.mind)