/datum/job/orknob
	title = "Ork Nob"
	flag = ORKNOB
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	alt_titles = list("Ork Nob")
	outfit_datum = /datum/outfit/orknob

/datum/outfit/orknob

	outfit_name = "Ork Nob"
	associated_job = /datum/job/orknob
	no_backpack = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = list(
				"Ork Nob" = /obj/item/clothing/under/color/grey,

			),
				slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork/nob = list( 
			slot_w_uniform_str = list(
				"Ork Nob" = list(/obj/item/clothing/under/ork/pants,
								/obj/item/clothing/under/ork/pantsandshirt,
								/obj/item/clothing/under/ork/leatherpantsandshirt)
			),
			slot_head_str = list(
				"Ork Nob" = list(/obj/item/clothing/head/ork/armorhelmet,
								/obj/item/clothing/head/ork/redbandana,
								/obj/item/clothing/head/ork/milcap)
			),
			slot_wear_suit_str = list(
				"Ork Nob" = list(/obj/item/clothing/suit/armor/ork/samuraiorkarmor,
								/obj/item/clothing/suit/armor/ork/rwallplate,
								/obj/item/clothing/suit/armor/ork/ironplate,
								/obj/item/clothing/suit/armor/ork/leatherbikervest)
			),
			slot_belt_str = list(
				"Ork Nob" = list(/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs)
			),
			slot_shoes_str = /obj/item/clothing/shoes/ork/orkboots,
			slot_back_str = /obj/item/weapon/storage/backpack/ork/brownbackpack,
			slot_r_hand = list(
				"Ork Nob" = list(/obj/item/weapon/gun/projectile/automatic/complexweapon/kustomshoota)
			),
		)
	)

/datum/outfit/orknob/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Nob")

/datum/outfit/orknob/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orknob/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boss = new
	new_boss.AssignToRole(H.mind,TRUE)
	new_boss.mind_storage(H.mind)