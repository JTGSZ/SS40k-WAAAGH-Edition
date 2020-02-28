/datum/faction/imperial_guard
	name = "Imperial Guard"
	desc = "Doing their best as humanity to survive as humanity under humanity."
	ID = IMPERIALGUARD
	required_pref = IMPERIALGUARDSMEN
	initial_role = IMPERIALGUARDSMEN
	late_role = IMPERIALGUARDSMEN
	roletype = /datum/role/imperial_guard
	initroletype = /datum/role/imperial_guard
	logo_state = "ig-logo"
	hud_icons = list("vox-logo")

	var/time_left = (1 MINUTES)/10
	//Are we completed or not
	var/completed = FALSE

	var/results = "Who knows."

	//Do we gots the items
	var/got_items = 0

	//How much shit we killed
	var/death_tally = 0

	//Our point total
	var/total_points = 0

/datum/faction/imperial_guard/forgeObjectives()


/datum/faction/imperial_guard/GetScoreboard()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"
	if (time_left < 0)
		. += "<br/> <span class='danger'>The raid has ended.</span>"
	. += "<br/> The imperial guard killed <b>[death_tally] orks.</b>."
	. += "<br/> The imperial guard secured <b>[got_items]</b> items."
	. += "<br/> Total points: <b>[total_points]</b>. <br/>"
	. += results

/datum/faction/imperial_guard/AdminPanelEntry()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"

/datum/faction/imperial_guard/OnPostSetup()
	..()

/datum/faction/imperial_guard/process()
	if(completed)
		return
	. = ..()
	time_left -= 2
	if(time_left < 0 && completed == FALSE)
		completed = TRUE
		for(var/datum/role/R in members)
			to_chat(R.antag.current, "<span class='warning'>The raid is over.</span>")

		var/area/points_area = locate(/area/vault/warhammergen/ig_loot_area)
		for(var/obj/O in points_area)
			if(is_type_in_list(O, macguffin_items))
				total_points += 500
				got_items++

		for(var/mob/player in mob_list)
			if(isork(player))
				if(player.stat == DEAD)
					total_points += 5
					death_tally++
					if(player.mind.assigned_role == "Ork Warboss")
						total_points += 1000
					if(player.mind.assigned_role == "Ork Nob")
						total_points += 250
			
/datum/faction/imperial_guard/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)

