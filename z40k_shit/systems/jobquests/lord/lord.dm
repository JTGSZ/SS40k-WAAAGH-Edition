/datum/job_quest/tzeetch_champion
	title = "Retrieving A Heirloom - Crown Quest"
	var/mask_out_of_dungeon = FALSE

/datum/job_quest/tzeetch_champion/main_body()
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'> You reminisce for a moment, dwelling upon when things were much more simple. Mostly because you weren't responsible for much.</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'> You think back to how the last lord always seemed so angry, talking about how everything was taken from him. How things were unfair, things do feel quite unfair. Considering you now have the title of Lord to this failing place, it could be worse though. </span>")
			alignment--
		if(-1)
			to_chat(our_protagonist, "<span class='notice'> It could indeed be a lot worse, you've found you have developed a certain talent over time, although you've taken care to keep it secret. You've taken the time to obtain a book and hone your power in private. </span>")
			alignment--
		if(-2)
			to_chat(our_protagonist, "<span class='notice'> Perhaps you should go search under your bed that book; a refresher couldn't hurt.</span>")
			alignment--
		if(-3)
			for(var/obj/effect/landmark/lordpsykerbook/ourbook in orange(3,our_protagonist))
				to_chat(our_protagonist, "<span class='notice'>Yes, this is the right place, regardless lets open this book.</span>")
				var/mob/living/carbon/human/H = our_protagonist
				H.attribute_willpower = 12
				H.attribute_sensitivity = 600
				H.psyker_points = 2
				new /obj/item/weapon/psychic_spellbook(ourbook.loc)
				qdel(ourbook)
				alignment--
		if(-4)
			to_chat(our_protagonist, "<span class='notice'> You know the gift that has come to you is wrong, perhaps that is why a inquisitor has been lurking. Most people wouldn't know much other than to burn the witch, but you are lord of this ruined moon. </span>")
			alignment--
		if(-5)
			to_chat(our_protagonist, "<span class='notice'> Indeed, you are aware of the dangers. But are they truly dangers? Only a fool couldn't control their power. </span>")
			alignment--
		if(-6)
			to_chat(our_protagonist, "<span class='notice'> Mmm, but we both know that isn't enough to turn the tide in bringing prosperity to this land. Along with that you've been hearing whispers as of late. </span>")
			alignment--
		if(-7)
			to_chat(our_protagonist, "<span class='tzeentch'> Your salvation lies in the place you rightfully belong. </span>")
			alignment--
		if(-8)
			to_chat(our_protagonist, "<span class='notice'> There it is again, a image of a white mask from a throne room fills your mind, similar to one that odd performer wears, but vastly different you feel. You aren't dumb though, clearly its telling you your rightful place is upon it, after-all that is where a Lord belongs.</span>")
			alignment--
		if(-9)
			to_chat(our_protagonist, "<span class='notice'> Alas, everytime you've tried to get into the throne room yourself. Something odd just prevents you from doing so, all the men you've sent have never returned either. Maybe today will be different </span>")
			alignment--
		if(-10)
			if(!mask_out_of_dungeon)
				to_chat(our_protagonist, "<span class='notice'> Send someone to investigate and chart once more, your birthright lay deep in the south-east. </span>")
			else
				to_chat(our_protagonist, "<span class='notice'> You've felt the odd feeling, perhaps its the feeling of success. Oddly, you feel something calling out to you now. </span>")
				alignment--
		if(-11) //End
			for(var/obj/item/clothing/mask/gas/artifact/evilmask in our_protagonist.contents)
				var/mob/living/carbon/human/H = our_protagonist
				to_chat(our_protagonist, "<span class='notice'> The mask called to you, and you have answered. Your perception of things opening up, can you truly describe it as power filling you? Its as if your whole being is capable of tapping into so much more. </span>")
				H.attribute_willpower = 12
				H.attribute_sensitivity = 600
				H.psyker_points = 12
