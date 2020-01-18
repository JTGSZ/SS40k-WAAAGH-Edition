 
//Heres the jumppack and all of its code
/obj/item/ork/jumppack
	name = "Jumppack"
	desc = "A missile, it still works enough to launch you with it for the most part."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkjumppack"
	item_state = "orkjumppack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	species_fit = list("Ork")
	var/usetime // Whats the total usetime of the pack.
	var/wallcrashiterations = 4 // How many times are we going to destroy everything before we stop.
	var/highinair = 0 //Am I flying, like real high?, If I am flying and the user pulls me off they will die.
	var/stuntime = 5 //How much do I stun on collision.
	var/knockdowntime = 5 // How much do I knockdown on collision.
	//We have a var called highflying on the mob now.

/obj/item/ork/jumppack/unequipped(mob/living/carbon/human/user, var/from_slot = null)
	if(user.highflying)
		user.visible_message("<span class='danger'> [user] takes their jumppack off in the air and learns about gravity!</span>")
		user.gib()

/obj/item/ork/jumppack/proc/hoverleap(var/mob/user) // We are flying, but its more like hovering.
	if(user.flying)
		return
	if(user.highflying)
		return
	to_chat(user, "<span class='warning'>You begin hovering deftly off the ground!</span>")
	user.flying = 1 //We are now hovering along with an animation afterwards
	hoveranimleap()

/obj/item/ork/jumppack/proc/hoverland(var/mob/user) // And then we stop hovering.
	to_chat(user, "<span class='warning'>You stop hovering deftly off the ground!</span>")
	user.flying = 0	
	hoveranimland()

/obj/item/ork/jumppack/proc/hoveranimleap(var/mob/user)
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 10, loop = 1, easing = SINE_EASING)

/obj/item/ork/jumppack/proc/hoveranimland(var/mob/user)
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
	animate(user, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
	animate(user)
	if(user.lying)
		user.pixel_y -= 6 * PIXEL_MULTIPLIER

/obj/item/ork/jumppack/proc/flyleap(var/mob/living/user, duration, enteranim = "liquify", exitanim = "reappear", smoke = 1) //We fly high into the air
	//Yeah, this code is copy and pasted from ethereal jaunt mostly
	//ethereal_jaunt(user, duration, enteranim, exitanim, smoke) //Reference line

	var/mobloc = get_turf(user)
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
	user.setDensity(FALSE)
	user.candrop = 0
	user.alphas["etheral_jaunt"] = 125 //Spoopy mode to know you are flying
	user.handle_alpha()
	user.delayNextAttack(duration+25)
	user.click_delayer.setDelay(duration+25)
	user.highflying = 1 //INTO THE AIR
	
	sleep(duration)
	flyland()

/obj/item/ork/jumppack/proc/flyland(var/mob/living/user, duration, enteranim = "liquify", exitanim = "reappear", smoke = 1) //We land from high in the air
	//Begin landing
	var/mobloc = get_turf(user)
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
	user.setDensity(TRUE)
	user.candrop = 1
	user.incorporeal_move = INCORPOREAL_DEACTIVATE
	user.alphas -= "etheral_jaunt"
	user.handle_alpha()
	user.highflying = 0 //BACK DOWN AGAIN

/obj/item/ork/jumppack/verb/flight()
	set name = "Vertical Leap"
	set category = "Jumppack"
	set desc = "Activate the jump pack to fly to high altitude. You may only take off or land outdoors."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.highflying)
		to_chat(user,"<span class='notice'> You pulse the jump pack to land again.</span>")
		flyland(user)
		return
	if(world.time < usetime + 120)
		to_chat(user,"<span class='warning'> The Jetpack is still charging!</span>")
		return
	if(!istype(user.loc, /turf/unsimulated/outside))
		user.visible_message("<span class='danger'> [user] shoots into the air and hits their head on the ceiling!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		user.take_organ_damage(15, 0)
		return
	to_chat(user, "<span class='warning'>You take off and jump high off the ground!</span>")
	flyleap(user) // We leap into the air.
	sleep(50)
	if(user.highflying)
		to_chat(user, "<span class='warning'> You fall back down towards the ground.</span>")
		flyland(user)
		return

/obj/item/ork/jumppack/verb/hover()
	set name = "Hover"
	set category = "Jumppack"
	set desc = "Hover with the jumppack."
	set src in usr

	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		to_chat(user, "<span class='warning'>You seem to have too many issues at the moment!</span>")
		return
	if(user.highflying)
		to_chat(user, "<span class='warning'>You can't stay up here forever!</span>")
		return
	if(world.time < usetime + 120)
		to_chat(user, "<span class='warning'>The Jumppack is still charging!</span>")
		return
	if(!user.flying)
		hoverleap(user)
	else
		hoverland(user)

/obj/item/ork/jumppack/verb/activatejetpack()
	set name = "Jetpack (short burst)"
	set category = "Jumppack"
	set desc = "Fly forward in a short potentially explosive burst."
	set src in usr
	
	var/mob/living/user = usr

	if(!user.canmove || user.stat || user.restrained())
		return
	if(ismob(user))
		if(user.highflying) 
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
				for(var/mob/living/carbon/human/M in orange(range, src.loc))
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
				for(var/mob/living/carbon/human/M in orange(range, src.loc))
					M.Stun(stuntime)
					M.Knockdown(knockdowntime)
				B.Move(get_step(user,movementdirection), movementdirection)	
				B.Move(get_step(user,movementdirection), movementdirection)	
				sleep(3)
				playsound(loc, 'sound/effects/jump_pack3.ogg', 75, 0)
				B.Move(get_step(user,movementdirection), movementdirection)	
	usetime = world.time

