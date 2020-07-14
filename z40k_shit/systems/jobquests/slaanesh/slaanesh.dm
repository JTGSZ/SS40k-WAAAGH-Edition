/datum/job_quest/slaanesh_champion
	title = "Cegorach or Bust - Harlequin Quest"
	var/suit_achieved = FALSE //Have we got our suit yet?

/datum/job_quest/slaanesh_champion/main_body()
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'>You renounce the Emperor and all that nonsense.</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'>Yeah! We don't need their stupid rules. We can at least have a beer. Just one beer. What is the worst that could happen? Lets go find a bottle of beer.</span>")
			alignment--
		if(-1)
			if(our_protagonist.find_held_item_by_type(/obj/item/weapon/reagent_containers/food/drinks/beer))
				var/thebeer = our_protagonist.find_held_item_by_type(/obj/item/weapon/reagent_containers/food/drinks/beer)
				our_protagonist.drop_item(thebeer)
				qdel(thebeer)
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] downs the entire beer like some one that hasn't had one in a while.</span>", 
												"<span class='notice'>You drink the shit out of that beer.</span>", 
												"<span class='warning>You smell beer.</span>")
				playsound(our_protagonist.loc, 'sound/items/drink.ogg', 50, 1)
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>What the crap? This isn't beer. It has to be a beer- just like old times. A beer in a beer bottle with a label on it that says 'space beer'. AND you have to be holding it in your hand!</span>")
				return
		if(-2)
			to_chat(our_protagonist, "<span class='notice'>Oh man that was nice! That really hit the spot. You know what would wash this down? Some blow. We need to get our hands on some laserbrain dust. I'm pretty sure there is some inside your ship some where.</span>")
			our_protagonist.maxHealth = 150
			our_protagonist.health = 150
			alignment--
		if(-3)
			if(our_protagonist.reagents.has_reagent(LASERBRAIN_DUST))
				to_chat(our_protagonist,"<span class='notice'>Oh holy crap man! That was awesome! Are you feeling better? I'm feeling better. This is nice. REAL nice.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Man I am a disembodied voice in your head! Did you really think you can trick me? Go get that Laserbrain dust! FUCKING STEAL IT if you have to! Just get it into your body!</span>")
		if(-4)
			to_chat(our_protagonist,"<span class='notice'>That was sweet but it's kind of lonely misbehaving by ourselves. Lets find some one else to get high with. And I know just the thing. WOOPS! Dropped it on the ground. Hope no one saw.</span>")
			new /obj/item/clothing/mask/cigarette/celeb(our_protagonist.loc)
			new /obj/item/weapon/lighter/zippo(our_protagonist.loc)

			our_protagonist.equip_to_slot_or_drop(new /obj/item/clothing/mask/cigarette/celeb(our_protagonist), slot_l_hand)
			our_protagonist.visible_message(text("<span class='alert'>[our_protagonist] pulls out a cigarette and smiles at it.</span>"))
			to_chat(our_protagonist,"<span class='notice'>I forgot we had this. This will do nicely. Lets find some one to share it BEFORE we light it up.</span>")
			our_protagonist.maxHealth = 200
			our_protagonist.health = 200
			our_protagonist.faction = "Slaanesh"
			alignment--
			var/obj/item/device/celebhacktool/C = new /obj/item/device/celebhacktool(our_protagonist.loc)
			to_chat(our_protagonist, "<span class='warning'> Hm? What's this? This [C] was also in our pocket.</span>")
		if(-5)
			to_chat(our_protagonist,"<span class='notice'>Puff puff give, you know how this works.</span>")	//had to put this in because everyone kept spawning multiple ciggarettes and wondering why it wasn't working.
		if(-6)
			to_chat(our_protagonist,"<span class='notice'>It has been a while since we jammed. I'm pretty sure we have an instrument in the closet on the south side of the ship. Lets grab it and see what we can manage.</span>")
			alignment--
		if(-7)
			if(our_protagonist.find_held_item_by_type(/obj/item/weapon/guitar))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intenly at the guitar.</span>", "<span class='notice'>This old thing. You have spent half your life with instruments like this. Lets tune it up a bit. We'll need a screwdriver.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Lets hear some tunes! Go find out old instrument in the ship. It's in there some where. Trust me! I'm a disembodied voice!</span>")
		if(-8)
			if(our_protagonist.find_held_item_by_type(/obj/item/weapon/guitar/five))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intenly at the guitar.</span>", "<span class='notice'>It's looking nice. It's looking real nice. Lets go show off our new style. It'll be a scream.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>No, this does not look like an upgraded guitar to me. Lets examine it again. Maybe figure out what we are doing wrong.</span>")
		if(-9)
			our_protagonist.visible_message("<span class='notice'>[our_protagonist] appears lost in thought.</span>", "<span class='notice'>Drugs, music, sex... it's all the same thing you know? It is all passion! What good is all the money in the universe if you don't feel alive? Lets go make ourselves a stun baton. Get some wire and rods and build one from scratch. One that is COMPLETELY ours. We can get a techpriest to help if it turns out to be complicated.</span>", "<span class='warning>You can't see shit.</span>")
			alignment--
		if(-10)
			if(our_protagonist.find_held_item_by_type(/obj/item/weapon/melee/baton))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intenly at the baton.</span>", "<span class='notice'>Every second of pain, like every note of music... is power. I think it is coming together now.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist, "<span class='notice'>You need to feel alive again. You need to harm others and BE harmed yourself. What is life even worth if you can not feel anything? Build a stun baton and lets get going.</span>")
		if(-11)
			our_protagonist.visible_message("<span class='notice'>[our_protagonist] appears lost in thought.</span>", "<span class='notice'>This is where things get tricky. We have learned the secret to TRUE power. The secret to true strength. Instead of running from vice, we have embraced it, faced it, stolen it, eaten it. The music critics can't hold you back anymore and soon... even physics won't be able to hold you back. You have a chance to transcend...but you just need one thing. A human heart. Now I know what you are thinking, you are thinking that is pretty messed up. But don't get shy on me now. This is ArchAngel IV!! There has got to be a few dead bodies laying around here some where. Get a human heart... and then we can find out just how powerful you really are. You will probably need a circular saw for this. Something small and sharp at least. Just aim for the chest and dig it out of there.</span>", "<span class='warning>You can't see shit.</span>")
			alignment--
		if(-12)
			if(our_protagonist.find_held_item_by_type(/obj/item/organ/internal/heart))
				var/theheart = our_protagonist.find_held_item_by_type(/obj/item/organ/internal/heart)
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intenly at the human heart when suddenly it morphs into something else.</span>", "<span class='notice'>I have been guiding you since you first stepped off that ship. You are my chosen and your power shall be limitless. But there is danger. Those that sent you here want you to perish. Your music, your words, your style frees the people that they have enslaved. You liberate all those around you! The imperials fear you for that. We must act quickly. Search the secret tavern for a clue.</span>", "<span class='warning>You can't see shit.</span>")
				our_protagonist.drop_item(theheart)
				qdel(theheart)
				var/obj/R = locate("landmark*crashclue")
				new /obj/item/weapon/paper/crashclue(R.loc)
				our_protagonist.equip_to_slot_or_drop(new /obj/item/weapon/sblade_stageone(our_protagonist), slot_l_hand)
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>You need a human heart. You need to hold it in your hand and assimilate it's power.</span>")
		if(-13)
			to_chat(our_protagonist,"<span class='notice'>The blade needs your strength. Only then will the path be revealed. Hold it in your hand.</span>")
			var/t_his = "it's"
			if (our_protagonist.gender == MALE)
				t_his = "his"
			if (our_protagonist.gender == FEMALE)
				t_his = "her"
			if(our_protagonist.find_held_item_by_type(/obj/item/weapon/sblade_stageone))
				var/theblade = our_protagonist.find_held_item_by_type(/obj/item/weapon/sblade_stageone)
				our_protagonist.drop_item(theblade)
				qdel(theblade)
				our_protagonist.equip_to_slot_or_drop(new /obj/item/weapon/daemonweapon/blissrazor(our_protagonist), slot_l_hand)
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] cuts a small symbol into [t_his] forehead.</span>", "<span class='notice'>Holding the blade up to your face, you close your eyes and slowly carve the symbol of Slaanesh into your forehead. Although you have never seen it before, it feels as if it has always been there. The pain is intense but it is the most natural thing you have ever known.</span>", "<span class='warning>Your hair stands on end.</span>")
				var/mob/living/carbon/human/H = our_protagonist
				H.mutate("mark of slaanesh")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Get out your blade and hold it in your hand. It's time to declare allegiance. True power awaits.</span>")
		if(-14) //Should this maybe check that they are in the right loc? I don't /really/ know quite how this is working...
			our_protagonist.say("I have travelled north. I have found the ship. Slaanesh, show me the way inside.")
/*			var/datum/shuttle_manager/s = shuttles["ladder"]
			if(istype(s)) 
				s.move_shuttle(0,1)*/
			alignment--
		if(-15)
//			our_protagonist.loud = 1
			our_protagonist.say("Things will get loud now!")
			var/mob/living/carbon/human/H = our_protagonist
			H.mutate("tentacle mutation")
			alignment--
			our_protagonist.maxHealth = 250
			our_protagonist.health = 250
			our_protagonist.status_flags = CANPARALYSE|CANPUSH
			to_chat(our_protagonist, "<span class='warning'> You feel stronger.</span>")
		if(-16)
			to_chat(our_protagonist,"<span class='slaanesh'>So... Disciple... I have heard certain whispers of an escaped eldar in your location. This one managed to escape the care of the darker variant of its kind... I would be so pleased if you could capture this one. Crush their spirit stone and keep them in exquisite agony...</span>")
			alignment--
//			U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/celeb/push(null)
		if(-17)
			to_chat(our_protagonist, "<span class='slaanesh'>You have done well thus far. Now is the time for you to assume your final form. I grant you the greatest blessing you will ever know. Find a private place and join the eternal party as an ascended champion!</span>")
//			U.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/celeb/ascention(null)