
//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/iguard/shocktrooper 
	name = "Flak Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon_state = "storm" //Check: Its there
	item_state = "storm"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/iguard/IG_cadian_armor
	name = "Flak Armor"
	desc = "Standard issue armor given to Guardsmen of the Imperial Guard. Protects against some damage."
	icon_state = "cadia_flak_armor" //Check: Its there
	item_state = "cadia_flak_armor" //Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/lasgun)

/obj/item/clothing/suit/armor/iguard/IG_cadian_medic_armor
	name = "Flak Armor"
	desc = "Standard issue armor given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant."
	icon_state = "cadia_flak_armor_medic" //Check: Its there
	item_state = "cadia_flak_armor_medic"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?
	allowed = list(/obj/item/weapon/gun/energy/lasgun)

/obj/item/clothing/head/iguard/stormtrooper
	name = "Flak Armor"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon_state = "stormh" //Check: its there
	item_state = "stormh" //Check: Its there
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES

//------------HELMETS-----------------
/obj/item/clothing/head/iguard/IG_cadian_helmet
	name = "Flak helmet"
	desc = "A standard issue helmet. Protects against some damage"
	icon_state = "cadian_flak_helmet" //Check: Its there
	item_state = "cadian_flak_helmet" //Check: Its there
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES|MASKHEADHAIR

//-----------Uniforms----------------------
/obj/item/clothing/under/iguard/ig_guard //Basic Cadian Uniform. 
	name = "guardsman uniform"
	desc = "A standard issue uniform given to Guardsmen of the Imperial Guard."
	icon_state = "guardsman_under" //Check: its there
	item_state = "guardsman_under"//Check: Its fine
	_color = "guardsman_under"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.

/*
	IMPERIAL GUARD CADIAN GLOVES
								*/

/obj/item/clothing/gloves/iguard/IG_wepspec_gloves
	name = "Plated Black Gloves"
	desc = "A pair of gloves with some plates near the knuckles"
	icon_state = "cadian_wepspec_gloves"
	item_state = "cadian_wepspec_gloves"
	_color = "cadian_wepspec_gloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	bonus_knockout = 25
	damage_added = 5
	force = 7

