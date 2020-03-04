/datum/job/basicork
	title = "Slugga Boy"
	flag = BASICORK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	minimal_access = list()
	landmark_job_override = TRUE
	alt_titles = list("Slugga Boy", "Shoota Boy", "Kommando", "Burna Boy", "Storm Boy")
	outfit_datum = /datum/outfit/basicork

/datum/outfit/basicork

	outfit_name = "Basic Ork"
	associated_job = /datum/job/basicork
	no_backpack = TRUE // We handle it in snowflakes.

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/ork/brownbackpack,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = list(
				"Slugga Boy" = /obj/item/clothing/under/color/grey,
				"Shoota Boy" =  /obj/item/clothing/under/color/grey,
				"Kommando" = /obj/item/clothing/under/color/grey,
				"Burna Boy" = /obj/item/clothing/under/color/grey,
				"Storm Boy" =/obj/item/clothing/under/color/grey,
			),
				slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork = list( 
			slot_w_uniform_str = list(
				"Slugga Boy" =	/obj/item/clothing/under/ork/pants,
				"Shoota Boy" = /obj/item/clothing/under/ork/pants,
				"Kommando" = /obj/item/clothing/under/ork/pants,
				"Burna Boy" = /obj/item/clothing/under/ork/pants,
				"Storm Boy" = /obj/item/clothing/under/ork/pants,
				),
			
			slot_shoes_str = /obj/item/clothing/shoes/ork/orkboots,
		
			slot_back_str = list(
				"Slugga Boy" = /obj/item/weapon/storage/backpack/ork/brownbackpack,
				"Shoota Boy" = /obj/item/weapon/storage/backpack/ork/brownbackpack,
				"Kommando"	= /obj/item/weapon/storage/backpack/ork/brownbackpack,
				"Burna Boy"	= /obj/item/weapon/ork/burnapack,
				"Storm Boy"	= /obj/item/ork/jumppack,
				),
		)
	)



// Handles the randomly generated equipment on basic boyz, ja? 

/datum/outfit/basicork/special_equip(var/title, var/slot, var/mob/living/carbon/human/H)
	switch(title)
		if("Slugga Boy" || "Shoota Boy" || "Kommando" || "Burna Boy" || "Storm Boy")
			switch(slot)
				if(slot_gloves_str) //Gloves
					if(prob(25))
						H.equip_or_collect(new /obj/item/clothing/gloves/ork/clothgloves(H), slot_gloves)
				if(slot_w_uniform_str) //Uniform
					if(prob(50))
						H.equip_or_collect(new /obj/item/clothing/under/ork/pantsandshirt(H), slot_w_uniform)
					else
						H.equip_or_collect(new /obj/item/clothing/under/ork/leatherpantsandshirt(H), slot_w_uniform)
//				if(slot_head_str) //Head
//				if(slot_wear_suit_str) //suit
//				if(slot_shoes_str) //Shoes
//				if(slot_belt_str) //Belt
//				if(slot_back_str) //Back
//				

/datum/outfit/basicork/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/basicork/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boy = new
	new_boy.AssignToRole(H.mind,TRUE)
	new_boy.mind_storage(M.mind)

