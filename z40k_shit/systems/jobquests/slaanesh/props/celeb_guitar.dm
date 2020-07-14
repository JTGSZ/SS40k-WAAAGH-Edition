/*
Guitar fun
*/

/obj/item/weapon/guitar																				//basic guitar, playes sound.
	name = "A Guitar"
	desc = "An extremely expensive instrument. Probably worth more than this entire planet."
	icon = 'icons/obj/musician.dmi'
	icon_state = "guitar1"
	item_state = "guitar1"
	force = 2
	var/playing = 0

/obj/item/weapon/guitar/attack_self(mob/user)
	interact(user)

/obj/item/weapon/guitar/interact(mob/user)
	if(!user)
		user << "What the? Who are you?"
		return
	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		user << "You can not do that while restrained."
		return

	if(playing)
		return
	else
		playing = 1
		var/guitarsound = pick('z40k_shit/sounds/guitar1.ogg','z40k_shit/sounds/guitar2.ogg')
		playsound(loc, guitarsound, 100, 0)
		user << "Hmm... maybe you need some practice."
		spawn (90)
			playing = 0

/*
Stage 1
*/

/obj/item/weapon/guitar/one

/obj/item/weapon/guitar/one/attackby(obj/item/weapon/W, mob/user)							//stub for upgrades
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		user << "The panel slides open."
		new /obj/item/weapon/guitar/two(user.loc)
		qdel(src)

/*
Stage 2
*/

/obj/item/weapon/guitar/two
	desc = "A very expensive instrument. The rear cover has been opened and there appears to be enough space in here to fit a second powercell."

/obj/item/weapon/guitar/two/attackby(obj/item/weapon/W, mob/user)						//after screwdriver comes powercell
	..()
	if(istype(W, /obj/item/weapon/cell))
		playsound(src.loc, 'z40k_shit/sounds/misc_effects/bin_open.ogg', 50, 1)
		user << "Must... have... more.... power...."
		new /obj/item/weapon/guitar/three(user.loc)
		qdel(W)
		qdel(src)
	else
		user << "Stop that! You need a power cell!"
/*
Stage 3
*/

/obj/item/weapon/guitar/three
	desc = "A heavilly modified Guitar. This one appears to be in need of a little bit of wire in order to optomize it's power consumption."

/obj/item/weapon/guitar/three/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/stack/cable_coil))														//then some wire
		playsound(src.loc, 'sound/effects/zzzt.ogg', 50, 1)
		user << "This is nice. Not that we are electricians or anything but this just seems natural some how. Now get out that screwdriver and lets close the cover."
		new /obj/item/weapon/guitar/four(user.loc)
		qdel(W)
		qdel(src)
	else
		user << "No... you need some wire for this."

/*
Stage 4
*/

/obj/item/weapon/guitar/four
	desc = "A very expensive instrument. The rear cover remains open."

/obj/item/weapon/guitar/four/attackby(obj/item/weapon/W, mob/user)					//then a screwdriver again
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		user << "The panel closes."
		new /obj/item/weapon/guitar/five(user.loc)
		qdel(src)
	else
		user << "Just use a screwdriver would ya?"

/*
Stage 5
*/

/obj/item/weapon/guitar/five																		//start of the slaaneshi upgraded instrument
	name = "A Guitar"
	desc = "An extremely expensive instrument. It seems to draw you in as you look at it."
	icon = 'icons/obj/musician.dmi'
	icon_state = "guitar2"
	item_state = "guitar2"
	force = 2

/obj/item/weapon/guitar/five/attack_self(mob/user)
	interact(user)

/obj/item/weapon/guitar/five/interact(mob/user)
	if(!user)
		user << "What the? Who are you?"
		return

	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		user << "Just.... can't.... reach...."
		return

	if(playing)
		return
	else
		playing = 1
		var/guitarsound = pick('z40k_shit/sounds/guitar3.ogg','z40k_shit/sounds/guitar4.ogg' , 'z40k_shit/sounds/guitar5.ogg')					//new sounds
		playsound(loc, guitarsound, 100, 0)
		for(var/mob/living/M in hearers(4, user))								//AOE stun
			if(prob(5))
				user.say("THINGS WILL GET LOUND NOW!!!")
			to_chat(M, "Man that guy can ROCK!")
			if(iscarbon(M))
				if(!M.mind)
					var/list/factions = list("SLAANESH")
					if(length(factions & M.faction)) //We don't want it affecting the celeb himself. Or anyone, really, who is slaaneshi. -Drake
						to_chat(M, "You make it look easy!!")
					else
//						M.Weaken(4)
						M.dizziness = max(M.dizziness-3, 0)
				else
					to_chat(M, "That guy is using warp energy of some kind.")								//callidus are excluded

		spawn (90)
			playing = 0