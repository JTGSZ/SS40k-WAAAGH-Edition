/obj/item/weapon/daemonweapon/blissrazor
	name = "bliss razor" //Temporary name. They will get to rename it.
	desc = "A wickedly curved, jet black blade stained a deep royal purple. This blade hums and pulses with unearthly energies and bears a cetain inexplicable beauty and allure."
	icon_state = "talking_sword"
	item_state = "talking_sword"
	sharpness_flags = SHARP_TIP |SHARP_BLADE
	sharpness = 1.5
	force = 25 //A decent melee weapon, but not exactly spectacular. Gets better when it hosts more souls, et cetera.
	throwforce = 40
	free_recruiter
	daemon_inside = FALSE
	last_ping_time = 0
	ping_cooldown = 5 SECONDS
	var/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/our_daemon
 
/obj/item/weapon/daemonweapon/blissrazor/attack_self(mob/living/user)
	if(daemon_inside)
		return
	awaken()

/obj/item/weapon/daemonweapon/blissrazor/awaken()
	icon_state = "[initial(icon_state)]_a"
	visible_message("<span class='notice'>\The [name] shakes vigorously!</span>")
	if(!free_recruiter)
		free_recruiter = new(src)
		free_recruiter.master = src

	free_recruiter.recruit_bitches()

/obj/item/weapon/daemonweapon/blissrazor/plugin_ourboy(var/client/C)
	if(C)
		daemon_inside = TRUE
		visible_message("<span class='notice'>\The [name] awakens!</span>")
		//We have a 20000 hp special daemonette contained within us. Release it if you want the round to go to hell.
		our_daemon = new(src) 
		our_daemon.real_name = name
		our_daemon.name = name
		our_daemon.ckey = C.ckey
		our_daemon.universal_speak = TRUE
		our_daemon.universal_understand = TRUE
		to_chat(our_daemon, "<span class='info'>You are currently a daemonette trapped in a sword.</span>")
		to_chat(our_daemon, "<span class='info'>Unable to do anything by yourself, you need a wielder. Find someone and satiate your desires.</span>")
		var/input = copytext(sanitize(input(our_daemon, "What should i call myself?","Name") as null|text), TRUE, MAX_MESSAGE_LEN)

		if(src && input)
			name = input
			our_daemon.real_name = input
			our_daemon.name = input
	else
		icon_state = initial(icon_state)
		visible_message("<span class='notice'>\The [name] calms down.</span>")

/obj/item/weapon/daemonweapon/blissrazor/Destroy()
	for(var/mob/living/simple_animal/lol in contents)
		to_chat(lol, "Suddenly, you are released into realspace!")
		lol.loc = src.loc
	qdel(free_recruiter)
	free_recruiter = null
	..()

/obj/item/weapon/daemonweapon/blissrazor/attack_ghost(var/mob/dead/observer/O)
	if(daemon_inside)
		return
	awaken()

/obj/item/weapon/daemonweapon/blissrazor/IsShield()
	return TRUE
