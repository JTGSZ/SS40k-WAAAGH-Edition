

/obj/item/clothing/suit/armor/iguard/valhalla 
	name = "Valhallan Greatcoat"
	desc = "A heavily armored, extremely warm, and waterproof coat that forms the standard armor of the valhallan ice warriors."
	icon_state = "valhalla"//Check: Its there
	item_state = "valhalla"//Check: Its there
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY //A bit much, but basically the upshot is these protect you from even severe cold.
	armor = list(melee = 70, bullet = 55, laser = 45, energy = 50, bomb = 40, bio = 100, rad = 95)

/obj/item/clothing/head/iguard/IG_valhallan_helmet
	name = "Valhallan Helmet"
	desc = "A cold resistant, heavily padded helmet that is issued to the Valhallan Ice Warriors."
	icon_state = "valhalla" //Check: its there
	item_state = "valhalla" //Check: its there
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES|MASKHEADHAIR
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY
	