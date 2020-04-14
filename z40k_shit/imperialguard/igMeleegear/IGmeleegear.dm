/obj/item/weapon/chainsword
	name = "Chainsword"
	desc = "A chainsword, that can probably saw through a great many things."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "chainsword"
	item_state = "chainsword"
	hitsound = 'z40k_shit/sounds/chainsword_swing.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = SHARP_TIP | SHARP_BLADE | SERRATED_BLADE | CHOPWOOD | CUT_AIRLOCK
	attack_verb = list("attacks", "slashes",  "slices", "tears", "rips", "dices", "cuts", "saws")
	actions_types = list(/datum/action/item_action/warhams/begin_sawing,
						/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/chainsword/New()
	. = ..()

/obj/item/weapon/chainsword/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("hurthurtknockbackhurt") //hurt hurt knockback hurt
			user.visible_message("<span class='danger'>[H] lands a extra hard swing!</span>")
			target.adjustBruteLoss(15)
			H.word_combo_chain = ""
			H.update_powerwords_hud()
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/GAY in RAAAGH)
					GAY.attackby(src,user)
		if("chargeknockbackhurt")
			user.visible_message("<span class='danger'>[H] follows up with a lunge into [T]!")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud()



/obj/item/weapon/shield/IGshield
	name = "metal shield"
	desc = "A piece metal that should be as unwavering as the person holding it."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "shieldimp"
	item_state = "shieldimp"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	force = 10
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = W_CLASS_LARGE
	stance = "blocking"
	starting_materials = list(MAT_IRON = 1000, MAT_GLASS = 7500)
	melt_temperature = MELTPOINT_GLASS
	origin_tech = Tc_MATERIALS + "=2"
	attack_verb = list("shoves", "bashes")
	var/cooldown = 0 //shield bash cooldown. based on world.time
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance)

/obj/item/weapon/shield/IGshield/suicide_act(mob/user)
	to_chat(viewers(user), "<span class='danger'>[user] is smashing \his face into the [src.name]! It looks like \he's  trying to commit suicide!</span>")
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/shield/IGshield/IsShield()
	return 1

/obj/item/weapon/shield/IGshield/attackby(obj/item/weapon/W , mob/user )
	if(istype(W, /obj/item))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()

/obj/item/weapon/shield/IGshield/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("blockknockbackknockback") //block knockback knockback
			user.visible_message("<span class='danger'>[H] shieldbashes [T]!</span>")
			if(T.attribute_constitution >= H.attribute_strength+3)
				var/turf/TT = get_edge_target_turf(src, H.dir)
				T.adjustBruteLoss(15)
				T.throw_at(TT,1,2)
			else
				T.Dizzy(30)
				T.adjustBruteLoss(15)

/obj/item/offhand //Reference this when you need to make a 2 handed weapon.

/obj/item/weapon/powersword
	name = "power sword"
	desc = "Its a power sword."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "powersword"
	item_state = "powersword"
	sharpness_flags = 0 //starts inactive
	force = 50
	armor_penetration = 100
	hitsound = "sound/weapons/blade1.ogg"
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	w_class = W_CLASS_SMALL
	flags = FPRINT
	sharpness = 1.5
	sharpness_flags = SHARP_TIP | SHARP_BLADE | INSULATED_EDGE | HOT_EDGE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK
	origin_tech = Tc_MAGNETS + "=3;" + Tc_SYNDICATE + "=4"
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	actions_types = list(/datum/action/item_action/warhams/piercing_blow,
						/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/powersword/IsShield()
	return 1

/obj/item/weapon/powersword/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("piercechargehurt") //parry piercing hurt
			user.visible_message("<span class='danger'>[H] lunges into [T] with a piercing strike!</span>")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud()
		if("pierceparryknockback")
			user.visible_message("<span class='danger'>[H] retaliates with a piercing thrust with their [name] into [T].")
			H.adjustBruteLoss(20)
			step_away(T,H,2)
			H.word_combo_chain = ""
			H.update_powerwords_hud()
