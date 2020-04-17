/spell/aoe_turf/invisibility	//Raaagh
	name = "Invisibility"
	abbreviation = "INV"
	desc = "Blessing - Makes everyone in range invisible."
	hud_state = "invisibility"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSTELEPATHY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/invisibility/cast(list/targets, mob/user)
	set waitfor = 0
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>You become invisible.</span>")
		L.invisibility = 101

	sleep(12 SECONDS)

	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Warp Energy fading, you return to being visible to the naked eye.</span>")
		L.invisibility = 0

/spell/aoe_turf/invisibility/choose_targets(var/mob/user = usr)
	var/list/targets = list()

	for(var/mob/living/L in view(2, user))
		targets += L

	targets += user

	return targets
