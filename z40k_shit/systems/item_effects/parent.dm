//Works like curses, makes research more interesting. Random items (scattered on the snow?) that are actually regular objects with unique effects built in.
//This may look suspiciously like curses code... The only reason I didn't outright inherit is because that is a misleading path name.
//But hey, it isn't as if I am copying code for this since I wrote curse effects too.
//What would be cool is if there was a machine that reverse engineered item effects and infused other objects with effects you find.
//Some items should look like normal items, some should be ornate looking weapons that are probably daemonic, and some should look like bizarre alien gizmos.
//NOTE: This is only a first draft of the system. I intend to make a lot more effects. And maybe let other people submit stuff for effects for consideration, since a single effect is quite easy to code.
//-DrakeMarshall

var/list/ITEM_PATHS = list(/datum/item_effect/undroppable,/datum/item_effect/ignite,/datum/item_effect/horseman,/datum/item_effect/blind,/datum/item_effect/heal,/datum/item_effect/harm,/datum/item_effect/stone,/datum/item_effect/tele,/datum/item_effect/wormhole,/datum/item_effect/eating,/datum/item_effect/shield,/datum/item_effect/ominous,/datum/item_effect/fake,/datum/item_effect/hulk,/datum/item_effect/tk,/datum/item_effect/radiate,/datum/item_effect/raise,/datum/item_effect/shieldwall)

/datum/item_effect
	var/name = "generic effect"   //Name
	var/desc = "doesn't exist"    //Help text
	var/charge = 0                //How much energy the item uses, in spells determines charge time, in objects determines charge time for infusing the object with a effect.
	var/max_uses = 25             //How many times the effect will activate until it wears off. Set to -1 or 0 for infinite.
	var/uses = 0
	var/trigger = "NOTHING"
	var/list/compatible_mobs = list(/mob/living)

/datum/item_effect/proc/item_init(var/obj/item/O)    //What the effect does to an object upon laying the curse on it.
	O.item_effects.Add(src)

/datum/item_effect/proc/item_act(var/mob/living/M) //What the effect does to a human upon laying the curse on the human or activating it from an object.
	M.item_effects.Add(src)

/datum/item_effect/proc/neutralize_obj(var/obj/item/O)
	O.item_effects.Remove(src)

/datum/item_effect/proc/neutralize_mob(var/mob/living/M)
	M.item_effects.Remove(src)

/datum/item_effect/New()
	uses = max_uses

/obj/item
	var/list/item_effects = list()

/mob
	var/list/item_effects = list()

/obj/item/attack_hand(mob/user)
	if(item_effects)
		for(var/datum/item_effect/C in item_effects)
			if(C.trigger == "ATTACK_HAND")
				if(!(C in user.item_effects))
					C.item_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
	..()

/obj/item/attack_self(mob/user)
	if(item_effects)
		for(var/datum/item_effect/C in item_effects)
			if(C.trigger == "ATTACK_SELF")
				if(!(C in user.item_effects))
					C.item_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
	..()

/obj/item/equipped(mob/user)
	if(item_effects)
		for(var/datum/item_effect/C in item_effects)
			if(C.trigger == "EQUIP")
				if(!(C in user.item_effects))
					C.item_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
	..()

/obj/item/on_found(mob/user)
	if(item_effects)
		for(var/datum/item_effect/C in item_effects)
			if(C.trigger == "FOUND")
				if(!(C in user.item_effects))
					C.item_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
	..()

/obj/item/attack(mob/living/M, mob/user)
	if(item_effects)
		for(var/datum/item_effect/C in item_effects)
			if(C.trigger == "ATTACK")
				if(!(C in user.item_effects))
					C.item_act(user)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
			if(C.trigger == "ATTACK_OTHER")
				if(!(C in M.item_effects))
					C.item_act(M)
					if(C.max_uses > 0)
						C.uses -= 1
						if(C.uses == 0)
							item_effects.Remove(C)
	..()

//here some of the curse effects since they can technically be items.

/datum/item_effect/undroppable
	name = "Undroppable Item"
	desc = "Curses the item so that any victim who tries to pick it up will not be able to drop it, as it will be stuck to them."
	charge = 200
	compatible_mobs = list()

/datum/item_effect/undroppable/item_init(var/obj/O)
		O.flags |= NODROP
		..()

/datum/item_effect/undroppable/neutralize_obj(var/obj/O)
		O.flags &= ~NODROP
		..()

/datum/item_effect/ignite
	name = "Fire Curse"
	desc = "A curse that sets people on fire."
	charge = 100

/datum/item_effect/ignite/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> You burst into flames!</span>")
	M.fire_stacks += 5
	M.IgniteMob()

/datum/item_effect/horseman
	name = "The Curse of the Horseman"
	desc = "NEEIGH"
	charge = 250
	compatible_mobs = list(/mob/living/carbon/human)

/datum/item_effect/horseman/item_act(var/mob/living/carbon/human/M)
	to_chat(M, "<span class='warning'>HOR-SIE HAS RISEN</span>")
	var/obj/item/clothing/mask/horsehead/magichead = new /obj/item/clothing/mask/horsehead
	magichead.flags |= NODROP		//curses!
	magichead.flags_inv = null	//so you can still see their face
	magichead.voicechange = 1	//NEEEEIIGHH
	if(!M.unEquip(M.wear_mask))
		qdel(M.wear_mask)
	M.equip_to_slot_if_possible(magichead, slot_wear_mask, 1, 1)
	..() //Call ..() only when the effect has a neutralize proc and should not be able to act twice on one person.

/datum/item_effect/horseman/neutralize_mob(var/mob/living/carbon/human/M) //This one needs a neutralize because it is a permanent effect otherwise. Ignite will probably be neutralized in more mundane ways anyway.
	if(!M.unEquip(M.wear_mask))
		qdel(M.wear_mask)
	to_chat(M, "<span class='warning'> You hear the sound of a thousand neighs fading from your head...</span>")
	..()

/datum/item_effect/stone
	name = "Petrification Curse"
	desc = "A curse that turns people to stone, though only breifly."
	charge = 400

/datum/item_effect/stone/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You suddenly feel very solid!</span>")
	var/obj/structure/closet/statue/S = new /obj/structure/closet/statue(M.loc, M)
	S.timer = 20
	M.drop_item()

/datum/item_effect/blind
	name = "Blindness Effect"
	desc = "A curse that robs a victim of their sight, for a time."
	charge = 200

/datum/item_effect/stone/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You go blind!</span>")
	M.eye_blind = 10

/datum/item_effect/heal
	name = "Healing Effect"
	desc = "An effect that heals."
	charge = 200

/datum/item_effect/heal/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You feel much better.</span>")
	M.adjustOxyLoss(-25)
	M.heal_organ_damage(25,0)
	M.heal_organ_damage(0,25)
	M.adjustToxLoss(-25)

/datum/item_effect/harm
	name = "Harming Effect"
	desc = "An effect that harms."
	charge = 200

/datum/item_effect/harm/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'>You feel an intense pain throughout all of your body!</span>")
	M.adjustOxyLoss(10)
	M.take_organ_damage(10,0)
	M.take_organ_damage(0,10)
	M.adjustToxLoss(10)

/datum/item_effect/tele
	name = "Teleportation Effect"
	desc = "An effect that teleports."
	charge = 200

/datum/item_effect/tele/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You suddenly appear somewhere else!</span>")
	do_teleport(M, get_turf(M), 20, asoundin = 'sound/effects/phasein.ogg')

/datum/item_effect/wormhole
	name = "Wormhole Effect"
	desc = "Produces a wormhole to a random teleportation beacon."

/datum/item_effect/wormhole/item_act(var/mob/living/M)
	var/list/L = list()
	for(var/obj/item/device/radio/beacon/B in world)
		L += B
	if(!L.len)
		return
	var/chosen_beacon = pick(L)
	var/obj/effect/portal/wormhole/jaunt_tunnel/J = new /obj/effect/portal/wormhole/jaunt_tunnel(get_turf(M), chosen_beacon, lifespan=100)
	J.target = chosen_beacon
	try_move_adjacent(J)
	playsound(src,'sound/effects/sparks4.ogg',50,1)

/datum/item_effect/fake
	name = "Fake Effect"
	desc = "Makes a gullible person die."
/datum/item_effect/fake/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> You feel invincible!</span>")

/datum/item_effect/ominous
	name = "Ominous Effect"
	desc = "Makes a superstitious person spooked."
/datum/item_effect/ominous/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> A scream enters your mind and fades away!</span>")

/datum/item_effect/shield
	name = "Shield Item"
	desc = "Blesses an item to repell projectiles."
	charge = 200
	compatible_mobs = list()

/datum/item_effect/shield/item_init(var/obj/item/O)
	O.shield_item = 1
	..()
/datum/item_effect/shield/neutralize_obj(var/obj/item/O)
	O.shield_item = 0
	..()

/datum/item_effect/eating
	name = "Feast Effect"
	desc = "Eats you."
	compatible_mobs = list(/mob/living/carbon/human)

/datum/item_effect/eating/item_act(var/mob/living/carbon/human/M)
	to_chat(M, "<span class='warning'>A scream enters your mind and fades away!</span>")
	spawn(50)
		to_chat(M, "<span class='warning'> You are being eaten alive!</span>")
		to_chat(M, "<span class='warning'> You can tell you don't have very long to live...</span>")
		spawn(pick(6000,4800,7200)) //Still 8, 10, or 12 minutes. And if you manage to destroy the item, you *might * survive.
			M.Drain()
			to_chat(M, "<span class='warning'> You have been devoured by the curse!</span>")
			to_chat(M, "<span class='warning'> You feel your spirit coalescing over your corpse...</span>")
			spawn(150)
				for(var/mob/living/L in range(7,M))
					to_chat(L, "<span class='warning'> You hear insane laughter...</span>")
					to_chat(L, "<span class='warning'> You hear a loud burp.</span>")
				var/mob/living/S = new /mob/living/simple_animal/shade(M.loc) //Leaves them as a shade.
				S.name = "Cursed Spirit"
				if(M.mind)
					M.mind.transfer_to(S)
				M.gib()

/datum/item_effect/hulk
	name = "Hulk Effect"
	desc = "Makes you big and strong."

/datum/item_effect/hulk/item_act(var/mob/living/M)
		M.mutations.Add(M_HULK)
		M.update_mutations()

/datum/item_effect/tk
	name = "Telekinesis Effect"
	desc = "Makes you very clever."

/datum/item_effect/tk/item_act(var/mob/living/M)
		M.mutations.Add(M_TK)
		M.update_mutations()

/datum/item_effect/radiate
	name = "Radiation Effect"
	desc = "Makes you get radiation problems."

/datum/item_effect/tk/item_act(var/mob/living/M)
		randmutb(M)
		randmutb(M)
		M.apply_effect(50,IRRADIATE,0)
		M.update_mutations()

/datum/item_effect/mindswap
	name = "Mind Swap Effect"
	desc = "Makes you switch minds with someone else."

/datum/item_effect/mindswap/item_act(var/mob/living/M)
	var/list/targets = list()
	for(var/mob/C in range(9,M)) //Can include ghosts. Because that is basically possession
		targets += C
	if(length(targets))
		var/mob/target = pick(targets)
		var/mob/dead/observer/ghost
		if(istype(target,/mob/living))
			ghost = target.ghostize(0)
		else
			ghost = target
		M.mind.transfer_to(target)
		ghost.mind.transfer_to(M)
		M.key = target.key
		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")

/datum/item_effect/possess
	name = "Possession Effect"
	desc = "Makes you switch minds with someone else, but temporarily."

/datum/item_effect/possess/item_act(var/mob/living/M)
	var/list/targets = list()
	for(var/mob/C in range(9,M))
		targets += C
	if(length(targets))
		var/mob/target = pick(targets)
		var/mob/dead/observer/ghost
		if(istype(target,/mob/living))
			ghost = target.ghostize(0)
		else
			ghost = target
		M.mind.transfer_to(target)
		ghost.mind.transfer_to(M)
		M.key = target.key
		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		spawn(150)
			var/mob/dead/observer/ghost2 = target.ghostize(0)
			M.mind.transfer_to(target)
			ghost2.mind.transfer_to(M)
			M.key = target.key

/datum/item_effect/raise
	name = "Summon Spectre Effect"
	desc = "Makes you call the dead."

/datum/item_effect/raise/item_act(var/mob/living/M)
	for(var/mob/dead/G in world)
		if(G.mind && G.key)
			G.loc = get_turf(M)
			var/mob/living/S = new /mob/living/simple_animal/shade(M.loc)
			S.name = "Spectre"
			S.real_name = "Spectre"
			G.mind.transfer_to(S)
			S.key = G.key

/datum/item_effect/shieldwall
	name = "Shield Wall Effect"
	desc = "Generates a wall of shields around the target."
	var/duration = 1200
	New()
		..()
		duration = pick(50,100,300,600,1200,3000)
/datum/item_effect/shieldwall/item_act(var/mob/living/M)
	for(var/turf/simulated/floor/T in orange(4,M))
		if(get_dist(M,T) == 4)
			var/obj/effect/forcefield/field = new /obj/effect/forcefield(T)
			spawn(duration)
				qdel(field)

/obj/item/
	var/shield_item = 0 //Quick way to make items block projectiles.

/obj/item/IsShield()
	return (shield_item)

/obj/item/IsReflect()
	return (shield_item)

/datum/item_power
	var/name = ""
	var/desc = ""

/datum/item_power/proc/init(var/obj/O)
	return

/datum/item_power/proc/init_mob(var/mob/living/carbon/H)
	return //If it modifies the person.

/datum/item_power/phase
	name = "Planar Shift"
	desc = "Throws you through the warp a few tiles forward."

/datum/item_power/phase/init(var/obj/O)
	O.verbs.Add(/datum/item_power/phase/proc/verb_act)
	return

/datum/item_power/phase/proc/verb_act()
	set category = "item"
	set name = "Planar Shift"
	set src in usr
	var/mob/living/carbon/human/U = usr
	var/turf/destination = get_teleport_loc(U.loc,U,4,1,3,1,0,1) //A bit like phase jaunt but not as far.
	var/turf/mobloc = get_turf(U.loc)//To make sure that certain things work properly below.
	if(destination&&istype(mobloc, /turf))//The turf check prevents unusual behavior. Like teleporting out of cryo pods, cloners, mechs, etc.
		usr << "You feel the [src.name] drag you through the warp!"
		spawn(0)
			anim(mobloc,src,'icons/mob/mob.dmi',,"dust_h",,U.dir)
		U.loc = destination
		spawn(0)
			anim(U.loc,U,'icons/mob/mob.dmi',,"shadow",,U.dir)
	else
		to_chat(M, "<span class='warning'> You are unable to do this at the time, <B>planar shift failed</B>.</span>")

/datum/item_power/hulk
	name = "Hulk Mutation"
	desc = "Makes you a hulk."

/datum/item_power/hulk/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(M_HULK)
	H.update_mutations()

/datum/item_power/tele
	name = "Tele Mutation"
	desc = "Makes you a TK."

/datum/item_power/tele/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(M_TK)
	H.update_mutations()

/datum/item_power/dodge
	name = "Unnatural Agility"
	desc = "Uses the psychic powers of divination to dodge all projectiles."
	var/charge = 10

/datum/item_power/dodge/init(var/obj/O)
	O.verbs.Add(/datum/item_power/dodge/proc/verb_act,/datum/item_power/dodge/proc/chargeup)
	return

/datum/item_power/dodge/proc/verb_act()
	set category = "item"
	set name = "Unnatural Agility"
	set src in usr

	var/mob/living/carbon/human/U = usr
	if(charge > 10)
		charge -= 10
		to_chat(U, "<span class='warning'> Glimpses of the future flood your mind as the powers of the warp expand your mind...</span>")
		U.dodging = 1
		spawn(150) U.dodging = 0
	else
		to_chat(U, "<span class='warning'> Not eneough energy!</span>")

/datum/item_power/dodge/proc/chargeup() //Dealing with chaos comes at a price...
	set category = "item"
	set name = "Charge Agility"
	set desc = "Pay the price in blood for more power..."
	set src in usr

	var/mob/living/carbon/human/U = usr
	if(charge < 20)
		charge += 5
		U.adjustBruteLoss(pick(5,10,15))
		to_chat(U, "<span class='warning'> Your blood flows out and the daemon hungrily consumes your life force as a price for more power.")

/datum/item_power/shield
	name = "Warded Effect"
	desc = "Harnesses unholy powers to deflect projectiles off of this object."

/datum/item_power/shield/init(var/obj/item/O)
	O.shield_item = 1

/datum/passive_effect
	var/name = ""
	var/desc = ""

/datum/passive_effect/proc/runmob(var/mob/living/carbon/M)
	return

/datum/passive_effect/unstunabble
	name = "Stun Recovery"
	desc = "Protects you from being stunned."

/datum/passive_effect/unstunnable/runmob(var/mob/living/carbon/M)
	M.drowsyness = 0
	M.sleeping = 0
	M.AdjustParalysis(-5)
	M.AdjustStunned(-5)
	M.AdjustWeakened(-5)

/datum/passive_effect/regen
	name = "Regeneration"
	desc = "Heals you rather quickly."

/datum/passive_effect/regen/runmob(var/mob/living/carbon/M)
	if(M.getOxyLoss()) 
		M.adjustOxyLoss(-1)
	if(M.getBruteLoss())
		 M.heal_organ_damage(1,0)
	if(M.getFireLoss()) 
		M.heal_organ_damage(0,1)
	if(M.getToxLoss()) 
		M.adjustToxLoss(-1)

/datum/passive_effect/immunity
	name = "Immunity"
	desc = "Immunity to toxins and diseases."

/datum/passive_effect/immunity/runmob(var/mob/living/carbon/M)
	M.reagents.remove_all_type(/datum/reagent/toxin, 2, 0, 1) //Good luck poisoning this one.
	if(M.getToxLoss()) 
		M.adjustToxLoss(-2)
	for(var/datum/disease/D in M.viruses)
		D.spread = "Remissive"
		D.stage--
		if(D.stage < 1)
			D.cure()

/datum/passive_effect/speed
	name = "Simulant"
	desc = "Makes you move faster."

/datum/passive_effect/speed/runmob(var/mob/living/carbon/M)
	M.status_flags |= GOTTAGOFAST

/datum/passive_effect/night
	name = "Destruction of Evil"
	desc = "Makes you destroy evil."

/datum/passive_effect/night/runmob(var/mob/living/carbon/M)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(!H.berserk && H.reagents.has_reagent("berserk"))
			H.berserk = 1
	M.reagents.add_reagent("berserk", 1)
	if(prob(25)) //Should make them dodge often, but not always reliably.
		M.reagents.add_reagent("atium", 1)
	if(prob(15))
		to_chat(M, "<span class='warning'> <b><i>Destroy evil.</b></i></span>")
	if(prob(60))
		var/obj/effect/effect/harmless_smoke/smoke = new /obj/effect/effect/harmless_smoke(get_turf(M))
		smoke.icon_state = "warpshadow" //Should make the smoke dark.
		smoke.alpha = 170 //Make it a little less opaque.
	M.take_overall_damage(3, 3)
	M.drowsyness = 0 //Probably not very helpful because it stops doing this once dropped, but hey.
	M.sleeping = 0
	M.AdjustParalysis(-5)
	M.AdjustStunned(-5)
	M.AdjustWeakened(-5)

/mob/living/simple_animal/shade/
	var/obj/item/item = null
	var/item_charge = 25

/mob/living/simple_animal/shade/proc/get_bearer()
	for(var/datum/item_effect/captured_soul/E in src.item.item_effects)
		if(E.spirit == src)
			return E.target
	for(var/datum/item_effect/daemon_effect/E in src.item.item_effects)
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
		M.AdjustWeakened(-5)
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

/datum/item_effect/daemon_effect
	name = "Daemon Effect"
	desc = "Literally the essence of a daemon. Handle with caution, it will probably try to utterly destroy you."
	charge = 0
	max_uses = -1
	uses = 1
	trigger = "EQUIP"
	compatible_mobs = list(/mob/living/carbon)
	var/datum/item_power/item_power
	var/datum/passive_effect/passive_effect
	var/mob/living/carbon/target
	var/mob/living/simple_animal/shade/spirit
	var/obj/item/myitem
	var/chaosgod

/datum/item_effect/daemon_effect/item_act(var/mob/living/M)
	if(target != M)
		item_power.init_mob(M)
		src.target = M
		to_chat(target, "<font color=\"purple\"> <i><b>Hello. You are in fact now bound to my will. Serve [chaosgod].</i></b></font>")

/datum/item_effect/daemon_effect/item_init(var/obj/item/O)
	..()
	myitem = O
	if(!chaosgod)  //Make these things randomize
		chaosgod = pick("nurgle","tzeench","khorne","slaanesh")
	if(!item_power)
		var/path = pick(/datum/item_power/phase,/datum/item_power/hulk,/datum/item_power/dodge,/datum/item_power/tele)
		item_power = new path
	if(!passive_effect)
		var/path = pick(/datum/passive_effect/unstunnable,/datum/passive_effect/regen,/datum/passive_effect/immunity,/datum/passive_effect/speed)
		passive_effect = new path
	item_power.init(O)
	spirit = new /mob/living/simple_animal/shade(O.loc)
	spirit.loc = O //put shade in object
	spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
	spirit.canmove = 0//Can't move out of the object
	spirit.item = O
	var/shadename
	switch(chaosgod)
		if("nurgle")
			shadename = "plague bearer"
		if("khorne")
			shadename = "bloodletter"
		if("tzeench")
			shadename = "horror of tzeench"
		if("slaanesh")
			shadename = "daemonette"
	spirit.name = shadename
	spirit.real_name = shadename
	spirit.key = null //Need to find a ghost.
	var/list/candidates = get_candidates(BE_TRAITOR)
	if(candidates.len)
		var/client/C = pick_n_take(candidates)
		spirit.key = C.key
	spirit.verbs.Add(/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer,/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer)
	//Shade should have the power to use the weapon as if clicking for the player. Technically you could hold a daemon weapon in your off hand and a regular one in your main one and both would fire simulatenously if the daemon handled one.
	//Note that this also means the daemon can make the weapon attack itself.
	//Daemon also may heal/destun target player, telepath with them, and harm them.
	spawn()
		src.passive()

/datum/item_effect/daemon_effect/proc/passive()
	set background = BACKGROUND_ENABLED
	while(1)
		sleep(20)
		if(target)
			passive_effect.runmob(src.target)
			if(prob(5)) //Some background automated messaging in case we didn't find a shade or just to improve the general roleplay of these.
				var/message = ""
				switch(pick(1,2,3,4,5,6,7))
					if(1)
						message = "Praise [chaosgod]."
					if(2)
						message = "Kill..."
					if(3)
						message = "Send more souls to [chaosgod]."
					if(4)
						switch(chaosgod)
							if("khorne")
								message = "BLOOD FOR THE BLOOD GOD! SKULLS FOR THE SKULL THRONE!"
							if("slaanesh")
								message = "SHOW THE UNBELIEVERS PAIN"
							if("tzeench")
								message = "Tzeench grants you sight."
							if("nurgle")
								message = "Nurgle loves us..."
					if(5)
						switch(chaosgod)
							if("khorne")
								message = "KILL! MAIM! BURN!"
							if("slaanesh")
								message = "Slaanesh thirsts for their souls..."
							if("tzeench")
								message = "You are part of Tzeench's plan."
							if("nurgle")
								message = "Spread nurgle's blessings!"
					if(6)
						message = "This world must burn..."
					if(7)
						message = "Destroy those who do not know [chaosgod]."
				to_chat(target, "<font color=\"purple\"> <i><b>[message]</i></b></font>")
				to_chat(spirit, "The item projects '[message]' to [target.name].")
			if(prob(10))
				for(var/mob/living/carbon/person in viewers(get_turf(myitem)))
					if(person!=target)
						if(person.mind.special_role != "Cultist" & person.mind.special_role != "Changeling") //Don't want to attack one of your own kind...
							to_chat(target, "<font color=\"purple\"> <i><b>Kill [person.name].</i></b></font>")
							to_chat(spirit, "The item projects 'Kill [person.name].' to [target.name].")

/datum/item_effect/daemon_effect/night //I have no idea why I decided to write this. It is inadvisable to put it anywhere, put it was a fun concept.
	name = "Nightblood" //And you think YOUR inquisitors are scary...
	desc = "Hello. Would you like to destroy some evil today?"
	
/datum/item_effect/daemon_effect/night/item_act(var/mob/living/M)
	if(!M) 
		return
	if(target != M)
		if(prob(70))
			src.target = M
			M << "<i><b>Hello. Would you like to destroy some evil today?</i></b>"
		else
			M << "<i><b>You feel incredibly sick.</i></b>"
			M.Weaken(3)
			M.adjustToxLoss(-3)
			var/turf/T = get_turf(M)
			T.add_vomit_floor(M)
			playsound(M, 'sound/effects/splat.ogg', 50, 1)
	
/datum/item_effect/daemon_effect/night/item_init(var/obj/item/O)
	O.item_effects.Add(src)
	chaosgod = "Endowement"
	myitem = O
	passive_effect = new /datum/passive_effect/night
	spirit = new /mob/living/simple_animal/shade(O.loc)
	spirit.loc = O //put shade in object
	spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
	spirit.canmove = 0//Can't move out of the object
	spirit.item = O
	spirit.key = null //Need to find a ghost.
	spirit.name = "nightblood"
	spirit.real_name = "nightblood"
	spirit.speak_emote = list("telepathically intones")
	spawn(20)
		to_chat(spirit, "<b>You are nightblood. Your very essence and existence centers around the command \"Destroy Evil\", which you must follow at all costs. What exactly than is evil? Hell if I know. You are a sword, not a philosopher.</b>")
	var/list/candidates = get_candidates(BE_TRAITOR)
	if(candidates.len)
		var/client/C = pick_n_take(candidates)
		spirit.key = C.key
	spirit.verbs.Add(/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer,/mob/living/simple_animal/shade/proc/telepathic_shout,/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer)
	spawn()
		src.passive()

/datum/item_effect/daemon_effect/night/passive()
	set background = BACKGROUND_ENABLED
	while(1)
		sleep(20)
		if(target)
			passive_effect.runmob(src.target)

/obj/item/xenoitem
	name = "Generic item (ERROR)"
	desc = "A small device that carries out the critically important task of never existing. Report this bug/heresy to Drake Marshall, Norc, or on the forums."
	icon = 'icons/obj/items.dmi'
	icon_state = "dev110"
	var/base_icon = "dev11"
	var/on = 0
	var/trigger

/obj/item/xenoitem/proc/update_icons()
	icon_state = "[base_icon][on]"

/obj/item/xenoitem/New()
	..()
	var/art_effect = pick(item_PATHS)
	var/datum/item_effect/E = new art_effect
	E.item_init(src)
	var/item_trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
	src.trigger = item_trigger
	E.trigger = item_trigger
	force = pick(0,0,0,0,5,5,5,5,10,10,15,20)

/obj/item/xenoitem/attack_hand(mob/user)
	if(trigger == "ATTACK_HAND")
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/attack_self(mob/user)
	if(trigger == "ATTACK_SELF")
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/equipped(mob/user)
	if(trigger == "EQUIP")
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/on_found(mob/user)
	if(trigger == "FOUND")
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/attack(mob/living/M, mob/user)
	if(trigger == "ATTACK" | trigger == "ATTACK_OTHER")
		on = 1
		update_icons()
	..()

/proc/generate_item(template,spawnloc)
	var/obj/item/A
	switch(template)
		if("generic") //A regular item imbued with an item effect. Basically just technological curiousities or the castoff of ancient psykers.
			var/item_path = pick(/obj/item/weapon/crowbar,/obj/item/weapon/weldingtool,/obj/item/weapon/wrench,/obj/item/weapon/screwdriver,/obj/item/weapon/wirecutters,/obj/item/weapon/weldingtool,/obj/item/device/soulstone,/obj/item/candle,/obj/item/xenos_claw)
			A = new item_path(spawnloc)
			var/effect_path = pick(item_PATHS)
			var/datum/item_effect/E = new effect_path
			E.trigger = pick("ATTACK_SELF","ATTACK_SELF","EQUIP","EQUIP","FOUND","ATTACK","ATTACK_OTHER","ATTACK_OTHER")
			E.item_init(A)
			return A
		if("daemon")  //An ornate weapon that corrupts the user and grants some varying powers. After the user dies, chooses a new user, so quite dangerous.
			A = new /obj/item/weapon/daemon(spawnloc)
			return A
		if("eldar")   //Eldar enchanted wierd thing.
			var/obj/item/xenoitem/XA = new /obj/item/xenoitem(spawnloc)
			XA.base_icon = pick("dev21","dev22","dev23","dev24")
			XA.update_icons()
			A = XA
			A.name = pick("relic","gizmo","object","item","gadget")
			A.name = "[pick("arcane","strange","runed", "glowing", "eldar", "alien", "bizarre", "ornate", "battered")] [A.name]"
			A.desc = pick("A completely bizarre device. ","Some kind of wierd item. ","A large device that pulsates with arcane energies. ","An object that is obviously not made by humans. ","A device that utilizes xeno technology. ")
			A.desc += pick("It hums with internal energy","It has a faint white glow.","It has an eldar sigil on it.","It has a small red stone pressed into it.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.")
			return A
		if("darkage") //Sophisticated tech that is basically like a necron item. However, the naming and sprites are different, and the lore of these is that they are from the dark age of technology. Includes powerful stuff like a very potent white esword, energy pistol, et cetera.
			return A    //I haven't put this in yet.

/proc/daemonize(var/obj/item/O,var/chaosgod = null) //Places the essence of a daemon in an object.
	var/datum/item_effect/daemon_effect/daemon = new /datum/item_effect/daemon_effect
	if(chaosgod)
		daemon.chaosgod = chaosgod
	daemon.item_init(O)

/obj/item/weapon/daemon
	name = "daemon weapon (ERROR)"
	desc = "A blade that carries a daemon's essence. Trouble is, it shouldn't really exist (at least not unaltered). Please report this to Drake, Norc, or the forums."
	icon = 'icons/obj/items.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/daemon/New()
	..()
	var/chaosgod = pick("khorne","tzeench","nurgle","slaanesh")
	daemonize(src,chaosgod)
	force = pick(30,35,40,40,40,45,45,50,55,60,65,70)
	switch(chaosgod)
		if("khorne")
			icon_state = pick("daemon1","daemon2","daemon3","daemon7","daemon8")
		if("tzeench")
			icon_state = pick("daemon2","daemon3","daemon5")
		if("nurgle")
			icon_state = pick("daemon2","daemon3","daemon4","daemon9")
		if("slaanesh")
			icon_state = pick("daemon2","daemon3","daemon6")
	name = pick("blade","razor","sword")
	name = "[pick("ornate","runed","ancient","gilded","gem-encrusted","blood-stained","warp","tainted","arcane", "rusted")] [name]"
	desc = pick("An ornate weapon.","An ancient blade.","A strange weapon.","A gem-encrusted blade.")
	desc += " "
	desc += pick("It is covered in unholy runes.","It has a faint red glow.","You feel like it is watching you.","It has strange markings on it.","It has a strange aura.","You feel an inexplicable urge to touch it...","You feel oddly attached to it...")

/obj/item/weapon/daemon/IsShield()
	return prob(50)

/obj/item/weapon/daemon/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

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
	return(BRUTELOSS)

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
	var/datum/item_effect/daemon_effect/night/spirit = new /datum/item_effect/daemon_effect/night
	spirit.item_init(src)

/obj/item/weapon/night/IsShield()
	return prob(90)

/obj/item/weapon/night/dropped(mob/user)
	..()
	for(var/datum/item_effect/daemon_effect/night/spirit in src.item_effects) //Unbonds with them when dropped.
		spirit.target = null
	if(iscarbon(user)) //Some backlash when dropped.
		var/mob/living/carbon/M = user
		M.Weaken(5)
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
	can_hold = list(/obj/item/weapon/night)
	max_w_class = 4
	max_combined_w_class = 4
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

/obj/item/clothing/mask/gas/item
	name = "Crimson Mask"
	desc = "The eerie countenance glows with a reddish light, humming with power..."
	icon_state = "item"
	item_state = "item"
	var/weartime = 0
	var/worn = 0

/obj/item/clothing/mask/gas/item/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/mask/gas/item/process()
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

/obj/item/clothing/mask/gas/item/dropped()
	..()
	spawn(5)
		if(worn)
			worn = 0
			if(ishuman(src.loc))
				var/mob/living/carbon/human/H = src.loc
				H.visible_message("<span class='warning'> <b>[H] takes off the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You collapse!</span>")
				H.Paralyse(weartime/5)
				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
					H.mind.spell_list.Remove(D)
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.dodging = 0

/obj/item/clothing/mask/gas/item/equipped()
	..()
	spawn(5) //Make sure we check this /after/ the mask's location is changed.
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(worn)
				worn = 0
				H.visible_message("<span class='warning'> <b>[H] takes off the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You collapse!</span>")
				H.Paralyse(weartime/5)
				for(var/obj/effect/proc_holder/spell/targeted/devestate/D in H.mind.spell_list)
					H.mind.spell_list.Remove(D)
			if(H.wear_mask == src)
				worn = 1
				H.visible_message("<span class='warning'> <b>[H] puts on the [src]!</b></span>")
				to_chat(H, "<span class='warning'> You feel a rush of power!</span>")
				H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/devestate(null) //Basically a much more gory version of disintegrate.

