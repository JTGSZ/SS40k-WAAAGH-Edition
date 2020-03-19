/datum/action/item_action/warhams/begin_sawing
	name = "Begin Sawing"
	background_icon_state = "bg_saw"
	button_icon_state = "saw"

/datum/action/item_action/warhams/begin_sawing/Trigger()
	var/obj/item/weapon/S = target
	if(!S.saw_execution)
		S.saw_execution = TRUE
	else
		S.saw_execution = FALSE