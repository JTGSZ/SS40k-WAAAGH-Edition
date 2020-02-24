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

	var/time_left = (30 MINUTES)/10
	var/completed = FALSE

	var/results = "Who knows."

	var/list/dept_objective = list()
	var/list/bonus_items_of_the_day = list()

	var/got_personnel = 0
	var/got_items = 0

	var/total_points = 0
	var/list/our_bounty_lockers = list()

var/list/ig_macguffin_items = list(
	/obj/item/weapon/card/emag,
)

/datum/faction/imperial_guard/forgeObjectives()
	//AppendObjective(/datum/objective/collect_shit)
	//AppendObjective(/datum/objective/assassinate_boss)

/datum/faction/imperial_guard/GetScoreboard()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"
	if (time_left < 0)
		. += "<br/> <span class='danger'>The raid took too long.</span>"
	//. += "<br/> The imperial guard killed <b>[got_personnel]</b>."
	. += "<br/> The imperial guard secured <b>[got_items]</b> priority items."
	. += "<br/> Total points: <b>[total_points]</b>. <br/>"
	. += results

/datum/faction/imperial_guard/AdminPanelEntry()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"

/datum/faction/imperial_guard/OnPostSetup()
	..()
	var/list/turf/vox_spawn = list()

	var/spawn_count = 1

	for(var/datum/role/vox_raider/V in members)
		if(spawn_count > vox_spawn.len)
			spawn_count = 1
		var/datum/mind/synd_mind = V.antag
		synd_mind.current.forceMove(vox_spawn[spawn_count])
		spawn_count++
		mind_storage(synd_mind.current)

/datum/faction/imperial_guard/proc/mind_storage(var/mob/living/carbon/human/guardsmen)
	guardsmen.store_memory("The priority items are: [english_list(ig_macguffin_items)]")

/datum/faction/imperial_guard/process()
	if (completed)
		return
	. = ..()
	time_left -= 2
	if (vox_shuttle.returned_home)
		completed =  TRUE
		var/area/end_area = locate(/area/shuttle/vox/station)
		// -- First, are we late ? -100 points for every minute over the clock.
		if(time_left < 0)
			for(var/datum/role/R in members)
				to_chat(R.antag.current, "<span class='warning'>The raid is over.</span>")
			total_points -= RULE_OF_THREE(-60, 100, time_left)

		for(var/obj/structure/closet/loot/L in our_bounty_lockers)
			for(var/obj/O in L)
				count_score(O)

/datum/faction/imperial_guard/proc/count_score(var/atom/O)
	if(ishuman(O))
		count_human_score(O)
		return
	// Items
	if(is_type_in_list(O, ig_macguffin_items))
		total_points += 500
		got_items++


/datum/faction/imperial_guard/proc/count_human_score(var/mob/living/carbon/human/H)
	if(H.mind.assigned_role in command_positions)
		total_points += 300
	if(H.mind.assigned_role in dept_objective)
		total_points += 200
		got_personnel++

/datum/faction/imperial_guard/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)

