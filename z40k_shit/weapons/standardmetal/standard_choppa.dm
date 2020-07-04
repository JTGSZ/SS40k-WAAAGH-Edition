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
			H.update_powerwords_hud(clear = TRUE)
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/GAY in RAAAGH)
					GAY.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
		if("chargeknockbackhurt")
			user.visible_message("<span class='danger'>[H] follows up with a lunge into [T]!")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)


