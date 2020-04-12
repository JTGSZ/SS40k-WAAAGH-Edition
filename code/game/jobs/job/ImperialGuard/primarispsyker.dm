
/datum/job/primarispsyker
	title = "Primaris Psyker"
	flag = PRIMARISPSYKER 
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	wage_payout = 65
	supervisors = "the Emperor"
	selection_color = "#E0D68B"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/primarispsyker
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_NO_RELATIONS


/datum/outfit/primarispsyker

	outfit_name = "Primaris Psyker"
	associated_job = /datum/job/primarispsyker
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/captain,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chaplain,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/iguard/primarispsykertop,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/primarispsykerrobe,
			slot_back_str = /obj/item/weapon/psykerstaff,
			slot_belt_str = /obj/item/weapon/psychic_spellbook,
		)
	)

	pda_type = /obj/item/device/pda/chaplain
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id

/datum/outfit/primarispsyker/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Fuck you")

/datum/outfit/primarispsyker/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/new_trooper = new
	new_trooper.AssignToRole(M.mind,TRUE)
	new_trooper.mind_storage(M.mind)

/datum/outfit/primarispsyker/handle_special_abilities(var/mob/living/carbon/human/H)
	return 1
