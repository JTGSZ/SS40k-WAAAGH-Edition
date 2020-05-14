//--------------Sister Hospitaller---------------//
/datum/job/sister_hospitaller
	title = "Sister Hospitaller"
	flag = SISTERHOSPITALLER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "The Ecclesiarchy"
	selection_color = "#ffddf0"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/sister_hospitaller
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_NO_RELATIONS

/datum/outfit/sister_hospitaller

	outfit_name = "sister_hospitaller"
	associated_job = /datum/job/sister_hospitaller
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_sec,
			slot_w_uniform_str = /obj/item/clothing/under/inquisitor,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/iguard/inqhat,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/inq,
			slot_r_hand = /obj/item/weapon/powersword,
			slot_l_hand = /obj/item/weapon/gun/projectile/automatic/boltpistol
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/detective
	pda_slot = slot_r_store
	id_type = /obj/item/weapon/card/id/security

/datum/outfit/sister_hospitaller/post_equip(var/mob/living/carbon/human/H)
	H.setGender(FEMALE)
	H.my_appearance.h_style = "Bobcurl"
	H.my_appearance.b_hair = 255
	H.my_appearance.g_hair = 255
	H.my_appearance.r_hair = 255
	H.my_appearance.f_style = "Shaved"
	H.my_appearance.r_facial = 255
	H.my_appearance.g_facial = 255
	H.my_appearance.b_facial = 255
	H.update_hair()
	H.update_body()
	H.check_dna(H)


/datum/outfit/sister_hospitaller/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/inquisitor/inquisitor = new
	inquisitor.AssignToRole(M.mind,TRUE)
	inquisitor.mind_storage(M.mind)

/datum/outfit/sister_hospitaller/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 10
	H.attribute_agility = 12
	H.attribute_dexterity = 13
	return 1