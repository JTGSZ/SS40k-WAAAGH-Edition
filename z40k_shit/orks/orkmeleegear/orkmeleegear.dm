//within this file is the ork melee shit maybe.

//choppa - a basic ork sword
//choppa1 = a basic ork axe
/obj/item/weapon/choppa
	name = "choppa"
	desc = "A basic choppa made for choppin shit."
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/orkequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/orkequipment_right.dmi')
	icon = 'icons/obj/orkstuff/orkequipment.dmi'
	icon_state = "choppa"
	item_state = "choppa"
	hitsound = 'sound/weapons/bloodyslice.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 35
	throwforce = 20
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = SHARP_TIP | SHARP_BLADE
	attack_verb = list("attacks", "slashes",  "slices", "tears", "rips", "dices", "cuts", "slamdunks")

/obj/item/weapon/choppa/New()
	. = ..()
	var/rngicon
	rngicon = pick("choppa","choppa1")
	icon_state = rngicon
	item_state = rngicon
	

/obj/item/weapon/shield/orkshield
	name = "ork shield"
	desc = "WAAAGH, I AIN'T GETTIN HIT BY SHIT (about 50% of the time)."
	icon = 'icons/obj/orkstuff/orkequipment.dmi'
	icon_state = "nobshield"
	item_state = "nobshield"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/orkequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/orkequipment_right.dmi')
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

/obj/item/weapon/shield/orkshield/suicide_act(mob/user)
	to_chat(viewers(user), "<span class='danger'>[user] is smashing \his face into the [src.name]! It looks like \he's  trying to commit suicide!</span>")
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/shield/orkshield/IsShield()
	return 1

/obj/item/weapon/shield/orkshield/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()