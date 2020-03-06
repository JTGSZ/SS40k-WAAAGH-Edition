
/datum/action/item_action/warhams/attachment/scope_zoom
	name = "Zoom"
	button_icon_state = "zoom"

/datum/action/item_action/warhams/attachment/scope_zoom/Trigger()
	..()
	var/obj/item/weapon/gun/energy/complexweapon/lasgun/S = target
	S.scope_act()
	if(S.currently_scoped)
		button_icon_state = "zoom"
	else
		button_icon_state = "unzoom"
	UpdateButtonIcon()

/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/scope_act()
	if(usr!=get_pilot())
		return
	
	var/mob/user = get_pilot()

	if(!currently_scoped)
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

/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/check_scope()
	if(!scope) //There's no light on the helmet
		if(currently_scoped) //The helmet light is currently on
			currently_scoped = FALSE //Force it off
			scope_act()
		actions_types.Remove(/datum/action/item_action/toggle_rig_light)//Disable the action button (which is only used to toggle the light, in theory)
	else //We have a light
		actions_types |= /datum/action/item_action/toggle_rig_light //Make sure we restore the action button

/obj/item/clothing/head/helmet/space/rig/proc/toggle_light(var/mob/user)
	if(no_light)
		return
	if(rig)
		on = !on
		if(!rig.cell || rig.cell.charge < 1)
			on = FALSE
		update_brightness()
		if(user)
			user.update_inv_head()
