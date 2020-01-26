/datum/job/preacher
	title = "Preacher"
	flag = PREACHER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Ecclesiarchy"
	wage_payout = 25
	selection_color = "#E0D68B"
	access = list()
	minimal_access = list()
	var/datum/religion/chap_religion
	landmark_job_override = TRUE
	
	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/preacher

/datum/outfit/preacher

	outfit_name = "Preacher"
	associated_job = /datum/job/preacher
	no_backpack = TRUE

	//backpack_types = list(
	//	BACKPACK_STRING = /obj/item/weapon/storage/backpack,
	//	SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
	//	SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
	//	MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger,
	//)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/captain,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chaplain,
			slot_shoes_str = /obj/item/clothing/shoes/laceup,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_l_store_str = /obj/item/weapon/nullrod,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/iguard/preacherrobe,
			slot_back_str = /obj/item/weapon/gun/projectile/complexweapon/eviscerator,
		)
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	pda_type = /obj/item/device/pda/chaplain
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id


/datum/outfit/preacher/post_equip(var/mob/living/carbon/human/H)
	H.add_language("Spooky") //SPOOK
	ChooseReligion(H, FALSE) //Our mob, the second var is if we are a follower of Chaos.

/datum/job/preacher/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/bottle/holywater(H.back), slot_in_backpack)
