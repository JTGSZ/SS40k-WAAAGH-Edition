/datum/job/basicork
	title = "Slugga Boy"
	flag = BASICORK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "da boss"
	selection_color = "#ffeef0"
	access = list()
	minimal_access = list()
	alt_titles = list("Slugga Boy", "Shoota Boy", "Kommando", "Burna Boy", "Storm Boy")
	outfit_datum = /datum/outfit/basicork

/datum/outfit/basicork

	outfit_name = "Basic Ork"
	associated_job = /datum/job/basicork

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/medic,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_chem,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/chem,
	)

	items_to_spawn = list(
		"Default" = list( 
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Slugga Boy" =	/obj/item/clothing/under/color/grey,
				"Shoota Boy" = /obj/item/clothing/under/color/grey,
				"Kommando" = /obj/item/clothing/under/color/grey,
				"Burna Boy" = /obj/item/clothing/under/color/grey,
				"Storm Boy" = /obj/item/clothing/under/color/grey,
			),
			slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Slugga Boy" =	/obj/item/clothing/under/color/grey,,
				"Shoota Boy" = /obj/item/clothing/under/color/grey,,
				"Kommando" = /obj/item/clothing/under/color/grey,
				"Burna Boy" = /obj/item/clothing/under/color/grey,
				"Storm Boy" = /obj/item/clothing/under/color/grey,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/science,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/medical/chemist,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/medical/chemist,
			slot_wear_mask_str = /obj/item/clothing/mask/breath/,
		),
	)

	pda_type = /obj/item/device/pda/chemist
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/medical

	special_snowflakes = list(
		"Default" = list(
			"Nurse" = list(slot_w_uniform_str, slot_head_str),
		),
	)

// Handles the randomly generated equipment on basic boyz, ja?

/datum/outfit/basicork/special_equip(var/title, var/slot, var/mob/living/carbon/human/H)
	switch (title)
		if ("Slugga Boy" || "Shoota Boy" || "Kommando" || "Burna Boy" || "Storm Boy")
			switch (slot)
				if (slot_w_uniform_str)
					if(H.gender == FEMALE)
						if(prob(50))
							H.equip_or_collect(new /obj/item/clothing/under/rank/nursesuit(H), slot_w_uniform)
						else
							H.equip_or_collect(new /obj/item/clothing/under/rank/nurse(H), slot_w_uniform)
					else
						H.equip_or_collect(new /obj/item/clothing/under/rank/medical/purple(H), slot_w_uniform)
				if (slot_head_str)
					if (H.gender == FEMALE)
						H.equip_or_collect(new /obj/item/clothing/head/nursehat(H), slot_head)

/datum/outfit/basicork/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")