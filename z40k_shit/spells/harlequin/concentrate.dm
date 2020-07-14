/spell/targeted/concentrate
	name = "Concentrate"
	desc = "Stretch out with your senses."
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
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
