//Within is all of the IG equipment, at some point im going to have to split these files ya dig?
//But considering im the only person working on this at the moment who gives a shit really.

//Heres all of the parents.
/obj/item/clothing/gloves/iguard //Parent of the children afterwards, inherits from these paths.
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.
/obj/item/clothing/head/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'
	species_restricted = list("Human")
/obj/item/clothing/suit/armor/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'
	species_restricted = list("Human")
/obj/item/clothing/shoes/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'
	species_restricted = list("Human")
/obj/item/clothing/under/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'
	species_restricted = list("Human")
/obj/item/weapon/storage/belt/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'
/obj/item/weapon/storage/backpack/iguard
	icon = 'icons/obj/IGstuff/IGarmorandclothesOBJ.dmi'

/*
	IG ARMOR AND SUITS
						*/
/obj/item/clothing/suit/armor/iguard/comissarcoat
	name = "commissar coat"
	desc = "A large coat with comissar stripes and heavy reinforcements."
	icon_state = "comissarcoat" //Check: Its there
	item_state = "comissarcoat" //Check: Its there
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 50, rad = 50)
	body_parts_covered = FULL_TORSO|ARMS|LEGS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/suit/armor/iguard/commanderarmor 
	name = "General Reinforced Coat"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon_state = "commanderarmor" //Check: Its there
	item_state = "commanderarmor"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS|LEGS|FEET|HANDS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/iguard/shocktrooper 
	name = "Shock Trooper Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon_state = "storm" //Check: Its there
	item_state = "storm"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/iguard/DKcoat 
	name = "Heavy Greatcoat"
	desc = "The heavy greatcoat is the most distinctive part of the Death Korps uniform, a warm and waterproof coat made locally on Krieg of thick cloth in a variety of colours. Double-breasted with brass buttons, the greatcoat itself can provide limited protection. Plasteel shoulder pads are buckled to the greatcoat and embossed with rank insignia in the case of Watchmasters and higher ranks."
	icon_state = "kriegcoat" //Check: Its there
	item_state = "kriegcoat"//Check: Its there
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 90, rad = 90)

/obj/item/clothing/suit/armor/iguard/valhalla 
	name = "Valhallan Greatcoat"
	desc = "A heavily armored, extremely warm, and waterproof coat that forms the standard armor of the valhallan ice warriors."
	icon_state = "valhalla"//Check: Its there
	item_state = "valhalla"//Check: Its there
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY //A bit much, but basically the upshot is these protect you from even severe cold.
	armor = list(melee = 70, bullet = 55, laser = 45, energy = 50, bomb = 40, bio = 100, rad = 95)

/obj/item/clothing/suit/armor/iguard/inq 
	name = "Inquisitor Suit"
	desc = "A stylish way to scare the shit out of people."
	icon_state = "inq"//Check its there
	item_state = "inq"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	pressure_resistance = 3 * ONE_ATMOSPHERE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/iguard/inq/alt
	icon_state = "inqalt" //Check: Its there
	item_state = "inqalt" //Check: Its there

/obj/item/clothing/suit/armor/iguard/inq/cape
	icon_state = "inqcapeo" //Check: Its there
	item_state = "inqcapeo"//Check: Its there

/obj/item/clothing/suit/armor/iguard/inq/alt/cape
	icon_state = "inqaltcape" //Check: Its there
	item_state = "inqaltcape" //Check: Its there

/obj/item/clothing/suit/armor/iguard/inq/old/cape
	icon_state = "inqcape" //Check: Its there
	item_state = "inqcape" //Check: Its there

/obj/item/clothing/suit/armor/iguard/inq/random/New() //Check: Its there
	..()
	var/whatami = pick("inq", "inqalt", "inqcape", "inqcapeo", "inqaltcape")
	switch(whatami)
		if("inq")
			icon_state = "inq"
			item_state = "inq"
		if("inqalt")
			icon_state = "inqalt"
			item_state = "inqalt"
		if("inqcape")
			icon_state = "inqcape"
			item_state = "inqcape"
		if("inqcapeo")
			icon_state = "inqcapeo"
			item_state = "inqcapeo"
		if("inqaltcape")
			icon_state = "inqaltcape"
			item_state = "inqalecape"

/obj/item/clothing/suit/armor/imperialarmor
	name = "guardsman armor"
	desc = "Standard issue armor given to Guardsmen of the Imperial Guard. Protects against some damage."
	icon_state = "guardsman_armor" //Check: Its there
	item_state = "guardsman_armor" //Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/laser/lasgun)

/obj/item/clothing/suit/armor/imperialarmor/medic 
	name = "guardsman medic armor"
	desc = "Standard issue armor given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant."
	icon_state = "guardsmanmedic_armor" //Check: Its there
	item_state = "guardsmanmedic_armor"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?
	allowed = list(/obj/item/weapon/gun/energy/laser/lasgun)

/obj/item/clothing/suit/armor/imperialarmor/leader 
	name = "guardsman sergeant armor"
	desc = "Standard issue armor given to Guardsmen Sergeants of the Imperial Guard. More resistant to heavy fire than the normal variant"
	icon_state = "guardsmanleader_armor" //Check: Its there
	item_state = "guardsmanleader_armor"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 30, bomb = 35, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/laser/lasgun)

/*
	IG SHOES AND BOOTS
						*/

/obj/item/clothing/shoes/iguard/imperialboots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look uncomfortable"
	icon_state = "imperialboots" //Check: Its there
	item_state = "imperialboots" //Check: Its fine
	body_parts_covered = LEGS|FEET
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)

/*
	IG UNIFORMS
				*/

/obj/item/clothing/under/iguard/generic_imperial //We are not using this one. But it can stay.
	name = "Imperial Jumpsuit"
	desc = "Imperial guard jumpsuit"
	icon_state = "imperial" //Check: Its there
	_color = "imperial" //Check: Its there
	has_sensor = 2

/obj/item/clothing/under/iguard/krieg_uniform 
	name = "Krieg Uniform"
	desc = "Reinforced uniform that protects against biological and chemical agents through a chemical impregnating process which gives it a pungent smell."
	icon_state = "kuniform" //Check: its there
	item_state = "kuniform"//Check: Its fine
	_color = "kuniform"
	has_sensor = 2

/obj/item/clothing/under/iguard/ig_guard //Basic Cadian Uniform. 
	name = "guardsman uniform"
	desc = "A standard issue uniform given to Guardsmen of the Imperial Guard."
	icon_state = "guardsman_under" //Check: its there
	item_state = "guardsman_under"//Check: Its fine
	_color = "imperial"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.

/obj/item/clothing/under/iguard/general
	name = "generals uniform"
	desc = "Its a uniform fit for a general."
	icon_state = "general" //Check: Its there
	item_state = "general" //Check: Its there
	_color = "general"

/obj/item/clothing/under/iguard/commissar
	name = "commissar uniform"
	desc = "Its a uniform fit for a commissar."
	icon_state = "commissar" //Check: Its there
	item_state = "commissar" //Check Its there:
	_color = "commissar"

/*
	IG HELMETS
				*/

/obj/item/clothing/head/iguard/cadianhelmet 
	name = "Cadian Helmet"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon_state = "stormh" //Check: its there
	item_state = "stormh" //Check: Its there
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES


/obj/item/clothing/head/iguard/imperialhelmet
	name = "guardsman helmet"
	desc = "Standard issue helmet given to Guardsmen of the Imperial Guard. Protects against some damage"
	icon_state = "guardsman_helmet" //Check: Its there
	item_state = "guardsman_helmet" //Check: Its there
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES

/obj/item/clothing/head/iguard/imperialhelmetmedic
	name = "guardsman medic helmet"
	desc = "Standard issue helmet given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant"
	icon_state = "guardsmanmedic_helmet" //Check: Its there
	item_state = "guardsmanmedic_helmet" //Check: Its fine
	body_parts_covered = HEAD|EARS|EYES
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?

/obj/item/clothing/head/iguard/imperialhelmetleader
	name = "guardsman sergeant helmet"
	desc = "Standard issue helmet given to Guardsmen Sergeants of the Imperial Guard. More resistant to heavy fire than the normal variant"
	icon_state = "guardsmanleader_helmet" //Check: Its there
	item_state = "guardsmanleader_helmet" //Check: Its fine
	body_parts_covered = HEAD|EARS|EYES
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 30, bomb = 35, bio = 0, rad = 0)

/obj/item/clothing/head/iguard/DKhelmet
	name = "Mark IX Helmet"
	desc = "The standard-issue Mark IX helmet is made of plasteel and constructed to ensure a good fit around the gasmask; ventilation is provided through a top spine, which has its own internal filter to keep out biological and chemical agents."
	icon_state = "krieghelm" //Check: Its there
	item_state = "krieghelm" //Check: Its there
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 90, rad = 90)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/head/iguard/valhalla
	name = "Valhallan Helmet"
	desc = "A cold resistant, heavily padded helmet that is issued to the Valhallan Ice Warriors."
	icon_state = "valhalla" //Check: its there
	item_state = "valhalla" //Check: its there
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY

/obj/item/clothing/head/iguard/commissarcap
	name = "Commissar Cap"
	desc = "An armored cap with the imperial insignia on it, symbolizing the authority of a Commissar."
	icon_state = "commissarcap" //Check: Its there
	item_state = "commissarcap" //Check: Its there
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/head/iguard/inqhat
	name = "Inquisitor Hat"
	desc = "It's a very nice hat."
	icon_state = "inqhat" //Check: its there
	item_state = "inqhat" //Check: Its there
	body_parts_covered = HEAD|EARS|EYES|HIDEFACE

/*
	IMPERIAL GUARD BELTS
						*/

/obj/item/weapon/storage/belt/iguard/basicbelt
	name = "Basic Belt"
	desc = "A standard issue belt."
	icon_state = "imperialbelt" //Check: Its there
	item_state = "imperialbelt" //Check: Its there
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list()

/*
	IMPERIAL GUARD GASMASKS
							*/

/obj/item/clothing/mask/gas/iguard/trooper_mask
	name = "gas mask"
	desc = "A standard issue imperial guard gas mask."
	icon_state = "ig" //Check: Its there
	item_state = "ig" //Check: Its there
	siemens_coefficient = 0.7
	w_class = W_CLASS_SMALL
	can_flip = 0
	canstage = 0

/obj/item/clothing/mask/gas/iguard/stormtrooper_mask
	name = "stormtrooper gasmask"
	desc = "A face-covering mask ment for only the finest the imperial guard can field."
	icon_state = "stormm" //Check: Its there
	item_state = "stormm" //Check: Its there
	siemens_coefficient = 0.7
	w_class = W_CLASS_SMALL
	can_flip = 0
	canstage = 0

/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/iguard/trooperbag
	name = "Standard issue Backpack"
	desc = "A standard issue backpack, maybe one day there will be more to it."
	icon_state = "impbag" //Check: Its there
	item_state = "impbag" //Check: Its there

/obj/item/weapon/storage/backpack/iguard/stormtrooperbag
	name = "Stormtrooper Backpack"
	desc = "This backpack looks like one of the finest the imperial guard can offer."
	icon_state = "stormp" //Check: Its there
	item_state = "stormp" //Check: Its there