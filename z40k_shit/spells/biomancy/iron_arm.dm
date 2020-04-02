/spell/aoe_turf/iron_arm	//Raaagh
	name = "Iron Arm"
	abbreviation = "IA"
	desc = "A blessing... NANOMACHINES SON."
//	panel = "Racial Abilities"
//	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	specialization = BIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/iron_arm/cast(list/targets, mob/user)
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Your arms feel a hell of a lot stronger.</span>")
		L.attribute_strength += 15
		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, your strength feels weak.</span>")
			L.attribute_strength -= 15
			
/spell/aoe_turf/iron_arm/choose_targets(var/mob/user = usr)
	return list(user)