/datum/job/chef
	title = "Chef"
	flag = CHEF
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 20
	selection_color = "#dddddd"
	access = list(access_hydroponics, access_bar, access_kitchen, access_morgue)
	minimal_access = list(access_kitchen, access_morgue, access_bar)
	alt_titles = list("Cook")

	outfit_datum = /datum/outfit/chef

	relationship_chance = HUMAN_COMMON

/datum/outfit/chef

	outfit_name = "Chef"
	associated_job = /datum/job/chef

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger,
	)
	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_service,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chef,
			slot_wear_suit_str = /obj/item/clothing/suit/chef,
			slot_head_str = /obj/item/clothing/head/chefhat,
			slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/plasmaman/ = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_service,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chef,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/service,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/service,
		),
		/datum/species/vox/ = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_service,
			slot_w_uniform_str = /obj/item/clothing/under/rank/bartender,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/chef,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/vox,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/chef,
		),
	)

	pda_type = /obj/item/device/pda/chef
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id

/datum/outfit/chef/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/> <b>Service:</b> [SER_FREQ]<br/>")

/datum/job/chef/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/flour(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/flour(H.back), slot_in_backpack)
