//TODO: Move some of the verbs into action buttons down the road lol.


/datum/action/warhams
	icon_icon = 'z40k_shit/icons/generic_action_buttons.dmi' //The symbol file
	button_icon_state = "default" // The button symbol state
	button_icon = 'z40k_shit/icons/generic_action_buttons.dmi' //background button file
	background_icon_state = "bg_generico" //background icon state

/datum/action/warhams/scope_zoom
	name = "Zoom"
	button_icon_state = "zoom"

/datum/action/warhams/scope_zoom/Trigger()
	..()
	var/obj/obj/item/weapon/gun/energy/complexweapon/lasgun/S = target
	S.scope_act()
	if(S.currently_scoped)
		button_icon_state = "zoom"
	else
		button_icon_state = "unzoom"
	UpdateButtonIcon()

/obj/item/weapon/gun/energy/complexweapon/lasgun/scope_act()
	if(usr!=get_pilot())
		return
	
	var/mob/user = get_pilot()

	if(!scoped)
		if(user && user.client) 
			usr.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view + 7)
			pilot_zoom = TRUE
	else
		if(user && user.client) 
			user.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view - 7)
			pilot_zoom = FALSE