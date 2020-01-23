
/obj/item/clothing/suit/armor/iguard/DKcoat 
	name = "Heavy Greatcoat"
	desc = "The heavy greatcoat is the most distinctive part of the Death Korps uniform, a warm and waterproof coat made locally on Krieg of thick cloth in a variety of colours. Double-breasted with brass buttons, the greatcoat itself can provide limited protection. Plasteel shoulder pads are buckled to the greatcoat and embossed with rank insignia in the case of Watchmasters and higher ranks."
	icon_state = "kriegcoat" //Check: Its there
	item_state = "kriegcoat"//Check: Its there
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 90, rad = 90)

/obj/item/clothing/under/iguard/krieg_uniform 
	name = "Krieg Uniform"
	desc = "Reinforced uniform that protects against biological and chemical agents through a chemical impregnating process which gives it a pungent smell."
	icon_state = "kuniform" //Check: its there
	item_state = "kuniform"//Check: Its fine
	_color = "kuniform"
	has_sensor = 2

/obj/item/clothing/head/iguard/IG_krieg_helmet
	name = "Mark IX Helmet"
	desc = "The standard-issue Mark IX helmet is made of plasteel and constructed to ensure a good fit around the gasmask; ventilation is provided through a top spine, which has its own internal filter to keep out biological and chemical agents."
	icon_state = "krieghelm" //Check: Its there
	item_state = "krieghelm" //Check: Its there
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 90, rad = 90)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

	
	