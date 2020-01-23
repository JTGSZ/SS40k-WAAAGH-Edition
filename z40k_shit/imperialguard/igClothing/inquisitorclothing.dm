
//------------------Suits-----------------
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

//----------------Hats----------------

/obj/item/clothing/head/iguard/inqhat
	name = "Inquisitor Hat"
	desc = "It's a very nice hat."
	icon_state = "inqhat" //Check: its there
	item_state = "inqhat" //Check: Its there
	body_parts_covered = HEAD|EARS|EYES|HIDEFACE


