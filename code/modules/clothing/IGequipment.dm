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

/*
	IG SHOES AND BOOTS
						*/

/obj/item/clothing/shoes/imperialboots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look uncomfortable"
	icon_state = "imperialboots"
	item_state = "imperialboots"
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)