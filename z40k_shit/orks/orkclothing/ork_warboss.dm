/obj/item/clothing/gloves/ork/warboss //Parent of the children afterwards, inherits from these paths.
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Ork Warboss")  //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork Warboss") //We insure it checks to fit for the species icon.

/obj/item/clothing/head/ork/warboss
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 

/obj/item/clothing/suit/armor/ork/warboss
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 


/obj/item/clothing/under/ork/warboss
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 

/obj/item/weapon/storage/belt/ork/warboss
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork Warboss") 
 
/*
	Belts
	*/
/obj/item/weapon/storage/belt/ork/warboss
	name = "Leather Belt with Metal Skull"
	desc = "A not very basic belt."
	icon_state = "warboss_belt"
	item_state = "warboss_belt"
	w_class = W_CLASS_LARGE
	storage_slots = 14
	max_combined_w_class = 200
	fits_max_w_class = 5
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb",
	"/obj/item/ammo_casing/rocket_rpg/rokkit",
	"/obj/item/weapon/gun/projectile/automatic/slugga",
	"/obj/item/weapon/gun/projectile/shotgun/shotta",
	"/obj/item/weapon/choppa",
	"/obj/item/ammo_casing/orkbullet",
	"/obj/item/ammo_storage/box/piles/sluggabulletpile",
	"/obj/item/ammo_storage/box/piles/buckshotpile",
	"/obj/item/ammo_storage/magazine/sluggamag",
	"/obj/item/ammo_storage/magazine/shottamag",
	"/obj/item/ammo_storage/magazine/kustom_shoota_belt")

/obj/item/weapon/storage/belt/ork/warboss/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
/*
	Armor and Suits
	*/
/obj/item/clothing/suit/armor/ork/warboss/platearmor
	name = "Large Plate Armor"
	desc = "Plate that should be currently adorning a large ork"
	icon_state = "warboss_armor1"
	icon_state = "warboss_armor1"
	armor = list(melee = 30, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO

/*
	Hats & Helmets
	*/
/obj/item/clothing/head/ork/warboss/bossarmorhelmet
	name = "Horned Armored Helmet"
	desc = "A large helmet with horns and a metal faceplate"
	icon_state = "warboss_helmet"
	item_state = "warboss_helmet"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD|HIDEHEADHAIR
	siemens_coefficient = 1

/*
	Shoes
	*/
/obj/item/clothing/shoes/ork/bossboots
	name = "Flashy Spiked Metal Boots"
	desc = "Looks aggressive."
	icon_state = "warboss_shoes"
	item_state = "warboss_shoes"
	siemens_coefficient = 0.6
	body_parts_covered = FEET

/* 
	Gloves
	*/
/obj/item/clothing/gloves/ork/warboss/armorbracers
	name = "Armor Bracers" //The name of the object ingame.
	desc = "A pair of metal bracers." //Description upon examination
	icon_state = "warboss_gloves" //The state of the object icon when dropped/displayed in slot
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 25 //Slight knockout chance increase.
	damage_added = 10 //Add 3 damage to unarmed attacks when worn

/*
	Uniforms
	*/
/obj/item/clothing/under/ork/warboss/pants
	name = "Pants"
	desc = "Some motherfuckin (Extra Flashy) PANTS"
	icon_state = "warboss_uniform1"
	item_state = "warboss_uniform1"
	_color = "warboss_uniform1"
	body_parts_covered = LOWER_TORSO|LEGS|FEET