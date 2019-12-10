// -- Medical outfits
// -- CMO

/datum/outfit/cmo

	outfit_name = "Chief Medical Officer"
	associated_job = /datum/job/cmo

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/medic,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_med,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/med,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/storage/labcoat/cmo,
			slot_s_store_str = /obj/item/device/flashlight/pen,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/medical/cmo,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/medical/cmo,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/medical/cmo,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/medical/cmo,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
	)

	pda_type = /obj/item/device/pda/heads/cmo
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/cmo

/datum/outfit/cmo/post_equip(var/mob/living/carbon/human/H)
	H.put_in_hands(new /obj/item/weapon/storage/firstaid/regular(get_turf(H)))
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ] <b>Medical:</b> [MED_FREQ]")


/datum/outfit/doctor

	outfit_name = "Medical Doctor"
	associated_job = /datum/job/doctor

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/medic,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_med,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/med,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = list(
				"Emergency Physician" = /obj/item/clothing/suit/storage/fr_jacket,
				"Surgeon" =  /obj/item/clothing/suit/storage/labcoat,
				"Medical Doctor" =  /obj/item/clothing/suit/storage/labcoat,
			),
			slot_head_str = list(
				"Surgeron" = /obj/item/clothing/head/surgery/blue,
			),
			slot_s_store_str = /obj/item/device/flashlight/pen,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/medical,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/medical,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/medical,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/medical,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
	)

	pda_type = /obj/item/device/pda/medical
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/medical

	special_snowflakes = list(
		"Default" = list(
			"Nurse" = list(slot_w_uniform_str, slot_head_str),
		),
	)

// This right here is the proof that the female gender should be removed from the codebase. Fucking snowflakes

/datum/outfit/doctor/special_equip(var/title, var/slot, var/mob/living/carbon/human/H)
	switch (title)
		if ("Nurse")
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

/datum/outfit/doctor/post_equip(var/mob/living/carbon/human/H)
	H.put_in_hands(new /obj/item/weapon/storage/firstaid/regular(get_turf(H)))
	H.mind.store_memory("Frequencies list: <br/><b>Medical:</b> [MED_FREQ]")

