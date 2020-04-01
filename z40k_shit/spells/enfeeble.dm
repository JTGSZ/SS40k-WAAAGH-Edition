/spell/targeted/enfeeble
	name = "Enfeeble"
	desc = "Malediction - Weakens the target and everyone around it."
	abbreviation = "GR"
	user_type = USER_TYPE_WIZARD
	specialization = BIOMANCY

	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	hud_state = "bucket"

/spell/targeted/enfeeble/cast(var/list/targets, mob/user)
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			C.movement_speed_modifier -= 0.5
			C.attribute_strength -= 10
			C.attribute_constitution -= 10
			C.adjustBruteLoss(50)

			spawn(3 SECONDS)
				C.adjustBruteLoss(-30)
				C.attribute_strength += 10
				C.attribute_constitution += 10
				C.movement_speed_modifier += 0.5


