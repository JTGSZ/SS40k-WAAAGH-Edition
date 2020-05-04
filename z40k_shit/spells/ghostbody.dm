//obj/abstract/screen/HU

/spell/aoe_turf/ghost_body //Raaagh
	name = "Ghost Bodies"
	desc = "For the ghost with the most."
	panel = "Racial Abilities"
	override_base = "grey"
	hud_state = "boo"
	charge_max = 20
	spell_flags = STATALLOWED | GHOSTCAST
	invocation_type = SpI_NONE

/spell/aoe_turf/ghost_body/New()
	..()

/spell/aoe_turf/ghost_body/Destroy()
	..()

/spell/aoe_turf/ghost_body/cast(var/list/targets, mob/user)
	open_menu(user)

/spell/aoe_turf/ghost_body/proc/open_menu(var/mob/user)
	if(!user)
		return
	if(!user.client)
		return	
	if(!isobserver(user))
		return
	if("ghosticons_map" in user.client.screen_maps) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good. 
		return 

	user.client.setup_popup("ghostbodies",6,6,1,"black")
	user.client.add_objs_to_map(ghostbody_buttons)
