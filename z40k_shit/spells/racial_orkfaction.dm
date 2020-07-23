/spell/aoe_turf/ork_mob_builder //Raaagh
	name = "Ork Mob Builder"
	abbreviation = "WG"
	desc = "For the boys to get together."
	panel = "Racial Abilities"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	
	override_base = "basic_button"
	override_icon = 'z40k_shit/icons/buttons/generic_action_buttons.dmi'
	hud_state = "mek_build"


	var/datum/faction/dyn_ork/our_faction = null

/spell/aoe_turf/ork_mob_builder/Destroy()
	our_faction = null
	..()

/spell/aoe_turf/ork_mob_builder/cast(var/list/targets, mob/user)
	popup_window(user)

/spell/aoe_turf/ork_mob_builder/proc/popup_window(mob/user)
	var/dat
	dat += {"<B>Ork Mob Builder Menu</B><BR>
			<HR>
			<I>Where ya go to get the feels.</I><BR>"}

	if(!our_faction)
		dat += "<B> If ya do this ya gotta find other boyz to work with, at least THREE, ya can't ever leave ya own mob too.</B><BR>"
		dat += "<A href='byond://?src=\ref[src];createorkmob=1'>Create ya own Mob</A>"
//	else
		

//else

	dat += "<HR>"

	var/datum/browser/popup = new(user, "mobbuilder", "Mob Builder Menu")
	popup.set_content(dat)
	popup.open()

/spell/aoe_turf/ork_mob_builder/Topic(href, href_list)
	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["createorkmob"])
		if(!our_faction)
			create_ork_mob(usr)

//	if(href_list["desc"])

	src.popup_window(usr)


/spell/aoe_turf/ork_mob_builder/proc/create_ork_mob(mob/user)
	var/datum/faction/dyn_ork/fac = ticker.mode.CreateFaction(/datum/faction/dyn_ork, null, 1)
	var/datum/role/mob_boss/ourboss = new (user.mind, fac, override = TRUE)
	our_faction = fac
	fac.leader = ourboss
	if(fac)
		var/newname = copytext(sanitize(input(ourboss.antag.current,"You are da boss of dis ere' mob. Think up a good name ya git", "Name change","")),1,MAX_NAME_LEN)
		if(newname)
			if(newname == "Unknown" || newname == "floor" || newname == "wall" || newname == "rwall" || newname == "_")
				to_chat(ourboss.antag.current, "That name is reserved.")
			fac.name = "[newname]."
		else
			fac.name = "DA BOYZ"
