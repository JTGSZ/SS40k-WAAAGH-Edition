/*
Celeb
*/

/obj/item/weapon/paper/celebjudgement
	name = "Deffered Judgement before a Magistrate."
	info = "The accused is hereby sentenced to 120 hours civil service to be performed on a reasonable time table not to exceed 12 months.<BR><BR> At the end of this period the order will be reviewed by the sentencing magistrate for compliance. If 120 hours of service have not been performed the defferment will expire and the accused will begin his/her sentence of sixteen months in a correctional facility. All claims of civil service must be proven by imperial documentation and submitted to the lower courts of the sector minoris. Compliance is manditory.<BR><BR>Goge Serand<BR>Civil Clerk.<BR>Office of the Magistrate, Eleventh District."

/obj/item/weapon/paper/crashclue
	name = "Recon Report."
	info = "//Intermediate report//<BR><BR>Squad seven reported that their patrol uncovered a shipwreck north of the outpost. Unable to investigate due to heavy snowfall but once the outpost is built it may warrant a second pass. One of the guardsmen said he heard some kind of music coming from the wreck. If the snow keeps up we'll just pass this along to the next detachment that gets stationed here. It's 50 paces north of the armory.//END// "


/*
Drugs are bad!
*/

/obj/item/clothing/mask/cigarette/celeb
	name = "fatty boom batty"
	desc = "From the agriworld 'Daronoco', the hard working Imperials have tirelessly worked the fields in order to bring you a stick of quality nicotene. Although some one seems to have mixed the contents of this premium ciggarette with cheap lho."
	var/thekey = null
	var/active = 0

/obj/item/clothing/mask/cigarette/celeb/New()
	..()
	reagents.add_reagent("lho", 20)


/obj/item/clothing/mask/cigarette/celeb/process()
	var/turf/location = get_turf(src)
	var/mob/living/carbon/human/M = loc
	var/list/factions = list("SLAANESH")
	if(isliving(loc))
		M.IgniteMob()
	smoketime--
	if(smoketime < 1)
		new type_butt(location)
		processing_objects.Remove(src)
		if(ismob(loc))
			M << "<span class='notice'>Your [name] goes out.</span>"
			M.unEquip(src, 1)	//un-equip it so the overlays can update //Force the un-equip so the overlays update
		qdel(src)
		return
	if(isliving(loc))
		if(length(factions & M.faction))
			thekey = M.ckey
	if(location)
		location.hotspot_expose(700, 5)
	if(reagents && reagents.total_volume)	//	check if it has any reagents at all
		handle_reagents()
	if(!istype(M)) return //This was throwing runtime errors when the cig was lit and on the ground, cuz turf has no variable called ckey. -Drake

	if(M.ckey != thekey)
		active = 1
	if((active) && (M.ckey == thekey))
		M.purity--
		M << "<span class='notice'>Nice. That was real nice. This has been a real inspiration. Now that we are in the correct frame of mind. Lets go back to the ship and see just how inspired we really are.</span>"
		qdel(src)
	return

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

/obj/item/weapon/guitar/attack_self(mob/user as mob)
	interact(user)

/obj/item/weapon/guitar/interact(mob/user as mob)

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
		var/guitarsound = pick('sound/items/guitar1.ogg','sound/items/guitar1.ogg')
		playsound(loc, guitarsound, 100, 0)
		user << "Hmm... maybe you need some practice."
		spawn (90)
			playing = 0

/*
Stage 1
*/

/obj/item/weapon/guitar/one

/obj/item/weapon/guitar/one/attackby(obj/item/weapon/W as obj, mob/user as mob)							//stub for upgrades
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

/obj/item/weapon/guitar/two/attackby(obj/item/weapon/W as obj, mob/user as mob)						//after screwdriver comes powercell
	..()
	if(istype(W, /obj/item/weapon/stock_parts/cell))
		playsound(src.loc, 'sound/effects/bin_open.ogg', 50, 1)
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

/obj/item/weapon/guitar/three/attackby(obj/item/weapon/W as obj, mob/user as mob)
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

/obj/item/weapon/guitar/four/attackby(obj/item/weapon/W as obj, mob/user as mob)					//then a screwdriver again
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

/obj/item/weapon/guitar/five/attack_self(mob/user as mob)
	interact(user)

/obj/item/weapon/guitar/five/interact(mob/user as mob)

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
		var/guitarsound = pick('sound/items/guitar3.ogg','sound/items/guitar4.ogg' , 'sound/items/guitar5.ogg')					//new sounds
		playsound(loc, guitarsound, 100, 0)
		for(var/mob/living/M in hearers(4, user))								//AOE stun
			if(prob(5))
				user.say("THINGS WILL GET LOUND NOW!!!")
			M << "Man that guy can ROCK!"
			if(iscarbon(M))
				if(!M.mind || !M.mind.changeling)
					var/list/factions = list("SLAANESH")
					if(length(factions & M.faction)) //We don't want it affecting the celeb himself. Or anyone, really, who is slaaneshi. -Drake
						M << "You make it look easy!!"
					else
//						M.Weaken(4)
						M.dizziness = max(M.dizziness-3, 0)
				else
					M << "That guy is using warp energy of some kind."								//callidus are excluded

		spawn (90)
			playing = 0

/*
Blade Stage 1
*/

/obj/item/weapon/sblade_stageone
	name = "Blade"
	desc = "A strange blade. What it is and where did it come from?"
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "slaanesh"
	item_state = "pk_off"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 15 //About as good as a heretic toolbox
	attack_verb = list("cut")

/obj/item/device/celebhacktool
	name = "Party Configuration Tool"
	desc = "A piece of heretical looking technology that makes a fire alarm more interesting. Use it on an alarm with an open panel."
	icon = 'icons/obj/device.dmi'
	icon_state = "celebhack"
	item_state = "pen"
	slot_flags = SLOT_BELT
	w_class = 2
	origin_tech = "combat=1;magnets=2"
	var/charges = 1

/*
Slaaneshi tentacle mutation by Drake
Enjoy
*/

/obj/item/clothing/under/tentacles
	name = "Tentacles"
	desc = "A chaotic alteration of the flesh to manifest tentacles."
	icon = 'icons/obj/corrupt.dmi'
	icon_state = "slaanesh"
	item_state = "tentacles"
	_color = "tentacles"
	has_sensor = 0
	armor = list(melee = 15, bullet = 0, laser = 5,energy = 0, bomb = 5, bio = 0, rad = 25)
	flags = STOPSPRESSUREDMAGE
	canremove = FALSE

/obj/item/clothing/under/tentacles/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/under/tentacles/process() //Lol this will still function when the wearer is dead. -Drake
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		for(var/mob/living/M in oview(1, H))
			if(prob(40))
				var/action = rand(1, 3)
				switch(action)
					if(1)
						H.visible_message("<span class='warning'>One of [H]'s tentacles slaps [M]!</span>")
						M.damageoverlaytemp = 9001 //Lol this will make them freak out for a moment.
					if(2)
						if(M.reagents)
							H.visible_message("<span class='warning'>One of [H]'s tentacles stings [M]!</span>")
							M.reagents.add_reagent("hallucinations", 10)
							M.reagents.add_reagent("stoxin", 10)
					if(3)
						H.visible_message("<span class='warning'>One of [H]'s tentacles hits [M]!</span>")
						M.take_organ_damage(10, 0)