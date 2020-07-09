/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player
	name = "Daemonette"
	real_name = "Daemonette"
	icon = 'z40k_shit/icons/mob/daemon.dmi'
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemon_remains"
	harm_intent_damage = 0
	maxHealth = 20000
	health = 20000
	melee_damage_lower = 50
	melee_damage_upper = 150

//As odd as it sounds, I'm basically gonna make someone releasing a daemonette from the sword a awful idea.
//Well unless you really want a 20k health daemonette walking around.
/*
	Welcome to a mix of copy pasted shitcode, we can hand the daemonette the hud in the weapon
*/

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/Login()
	..()
	hud_used.shade_hud()
	if (istype(loc, /obj/item/weapon/daemonweapon))
		client.CAN_MOVE_DIAGONALLY = 1
		client.screen += list(
			gui_icons.soulblade_bgLEFT,
			gui_icons.soulblade_coverLEFT,
			gui_icons.soulblade_bloodbar,
			)

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/Life()
	if(timestopped)
		return FALSE //under effects of time magick
	..()
	regular_hud_updates()
	if(isDead())
		for(var/i=0;i<3;i++)
			new /obj/item/weapon/ectoplasm (src.loc)
		visible_message("<span class='warning'> [src] lets out a contented sigh as their form unwinds.</span>")
		ghostize()
		qdel (src)
		return

	if (istype(loc,/obj/item/weapon/melee/soulblade))
		var/obj/item/weapon/melee/soulblade/SB = loc
		if (istype(SB.loc,/obj/structure/cult/altar))
			if (SB.blood < SB.maxblood)
				SB.blood = min(SB.maxblood,SB.blood+5)//faster blood regen when planted on an altar
			if (SB.health < SB.maxHealth)
				SB.health = min(SB.maxHealth,SB.health+5)//and health regen on top
		else if (istype(SB.loc,/mob/living))
			var/mob/living/L = SB.loc
			if (iscultist(L) && SB.blood < SB.maxblood)
				SB.blood++//no cap on blood regen when held by a cultist, no blood regen when held by a non-cultist (but there's a spell to take care of that)
		else if (SB.blood < SB.maxregenblood)
			SB.blood++

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'>\The [M] [M.attacktext] [src]!</span>", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/attempt_suicide(forced = FALSE, suicide_set = TRUE)
	if(!forced)
		var/confirm = alert("Are you sure you want to go to sleep?.", "Confirm Suicide", "Yes", "No")

		if(!confirm == "Yes")
			return

		if(stat != CONSCIOUS)
			to_chat(src, "<span class='warning'>You can't perform the sealing ritual in this state!</span>")
			return

		log_attack("<span class='danger'>[key_name(src)] has sealed itself via the suicide verb.</span>")

	if(suicide_set)
		suiciding = TRUE

	visible_message("<span class='danger'>[src] shudders violently for a moment, then becomes motionless, its aura fading. </span>")
	death()

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/death(var/gibbed = FALSE)
	if(istype(loc, /obj/item/weapon/nullrod/sword/chaos))
		var/obj/item/weapon/nullrod/sword/chaos/C = loc
		C.possessed = FALSE
		C.icon_state = "talking_sword"
	..(gibbed)
