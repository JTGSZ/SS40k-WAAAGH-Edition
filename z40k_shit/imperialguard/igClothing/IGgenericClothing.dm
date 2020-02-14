/*
	IMPERIAL GUARD GASMASKS
							*/

/obj/item/clothing/mask/gas/iguard/trooper_mask
	name = "gas mask"
	desc = "A standard issue imperial guard gas mask."
	icon_state = "ig" //Check: Its there
	item_state = "ig" //Check: Its there
	siemens_coefficient = 0.7
	body_parts_covered = FACE
	w_class = W_CLASS_SMALL
	can_flip = 0
	canstage = 0

//----------Masks-----------
/obj/item/clothing/mask/gas/iguard/stormtrooper_mask
	name = "stormtrooper gasmask"
	desc = "A face-covering mask ment for only the finest the imperial guard can field."
	icon_state = "stormm" //Check: Its there
	item_state = "stormm" //Check: Its there
	siemens_coefficient = 0.7
	body_parts_covered = FACE
	w_class = W_CLASS_SMALL
	can_flip = 0
	canstage = 0

/*
	IG UNIFORMS
				*/

/obj/item/clothing/under/iguard/generic_imperial //We are not using this one. But it can stay.
	name = "Imperial Jumpsuit"
	desc = "Imperial guard jumpsuit"
	icon_state = "imperial" //Check: Its there
	_color = "imperial" //Check: Its there
	has_sensor = 2

/*
	IG SHOES AND BOOTS
						*/

/obj/item/clothing/shoes/iguard/IG_cadian_boots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look uncomfortable"
	icon_state = "imperialboots" //Check: Its there
	item_state = "imperialboots" //Check: Its fine
	body_parts_covered = LEGS|FEET
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)

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

