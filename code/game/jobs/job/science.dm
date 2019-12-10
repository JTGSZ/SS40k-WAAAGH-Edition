/datum/job/rd
	title = "Research Director"
	flag = RD
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	wage_payout = 80
	selection_color = "#ffddff"
	idtype = /obj/item/weapon/card/id/rd
	req_admin_notify = 1
	access = list(access_rd, access_heads, access_rnd, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_science, access_robotics, access_xenobiology, access_ai_upload,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_mechanic)
	minimal_access = list(access_rd, access_heads, access_rnd, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_science, access_robotics, access_xenobiology, access_ai_upload,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_mechanic)
	minimal_player_age = 20

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/heads/rd

/datum/job/rd/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_tox(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger/tox(H), slot_back)
	H.equip_or_collect(new /obj/item/device/radio/headset/heads/rd(H), slot_ears)
	H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
	H.equip_or_collect(new /obj/item/clothing/under/rank/research_director(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/suit/storage/labcoat/rd(H), slot_wear_suit)
	H.put_in_hands(new /obj/item/weapon/storage/bag/clipboard(H))
	if(H.backbag == 1)
		H.put_in_hand(GRASP_RIGHT_HAND, new H.species.survival_gear(H))
	else
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	equip_accessory(H, pick(ties), /obj/item/clothing/under)
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ] <br/> <b>Science:</b> [SCI_FREQ]<br/>")
	return 1
