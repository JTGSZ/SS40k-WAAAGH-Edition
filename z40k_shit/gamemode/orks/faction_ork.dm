/datum/faction/ork_raiders
	name = "Ork Raiders"
	desc = "Doing as Orks usually do."
	ID = ORKS
	required_pref = ORKRAIDER
	initial_role = ORKRAIDER
	late_role = ORKRAIDER
	roletype = /datum/role/ork_raider
	initroletype = /datum/role/ork_raider
	logo_state = "ig-logo"
	hud_icons = list("vox-logo")

	var/time_left = (30 MINUTES)/10
	//Are we completed or not
	var/completed = FALSE

	var/results = "Who knows."

	//Do we gots the items
	var/got_items = 0

	//Our point total
var/ork_total_points = 0

/datum/faction/ork_raiders/forgeObjectives()


/datum/faction/ork_raiders/GetScoreboard()
	. = ..()
	//. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"
	if (time_left < 0)
		. += "<br/> <span class='danger'>The raid has ended.</span>"
	. += "<br/> The orks looted <b>[got_items]</b> items."
	. += "<br/> Total points: <b>[ork_total_points]</b>. <br/>"
	. += results

/datum/faction/ork_raiders/AdminPanelEntry()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"

/datum/faction/ork_raiders/OnPostSetup()
	..()
	for(var/datum/role/imperial_guard/IG in members)
		var/datum/mind/synd_mind = IG.antag
		mind_storage(synd_mind.current)

/datum/faction/ork_raiders/proc/mind_storage(var/mob/living/carbon/human/guardsmen)
	guardsmen.store_memory("The priority items are: [english_list(macguffin_items)]")

/datum/faction/ork_raiders/process()
	if(completed)
		return
	. = ..()
	time_left -= 2
	if(time_left < 0 && completed == FALSE)
		completed = TRUE
		for(var/datum/role/R in members)
			to_chat(R.antag.current, "<span class='warning'>The raid is over.</span>")

		var/area/points_area = locate(/area/vault/warhammergen/ork_loot_area)
		for(var/obj/O in points_area)
			if(is_type_in_list(O, macguffin_items))
				ork_total_points += 500
				got_items++

		for(var/mob/player in mob_list)
			if(player.stat == DEAD)
				if(player.mind.assigned_role == "General")
					ork_total_points += 1000
				if(player.mind.assigned_role == "Commissar")
					ork_total_points += 250

		if(ig_total_points <= ork_total_points)
			stage(FACTION_VICTORY)
			results = "WE KRUMPED DA 'UMIES."
		else
			stage(FACTION_DEFEATED)
			results = "THE 'UMIES KRUMPED US."
			
/datum/faction/ork_raiders/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)
