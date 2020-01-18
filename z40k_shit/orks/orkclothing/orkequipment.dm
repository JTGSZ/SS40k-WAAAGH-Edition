//Within is all of the ork equipment, I figured it'd be easier to just pool it here.
//Since after-all we can do whatever we wish ya know? If its that bad it can be moved later.
//The mob icon path for orks is located in 40kSpecies.dm. Mob being what appears when it is worn
// -Love JTGSZ

//Heres all of the parents.
/obj/item/clothing/gloves/ork //Parent of the children afterwards, inherits from these paths.
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Ork") //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork") //We insure it checks to fit for the species icon.
/obj/item/clothing/head/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/suit/armor/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/shoes/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/under/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/weapon/storage/belt/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork")
/obj/item/weapon/storage/backpack/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork")

/* 
	Gloves
	*/
/obj/item/clothing/gloves/ork/clothgloves 
	name = "Ragged Gloves" //The name of the object ingame.
	desc = "A pair of ragged cloth gloves." //Description upon examination
	icon_state = "orkgloves1" //The state of the object icon when dropped/displayed in slot
	item_state = "orkgloves1" //The state of the mob icon when worn.
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 17 //Slight knockout chance increase.
	damage_added = 3 //Add 3 damage to unarmed attacks when worn

/*
	Hats & Helmets
	*/
/obj/item/clothing/head/ork/milcap
	name = "Red Military Cap"
	desc = "A stylish hat, hopefully it makes you think faster idiot."
	icon_state = "orkhat2"
	item_state = "orkhat2"
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/armorhelmet
	name = "Horned Armored Helmet"
	desc = "A helmet with horns"
	icon_state = "orkhelmet1"
	item_state = "orkhelmet1"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD
	siemens_coefficient = 1

/obj/item/clothing/head/ork/redbandana
	name = "Red Bandana"
	desc = "A red bandana that seems to be stuck in the shape of an ork head."
	icon_state = "orkhat1"
	item_state = "orkhat1"
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/bucket
	name = "Metal Bucket Helmet"
	desc = "A metal bucket, conveniently sized for a orks head."
	icon_state = "orkhelmet2"
	item_state = "orkhelmet2"
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 10, bomb = 25, bio = 10, rad = 0)
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.8

/*
	Armor and Suits
	*/
/obj/item/clothing/suit/armor/ork/samuraiorkarmor
	name = "Plated Ork Armor"
	desc = "Armor that seems to have more plates than usual, RESEMBLES SOMETHING DOESN'T IT."
	icon_state = "orkarmor1"
	item_state = "orkarmor1"
	armor = list(melee = 50, bullet = 60, laser = 60,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.8
	body_parts_covered = ARMS|FULL_TORSO

/obj/item/clothing/suit/armor/ork/leatherbikervest
	name = "Leather Biker Vest"
	desc = "A protective leather vest with a stylish skull on the back, looks like it used to be a jacket"
	icon_state = "orkarmor2"
	item_state = "orkarmor2"
	armor = list(melee = 20, bullet = 30, laser = 40,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.5
	body_parts_covered = FULL_TORSO

/obj/item/clothing/suit/armor/ork/rwallplate
	name = "Plate Ork Armor"
	desc = "Two sets of plating that seem to have came off a wall"
	icon_state = "orkarmor3"
	item_state = "orkarmor3"
	armor = list(melee = 30, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO

/obj/item/clothing/suit/armor/ork/ironplate
	name = "Metal Armor"
	desc = "A crude suit of armor, made for an ork"
	icon_state = "orkarmor4"
	item_state = "orkarmor4"
	armor = list(melee = 30, bullet = 40, laser = 30,energy = 10, bomb = 10, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO

/*
	Shoes
	*/
/obj/item/clothing/shoes/ork/orkboots
	name = "Leather Boots"
	desc = "What more is there to say? These are leather boots, ork sized."
	icon_state = "orkboots1"
	item_state = "orkboots1"
	siemens_coefficient = 0.6
	body_parts_covered = FEET



/*
	Uniforms
	*/
/obj/item/clothing/under/ork/pants
	name = "Pants"
	desc = "Some motherfuckin PANTS"
	icon_state = "orkuniform1"
	item_state = "orkuniform1"
	_color = "orkuniform1"
	body_parts_covered = LOWER_TORSO|LEGS|FEET

/obj/item/clothing/under/ork/pantsandshirt
	name = "Pants and Shirt"
	desc = "You think having pants is a luxury? This is a pants and SHIRT."
	icon_state = "orkuniform1dev1"
	item_state = "orkuniform1dev1"
	_color = "orkuniform1dev1"
	body_parts_covered = FULL_TORSO|LEGS|FEET

/obj/item/clothing/under/ork/leatherpantsandshirt
	name = "Leather Uniform"
	desc = "A crude uniform, made of brown leather of some sort."
	icon_state = "orkuniform2"
	item_state = "orkuniform2"
	_color = "orkuniform2"
	body_parts_covered = FULL_TORSO|LEGS|FEET

/*
	Belts
	*/
/obj/item/weapon/storage/belt/ork/basicbelt
	name = "Basic Belt"
	desc = "A basic belt for a basic bitch."
	icon_state = "orkbelt1"
	item_state = "orkbelt1"
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")

/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/belt/ork/armorbelt
	name = "Belt with Plates"
	desc = "A belt with armored plates attached to it."
	icon_state = "orkbelt1dev1"
	item_state = "orkbelt1dev1"
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 10, bullet = 10, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")

/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/ork/brownbackpack
	name = "Brown Backpack"
	desc = "A brown backpack, maybe one day there will be more to it."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkbackpack"
	item_state = "orkbackpack"
