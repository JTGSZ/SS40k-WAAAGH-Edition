/datum/job/clown
	title = "Celebrity"
	flag = CLOWN
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 15
	selection_color = "#dddddd"
	access = list(access_clown, access_theatre, access_maint_tunnels)
	minimal_access = list(access_clown, access_theatre)
	alt_titles = list("Jester")
	species_blacklist = list("Ork")
	outfit_datum = /datum/outfit/clown

	relationship_chance = HUMAN_COMMON

/datum/outfit/clown // Honk
	outfit_name = "Celebrity"
	associated_job = /datum/job/clown
	use_pref_bag = FALSE
	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/clown,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = list(
				"Clown" = /obj/item/clothing/under/rank/clown,
				"Jester" = /obj/item/clothing/under/jester,
			),
			slot_shoes_str = list(
				"Clown" = /obj/item/clothing/shoes/clown_shoes,
				"Jester" = /obj/item/clothing/shoes/jestershoes,
			),
			slot_head_str = list(
				"Jester" = /obj/item/clothing/head/jesterhat,
			),
			slot_wear_mask_str = /obj/item/clothing/mask/gas/clown_hat,
		),
		/datum/species/plasmaman/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = list(
				"Clown" = /obj/item/clothing/under/rank/clown,
				"Jester" = /obj/item/clothing/under/jester,
			),
			slot_shoes_str = list(
				"Clown" = /obj/item/clothing/shoes/clown_shoes,
				"Jester" = /obj/item/clothing/shoes/jestershoes,
			),
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/clown,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/clown,
			slot_wear_mask_str =  /obj/item/clothing/mask/gas/clown_hat,
		),
		/datum/species/vox/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = list(
				"Clown" = /obj/item/clothing/under/rank/clown,
				"Jester" = /obj/item/clothing/under/jester,
			),
			slot_shoes_str = list(
				"Clown" = /obj/item/clothing/shoes/clown_shoes,
				"Jester" = /obj/item/clothing/shoes/jestershoes,
			),
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ,
			slot_wear_mask_str =  /obj/item/clothing/mask/gas/clown_hat,
		),
	)

	items_to_collect = list( // No backup slots ; backbag pref ignored
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana = null, 
		/obj/item/weapon/bikehorn = null,
		/obj/item/weapon/stamp/clown = null,
		/obj/item/toy/crayon/rainbow = null,
		/obj/item/weapon/storage/fancy/crayons = null,
		/obj/item/toy/waterflower = null,
	)

	pda_type = /obj/item/device/pda/clown
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/clown

