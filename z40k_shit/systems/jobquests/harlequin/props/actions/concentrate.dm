/spell/targeted/concentrate
	name = "Concentrate"
	desc = "Stretch out with your senses."
	school = "mime"
	panel = "Mime"
	invocation_type = SpI_NONE
	charge_max = 10
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/concentrate/cast(list/targets)
	for(var/mob/living/carbon/human/M in targets)
		M.job_quest.main_body()
		return
