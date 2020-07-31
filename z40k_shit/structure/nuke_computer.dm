/obj/structure/nuke_computer_left
	name = "Mysterious Console"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "left"

/obj/structure/nuke_computer_left/ex_act(severity)
	return

/obj/structure/nuke_computer_right
	name = "Mysterious Console"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "right_closed"

/obj/structure/nuke_computer_right/ex_act(severity)
	return

/obj/structure/nuke_computer
	name = "Mysterious Console"
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "ob1"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	var/nuke_authorized = FALSE
	var/lord_authorized = FALSE
	var/already_signalled = FALSE
	var/list/used_id = list()
	var/time_left = 600 //This is a value in seconds, deciseconds will be deducted

/obj/structure/nuke_computer/ex_act(severity)
	return

/obj/structure/nuke_computer/New()
	..()

/obj/structure/nuke_computer/Destroy()
	..()

/obj/structure/nuke_computer/attack_hand(mob/user)
	lets_a_go(user)

/obj/structure/nuke_computer/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/id_card = W
		if(!id_card in used_id)
			if(access_lord_nuke_computer in id_card.access)
				lord_authorized = TRUE
				used_id += id_card
			if(accesss_knight_nuke_computer in id_card.access)
				used_id += id_card
		else
			if(access_lord_nuke_computer in id_card.access)
				lord_authorized = FALSE
				used_id -= id_card
			if(accesss_knight_nuke_computer in id_card.access)
				used_id -= id_card
		check_authorization()
	else 
		return ..()
			
/obj/structure/nuke_computer/proc/lets_a_go(mob/user)
	check_authorization()
	var/dat
	dat += {"<B> Control Uplink Console</B><BR>
			<HR>
			<B>Currently Authorized:</B> <I>[nuke_authorized ? "<font='#2bff00'>AUTHORIZED</font>":"<font='#ff0000'>DENIED</font>"]"</I><BR>"}
	if(!nuke_authorized)
		dat += "<BR><BR><I>SUBMIT AUTHORIZATION IDENTIFICATION</I>"
	else
		if(!already_signalled)
			dat += "<BR><I><B>SIGNAL DEATHSTRIKE MISSILE</I></B><BR>"
			dat += "<A href='byond://?src=\ref[src];signal_missile=1>Hit the Button</A>"
		else
			dat += "<BR><B><font='#ff0000'>MISSILE ENROUTE TO COORDINATES</font></B><BR>"
			dat += "Time before Impact: [time_left] Seconds"

	var/datum/browser/popup = new(user, "nukemenu", "Control Uplink Console")
	popup.set_content(dat)
	popup.open()

/obj/structure/nuke_computer/proc/check_authorization()
	if(lord_authorized)
		nuke_authorized = TRUE
	if(used_id.len >= 3)
		nuke_authorized = TRUE
	return nuke_authorized

/obj/structure/nuke_computer/proc/the_long_goodbye()
	to_chat(world, "<span class='tzeentch'> <i>You have a eerie feeling like something bad is going to happen in the future.</i></span>")
	processing_objects += src

/obj/structure/nuke_computer/process()
	time_left--
	if(time_left <= 0)
		detonate_the_world()
		processing_objects -= src
		time_left = 600

/obj/structure/nuke_computer/proc/detonate_the_world()
	enter_allowed = 0
	if(ticker)
		ticker.station_explosion_cinematic(0,"planet_nuke")
		ticker.station_was_nuked = 1
		ticker.explosion_in_progress = 0
		SSpersistence_map.setSavingFilth(FALSE)

/obj/structure/nuke_computer/Topic(href, href_list)
	if(usr.stat != DEAD)
		return
	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["signal_missile"])
		if(check_authorization())
			if(!already_signalled)
				say("Authorization Cleared, Sending Coordinates to Missile.")
				already_signalled = TRUE
				sleep(5 SECONDS)
				the_long_goodbye() //We add ourselves to processing objects
			else
				say("Signal Received, Signal Returned")

	lets_a_go(L)