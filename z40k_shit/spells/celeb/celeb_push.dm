/*
abilities
*/

/obj/effect/proc_holder/spell/targeted/celeb/push
	name = "Expose the Warp"
	desc = "Slaanesh pushes against the very fabric of reality- threatening to break through."
	invocation = "Get Turned up to Death!"
	invocation_type = "none"
	school = "warp"
	panel = "Warp Magic"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1


/obj/effect/proc_holder/spell/targeted/celeb/push/cast()				//we hijack the click!! Take this click to cuba!!!
	if(!usr) 
		return
	if(!ishuman(usr)) 
		return
	var/mob/living/carbon/human/U = usr
	var/soundfile = 'sound/voice/celeb.ogg'								//droppin beats!
	playsound(U.loc, soundfile, 75, 0)
	var/obj/item/device/soulstone/X
	for(var/mob/living/carbon/human/H in range(9, U.loc))				//who is in range?
		if(H != U)
			H.Jitter(250)												//make them jitter
			spawn(0)
				if(X in H.contents)
					var/eyeofslaanesh = H.name
					if(H.gender == "male")
						U << "Kill [eyeofslaanesh] and bring his soulstone to me!"
						H.Weaken(4)
					if(H.gender == "female")
						U << "Kill [eyeofslaanesh] and bring her soulstone to me!"
						H.Weaken(4)
				else
					H.mutate("slaanesh")
					warppush(H)


	if(iscarbon(U))													//regen but only if people are in range to see it
		U.handcuffed = initial(U.handcuffed)
		if(!U.stat)
			U.heal_organ_damage(2,2)
		if(U.reagents)
			U.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			U.adjustToxLoss(-2)

		for(var/datum/reagent/R in U.reagents.reagent_list)
			U.reagents.clear_reagents()

	U.visible_message("<span class='notice'>Space and time bend before your eyes!!</span>", "<span class='notice'>LETS GET THIS PARTY STARTED!!</span>")


	..()

/obj/effect/proc_holder/spell/targeted/celeb/push/proc/warppush(var/mob/H)
	H.loc = get_turf(locate("landmark*warppush"))
	sleep(240)
	H.loc = get_turf(locate("landmark*warppush2"))
