// The chaos blade, a ghost role talking sword. Unlike the nullrod skins this thing works as a proper shield and has sharpness.
/obj/item/weapon/genericdaemonweapon
	name = "chaos blade"
	desc = "Considered a 'cursed blade' legend says that anyone that tries to wield it end corrupted by chaos. It has three yellow eyes, two near the base of the hilt and one at the pommel, and a decorative jewel between its eyes."
	icon_state = "talking_sword"
	item_state = "talking_sword"
	sharpness_flags = SHARP_TIP |SHARP_BLADE
	sharpness = 1.5
	var/datum/recruiter/recruiter = null
	var/possessed = FALSE
	var/awakening = FALSE
	var/last_ping_time = 0
	var/ping_cooldown = 5 SECONDS
 
/obj/item/weapon/genericdaemonweapon/attack_self(mob/living/user)
	if(possessed)
		return

	awaken()


/obj/item/weapon/genericdaemonweapon/proc/awaken()
	if(awakening)
		return
	awakening = TRUE
	icon_state = "[initial(icon_state)]_a"
	visible_message("<span class='notice'>\The [name] shakes vigorously!</span>")
	if(!recruiter)
		recruiter = new(src)
		recruiter.display_name = name
		recruiter.role = ROLE_BORER //Uses the borer pref because preferences are scary and i don't want to touch them.
		recruiter.jobban_roles = list("pAI") // pAI/Borers share the same jobban check so here we go too.

	// Role set to Yes or Always
	recruiter.player_volunteering.Add(src, "recruiter_recruiting")
	// Role set to No or Never
	recruiter.player_not_volunteering.Add(src, "recruiter_not_recruiting")

	recruiter.recruited.Add(src, "recruiter_recruited")

	recruiter.request_player()

/obj/item/weapon/genericdaemonweapon/proc/recruiter_recruiting(var/list/args)
	var/mob/dead/observer/O = args["player"]
	var/controls = args["controls"]
	to_chat(O, "<span class='recruit'>\The [name] is awakening. You have been added to the list of potential ghosts. ([controls])</span>")

/obj/item/weapon/genericdaemonweapon/proc/recruiter_not_recruiting(var/list/args)
	var/mob/dead/observer/O = args["player"]
	var/controls = args["controls"]
	to_chat(O, "<span class='recruit'>\The [src] is awakening. ([controls])</span>")


/obj/item/weapon/genericdaemonweapon/proc/recruiter_recruited(var/list/args)
	var/mob/dead/observer/O = args["player"]
	if(O)
		possessed = TRUE
		qdel(recruiter)
		recruiter = null
		awakening = FALSE
		visible_message("<span class='notice'>\The [name] awakens!</span>")
		var/mob/living/simple_animal/shade/sword/S = new(src)
		S.real_name = name
		S.name = name
		S.ckey = O.ckey
		S.universal_speak = TRUE
		S.universal_understand = TRUE
		S.status_flags |= GODMODE //Make sure they can NEVER EVER leave the blade.
		to_chat(S, "<span class='info'>You open your eyes and find yourself in a strange, unknown location with no recollection of your past.</span>")
		to_chat(S, "<span class='info'>Despite being a sword, you have the ability to speak, as well as an abnormal desire for slicing and killing evil beings.</span>")
		to_chat(S, "<span class='info'>Unable to do anything by yourself, you need a wielder. Find someone with a strong will and become their strength so you may finally satiate your desires.</span>")
		var/input = copytext(sanitize(input(S, "What should i call myself?","Name") as null|text), TRUE, MAX_MESSAGE_LEN)

		if(src && input)
			name = input
			S.real_name = input
			S.name = input
	else
		awakening = FALSE
		icon_state = initial(icon_state)
		visible_message("<span class='notice'>\The [name] calms down.</span>")

/obj/item/weapon/genericdaemonweapon/Destroy()
	for(var/mob/living/simple_animal/shade/sword/S in contents)
		to_chat(S, "You were destroyed!")
		qdel(S)
	if(recruiter)
		qdel(recruiter)
		recruiter = null
	..()

/obj/item/weapon/genericdaemonweapon/attack_ghost(var/mob/dead/observer/O)
	if(possessed)
		return
	if(last_ping_time + ping_cooldown <= world.time)
		last_ping_time = world.time
		awaken()
	else
		to_chat(O, "\The [name]'s power is low. Try again in a few moments.")

/obj/item/weapon/genericdaemonweapon/IsShield()
	return TRUE
