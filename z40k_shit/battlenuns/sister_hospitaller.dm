//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/sbattle/hospitaller_suit
	name = "Hospitaller Armor"
	desc = "Its basically bolted on, if it isn't then the person wearing it is probably missing flesh."
	icon_state = "hospitaller_suit" //Check: Its there
	item_state = "hospitaller_suit"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	allowed = list(/obj/item/weapon/gun/projectile/automatic/boltpistol,
			/obj/item/weapon/chainsword,
			/obj/item/weapon/powersword
			)
	armor = list(melee = 70, bullet = 80, laser = 70,energy = 25, bomb = 50, bio = 100, rad = 50)
	canremove = FALSE

//------------HELMET-----------------
/obj/item/clothing/head/sbattle/hospitaller_head
	name = "Hospitaller Habit"
	desc = "Its cloth that goes over the head"
	icon_state = "hospitaller_hat" //Check: Its there
	item_state = "hospitaller_hat" //Check: Its there
	armor = list(melee = 40, bullet = 40, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES|HIDEHEADHAIR
	canremove = FALSE

//--------------BELT----------------
/obj/item/weapon/storage/belt/sbattle/hospitaller_belt
	name = "Cloth Armor Addition"
	desc = "Its basically cloth that makes your armor look kind of stylish."
	icon_state = "hospitaller_belt"
	item_state = "hospitaller_belt"
	max_combined_w_class = 200
	fits_max_w_class = 5
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 30, bullet = 20, laser = 40,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(/obj/item/weapon/gun/projectile/automatic/boltpistol,
					/obj/item/weapon/chainsword,
					/obj/item/weapon/powersword
					)
	canremove = FALSE

/*
	Shoes
	*/
/obj/item/clothing/shoes/sbattle/hospitaller_shoes
	name = "Armored Boots"
	desc = "Armored boots, that are probably bolted on."
	icon_state = "hospitaller_boots"
	item_state = "hospitaller_boots"
	siemens_coefficient = 0.6
	body_parts_covered = FEET
	canremove = FALSE
