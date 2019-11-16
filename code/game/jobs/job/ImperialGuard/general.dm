/datum/job/general
	title = "General"
	flag = GENERAL
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the emperor, and the imperium of man"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 30
	wage_payout = 100

	species_whitelist = list("Human")

	pdaslot=slot_l_store
	pdatype=/obj/item/device/pda/captain

/datum/job/general/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	H.equip_or_collect(new /obj/item/device/radio/headset/heads/captain(H), slot_ears)
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/captain(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_cap(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger/com(H), slot_back)
	H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
	H.equip_or_collect(new /obj/item/clothing/head/caphat(H), slot_head)
	H.equip_or_collect(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	if(H.backbag == 1)
		H.put_in_hand(GRASP_RIGHT_HAND, new /obj/item/weapon/storage/box/ids(H))
		H.put_in_hand(GRASP_LEFT_HAND, new /obj/item/weapon/gun/energy/gun(H))
	else
		H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H.back), slot_in_backpack)
		H.equip_or_collect(new /obj/item/weapon/gun/energy/gun(H), slot_in_backpack)
	equip_accessory(H, /obj/item/clothing/accessory/medal/gold/captain, /obj/item/clothing/under)
	var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
	L.imp_in = H
	L.implanted = 1
	to_chat(world, "<b>[H.real_name] is the General!</b>")
	var/datum/organ/external/affected = H.get_organ(LIMB_HEAD)
	affected.implants += L
	L.part = affected
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ] <br/> <b>Security:</b> [SEC_FREQ] <br/> <b>Medical:</b> [MED_FREQ] <br/> <b>Science:</b> [SCI_FREQ] <br/> <b>Engineering:</b> [ENG_FREQ] <br/> <b>Service:</b> [SER_FREQ] <b>Cargo:</b> [SUP_FREQ]<br/>")
	return 1

/datum/job/general/get_access()
	return get_all_accesses()

/datum/job/general/reject_new_slots()
	if(security_level == SEC_LEVEL_RED)
		return FALSE
	else
		return "Red Alert"