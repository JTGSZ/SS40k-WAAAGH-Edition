 
//Heres the jumppack and all of its code
/obj/item/ork/jumppack
	name = "Jumppack"
	desc = "A missile, it still works enough to launch you with it for the most part."
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkjumppack"
	item_state = "orkjumppack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	species_fit = list("Ork")
	var/usetime // cooldown holder for verb actions
	var/wallcrashiterations = 4 // How many times are we going to destroy everything before we stop.
	var/highinair = 0 //Am I flying, like real high?, If I am flying and the user pulls me off they will die.
	var/stuntime = 5 //How much do I stun on collision.
	var/knockdowntime = 5 // How much do I knockdown on collision.
	var/leapduration = 5 SECONDS //How long we stay in the air

	//We have a var called highflying on the mob now.

/obj/item/ork/jumppack/unequipped(mob/living/carbon/human/user, var/from_slot = null)
	if(user.highflying)
		user.visible_message("<span class='danger'> [user] takes their jumppack off in the air and learns about gravity!</span>")
		animate(user, pixel_y = 0, time = 10, loop = 0, QUAD_EASING) //Our fun animation
		sleep(10) //10 ticks until we meet our end
		user.gib() //And we die
	if(user.flying)
		user.flying = 0
		user.visible_message("<span class='danger'> [user] takes their jumppack off and meets the ground!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
		animate(user, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
		animate(user)
		if(user.lying)
			user.pixel_y -= 6 * PIXEL_MULTIPLIER

/obj/item/ork/jumppack/proc/hoverleap(mob/user) // We are flying, but its more like hovering.
	if(user.flying)
		return
	if(user.highflying)
		return
	to_chat(user, "<span class='warning'>You begin hovering deftly off the ground!</span>")
	user.flying = 1 //We are now hovering along with an animation afterwards
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 10, loop = 1, easing = SINE_EASING)

/obj/item/ork/jumppack/proc/hoverland(mob/user) // And then we stop hovering.
	if(user.highflying)
		to_chat(user, "<span class='warning'>You can't hover and jump at the same time.</span>")
		user.flying = 0
	else
		to_chat(user, "<span class='warning'>You stop hovering deftly off the ground!</span>")
		user.flying = 0
	
	//Animation will occur regardless because we are going to land.
	animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
	animate(user, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
	animate(user)
	if(user.lying)
		user.pixel_y -= 6 * PIXEL_MULTIPLIER

/obj/item/ork/jumppack/proc/flyleap(var/mob/living/user, leapduration, smoke = 1) //We fly high into the air
	//Yeah, this code is copy and pasted from ethereal jaunt mostly
	//ethereal_jaunt(user, duration, enteranim, exitanim, smoke) //Reference line

	if(user.incorporeal_move == INCORPOREAL_ETHEREAL) //they're already jaunting, we have another fix for this but this is sane
		return
	user.unlock_from()
	//Begin moving with an animation
	animate(user, pixel_y = 300, time = 20, loop = 0, QUAD_EASING)

	if(smoke)
		user.ExtinguishMob()
		var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
		S.time_to_live = 20 //2 seconds instead of full 10

	//Turn on jaunt incorporeal movement, make him invincible, they can't see him over the screen anyways.
	user.incorporeal_move = INCORPOREAL_ETHEREAL
	user.invisibility = INVISIBILITY_MAXIMUM
	user.flags |= INVULNERABLE
	user.setDensity(FALSE)
	user.candrop = 0
	user.delayNextAttack(leapduration+25)
	user.click_delayer.setDelay(leapduration+25)
	user.highflying = 1 //INTO THE AIR

	if(user.flying)
		hoverland()

	sleep(leapduration)
	
	if(user && user.stat != DEAD) //If our dumb ass didn't take off the jetpack midair
		flyland(user) //we now land

/obj/item/ork/jumppack/proc/flyland(var/mob/living/user, smoke = 1) //We land from high in the air
	//Begin landing
	var/mobloc = get_turf(user)
	//user.delayNextMove(25)
	user.dir = SOUTH

	animate(user, pixel_y = 0, time = 20, loop = 0, QUAD_EASING)

	//Forcemove him onto the tile and make him visible and vulnerable
	user.forceMove(mobloc)
	user.invisibility = 0
	user.flags &= ~INVULNERABLE
	user.candrop = 1
	user.incorporeal_move = INCORPOREAL_DEACTIVATE

	sleep(20) //We should have 20 ticks before footprints start up again
	user.setDensity(TRUE) // We also aren't dense until the anim is done too.
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
		to_chat(user,"<span class='warning'> The jumppack is still charging!</span>")
		return
	if(!istype(user.loc, /turf/unsimulated/outside))
		user.visible_message("<span class='danger'> [user] shoots into the air and hits their head on the ceiling!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		user.take_organ_damage(15, 0)
		return
	to_chat(user, "<span class='warning'>You take off and jump high off the ground!</span>")
	flyleap(user, leapduration) // We leap into the air.
	usetime = world.time
	
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

/obj/item/ork/jumppack/verb/activatejumppack()
	set name = "Jumppack (short burst)"
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
		to_chat(user, "<span class='warning'> The jumppack is still charging!</span>")
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

