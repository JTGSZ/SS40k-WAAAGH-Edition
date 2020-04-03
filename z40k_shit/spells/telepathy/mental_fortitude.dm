/spell/aoe_turf/mental_fortitude	//Raaagh
	name = "Mental Fortitude"
	abbreviation = "MF"
	desc = "Blessing - Fills everyone around you with visions of glorious victory."
	hud_state = "racial_waagh"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = TELEPATHY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/mental_fortitude/cast(list/targets, mob/user)

	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Visions of victory flood your mind, and you charge forward.</span>")
		L.movement_speed_modifier += 1.0
		for(var/i=1 to 6)
			step(L,user.dir)

		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>The visions leave your mind, along with your vigor.</span>")
			L.movement_speed_modifier -= 1.0

/spell/aoe_turf/mental_fortitude/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/L in view(2, user))
		targets += L

	return targets