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

/*
	IG ARMOR AND SUITS
						*/
/obj/item/clothing/suit/armor/commanderarmor //JOB: GENERAL'S ARMOR
	name = "General Reinforced Coat"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon_state = "commanderarmor" //OBJ STATE
	item_state = "commanderarmor" //MOB STATE

/obj/item/clothing/suit/armor/hos/comissarcoat
	name = "comissar coat"
	desc = "A large coat with comissar stripes and heavy reinforcements."
	icon_state = "comissarcoat"
	item_state = "comissarcoat"
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 50, rad = 50)
	body_parts_covered = FULL_TORSO|ARMS|LEGS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/suit/armor/commanderarmor
	name = "General Reinforced Coat"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon_state = "commanderarmor"
	item_state = "commanderarmor"
	body_parts_covered = FULL_TORSO|ARMS|LEGS|FEET|HANDS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/shocktrooper
	name = "Shock Trooper Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon_state = "storm"
	item_state = "storm"
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/subflak
	name = "Sub-Flak Armor"
	desc = "Padded sub-flak armor."
	icon_state = "subflak"
	item_state = "subflak"
	body_parts_covered = FULL_TORSO|ARMS
	armor = list(melee = 35, bullet = 15, laser = 35, energy = 15, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/DKcoat
	name = "Heavy Greatcoat"
	desc = "The heavy greatcoat is the most distinctive part of the Death Korps uniform, a warm and waterproof coat made locally on Krieg of thick cloth in a variety of colours. Double-breasted with brass buttons, the greatcoat itself can provide limited protection. Plasteel shoulder pads are buckled to the greatcoat and embossed with rank insignia in the case of Watchmasters and higher ranks."
	icon_state = "kriegcoat"
	item_state = "kriegcoat"
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 90, rad = 90)

/obj/item/clothing/suit/armor/DKcoat/officer
	icon_state = "kriegofficer"
	item_state = "kriegofficer"
	armor = list(melee = 65, bullet = 45, laser = 65, energy = 25, bomb = 35, bio = 100, rad = 100)

/obj/item/clothing/suit/armor/valhalla
	name = "Valhallan Greatcoat"
	desc = "A heavily armored, extremely warm, and waterproof coat that forms the standard armor of the valhallan ice warriors."
	icon_state = "valhalla"
	item_state = "valhalla"
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY //A bit much, but basically the upshot is these protect you from even severe cold.
	armor = list(melee = 70, bullet = 55, laser = 45, energy = 50, bomb = 40, bio = 100, rad = 95)

/obj/item/clothing/suit/armor/inq
	name = "Inquisitor Suit"
	desc = "A stylish way to scare the shit out of people."
	icon_state = "inq"
	icon_state = "inq"
	body_parts_covered = FULL_TORSO|ARMS
	pressure_resistance = 3 * ONE_ATMOSPHERE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/inq/alt
	icon_state = "inqalt"

/obj/item/clothing/suit/armor/inq/old
	icon_state = "inqold"

/obj/item/clothing/suit/armor/inq/cape
	icon_state = "inqcapeo"

/obj/item/clothing/suit/armor/inq/alt/cape
	icon_state = "inqaltcape"

/obj/item/clothing/suit/armor/inq/old/cape
	icon_state = "inqcape"

/obj/item/clothing/suit/armor/inq/random/New()
	..()
	icon_state = pick("inq", "inqalt", "inqold", "inqcape", "inqcapeo", "inqaltcape")

/*
	IG SHOES AND BOOTS
						*/

/obj/item/clothing/shoes/imperialboots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look uncomfortable"
	icon_state = "imperialboots"
	item_state = "imperialboots"
	body_parts_covered = LEGS|FEET
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)

/*
	IG UNIFORMS
				*/

/obj/item/clothing/under/color/generic_imperial
	name = "Imperial Jumpsuit"
	desc = "Imperial guard jumpsuit"
	icon_state = "imperial_s"
	_color = "imperial_s"

/obj/item/clothing/under/color/krieg_uniform
	name = "Krieg Uniform"
	desc = "Reinforced uniform that protects against biological and chemical agents through a chemical impregnating process which gives it a pungent smell."
	icon_state = "kuniform"
	_color = "kuniform"

/obj/item/clothing/under/rank/ig_sergeant
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Sergeant\" written on the shoulders."
	name = "imperial uniform"
	icon_state = "warden"
	item_state = "r_suit"
	_color = "warden"

/obj/item/clothing/under/rank/ig_guard
	name = "guardsman uniform"
	desc = "A standard issue uniform given to Guardsmen of the Imperial Guard.."
	icon_state = "guardsman_under"
	item_state = "guardsman_under"
	_color = "imperial"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.


/*
	IG HELMETS
				*/

/obj/item/clothing/head/cadianhelmet 
	name = "Cadian Helmet"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon_state = "stormh"
	item_state = "stormh"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES


/obj/item/clothing/head/imperialhelmet
	name = "guardsman helmet"
	desc = "Standard issue helmet given to Guardsmen of the Imperial Guard. Protects against some damage"
	icon_state = "guardsman_helmet"
	item_state = "guardsman_helmet"
	armor = list(melee = 30, bullet = 10, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES

/obj/item/clothing/head/imperialhelmet/medic
	name = "guardsman medic helmet"
	desc = "Standard issue helmet given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant"
	icon_state = "guardsmanmedic_helmet"
	item_state = "guardsmanmedic_helmet"
	body_parts_covered = HEAD|EARS|EYES
	armor = list(melee = 25, bullet = 10, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?

/obj/item/clothing/head/imperialhelmet/leader
	name = "guardsman sergeant helmet"
	desc = "Standard issue helmet given to Guardsmen Sergeants of the Imperial Guard. More resistant to heavy fire than the normal variant"
	icon_state = "guardsmanleader_helmet"
	body_parts_covered = HEAD|EARS|EYES
	item_state = "guardsmanleader_helmet"
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 30, bomb = 35, bio = 0, rad = 0)

/obj/item/clothing/head/imperialhelmet/reinforced
	name = "Reinforced Imperial Flak Helmet"
	desc = "Upgraded Imperial Guard Helmet"
	icon_state = "flakhelmet"
	item_state = "flakhelmet"
	armor = list(melee = 65, bullet = 35, laser = 50,energy = 20, bomb = 50, bio = 5, rad = 5)

/obj/item/clothing/head/DKhelmet
	name = "Mark IX Helmet"
	desc = "The standard-issue Mark IX helmet is made of plasteel and constructed to ensure a good fit around the gasmask; ventilation is provided through a top spine, which has its own internal filter to keep out biological and chemical agents."
	icon_state = "krieghelm"
	item_state = "krieghelm"
	armor = list(melee = 55, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 90, rad = 90)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/head/valhalla
	name = "Valhallan Helmet"
	desc = "A cold resistant, heavily padded helmet that is issued to the Valhallan Ice Warriors."
	icon_state = "valhalla"
	item_state = "valhalla"
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY

/obj/item/clothing/head/commissarcap
	name = "Commissar Cap"
	desc = "An armored cap with the imperial insignia on it, symbolizing the authority of a Commissar."
	icon_state = "comissarcap"
	item_state = "comissarcap"
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/head/comissar2/festive
	name = "Commisar Festive cap"
	icon_state = "comissar2"

