/obj/item/weapon/chainsword
	name = "Chainsword"
	desc = "A chainsword, that can probably saw through a great many things."
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "chainsword"
	item_state = "chainsword"
	hitsound = 'sound/weapons/chainsword_swing.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 35
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = SHARP_TIP | SHARP_BLADE | SERRATED_BLADE | CHOPWOOD | CUT_AIRLOCK
	attack_verb = list("attacks", "slashes",  "slices", "tears", "rips", "dices", "cuts", "saws")

/obj/item/weapon/chainsword/New()
	. = ..()

/obj/item/weapon/shield/IGshield
	name = "metal shield"
	desc = "A piece metal that should be as unwavering as the person holding it."
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "shieldimp"
	item_state = "shieldimp"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	force = 10
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = W_CLASS_LARGE
	starting_materials = list(MAT_IRON = 1000, MAT_GLASS = 7500)
	melt_temperature = MELTPOINT_GLASS
	origin_tech = Tc_MATERIALS + "=2"
	attack_verb = list("shoves", "bashes")
	var/cooldown = 0 //shield bash cooldown. based on world.time

/obj/item/weapon/shield/IGshield/suicide_act(mob/user)
	to_chat(viewers(user), "<span class='danger'>[user] is smashing \his face into the [src.name]! It looks like \he's  trying to commit suicide!</span>")
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/shield/IGshield/IsShield()
	return 1

/obj/item/weapon/shield/IGshield/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()


/obj/item/offhand //Reference this when you need to make a 2 handed weapon.

/*
 * Eviscerator
 */
/obj/item/projectile/fire_breath/eviscerator //The fire projectile we will use, cap it to 3 turfs.
	fire_blast_type = /obj/effect/fire_blast/no_spread
	max_range = 4

/obj/item/weapon/gun/eviscerator
	name = "Eviscerator"
	desc = "A oversized chainsword. This one has a exterminator attached to it too."
	slot_flags = SLOT_BACK
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/eviscerator.dmi', "right_hand" = 'icons/mob/in-hand/right/eviscerator.dmi')
	icon_state = "eviscerator"
	item_state = "eviscerator"
	throwforce = 35
	force = 50
	armor_penetration = 100
	throw_speed = 5
	throw_range = 10
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK //it's a really sharp blade m'kay
	w_class = W_CLASS_LARGE
	flags = FPRINT | TWOHANDABLE | MUSTTWOHAND
	mech_flags = MECH_SCAN_FAIL
	origin_tech = Tc_MAGNETS + "=4;" + Tc_COMBAT + "=5"

/obj/item/weapon/gun/eviscerator/IsShield()
	return 1

/obj/item/weapon/gun/eviscerator/process_chambered()
	in_chamber = new/obj/item/projectile/fire_breath/eviscerator(src)
	return 1