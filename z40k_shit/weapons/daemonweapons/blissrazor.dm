/obj/item/weapon/slaanesh_blade
	name = "bliss razor" //Temporary name. They will get to rename it.
	desc = "A wickedly curved, jet black blade stained a deep royal purple. This blade hums and pulses with unearthly energies and bears a cetain inexplicable beauty and allure."
	icon = 'icons/obj/items.dmi'
	icon_state = "slaanesh"
	item_state = "pk_on"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 25 //A decent melee weapon, but not exactly spectacular. Gets better when it hosts more souls, et cetera.
	throwforce = 40 //I don't know why all the weapons in this game have such low throwing force. You are literally throwing a supernaturally enhanced dagger at someone. That should actually injure them.
	w_class = 2 //Dagger. One of the advantages of the slaaneshi weapon.
	attack_verb = list("slashed", "mutilated", "eviscerated", "torn", "ripped", "diced", "mauled", "impaled", "tortured")
	var/energy = 250 //How much force the blade has to bind the captured souls to the bearer's will. This can be renewed, but rebellious souls will constantly eat away at it. Eventually they will have full power to kill their bearer.

/obj/item/weapon/slaanesh_blade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src.name]! It looks like \he's trying to commit suicide.</span>")
	to_chat(user, "<span class='warning'> You hear the sound of laughter in your mind as darkness overtakes your consciousness.</span>")
	user.sleeping += 25 //Just making sure they pass out. By the time the slaaneshi gets the blade, they will probably not die from falling on their sword.
	spawn(100)
		user.visible_message("<span class='suicide'>You hear a hissing sound as a wave of exquisite pain washes over you.</span>") //Spooky slaaneshi shit.
		to_chat(user, "<span class='warning'> Your essence is consumed by [src]!</span>") //If someone willingly sacrifices themselves with the blade, it becomes even more powerful than if you forcibly captured their soul.
		src.force += 20
		src.throwforce += 20
		src.energy = 0 //Not much sorcery demanding a master's allegiance after the master kills themself. Then the blade is just free.
		src.absorb_soul(null, user)
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/slaanesh_blade/attack(target, mob/living/user)
	if(istype(target,/mob/living/carbon))
		var/mob/living/carbon/C = target
		if(C == user)
			user.visible_message("<span class='warning'> [user] slits their wrist with [src]!</span>", \
	"<span class='warning'> You draw your own blood to strengthen the sorcery in [src], bringing the inhabitant spirits under greater control.</span>", \
	"<span class='warning'> You hear a hissing sound.</span>")
			energy += 60
			force += 1.0
			throwforce += 1.0
			user.take_organ_damage(25,0)
			return
		if(C.stat == 2)
			if(C.client)
				to_chat(user, "<span class='warning'> [src] greedily absorbs [C]'s essence!</span>")
				to_chat(user, "<span class='warning'> [src] seems to hum with energy as [C]'s torment is soaked up by the blade!</span>")
			src.absorb_soul(user, C)
			playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
		else
			if(prob(src.item_effects.len*30))
				to_chat(user, "<span class='warning'> [src] overloads [C]'s senses and casts them into a breif coma.</span>")
				C.sleeping += 10
	else if(istype(target,/mob/living/simple_animal)) //Still gibs animals, but gets less power from them.
		var/mob/living/simple_animal/A = target
		if(A.stat == 2)
			to_chat(user, "<span class='warning'> [src] accepts your sacrifice.")
			to_chat(user, "<span class='warning'> [src] seems slightly energized.")
			src.force += 3.0
			src.throwforce += 5.0
			A.gib()
			playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/slaanesh_blade/throw_impact(atom/hit_atom)
	..()
	if(isliving(hit_atom))
		var/mob/living/vict = hit_atom
		vict.visible_message("<span class='warning'> [src] swings in midair as if it had a mind of its own, pointing like a compass needle to [hit_atom]'s heart as its point slashes them!</span>", \
	"<span class='warning'> You feel a stabbing pain in your chest as [src] drives itself towards your heart!</span>", \
	"<span class='warning'> You hear the sound of steel slicing through flesh.</span>")
		if(iscarbon(vict) && vict.stat == 2)
			src.absorb_soul(null, vict)

/obj/item/weapon/slaanesh_blade/proc/absorb_soul(var/mob/living/carbon/user, var/mob/living/carbon/C)
	if(!C.client)
		if(user)
			to_chat(user, "<span class='warning'> This one's soul is not present. Sacrifice failed.</span>")
		return //No absorbing AFK people.
	var/datum/item_effect/captured_soul/soul = new()
	soul.victim = C
	soul.item_init(src)
	soul.item_act(user)
	src.force += 10
	src.throwforce += 10