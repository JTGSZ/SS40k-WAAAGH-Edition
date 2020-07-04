/spell/targeted/stealth
	name = "Stealth"
	desc = "Hiding is like second nature to you."
	school = "mime"
	panel = "Mime"
	invocation_type = SpI_NONE
	charge_max = 500
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/stealth/cast(list/targets)
	for(var/mob/living/carbon/human/H in targets)
		H.invisibility = INVISIBILITY_LEVEL_TWO
		spawn(0)
			anim(H.loc,H,'z40k_shit/icons/mob/mobs.dmi',,"cloak",,H.dir)
		H.alpha = 0
		H << "\blue You are now invisible to normal detection."
		for(var/mob/O in oviewers(H))
			O.show_message("[H.name] vanishes into thin air!",1)
		sleep(120)
		if(H)
			spawn(0)
				anim(H.loc,H,'z40k_shit/icons/mob/mobs.dmi',,"uncloak",,H.dir)
			H.alpha = 255
			H << "\blue You are now visible."
			for(var/mob/O in oviewers(H))
				O.show_message("[H.name] appears from thin air!",1)
		H.invisibility = 0
