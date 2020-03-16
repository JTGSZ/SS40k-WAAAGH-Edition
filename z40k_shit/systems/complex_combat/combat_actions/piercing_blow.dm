
//We ready a piercing Blow, which will armor penetrate to some degree on the weapon you do it with.
//Can be used in conjunction with stances.
/datum/action/item_action/warhams/piercing_blow
	name = "Piercing Blow"
	background_icon_state = "bg_pierce"
	button_icon_state = "pierce"

/datum/action/item_action/warhams/piercing_blow/Trigger()
	var/obj/item/weapon/S = target
	S.piercing_blow(owner)

/obj/item/weapon/proc/piercing_blow(var/mob/living/user)
	var/mob/living/carbon/human/H = user
	if(can_piercing)
		user.visible_message("<span class='danger'> [user] prepares to deliver a piercing blow.</span>")
		if(do_after(H,src,20))
			is_piercing = TRUE
			H.word_combo_chain += "pierce"
			H.update_powerwords_hud()