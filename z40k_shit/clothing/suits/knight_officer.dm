//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/knight_officer
	name = "Heavy Metal Armor"
	desc = "Shiny Heavy Metal Armor, stops things from cleaving your arm off at the elbow."
	icon = 'z40k_shit/icons/obj/clothing/suits.dmi'
	icon_state = "knight_officer" //Check: Its there
	item_state = "knight_officer"//Check: Its there
	body_parts_covered = UPPER_TORSO
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 70, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)
	species_restricted = list("Human")
	allowed = list(/obj/item/weapon)
