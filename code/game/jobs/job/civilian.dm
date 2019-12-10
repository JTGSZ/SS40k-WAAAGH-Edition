//Food
/datum/job/bartender
	title = "Bartender"
	flag = BARTENDER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 20
	selection_color = "#dddddd"
	access = list(access_hydroponics, access_bar, access_kitchen, access_morgue, access_weapons)
	minimal_access = list(access_bar,access_weapons)

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/bar

/datum/job/bartender/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger(H), slot_back)
	H.equip_or_collect(new /obj/item/device/radio/headset/headset_service(H), slot_ears)
	H.equip_or_collect(new /obj/item/clothing/shoes/black(H), slot_shoes)
	H.equip_or_collect(new /obj/item/clothing/suit/armor/vest(H), slot_wear_suit)
	H.equip_or_collect(new /obj/item/clothing/under/rank/bartender(H), slot_w_uniform)
	H.put_in_hands(new /obj/item/weapon/storage/bag/plasticbag(H))
	//H.equip_or_collect(new /obj/item/device/pda/bar(H), slot_belt)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/shaker(H), slot_l_store)//each bartender brings their own

	if(H.backbag == 1)
		var/obj/item/weapon/storage/box/survival/Barpack = new H.species.survival_gear(H)
		H.put_in_hand(GRASP_RIGHT_HAND, Barpack)
		new /obj/item/ammo_casing/shotgun/beanbag(Barpack)
		new /obj/item/ammo_casing/shotgun/beanbag(Barpack)
		new /obj/item/ammo_casing/shotgun/beanbag(Barpack)
		new /obj/item/ammo_casing/shotgun/beanbag(Barpack)
	else
		H.equip_or_collect(new H.species.survival_gear(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/ammo_casing/shotgun/beanbag(H), slot_in_backpack)

	H.dna.SetSEState(SOBERBLOCK,1)
	H.mutations += M_SOBER
	H.check_mutations = 1
	H.mind.store_memory("Frequencies list: <br/> <b>Service:</b> [SER_FREQ]<br/>")

	return 1

/datum/job/bartender/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/circuitboard/chem_dispenser/soda_dispenser(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/circuitboard/chem_dispenser/booze_dispenser(H.back), slot_in_backpack)


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

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/chef

/datum/job/chef/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger(H), slot_back)
	H.equip_or_collect(new /obj/item/device/radio/headset/headset_service(H), slot_ears)
	H.equip_or_collect(new /obj/item/clothing/under/rank/chef(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/suit/chef(H), slot_wear_suit)
	H.equip_or_collect(new /obj/item/clothing/shoes/black(H), slot_shoes)
	H.equip_or_collect(new /obj/item/clothing/head/chefhat(H), slot_head)
	H.put_in_hands(new /obj/item/weapon/storage/bag/plasticbag(H))
	//H.equip_or_collect(new /obj/item/device/pda/chef(H), slot_belt)
	if(H.backbag == 1)
		H.put_in_hand(GRASP_RIGHT_HAND, new H.species.survival_gear(H))
	else
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	H.mind.store_memory("Frequencies list: <br/> <b>Service:</b> [SER_FREQ]<br/>")
	return 1

/datum/job/chef/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/flour(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/flour(H.back), slot_in_backpack)

/datum/job/clown
	title = "Clown"
	flag = CLOWN
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 15
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/clown
	access = list(access_clown, access_theatre, access_maint_tunnels)
	minimal_access = list(access_clown, access_theatre)
	alt_titles = list("Jester")

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/clown

/datum/job/clown/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	H.equip_or_collect(new /obj/item/weapon/storage/backpack/clown(H), slot_back)
	H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	//H.equip_or_collect(new /obj/item/device/pda/clown(H), slot_belt)
	H.equip_or_collect(new /obj/item/clothing/mask/gas/clown_hat(H), slot_wear_mask)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/snacks/grown/banana(H), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/bikehorn(H), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/stamp/clown(H), slot_in_backpack)
	H.equip_or_collect(new /obj/item/toy/crayon/rainbow(H), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/storage/fancy/crayons(H), slot_in_backpack)
	H.equip_or_collect(new /obj/item/toy/waterflower(H), slot_in_backpack)
	H.mutations.Add(M_CLUMSY)
	if (H.mind.role_alt_title)
		switch(H.mind.role_alt_title)
			if("Jester")
				H.equip_or_collect(new /obj/item/clothing/under/jester(H), slot_w_uniform)
				H.equip_or_collect(new /obj/item/clothing/shoes/jestershoes(H), slot_shoes)
				H.equip_or_collect(new /obj/item/clothing/head/jesterhat(H), slot_head)
			else
				H.equip_or_collect(new /obj/item/clothing/under/rank/clown(H), slot_w_uniform)
				H.equip_or_collect(new /obj/item/clothing/shoes/clown_shoes(H), slot_shoes)
	H.fully_replace_character_name(H.real_name,pick(clown_names))
	H.dna.real_name = H.real_name
	mob_rename_self(H,"clown")
	return 1

/datum/job/clown/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/coin/clown(H.back), slot_in_backpack)

/datum/job/clown/reject_new_slots()
	if(Holiday == APRIL_FOOLS_DAY)
		return FALSE
	if(!xtra_positions)
		return FALSE
	if(security_level == SEC_LEVEL_RAINBOW)
		return FALSE
	else
		return "Rainbow Alert"

/datum/job/clown/get_total_positions()
	if(Holiday == APRIL_FOOLS_DAY)
		spawn_positions = -1
		return 99
	else
		return ..()

/datum/job/mime
	title = "Mime"
	flag = MIME
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 15
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/mime
	access = list(access_mime, access_theatre, access_maint_tunnels)
	minimal_access = list(access_mime, access_theatre)

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/mime

/datum/job/mime/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger(H), slot_back)
	H.equip_or_collect(new /obj/item/clothing/under/mime(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/mime(H), slot_shoes)
	//H.equip_or_collect(new /obj/item/device/pda/mime(H), slot_belt)
	H.equip_or_collect(new /obj/item/clothing/gloves/white(H), slot_gloves)
	H.equip_or_collect(new /obj/item/clothing/mask/gas/mime(H), slot_wear_mask)
	H.equip_or_collect(new /obj/item/clothing/head/beret(H), slot_head)
	H.equip_or_collect(new /obj/item/clothing/suit/suspenders(H), slot_wear_suit)
	if(H.backbag == 1)
		H.put_in_hand(GRASP_RIGHT_HAND, new H.species.survival_gear(H))
		H.equip_or_collect(new /obj/item/toy/crayon/mime(H), slot_l_store)
		H.put_in_hands(new /obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing(H))
	else
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
		H.equip_or_collect(new /obj/item/toy/crayon/mime(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing(H), slot_in_backpack)
	H.add_spell(new /spell/aoe_turf/conjure/forcewall/mime, "grey_spell_ready")
	H.add_spell(new /spell/targeted/oathbreak/)
	H.mind.miming = MIMING_OUT_OF_CHOICE
	mob_rename_self(H,"mime")
	return 1

/datum/job/mime/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/food/snacks/baguette(H.back), slot_in_backpack)

/datum/job/mime/reject_new_slots()
	if(!xtra_positions)
		return FALSE
	if(security_level == SEC_LEVEL_RAINBOW)
		return FALSE
	else
		return "Rainbow Alert"

//Mime's break vow spell, couldn't think of anywhere else to put this

/spell/targeted/oathbreak
	name = "Break Oath of Silence"
	desc = "Break your oath of silence."
	school = "mime"
	panel = "Mime"
	charge_max = 10
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

	hud_state = "mime_oath"
	override_base = "const"

/spell/targeted/oathbreak/cast(list/targets)
	for(var/mob/living/carbon/human/M in targets)
		var/response = alert(M, "Are you -sure- you want to break your oath of silence?\n(This removes your ability to create invisible walls and cannot be undone!)","Are you sure you want to break your oath?","Yes","No")
		if(response != "Yes")
			return
		M.mind.miming=0
		for(var/spell/aoe_turf/conjure/forcewall/mime/spell in M.spell_list)
			M.remove_spell(spell)
		for(var/spell/targeted/oathbreak/spell in M.spell_list)
			M.remove_spell(spell)
		message_admins("[M.name] ([M.ckey]) has broken their oath of silence. (<A HREF='?_src_=holder;adminplayerobservejump=\ref[M]'>JMP</a>)")
		to_chat(M, "<span class = 'notice'>An unsettling feeling surrounds you...</span>")
		return

/datum/job/janitor
	title = "Janitor"
	flag = JANITOR
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	wage_payout = 20
	selection_color = "#dddddd"
	access = list(access_janitor, access_maint_tunnels)
	minimal_access = list(access_janitor, access_maint_tunnels)

	pdaslot=slot_belt
	pdatype=/obj/item/device/pda/janitor

/datum/job/janitor/equip(var/mob/living/carbon/human/H)
	if(!H)
		return 0
	switch(H.backbag)
		if(2)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
		if(4)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5)
			H.equip_or_collect(new /obj/item/weapon/storage/backpack/messenger(H), slot_back)
	H.equip_or_collect(new /obj/item/clothing/under/rank/janitor(H), slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/black(H), slot_shoes)
	H.put_in_hands(new /obj/item/weapon/storage/bag/plasticbag(H))
	//H.equip_or_collect(new /obj/item/device/pda/janitor(H), slot_belt)
	if(H.backbag == 1)
		H.put_in_hand(GRASP_RIGHT_HAND, new H.species.survival_gear(H))
	else
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
	// Now spawns on the janikart.  H.equip_or_collect(new /obj/item/key(H), slot_l_store)

	H.add_language(LANGUAGE_MOUSE)
	to_chat(H, "<span class = 'notice'>Decades of roaming maintenance tunnels and interacting with its denizens have granted you the ability to understand the speech of mice and rats.</span>")

	return 1

/datum/job/janitor/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/grenade/chem_grenade/cleaner(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/spray/cleaner(H.back), slot_in_backpack)
