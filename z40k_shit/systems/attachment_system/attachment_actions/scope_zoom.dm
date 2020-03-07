
/datum/action/item_action/warhams/attachment/scope_zoom
	name = "Zoom"
	button_icon_state = "zoom"
	var/obj/item/weapon/attachment/scope/ownerscope

/datum/action/item_action/warhams/attachment/scope_zoom/Trigger()
	..()
	var/obj/item/weapon/S = target
	
	ownerscope.attack_self(owner)
	if(S.currently_zoomed)
		button_icon_state = "zoom"
	else
		button_icon_state = "unzoom"
	UpdateButtonIcon()

/obj/item/weapon/attachment/scope/attack_self(var/mob/user)

	if(!currently_zoomed)
		if(user && user.client) 
			usr.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view + 7)
			currently_zoomed = TRUE
	else
		if(user && user.client) 
			user.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view - 7)
			currently_zoomed = FALSE
