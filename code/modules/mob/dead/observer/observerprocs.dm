/*
	toggle_medHUD()
*/
/mob/dead/observer/proc/toggle_medHUD()
	if(!client)
		return
	if(selectedHUD == HUD_MEDICAL)
		selectedHUD = HUD_NONE
		to_chat(src, "<span class='notice'><B>Medical HUD disabled.</B></span>")
	else
		selectedHUD = HUD_MEDICAL
		to_chat(src, "<span class='notice'><B>Medical HUD enabled.</B></span>")

/*
Reenter corpse
*/
/mob/dead/observer/proc/reenter_corpse()
	var/mob/M = get_top_transmogrification()
	if(!M.client)
		return
	if(!(mind && mind.current && can_reenter_corpse))
		to_chat(src, "<span class='warning'>You have no body.</span>")
		return
	if(mind.current.key && copytext(mind.current.key,1,2)!="@")	//makes sure we don't accidentally kick any clients
		to_chat(usr, "<span class='warning'>Another consciousness is in your body...It is resisting you.</span>")
		return
	if(mind.current.ajourn && istype(mind.current.ajourn,/obj/effect/rune_legacy) && mind.current.stat != DEAD) 	//check if the corpse is astral-journeying (it's client ghosted using a cultist rune).
		var/obj/effect/rune_legacy/R = mind.current.ajourn	//whilst corpse is alive, we can only reenter the body if it's on the rune
		var/datum/faction/cult/narsie/blood_cult = find_active_faction_by_member(mind.GetRole(LEGACY_CULTIST))
		var/list/cultwords
		if (istype(blood_cult))
			cultwords = blood_cult.cult_words
		else
			cultwords = null
		if(cultwords && !(R && R.word1 == cultwords["hell"] && R.word2 == cultwords["travel"] && R.word3 == cultwords["self"]))	//astral journeying rune
			to_chat(usr, "<span class='warning'>The astral cord that ties your body and your spirit has been severed. You are likely to wander the realm beyond until your body is finally dead and thus reunited with you.</span>")
			return
	completely_untransmogrify()
	mind.current.key = key
	mind.isScrying = 0
	return 1

/*
	Toggle Darkness
					*/

/mob/dead/observer/proc/toggle_darkness()
	if(see_invisible == SEE_INVISIBLE_OBSERVER_NOLIGHTING)
		to_chat(src, "<span class='warning'>Lighting unhidden.</span>")
		see_invisible = SEE_INVISIBLE_OBSERVER
	else
		to_chat(src, "<span class='warning'>Lighting hidden.</span>")
		see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING

/*
	Dead Teleport
					*/
/mob/dead/observer/proc/dead_tele()
	if(!istype(usr, /mob/dead/observer))
		to_chat(usr, "Not when you're not dead!")
		return
	var/A
	A = input("Area to jump to", "BOOYEA", A) as null|anything in ghostteleportlocs
	var/area/thearea = ghostteleportlocs[A]

	if(!thearea)
		return

	if(thearea && thearea.anti_ethereal && !isAdminGhost(usr))
		to_chat(usr, "<span class='sinister'>As you are about to arrive, a strange dark form grabs you and sends you back where you came from.</span>")
		return

	var/list/L = list()
	var/holyblock = 0

	if((usr.invisibility == 0) || islegacycultist(usr))
		for(var/turf/T in get_area_turfs(thearea.type))
			if(!T.holy)
				L+=T
			else
				holyblock = 1
	else
		for(var/turf/T in get_area_turfs(thearea.type))
			L+=T

	if(!L || !L.len)
		if(holyblock)
			to_chat(usr, "<span class='warning'>This area has been entirely made into sacred grounds, you cannot enter it while you are in this plane of existence!</span>")
		else
			to_chat(usr, "No area available.")

	usr.forceMove(pick(L))
	if(locked_to)
		manual_stop_follow(locked_to)

/*
	Hide Sprite
				*/
		
// For filming shit.
/mob/dead/observer/proc/hide_sprite()
	// Toggle alpha
	if(alpha == 127)
		alpha = 0
		mouse_opacity = 0
		to_chat(src, "<span class='warning'>Sprite hidden.</span>")
	else
		alpha = 127
		mouse_opacity = 1
		to_chat(src, "<span class='info'>Sprite shown.</span>")

/mob/dead/observer/proc/follow()
	var/list/mobs = getmobs()
	var/input = input("Please, select a mob!", "Haunt", null, null) as null|anything in mobs
	var/mob/target = mobs[input]
	manual_follow(target)

//This is the ghost's follow verb with an argument
/mob/dead/observer/proc/manual_follow(var/atom/movable/target)
	if(target)
		var/turf/targetloc = get_turf(target)
		var/area/targetarea = get_area(target)
		if(targetarea && targetarea.anti_ethereal && !isAdminGhost(usr))
			to_chat(usr, "<span class='sinister'>You can sense a sinister force surrounding that mob, your spooky body itself refuses to follow it.</span>")
			return
		if(targetloc && targetloc.holy && (!invisibility || islegacycultist(src)))
			to_chat(usr, "<span class='warning'>You cannot follow a mob standing on holy grounds!</span>")
			return
		if(target != src)
			if(locked_to)
				if(locked_to == target) //Trying to follow same target, don't do anything
					return
				manual_stop_follow(locked_to) //So you can switch follow target on a whim
			target.lock_atom(src, /datum/locking_category/observer)
			to_chat(src, "<span class='sinister'>You are now haunting \the [target]</span>")

/mob/dead/observer/proc/manual_stop_follow(var/atom/movable/target)
	if(!target)
		to_chat(src, "<span class='warning'>You are not currently haunting anyone.</span>")
		return
	else
		to_chat(src, "<span class='sinister'>You are no longer haunting \the [target].</span>")
		unlock_from()

/mob/dead/observer/proc/jumptomob() //Moves the ghost instead of just changing the ghosts's eye -Nodrak
	if(istype(usr, /mob/dead/observer)) //Make sure they're an observer!
		var/list/dest = list() //List of possible destinations (mobs)
		var/target = null	   //Chosen target.

		dest += getmobs() //Fill list, prompt user with list
		target = input("Please, select a player!", "Jump to Mob", null, null) as null|anything in dest

		if (!target)//Make sure we actually have a target
			return
		else
			var/turf/targetloc = get_turf(target)
			var/area/targetarea = get_area(target)
			if(targetarea && targetarea.anti_ethereal && !isAdminGhost(usr))
				to_chat(usr, "<span class='sinister'>You can sense a sinister force surrounding that mob, your spooky body itself refuses to jump to it.</span>")
				return
			if(targetloc && targetloc.holy && ((src.invisibility == 0) || islegacycultist(src)))
				to_chat(usr, "<span class='warning'>The mob that you are trying to follow is standing on holy grounds, you cannot reach him!</span>")
				return
			var/mob/M = dest[target] //Destination mob
			var/mob/A = src			 //Source mob
			var/turf/T = get_turf(M) //Turf of the destination mob

			if(T && isturf(T))	//Make sure the turf exists, then move the source to that destination.
				A.forceMove(T)
				if(locked_to)
					manual_stop_follow(locked_to)
			else
				to_chat(A, "This mob is not located in the game world.")

/mob/dead/observer/proc/hide_ghosts()
	if(!client.ghost_planemaster)
		to_chat(src, "<span class='warning'>You have no ghost planemaster. Make a bug report!</span>")
		return

	if(client.ghost_planemaster.alpha == 255)
		client.ghost_planemaster.alpha = 0
		client.ghost_planemaster.mouse_opacity = 0
		to_chat(src, "<span class='info'>Ghosts hidden.</span>")
	else
		client.ghost_planemaster.alpha = 255
		client.ghost_planemaster.mouse_opacity = 1
		to_chat(src, "<span class='info'>Ghosts shown.</span>")

