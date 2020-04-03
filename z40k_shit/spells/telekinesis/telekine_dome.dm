/spell/aoe_turf/telekine_dome
	name = "Telekine Dome"
	desc = "Blessing - Erects cover around ."
	abbreviation = "GL"

	school = "vampire"
	user_type = USER_TYPE_PSYKER
	specialization = TELEKINESIS
	charge_type = Sp_RECHARGE
	charge_max = 3 MINUTES
	invocation_type = SpI_NONE
	override_base = "vamp"
	hud_state = "vampire_glare"

	range = 5
	inner_radius = 4

/spell/aoe_turf/telekine_dome/cast(var/list/targets, var/mob/living/user)
	set waitfor = 0
	var/list/barriers = list()
	var/duration = user.attribute_willpower

	for(var/turf/T in targets)
		var/obj/effect/telekine_dome/PP = new(T,user)
		barriers += PP

	sleep(duration SECONDS)
	for(var/obj/effect/telekine_dome/PP in barriers)
		qdel(PP)


/obj/effect/telekine_dome
	name = "Psychic Wall"
	desc = "A telepathic dome's force field."
	icon = 'icons/effects/effects.dmi'
	icon_state = "m_shield"
	anchored = 1
	opacity = 0
	density = 1
	invisibility = 0
	var/health = 500

	var/explosion_block = 90 //making this spell marginally more useful

/obj/effect/telekine_dome/New(var/turf/T,mob/user)
	..()
	dir = get_dir(user,src)

/obj/effect/telekine_dome/attackby(obj/item/weapon/W, mob/user)
	if(W.damtype == BRUTE || W.damtype == BURN)
		user.delayNextAttack(10)
		health -= W.force
		user.visible_message("<span class='warning'>\The [user] hits \the [src] with \the [W].</span>", \
		"<span class='warning'>You hit \the [src] with \the [W].</span>")
		healthcheck(user)
		return

/obj/effect/telekine_dome/proc/healthcheck(var/mob/M, var/sound = 1)
	if(health <= 0)
		visible_message("<span class='warning'>[src] shatters like crystalline glass!</span>")
		setDensity(FALSE)
		qdel(src)

/obj/effect/telekine_dome/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(istype(mover,/obj/item/projectile))
		return (check_cover(mover,target))
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
	if(get_dir(loc, target) == dir || get_dir(loc, mover) == dir)
		return !density
	else
		return 1
	return 0


//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/effect/telekine_dome/proc/check_cover(obj/item/projectile/P, turf/from)
	var/shooting_at_the_barricade_directly = P.original == src
	var/chance = 70
	if(!shooting_at_the_barricade_directly)
		if(get_dir(loc, from) != dir) // It needs to be flipped and the direction needs to be right
			return 1
		if(get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
			return 1
		if(ismob(P.original))
			var/mob/M = P.original
			if(M.lying)
				chance += 20 //Lying down lets you catch less bullets
	if(shooting_at_the_barricade_directly || prob(chance))
		health -= P.damage/2
		if(health > 0)
			visible_message("<span class='warning'>[P] hits \the [src]!</span>")
			return 0
		else
			visible_message("<span class='warning'>[src] shatters!</span>")
			setDensity(FALSE)
			qdel(src)
			return 1
	return 1

