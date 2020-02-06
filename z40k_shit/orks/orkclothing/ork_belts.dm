/*
	Belts
	*/
/obj/item/weapon/storage/belt/ork/basicbelt
	name = "Basic Belt"
	desc = "A basic belt for a basic bitch."
	icon_state = "orkbelt1"
	item_state = "orkbelt1"
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")

/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/belt/ork/armorbelt
	name = "Belt with Plates"
	desc = "A belt with armored plates attached to it."
	icon_state = "orkbelt1dev1"
	item_state = "orkbelt1dev1"
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 10, bullet = 10, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")
	