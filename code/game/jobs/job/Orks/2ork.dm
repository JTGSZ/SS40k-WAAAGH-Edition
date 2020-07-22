/datum/job/basicork
	title = "(RNG) Various Orks"
	flag = BASICORK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 10
	wage_payout = 0
	supervisors = "yaself"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/basicork

	relationship_chance = XENO_NO_RELATIONS

/datum/outfit/basicork

	outfit_name = "Basic Ork"
	associated_job = /datum/job/basicork
	no_backpack = TRUE
	no_id = TRUE
	var/list/ork_uniforms =	list(/obj/item/clothing/under/ork/pantsandshirt,
							/obj/item/clothing/under/ork/pants,
							/obj/item/clothing/under/ork/leatherpantsandshirt
							)
	var/list/ork_hats = list(/obj/item/clothing/head/ork/armorhelmet,
								/obj/item/clothing/head/ork/bucket,
								/obj/item/clothing/head/ork/redbandana,
								/obj/item/clothing/head/ork/milcap
								)
	var/list/ork_suits = list(/obj/item/clothing/suit/armor/ork/samuraiorkarmor,
							/obj/item/clothing/suit/armor/ork/rwallplate,
							/obj/item/clothing/suit/armor/ork/ironplate,
							/obj/item/clothing/suit/armor/ork/leatherbikervest
							)
	var/list/ork_belts = list(/obj/item/weapon/storage/belt/ork/armorbelt,
							/obj/item/weapon/storage/belt/ork/basicbelt
							)
	var/list/ork_shoes = list(/obj/item/clothing/shoes/ork/orkboots
							)

	var/list/ork_mek_hats = list(/obj/item/clothing/head/ork/redbandana,
								/obj/item/clothing/head/ork/milcap)
	

/datum/outfit/basicork/bypass_list_equips(var/mob/living/carbon/human/H)
	var/object = null
	var/numerical_fun = rand(1,11)
	switch(numerical_fun)
		if(1 to 8) //Standard Orks
			object = pick(ork_uniforms)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_w_uniform, TRUE)
			object = pick(ork_hats)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_head, TRUE)
			object = pick(ork_suits)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_wear_suit, TRUE)
			object = pick(ork_belts)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_belt, TRUE)
			object = pick(ork_shoes)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_shoes, TRUE)
		if(9 to 10) //Gretchin
			H.set_species("Ork Gretchin")
		if(11) //Mek
			object = pick(ork_uniforms)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_w_uniform, TRUE)
			object = pick(ork_mek_hats)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_head, TRUE)
			object = pick(ork_shoes)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_shoes, TRUE)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/ork/leatherbikervest(get_turf(H)), slot_wear_suit, TRUE)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/ork/brownbackpack(get_turf(H)), slot_back, TRUE)
			H.add_spell(new /spell/aoe_turf/mekbuild, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
			H.attribute_strength = 12
	return 1

/datum/outfit/basicork/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/basicork/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boy = new
	new_boy.AssignToRole(H.mind,TRUE)
	new_boy.mind_storage(H.mind)

/datum/outfit/basicork/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)

