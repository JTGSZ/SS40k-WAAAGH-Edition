/*
Basic groundwork for daemonic NPCs
Eventually they will be used in daemon contracts and such. Right now I can make some agressive NPCs for the hulk.
-Drake
*/

/mob/living/simple_animal/hostile/retaliate/daemon
	name = "spirit"
	real_name = "spirit"
	desc = "A malevolent presence."
	icon = 'icons/mob/mob.dmi'
	icon_state = "void_demon"
	icon_living = "void_demon"
	icon_dead = "daemon_remains"
	layer = 4
	blinded = 0
	anchored = 1	//  don't get pushed around
	density = 0
	invisibility = INVISIBILITY_OBSERVER //This is what makes it a proper spirit.
	maxHealth = 500
	health = 500
	speak_emote = list("hisses")
	emote_hear = list("wails","screeches")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	harm_intent_damage = 5
	melee_damage_lower = 50
	melee_damage_upper = 150
	attacktext = "flogs"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speed = 0
	stop_automated_movement = 1
	status_flags = 0
	environment_smash_flags = 0
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 450 //A good fire would hurt one, but not something small.
	heat_damage_per_tick = 15	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 10	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	unsuitable_atoms_damage = 10

	faction = "void"

/mob/living/simple_animal/hostile/retaliate/daemon/Life()
	..()
	see_invisible = SEE_INVISIBLE_OBSERVER //Daemons can see into the immaterial world, I should think.
	var/turf/T = get_turf(src)
	if(T.flags & NOJAUNT)
		adjustBruteLoss(20)
		if(src.stat != DEAD)
			src.visible_message("<span class='danger'>\the [src] hisses in agony over the holy water!</span>")
	for(var/obj/item/clothing/tie/medal/gold/sealofpurity/S in range(1, T))
		adjustBruteLoss(1)
		if(prob(25))
			if(src.stat != DEAD)
				src.visible_message("<span class='danger'>\the [src] growls at the [S]!</span>")
		if(prob(5))
			if(invisibility != 0)
				if(src.stat != DEAD)
					src.visible_message("<span class='danger'>The holy power of the [S] forces \the [src] to materialize!</span>")
					invisibility = 0
					density = 1
					spawn(25)
						density = 0
						invisibility = INVISIBILITY_OBSERVER

/mob/living/simple_animal/hostile/retaliate/daemon/Move(NewLoc, direct) //Daemons are blocked by psychic walls too.
	var/turf/destination = get_step(get_turf(src),direct)
	for(var/obj/effect/warp/W in range(destination, 0)) //Ghost walls. For no particular reason. -Drake
		if(W.ghost_density)
			return
	..(NewLoc, direct)

/mob/living/simple_animal/hostile/retaliate/daemon/hulk
	name = "neverborn"
	real_name = "neverborn"
	maxHealth = 300
	health = 300

/mob/living/simple_animal/hostile/retaliate/daemon/hulk/Life()
	..()
	if(src.stat == DEAD) return
	for(var/mob/living/M in range(7, src))
		if(M != src && M.stat != DEAD && !("void" in M.factions))
			enemies.Add(M)
			emote("hisses at \the [M]")
			playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
	if(prob(25)) //Becomes visible (and actually damagable) for a moment.
		invisibility = 0
		density = 1
		spawn(25)
			density = 0
			invisibility = INVISIBILITY_OBSERVER

/mob/living/simple_animal/hostile/retaliate/daemon/lesser
	name = "wight"
	real_name = "wight"
	icon = 'icons/mob/chaosspawn.dmi'
	icon_state = "ws"
	icon_living = "ws"
	icon_dead = "ws_dead"
	attacktext = "drains life from"
	maxHealth = 40
	health = 40
	melee_damage_lower = 10
	melee_damage_upper = 20
	density = 1

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/Life()
	..()
	if(src.stat == DEAD) return
	for(var/mob/living/M in range(7, src))
		if(M != src && M.stat != DEAD && !("void" in M.factions))
			enemies.Add(M)
			emote("hisses at \the [M]")
			playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
	if(prob(5)) //Becomes visible for a moment.
		invisibility = 0
		spawn(15)
			invisibility = INVISIBILITY_OBSERVER

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/guard
	name = "Warped Guardsman"
	desc = "A twisted, shadowed, and warp consumed creature that appears to have once been a regular human."
	icon = 'icons/mob/mob.dmi'
	icon_state = "shadow"
	icon_living = "shadow"
	icon_dead = "shadow_dead"
	maxHealth = 120
	health = 120

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/predator
	name = "ebon geist"
	real_name = "ebon geist"
	attacktext = "tears into"
	icon = 'icons/mob/mob.dmi'
	icon_state = "daemon"
	icon_living = "daemon"
	icon_dead = "jaunt"
	maxHealth = 80
	health = 80
	melee_damage_lower = 20
	melee_damage_upper = 30

/mob/living/simple_animal/hostile/retaliate/daemon/bloodletter
	name = "Bloodletter"
	real_name = "Bloodletter"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "bloodletter"
	icon_living = "bloodletter"
	icon_dead = "daemon_remains"
	maxHealth = 650
	health = 650
	harm_intent_damage = 0
	melee_damage_lower = 100
	melee_damage_upper = 150
	speed = 0
	move_to_delay = 2
	alpha = 240
	attacktext = "mauls"

/mob/living/simple_animal/hostile/retaliate/daemon/bloodletter/attack_animal(mob/living/simple_animal/M as mob) //A real daemon that isn't some lesser warp creature is particularly resistant to shades.
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette
	name = "Daemonette"
	real_name = "Daemonette"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemon_remains"
	harm_intent_damage = 0

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror
	name = "Horror of Tzeench"
	real_name = "Horror of Tzeench"
	speed = -1
	move_to_delay = 1
	harm_intent_damage = 0
	speak_chance = 5
	speak_emote = list("giggles", "laughs", "chuckles")
	attacktext = "curses"
	alpha = 150
	var/horror_color = "#FF0088"

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/Life()
	..()
	if(src.stat == DEAD) 
		return
	if(src.horror_color == "FF0088" && src.stance == HOSTILE_STANCE_ATTACK)
		for(var/mob/living/carbon/C in range(src, 1))
			if(C in src.enemies)
				C.fire_stacks += 1
				C.IgniteMob()
	if(prob(25))
		for(var/atom/movable/target in range(5, get_turf(src)))
			src.icon = target.icon
			src.icon_state = target.icon_state
			src.overlays = target.overlays
			src.color = horror_color
			src.GlichAnimation(changecolor = 0)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/blue
	speed = 2
	move_to_delay = 4
	horror_color = "0000FF"
	speak_emote = list("scowls")
	maxHealth = 150
	health = 150
	melee_damage_lower = 20
	melee_damage_upper = 40
	attacktext = "chokes"

/mob/living/simple_animal/hostile/retaliate/daemon/plaguebearer
	name = "Plaguebearer"
	real_name = "Plaguebearer"
	icon = 'icons/mob/daemon.dmi'
	icon_state = "plaguebearer"
	icon_living = "plaguebearer"
	icon_dead = "daemon_remains"
	maxHealth = 850
	health = 850
	speed = 1
	move_to_delay = 5
	melee_damage_lower = 50
	melee_damage_upper = 100

/mob/living/simple_animal/hostile/retaliate/daemon/plaguebearer/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>\The [M]</B> [M.attacktext] [src]!", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)
