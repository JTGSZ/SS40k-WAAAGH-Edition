//Within is all of the ork equipment, I figured it'd be easier to just pool it here.
//Since after-all we can do whatever we wish ya know? If its that bad it can be moved later.
//The mob icon path for orks is located in 40kSpecies.dm. Mob being what appears when it is worn
// -Love JTGSZ

//Heres all of the parents.
/obj/item/clothing/gloves/ork //Parent of the children afterwards, inherits from these paths.
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Ork") //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork") //We insure it checks to fit for the species icon.
/obj/item/clothing/head/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/suit/armor/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/shoes/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/clothing/under/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork")
	species_fit = list("Ork")
/obj/item/weapon/storage/belt/ork
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork")

/* 
	Gloves
	*/
/obj/item/clothing/gloves/ork/clothgloves
	name = "Ragged Gloves" //The name of the object ingame.
	desc = "A pair of ragged cloth gloves." //Description upon examination
	icon_state = "orkgloves1" //The state of the object icon when dropped/displayed in slot
	item_state = "orkgloves1" //The state of the mob icon when worn.
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 17 //Slight knockout chance increase.
	damage_added = 3 //Add 3 damage to unarmed attacks when worn

/*
	Hats & Helmets
	*/
/obj/item/clothing/head/ork/milcap
	name = "Red Military Cap"
	desc = "A stylish hat, hopefully it makes you think faster idiot."
	icon_state = "orkhat2"
	item_state = "orkhat2"
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/armorhelmet
	name = "Horned Armored Helmet"
	desc = "A helmet with horns"
	icon_state = "orkhelmet1"
	item_state = "orkhelmet1"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD
	siemens_coefficient = 1

/obj/item/clothing/head/ork/redbandana
	name = "Red Bandana"
	desc = "A red bandana that seems to be stuck in the shape of an ork head."
	icon_state = "orkhat1"
	item_state = "orkhat1"
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.9

/obj/item/clothing/head/ork/bucket
	name = "Metal Bucket Helmet"
	desc = "A metal bucket, conveniently sized for a orks head."
	icon_state = "orkhelmet2"
	item_state = "orkhelmet2"
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 10, bomb = 25, bio = 10, rad = 0)
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.8

/*
	Armor and Suits
	*/
/obj/item/clothing/suit/armor/ork/samuraiorkarmor
	name = "Plated Ork Armor"
	desc = "Armor that seems to have more plates than usual, RESEMBLES SOMETHING DOESN'T IT."
	icon_state = "orkarmor1"
	item_state = "orkarmor1"
	armor = list(melee = 50, bullet = 60, laser = 60,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.8
	body_parts_covered = ARMS|FULL_TORSO

/obj/item/clothing/suit/armor/ork/leatherbikervest
	name = "Leather Biker Vest"
	desc = "A protective leather vest with a stylish skull on the back, looks like it used to be a jacket"
	icon_state = "orkarmor2"
	item_state = "orkarmor2"
	armor = list(melee = 20, bullet = 30, laser = 40,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.5
	body_parts_covered = FULL_TORSO

/obj/item/clothing/suit/armor/ork/rwallplate
	name = "Plate Ork Armor"
	desc = "Two sets of plating that seem to have came off a wall"
	icon_state = "orkarmor3"
	item_state = "orkarmor3"
	armor = list(melee = 30, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO

/obj/item/clothing/suit/armor/ork/ironplate
	name = "Metal Armor"
	desc = "A crude suit of armor, made for an ork"
	icon_state = "orkarmor4"
	item_state = "orkarmor4"
	armor = list(melee = 30, bullet = 40, laser = 30,energy = 10, bomb = 10, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO

/*
	Shoes
	*/
/obj/item/clothing/shoes/ork/orkboots
	name = "Leather Boots"
	desc = "What more is there to say? These are leather boots, ork sized."
	icon_state = "orkboots1"
	item_state = "orkboots1"
	siemens_coefficient = 0.6
	body_parts_covered = FEET



/*
	Uniforms
	*/
/obj/item/clothing/under/ork/pants
	name = "Pants"
	desc = "Some motherfuckin PANTS"
	icon_state = "orkuniform1"
	item_state = "orkuniform1"
	_color = "orkuniform1"
	body_parts_covered = LOWER_TORSO|LEGS|FEET

/obj/item/clothing/under/ork/pantsandshirt
	name = "Pants and Shirt"
	desc = "You think having pants is a luxury? This is a pants and SHIRT."
	icon_state = "orkuniform1dev1"
	item_state = "orkuniform1dev1"
	_color = "orkuniform1dev1"
	body_parts_covered = FULL_TORSO|LEGS|FEET

/obj/item/clothing/under/ork/leatherpantsandshirt
	name = "Leather Uniform"
	desc = "A crude uniform, made of brown leather of some sort."
	icon_state = "orkuniform2"
	item_state = "orkuniform2"
	_color = "orkuniform2"
	body_parts_covered = FULL_TORSO|LEGS|FEET

/*
	Belts
	*/
/obj/item/weapon/storage/belt/ork/basicbelt
	name = "Basic Belt"
	desc = "A basic belt for a basic bitch."
	icon_state = "orkbelt1"
	item_state = "orkbelt1"
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")

/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/belt/ork/armorbelt
	name = "Belt with Plates"
	desc = "A belt with armored plates attached to it."
	icon_state = "orkbelt1dev1"
	item_state = "orkbelt1dev1"
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 10, bullet = 10, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb")

/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/ork/brownbackpack
	name = "Brown Backpack"
	desc = "A brown backpack, maybe one day there will be more to it."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkbackpack"
	item_state = "orkbackpack"

/*
	Back Items - These currently don't do much, have to code in that.
				*/
// The burnapack, uses welderfuel from the back and verbs/attackby to attach and detach the gun.
/obj/item/weapon/ork/burnapack
	name = "Burna Pack"
	desc = "Let forth your burning spirit in a gout of flames."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkburnapack"
	item_state = "orkburnapack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	var/obj/item/weapon/gun/flamernozzle/mynozzle // The specific gun end tied to this pack
	var/heldorholstered = 0 //Is the nozzle on it or off of it
	var/max_fuel = 1500 //The max amount of fuel this can hold
	var/start_fueled = 1 // Do we start fueled

/obj/item/weapon/ork/burnapack/New()
	. = ..()
	mynozzle = new(src)
	create_reagents(max_fuel)
	if(start_fueled)
		reagents.add_reagent(FUEL, max_fuel)

/obj/item/weapon/ork/burnapack/proc/can_use_verbs(mob/user)
	var/mob/living/carbon/human/M = user
	if (M.stat == DEAD)
		to_chat(user, "You can't do that while you're dead!")
		return 0
	else if (M.stat == UNCONSCIOUS)
		to_chat(user, "You must be conscious to do this!")
		return 0
	else if (M.handcuffed)
		to_chat(user, "You can't reach the controls while you're restrained!")
		return 0
	else if(!isork(user))
		to_chat(user,"What the hell am I looking at?")
		return 0
	else
		return 1

/obj/item/weapon/ork/burnapack/verb/remove_nozzle() //pulls the nozzle off the burnapack
	set name = "Remove Nozzle"
	set category = "Object"
	set src in usr

	if (!can_use_verbs(usr))
		return

	detach_nozzle()

/obj/item/weapon/ork/burnapack/examine(mob/user)
	..()
	to_chat(user, "<span class='info'> Has [max_fuel] unit\s of fuel remaining.</span>")

/obj/item/weapon/ork/burnapack/update_icon()
	if(heldorholstered)
		icon_state = "orkburnapack"
	else
		icon_state = ""

/obj/item/weapon/ork/burnapack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return

/obj/item/weapon/ork/burnapack/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/gun/flamernozzle/))
		attach_nozzle(mynozzle)
		return

/obj/item/weapon/ork/burnapack/proc/attach_nozzle(var/mob/user)
	if(!mynozzle)
		mynozzle = new(src)
	mynozzle.forceMove(src)
	heldorholstered = 0
	if(user)
		to_chat(user, "<span class='notice'> You loop [mynozzle.name] to a hook on the [name].</span>")
	update_icon()
	user.update_inv_back()

/obj/item/weapon/ork/burnapack/proc/detach_nozzle(var/mob/user)
	if(!mynozzle)
		to_chat(user, "Your pack seems to have no nozzle, FUCK.")
		return
	user.put_in_hands(mynozzle)
	heldorholstered = 1
	if(user)
		to_chat(user,"<span class='notice'> You unloop [mynozzle.name] off the hook on the [name].</span>")
	update_icon()
	user.update_inv_back()

/obj/item/weapon/gun/flamernozzle
	name = "Burna Pack Nozzle"
	desc = "The shooty end of a flamethrower"
	icon = 'icons/obj/flamethrower.dmi'
	icon_state = "flamethrowerbase"
	item_state = "flamethrower_0"
	var/obj/item/weapon/ork/burnapack/my_pack
	var/currently_lit = 0

/obj/item/weapon/gun/flamernozzle/New()
	if(istype(loc, /obj/item/weapon/ork/burnapack))
		my_pack = loc

/obj/item/weapon/gun/flamernozzle/dropped(mob/user)
	if(my_pack)
		my_pack.attach_nozzle(user)
	else
		qdel(src)

/obj/item/weapon/gun/flamernozzle/verb/light_flame() //pulls the nozzle off the chempack
	set name = "Igniter Toggle"
	set desc = "Turns the igniter on, along with all that entails"
	set category = "Object"
	set src in usr

	if(!currently_lit)
		currently_lit = 1
	else
		currently_lit = 0

/obj/item/weapon/gun/flamernozzle/process_chambered()
	if(in_chamber)
		return 1
	if(currently_lit)
		if(my_pack.max_fuel > 0)
			my_pack.max_fuel-= 50
			in_chamber = new/obj/item/projectile/fire_breath/shuttle_exhaust(src)
			return 1
		else
			return
	return 0

/* TODO: FINISH THIS JUMPPACK, IT'LL BE FUCKING EPIC MOTHERFUCKER.
//Heres the jumppack and all of its code
/obj/item/ork/jumppack
	name = "Jumppack"
	desc = "A missile, it still works enough to launch you with it for the most part."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkjumppack"
	item_state = "orkjumppack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	var/usetime // Whats the total usetime of the pack.
	var/wallcrashiterations = 4 // How many times are we going to destroy everything before we stop.
	var/highinair = 0 //Am I flying, like real high?, If I am flying and the user pulls me off they will die.
	var/stuntime = 5 //How much do I stun on collision.
	var/knockdowntime = 5 // How much do I knockdown on collision.

/obj/item/ork/jumppack/proc/hoverleap(var/mob/user) // We are flying, but its more like hovering.
	if(user.flying)
		return
	user.flying = 1 //We are now hovering along with an animation afterwards
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 10, loop = 1, easing = SINE_EASING)

/obj/item/ork/jumppack/proc/hoverland(var/mob/user) // And then we stop hovering.
	user.flying = 0
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
	animate(user, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
	animate(user)
	if(user.lying)
		user.pixel_y -= 6 * PIXEL_MULTIPLIER

/obj/item/ork/jumppack/proc/flyleap(var/mob/living/user, duration, enteranim = "liquify", exitanim = "reappear", smoke = 1) //We fly high into the air
	//Yeah, this code is copy and pasted from ethereal jaunt mostly
	ethereal_jaunt(user, duration, enteranim, exitanim, smoke)

	var/mobloc = get_turf(user)
	var/previncorp = user.incorporeal_move //This shouldn't ever matter under usual circumstances
	if(user.incorporeal_move == INCORPOREAL_ETHEREAL) //they're already jaunting, we have another fix for this but this is sane
		return
	user.unlock_from()
	//Begin moving with an animation
	anim(location = mobloc, a_icon = 'icons/mob/mob.dmi', flick_anim = enteranim, direction = user.dir, name = user.name,lay = user.layer+1,plane = user.plane)
	if(smoke)
		user.ExtinguishMob()
		var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
		S.time_to_live = 20 //2 seconds instead of full 10

	//Turn on jaunt incorporeal movement, make him invincible and invisible
	user.incorporeal_move = INCORPOREAL_ETHEREAL
	user.invisibility = INVISIBILITY_MAXIMUM
	user.flags |= INVULNERABLE
	var/old_density = user.density
	user.setDensity(FALSE)
	user.candrop = 0
	user.alphas["etheral_jaunt"] = 125 //Spoopy mode to know you are flying
	user.handle_alpha()
	user.delayNextAttack(duration+25)
	user.click_delayer.setDelay(duration+25)

	sleep(duration)

/obj/item/ork/jumppack/proc/flyland(var/mob/living/user, duration, enteranim = "liquify", exitanim = "reappear", smoke = 1) //We land from high in the air
	//Begin landing
	mobloc = get_turf(user)
	if(smoke)
		var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
		S.time_to_live = 20 //2 seconds instead of full 10
	user.delayNextMove(25)
	user.dir = SOUTH
	sleep(20)
	anim(location = mobloc, a_icon = 'icons/mob/mob.dmi', flick_anim = exitanim, direction = user.dir, name = user.name,lay = user.layer+1,plane = user.plane)
	sleep(5)

	//Forcemove him onto the tile and make him visible and vulnerable
	user.forceMove(mobloc)
	user.invisibility = 0
	for(var/obj/abstract/screen/movable/spell_master/SM in user.spell_masters)
		SM.silence_spells(0)
	user.flags &= ~INVULNERABLE
	user.setDensity(old_density)
	user.candrop = 1
	user.incorporeal_move = previncorp
	user.alphas -= "etheral_jaunt"
	user.handle_alpha()

/obj/item/ork/jumppack/verb/flight()
	set name = "Vertical Leap"
	set category = "Jumppack"
	set desc = "Activate the jump pack to fly to high altitude. You may only take off or land outdoors."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.flying && !user.dropping)
		to_chat(user,"<span class='notice'> You pulse the jump pack to land again.</span>")
		flyland()
		return
	if(world.time < usetime + 120)
		to_chat(user,"<span class='warning'> The Jetpack is still charging!</span>")
		return
	if(!istype(user.loc, /turf/snow) && !istype(user.loc, /turf/unsimulated/floor/snow))
		user.visible_message("<span class='danger'> [user] shoots into the air and hits their head on the ceiling!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		user.take_organ_damage(15, 0)
		return
	flyleap() // We leap into the air.
	sleep(50)
	if(user.flying)
		to_chat(user, "<span class='warning'> You fall back down towards the ground.</span>")
		flyland()
		return

/obj/item/ork/jumppack/verb/hover()
	set name = "Hover"
	set category = "Jumppack"
	set desc = "Hover with the jumppack."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(world.time < usetime + 120)
		to_chat(user, "<span class='warning'>The Jumppack is still charging!</span>")
		return
	if(!user.flying)
		hover()
	else
		unhover()

/obj/item/ork/jumppack/verb/activatejetpack()
	set name = "Jetpack (short burst)"
	set category = "Jumppack"
	set desc = "Fly forward in a short potentially explosive burst."
	set src in usr
	
	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(ismob(user))
		if(highinair) 
			return
	if(world.time < usetime + 60)
		to_chat(user, "<span class='warning'> The Jetpack is still charging!</span>")
		return
	else
		for (var/i = 1 to wallcrashiterations) //We just loop this way.
			spawn(0)
				var/mob/B = usr
				var/movementdirection = B.dir
				var/range = 1
				var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
				S.time_to_live = 20 //2 seconds instead of full 10
				item_state = "RGjumppackon"
				update_icon()
				playsound(loc, 'sound/effects/jump_pack1.ogg', 75, 0)
				for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
					if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
						var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
						playsound(loc, randomizer, 75, 0)
						qdel(M)
					if (istype(M, /turf/simulated/wall/r_wall))
						M.ex_act(1)
				for(var/obj/structure/grille/M in range(range, src.loc))
					qdel(M)
				for(var/obj/structure/window/M in range(range, src.loc))
					qdel(M)
				for(var/turf/simulated/floor/M in range(range, src.loc))
					M.burn_tile()
				for(var/obj/machinery/door/M in range(range, src.loc))
					qdel(M)
				for(var/mob/living/carbon/human/M in range(range, src.loc))
					M.Stun(stuntime)
					M.Knockdown(knockdowntime)

				B.Move(get_step(usr,movementdirection), movementdirection)
				sleep(1)
				for(var/turf/simulated/wall/M in range(range, src.loc))
					if (istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
						var/randomizer = pick('sound/effects/wallsmash1.ogg','sound/effects/wallsmash2.ogg', 'sound/effects/wallsmash3.ogg')
						playsound(loc, randomizer, 75, 0)
						qdel(M)
					if (istype(M, /turf/simulated/wall/r_wall))
						M.ex_act(1)
				for(var/obj/structure/grille/M in range(range, src.loc))
					qdel(M)
				for(var/obj/structure/window/M in range(range, src.loc))
					qdel(M)
				for(var/turf/simulated/floor/M in range(range, src.loc))
					M.burn_tile()
				for(var/obj/machinery/door/M in range(range, src.loc))
					qdel(M)
				for(var/mob/living/carbon/human/M in range(range, src.loc))
					M.Stun(stuntime)
					M.Knockdown(knockdowntime)
				B.Move(get_step(user,movementdirection), movementdirection)	
				B.Move(get_step(user,movementdirection), movementdirection)	
				sleep(3)
				playsound(loc, 'sound/effects/jump_pack3.ogg', 75, 0)
				B.Move(get_step(user,movementdirection), movementdirection)	
	usetime = world.time	*/

