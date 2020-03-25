//within this file is the ork melee shit maybe.

//choppa - a basic ork sword
//choppa1 = a basic ork axe
/obj/item/weapon/choppa
	name = "choppa"
	desc = "A basic choppa made for choppin shit."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/orkequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/orkequipment_right.dmi')
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
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
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/choppa/New()
	. = ..()
	var/rngicon
	rngicon = pick("choppa","choppa1")
	icon_state = rngicon
	item_state = rngicon
	
/obj/item/weapon/choppa/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("hurthurtknockbackhurt") //hurt hurt knockback hurt
			user.visible_message("<span class='danger'>[H] lands a extra hard swing on [T]!</span>")
			target.adjustBruteLoss(35)
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


/obj/item/weapon/shield/orkshield
	name = "ork shield"
	desc = "WAAAGH, I AIN'T GETTIN HIT BY SHIT (about 50% of the time)."
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "nobshield"
	item_state = "nobshield"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/orkequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/orkequipment_right.dmi')
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	force = 15
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = W_CLASS_LARGE
	starting_materials = list(MAT_IRON = 1000, MAT_GLASS = 7500)
	melt_temperature = MELTPOINT_GLASS
	origin_tech = Tc_MATERIALS + "=2"
	attack_verb = list("shoves", "bashes")
	stance = "blocking"
	var/cooldown = 0 //shield bash cooldown. based on world.time
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance)

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

/obj/item/weapon/shield/orkshield/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
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
