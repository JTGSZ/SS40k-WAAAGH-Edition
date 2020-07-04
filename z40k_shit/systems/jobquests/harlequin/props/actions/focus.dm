
/spell/targeted/focus
	name = "Focus"
	desc = "Stretch out with your senses."
	school = "mime"
	panel = "Mime"
	charge_max = 750
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/focus/cast(list/targets)
	for(var/mob/living/carbon/human/H in targets)
		var/client/C = H.client
		var/datum/job_quest/QST = H.job_quest
		if(QST.alignment == -5)
			to_chat(H, "<span class='notice'>You need to stand still and focus for a moment. This is important.</span>")
			QST.alignment--
			return
		if(QST.alignment == -6)
			to_chat(H, "<span class='notice'>It's..... almost....</span>")
			QST.alignment--
			return
		if(QST.alignment < -6)
			to_chat(H, "<span class='notice'>You stretch out with your senses.</span>")
			for(var/i=0, i<8, i++)
				sleep(60)
				if(H)
					C.changeView(C.view + 1)
			sleep(120)
			if(H) 
				C.changeView(C.view - 7)
