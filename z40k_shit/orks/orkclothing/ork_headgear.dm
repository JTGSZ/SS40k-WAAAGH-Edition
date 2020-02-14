/*
	Hats & Helmets
	*/
/obj/item/clothing/head/ork/milcap
	name = "Red Military Cap"
	desc = "A stylish hat, hopefully it makes you think faster idiot."
	icon_state = "orkhat2"
	item_state = "orkhat2"
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/armorhelmet
	name = "Horned Armored Helmet"
	desc = "A helmet with horns"
	icon_state = "orkhelmet1"
	item_state = "orkhelmet1"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD|HIDEHEADHAIR
	siemens_coefficient = 1

/obj/item/clothing/head/ork/redbandana
	name = "Red Bandana"
	desc = "A red bandana that seems to be stuck in the shape of an ork head."
	icon_state = "orkhat1"
	item_state = "orkhat1"
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/bucket
	name = "Metal Bucket Helmet"
	desc = "A metal bucket, conveniently sized for a orks head."
	icon_state = "orkhelmet2"
	item_state = "orkhelmet2"
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 10, bomb = 25, bio = 10, rad = 0)
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.8

