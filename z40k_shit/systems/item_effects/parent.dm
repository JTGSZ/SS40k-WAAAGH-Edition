/*




/obj/item/weapon/hellblade //Mostly for debugging, but hey, if you want you can put this in somewhere. After all, it is a lore-accurate hellblade of khorne.
	name = "hellblade"
	desc = "A hellblade of khorne. Contains the essence of a bloodletter daemon."
	icon = 'icons/obj/items.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/hellblade/New()
	..()
	daemonize(src,"khorne") //Makes it into a daemon weapon, supplies the optional argument to make it a khorne daemon.

/obj/item/weapon/hellblade/IsShield()
	return prob(50)

/obj/item/weapon/hellblade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>")
	to_chat(user, "<span class='warning'> You hear the sound of laughter in your mind as darkness overtakes your consciousness.</span>")
	spawn(100)
		user.visible_message("<span class='suicide'>BLOOD FOR THE BLOOD GOD</span>")
		user.gib()
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/hellblade/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/night
	name = "nightblood"
	desc = "A massive jet black sword. You feel the need to pick it up..."
	icon = 'icons/obj/items.dmi'
	icon_state = "night"
	item_state = "cultbladeold"
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 50
	throwforce = 40
	w_class = 4
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/night/New()
	..()
	var/datum/item_artifact/daemon_effect/night/spirit = new /datum/item_artifact/daemon_effect/night
	spirit.item_init(src)

/obj/item/weapon/night/IsShield()
	return prob(90)

/obj/item/weapon/night/dropped(mob/user)
	..()
	for(var/datum/item_artifact/daemon_effect/night/spirit in src.item_artifacts) //Unbonds with them when dropped.
		spirit.target = null
	if(iscarbon(user)) //Some backlash when dropped.
		var/mob/living/carbon/M = user
		M.apply_effect(3,WEAKEN)
		M.adjustToxLoss(-5)
		M.reagents.clear_reagents()
		var/turf/T = get_turf(M)
		T.add_vomit_floor(M)
		playsound(M, 'sound/effects/splat.ogg', 50, 1)

/obj/item/weapon/night/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/storage/belt/night
	name = "sword sheath"
	desc = "Holds a sword."
	icon_state = "night"
	item_state = "katana"
	can_only_hold = list(/obj/item/weapon/night)
	storage_slots = 2
	max_combined_w_class = 200
	attack_verb = list("beat")
 
/obj/item/weapon/storage/belt/night/New()
	..()
	new /obj/item/weapon/night(src)

/obj/item/clothing/suit/armor/shadowcloak/dropped()
	..()
	usr.alpha = 255

/obj/item/clothing/suit/armor/shadowcloak/equipped()
	..()
	usr.alpha = 255

/obj/item/clothing/mask/gas/artifact
	name = "Crimson Mask"
	desc = "The eerie countenance glows with a reddish light, humming with power..."
	icon_state = "item"
	item_state = "item"
	var/weartime = 0
	var/worn = 0

/obj/item/clothing/mask/gas/artifact/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/mask/gas/artifact/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		if(H.wear_mask == src)
			weartime += 10
			if(weartime >= 100)
				if(prob(75)) 
					to_chat(H, "<span class='warning'> You sense that wearing the mask for much longer would be a bad idea.</span>")
			if(weartime >= 150)
				H.visible_message("<span class='warning'> [H]'s body is consumed in a flash of deep red light!</span>")
				H.dust()
			H.heal_organ_damage(8, 8)
			H.adjustOxyLoss(-12)
			H.adjustToxLoss(-8)
			H.ignore_pain += 5
			H.suppress_pain += 5
			H.adjustStaminaLoss(-10)
			H.AdjustStunned(-10)
			H.AdjustWeakened(-10)
			H.AdjustParalysis(-10)
			H.drowsyness = 0
			H.eye_blurry = 0
			H.reagents_speedmod = min(H.reagents_speedmod, -12)
			H.next_click -= 1
			spawn(4) H.next_click -= 1
			H.dodging = 2
			if(H.handcuffed)
				H.visible_message("<span class='warning'>[H] is trying to break free!</span>", "<span class='warning'>You attempt to break free.</span>")
				qdel(H.handcuffed)
				H.regenerate_icons()
	else
		if(weartime > 0) weartime --

/obj/item/clothing/mask/gas/artifact/dropped()
	..()
	spawn(5)
		if(worn)
			worn = 0
			if(ishuman(src.loc))
				var/mob/living/carbon/human/H = src.loc
				H.visible_message("<span class='warning'> <b>[H] takes off the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You collapse!</span>")
				H.Paralyse(weartime/5)
//				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
//					H.mind.spell_list.Remove(D)
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.dodging = 0

/obj/item/clothing/mask/gas/artifact/equipped()
	..()
	spawn(5) //Make sure we check this /after/ the mask's location is changed.
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(worn)
				worn = 0
				H.visible_message("<span class='warning'> <b>[H] takes off the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You collapse!</span>")
				H.Paralyse(weartime/5)
//				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
//					H.mind.spell_list.Remove(D)
			if(H.wear_mask == src)
				worn = 1
				H.visible_message("<span class='warning'> <b>[H] puts on the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You feel a rush of power!</span>")
//				H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/devestate(null) //Basically a much more gory version of disintegrate.

*/