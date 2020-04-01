/spell/aoe_turf/endurance	//Raaagh
	name = "Endurance"
	abbreviation = "WG"
	desc = "Blessing - Makes everyone in range tougher."
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	specialization = BIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/endurance/cast(list/targets, mob/user)
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Warp Energy courses through you, increasing your constitution.</span>")
		L.attribute_constitution += 15
		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, your constitution returns to normal.</span>")
			L.attribute_constitution -= 15

/spell/aoe_turf/endurance/choose_targets(var/mob/user = usr)
	var/list/targets = list()

	for(var/mob/living/L in view(2, user))
		targets += L

	return targets
