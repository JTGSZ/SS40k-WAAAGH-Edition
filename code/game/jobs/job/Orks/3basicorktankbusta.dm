/datum/job/orktankbusta
	title = "Ork Tankbusta"
	flag = ORKTANKBUSTA
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	alt_titles = list("Ork Tankbusta")
	outfit_datum = /datum/outfit/orktankbusta

	relationship_chance = XENO_NO_RELATIONS

/datum/outfit/orktankbusta

	outfit_name = "Ork Tankbusta"
	associated_job = /datum/job/orktankbusta
	no_backpack = TRUE
	no_id = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/iguard/ig_guard,
		),
		/datum/species/ork = list(
			slot_w_uniform_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/under/ork/pantsandshirt,
									/obj/item/clothing/under/ork/pants,
									/obj/item/clothing/under/ork/leatherpantsandshirt)
			),
			slot_shoes_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/shoes/ork/orkboots)
			),
			slot_gloves_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/gloves/ork/clothgloves)
			),
			slot_belt_str = list(
				"Ork Tankbusta" = list(/obj/item/weapon/storage/belt/ork/armorbelt/rokkitbelt,
										/obj/item/weapon/storage/belt/ork/basicbelt/rokkitbelt)
			),
			slot_head_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/head/ork/armorhelmet,
									/obj/item/clothing/head/ork/bucket,
									/obj/item/clothing/head/ork/redbandana,
									/obj/item/clothing/head/ork/milcap)
			),
			slot_wear_suit_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/suit/armor/ork/samuraiorkarmor,
									/obj/item/clothing/suit/armor/ork/rwallplate,
									/obj/item/clothing/suit/armor/ork/ironplate,
									/obj/item/clothing/suit/armor/ork/leatherbikervest)
			),
			slot_back_str = list(
				"Ork Tankbusta" = list(/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha)
			)
		)
	)


/datum/outfit/orktankbusta/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orktankbusta/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_busta = new
	new_busta.AssignToRole(H.mind,TRUE)
	new_busta.mind_storage(H.mind)

/datum/outfit/orktankbusta/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(/spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
