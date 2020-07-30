/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/brownbackpack
	name = "Brown Backpack"
	desc = "A brown backpack, maybe one day there will be more to it."
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkbackpack"
	item_state = "orkbackpack"
	max_combined_w_class = 200
	
/obj/item/weapon/storage/backpack/brownbackpack/sluggakit/New()
	..()
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/weapon/grenade/stikkbomb(src)


/obj/item/weapon/storage/backpack/brownbackpack/kommandokit/New()
	..()
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/magazine/shottamag(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/backpack/brownbackpack/shootakit/New()
	..()
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

/obj/item/weapon/storage/backpack/brownbackpack/kustomshootabelts/New()
	..()
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

/obj/item/weapon/storage/backpack/brownbackpack/mekpack/New()
	..()
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/weapon/taperoll(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

