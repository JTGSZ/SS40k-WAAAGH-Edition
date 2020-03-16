//STANCE SWAP - BASIC
/datum/action/item_action/warhams/heavydef_swap_stance
	name = "Swap Stance"
	background_icon_state = "bg_block"
	button_icon_state = "defensive"

/datum/action/item_action/warhams/heavydef_swap_stance/Trigger()
	var/obj/item/weapon/S = target
	S.switch_stance(owner)

	if(S.stance == "deflecting")
		background_icon_state = "bg_deflect"
		button_icon_state = "deflect"
		UpdateButtonIcon()
	if(S.stance == "blocking")
		background_icon_state = "bg_block"
		button_icon_state = "blocking"
		UpdateButtonIcon()
