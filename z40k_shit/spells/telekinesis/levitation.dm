/spell/aoe_turf/levitation	//Raaagh
	name = "Levitation"
	abbreviation = "LVT"
	desc = "Blessing - Makes everyone in range levitate."
	hud_state = "levitate"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSTELEKINESIS
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/aoe_turf/levitation/cast(list/targets, mob/user)
	set waitfor = 0
	for(var/mob/living/L in targets)
		var/pixel_y = L.pixel_y
		to_chat(L, "<span class='sinister'>You begin floating off the ground.</span>")
		L.flying = TRUE
		animate(L, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 10, loop = 1, easing = SINE_EASING)
		
	sleep(12 SECONDS)
	
	for(var/mob/living/L in targets)
		var/pixel_y = L.pixel_y
		animate(L, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
		animate(L, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
		animate(L)
		to_chat(L, "<span class='sinister'>You stop floating.</span>")
		L.flying = FALSE

/spell/aoe_turf/levitation/choose_targets(var/mob/user = usr)
	var/list/targets = list()

	for(var/mob/living/L in view(2, user))
		targets += L

	return targets