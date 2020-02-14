
//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/iguard/shocktrooper 
	name = "Shock Trooper Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon_state = "storm" //Check: Its there
	item_state = "storm"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/iguard/IG_cadian_armor
	name = "guardsman armor"
	desc = "Standard issue armor given to Guardsmen of the Imperial Guard. Protects against some damage."
	icon_state = "guardsman_armor" //Check: Its there
	item_state = "guardsman_armor" //Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/complexweapon/lasgun)

/obj/item/clothing/suit/armor/iguard/IG_cadian_medic_armor
	name = "guardsman medic armor"
	desc = "Standard issue armor given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant."
	icon_state = "guardsmanmedic_armor" //Check: Its there
	item_state = "guardsmanmedic_armor"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?
	allowed = list(/obj/item/weapon/gun/energy/complexweapon/lasgun)

/obj/item/clothing/suit/armor/iguard/IG_cadian_sergeant_armor
	name = "guardsman sergeant armor"
	desc = "Standard issue armor given to Guardsmen Sergeants of the Imperial Guard. More resistant to heavy fire than the normal variant"
	icon_state = "guardsmanleader_armor" //Check: Its there
	item_state = "guardsmanleader_armor"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 30, bomb = 35, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/complexweapon/lasgun)

/obj/item/clothing/head/iguard/stormtrooper
	name = "Cadian Helmet"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon_state = "stormh" //Check: its there
	item_state = "stormh" //Check: Its there
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES

//------------HELMETS-----------------
/obj/item/clothing/head/iguard/IG_cadian_helmet
	name = "guardsman helmet"
	desc = "Standard issue helmet given to Guardsmen of the Imperial Guard. Protects against some damage"
	icon_state = "guardsman_helmet" //Check: Its there
	item_state = "guardsman_helmet" //Check: Its there
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES|MASKHEADHAIR

/obj/item/clothing/head/iguard/IG_cadian_medic_helmet
	name = "guardsman medic helmet"
	desc = "Standard issue helmet given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant"
	icon_state = "guardsmanmedic_helmet" //Check: Its there
	item_state = "guardsmanmedic_helmet" //Check: Its fine
	body_parts_covered = HEAD|EARS|EYES|MASKHEADHAIR
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?

/obj/item/clothing/head/iguard/IG_cadian_sergeant_helmet
	name = "guardsman sergeant helmet"
	desc = "Standard issue helmet given to Guardsmen Sergeants of the Imperial Guard. More resistant to heavy fire than the normal variant"
	icon_state = "guardsmanleader_helmet" //Check: Its there
	item_state = "guardsmanleader_helmet" //Check: Its fine
	body_parts_covered = HEAD|EARS|EYES|HIDEHAIR
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 30, bomb = 35, bio = 0, rad = 0)

//-----------Uniforms----------------------
/obj/item/clothing/under/iguard/ig_guard //Basic Cadian Uniform. 
	name = "guardsman uniform"
	desc = "A standard issue uniform given to Guardsmen of the Imperial Guard."
	icon_state = "guardsman_under" //Check: its there
	item_state = "guardsman_under"//Check: Its fine
	_color = "imperial"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.
