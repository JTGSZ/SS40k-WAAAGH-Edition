/mob/living/simple_animal/shade/
	var/obj/item/item = null
	var/item_charge = 25

/mob/living/simple_animal/shade/proc/get_bearer()
	for(var/datum/item_artifact/captured_soul/E in src.item.item_artifacts)
		if(E.spirit == src)
			return E.target
	for(var/datum/item_artifact/daemon_effect/E in src.item.item_artifacts)
		if(E.spirit == src)
			return E.target
	return null

/mob/living/simple_animal/shade/proc/healbearer() //Added as verbs on initialization in item.
	set category = "item"
	set name = "Heal Bearer"

	if(item_charge > 0)
		var/mob/living/carbon/M = get_bearer()
		if(!M) return
		M.drowsyness = 0
		M.sleeping = 0
		M.AdjustParalysis(-5)
		M.AdjustStunned(-5)
		M.adjustToxLoss(-10)
		M.adjustBruteLoss(-10)
		M.adjustFireLoss(-10)
		M.adjustOxyLoss(-10)
		to_chat(M, "<span class='warning'> You feel a surge of vitality!</span>")
		to_chat(usr, "<span class='warning'> You lend [M] some of your strength</span>")
		item_charge -= 1
	else
		to_chat(usr, "<span class='warning'> Not enough energy!</span>")

/mob/living/simple_animal/shade/proc/harmbearer()
	set category = "item"
	set name = "Drain Target"
	
	var/mob/living/carbon/M = get_bearer()
	if(!M) 
		return
	if(istype(src.item, /obj/item/weapon/slaanesh_blade))
		var/obj/item/weapon/slaanesh_blade/weapon = src.item
		if(weapon.energy)
			to_chat(usr, "<span class='warning'> You struggle against the sorcery that keeps you from acting against the will of your master!</span>")
			to_chat(M, "<span class='warning'> [src] struggles against the sorcery of the [src.item] that forces them to your will!</span>")
			weapon.energy -= 1
			if(weapon.energy == 0)
				to_chat(usr, "<span class='warning'> You break the bonds of sorcery that constrain your actions!</span>")
				to_chat(M, "<span class='warning'> [src] breaks the bonds of sorcery that forces them to your will!</span>")
			return
	M.adjustToxLoss(10)
	M.adjustBruteLoss(10)
	M.adjustFireLoss(10)
	M.adjustOxyLoss(10)
	to_chat(M, "<span class='warning'> You feel horribly weak!</span>")
	to_chat(usr, "<span class='warning'> You drain some energy from [M].</span>")
	if(item_charge < 25)
		item_charge += 1

/mob/living/simple_animal/shade/proc/showbearer()
	set category = "item"
	set name = "Read Target Memory"
	var/mob/living/carbon/M = get_bearer()
	if(M)
		M.mind.show_memory(src, 0)

/mob/living/simple_animal/shade/proc/telepathbearer()
	set category = "item"
	set name = "Telepathy"
	
	var/mob/living/carbon/M = get_bearer()
	if(M)
		var/msg = sanitize(input("Message:", "Daemonic Astropathy") as text|null)
		to_chat(M, "<font color=\"purple\"> <i><b>[msg]</i></b></font>")
		to_chat(usr, "<span class='warning'>You project '[msg]' to [M.name].</span>")

/mob/living/simple_animal/shade/proc/throw_item()
	set category = "item"
	set name = "Throw item"

	var/atom/target = input("Choose what you wish to throw at.","item Throw") as obj|mob in view(get_turf(src.item),7)
	if(target && istype(target))
		if(istype(src.item, /obj/item/weapon/slaanesh_blade))
			var/obj/item/weapon/slaanesh_blade/weapon = src.item
			if(weapon.energy)
				var/mob/living/carbon/M = get_bearer()
				if(istype(target, /mob/living/carbon))
					var/mob/living/carbon/C = target
					if(C.real_name == M.real_name)
						to_chat(usr, "<span class='warning'> You struggle against the sorcery that keeps you from acting against the will of your master!</span>")
						to_chat(M, "<span class='warning'> [src] struggles against the sorcery of the [src.item] that forces them to your will!</span>")
						weapon.energy -= 1
						if(weapon.energy == 0)
							to_chat(usr, "<span class='warning'> You break the bonds of sorcery that constrain your actions!</span>")
							to_chat(M, "<span class='warning'> [src] breaks the bonds of sorcery that forces them to your will!</span>")
						return
				if(get_turf(src) == get_turf(M))
					to_chat(usr, "<span class='warning'> You struggle against the sorcery that keeps you from acting against the will of your master!</span>")
					to_chat(M, "<span class='warning'> [src] struggles against the sorcery of the [src.item] that forces them to your will!</span>")
					weapon.energy -= 1
					if(weapon.energy == 0)
						to_chat(usr, "<span class='warning'> You break the bonds of sorcery that constrain your actions!</span>")
						to_chat(M, "<span class='warning'> [src] breaks the bonds of sorcery that forces them to your will!</span>")
					return
		if(get_turf(src) != src.item.loc)
			if(ishuman(src.item.loc))
				var/mob/living/carbon/human/H = src.item.loc
				H.unEquip(src.item, 0)
			else
				src.item.loc = get_turf(src)
		src.item.throw_at(target, 10, 1)

/mob/living/simple_animal/shade/proc/telepathic_shout() //Why a bunch of tormented souls can really cause problems.
	set category = "item"
	set name = "Telepathic Shout"

	var/mob/living/carbon/target = input("Choose what you wish to throw at.","item Throw") as mob in view(get_turf(src.item),7)
	if(target && istype(target))
		if(istype(src.item, /obj/item/weapon/slaanesh_blade))
			var/obj/item/weapon/slaanesh_blade/weapon = src.item
			if(weapon.energy)
				var/mob/living/carbon/M = get_bearer()
				if(target.real_name == M.real_name)
					to_chat(usr, "<span class='warning'> You struggle against the sorcery that keeps you from harming your master!</span>")
					to_chat(target, "<span class='warning'> [src] struggles against the sorcery of the [src.item] that forces them to your will!</span>")
					weapon.energy -= 1
					if(weapon.energy == 0)
						to_chat(usr, "<span class='warning'> You break the bonds of sorcery that constrain your actions!</span>")
						to_chat(M, "<span class='warning'> [src] breaks the bonds of sorcery that forces them to your will!</span>")
					return
		var/msg = sanitize(input("Message:", "Telepathic Shout") as text|null)
		to_chat(target, "<span class='warning'> You get a splitting headache!</span>")
		to_chat(target, "<font size = '12' color=\"purple\"> <i><b>[msg]</i></b></font>")
		target.Dizzy(5)
		target.confused += 10
		shake_camera(target, 10, 1)
		target.hallucination += 20

/mob/living/simple_animal/shade/proc/energize_weapon() //Why the souls won't instantly be able to kill their bearer necessarily.
	set category = "item"
	set name = "Energize Blade"

	if(istype(src.item, /obj/item/weapon/slaanesh_blade))
		var/obj/item/weapon/slaanesh_blade/weapon = src.item
		weapon.energy ++
		to_chat(usr, "<span class='warning'> You exert your will to make it more difficult for other inhabitant souls of [src.item] to murder your bearer.</span>")