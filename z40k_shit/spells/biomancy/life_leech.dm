/spell/targeted/projectile/life_leech
	name = "Life Leech"
	desc = "Witchfire - Drains life from things in a area and returns it to you."
	abbreviation = "LL"
	user_type = USER_TYPE_PSYKER
	specialization = BIOMANCY

	proj_type = /obj/item/projectile/spell_projectile/life_leech
	school = "evocation"
	projectile_speed = 1
	duration = 20
	var/leech_amount = 30

	charge_max = 100
	invocation_type = SpI_NONE
	spell_flags = WAIT_FOR_CLICK
	hud_state = "bucket"
	cast_prox_range = 2


/spell/targeted/projectile/life_leech/cast(list/targets, mob/living/user = usr)
	cast_prox_range = cast_prox_range + round(user.attribute_sensitivity/500)
	leech_amount = leech_amount + user.attribute_willpower
	..()

//Basically it runs this when its in range to do shit.
/spell/targeted/projectile/life_leech/prox_cast(var/list/targets, var/obj/item/projectile/spell_projectile/spell_holder)
	spell_holder.visible_message("<span class='danger'>\The [spell_holder] pops with a flash!</span>")
	var/mob/living/owner = spell_holder.shot_from
	for(var/mob/living/M in targets)
		M.adjustBruteLoss(leech_amount)
		M.vis_contents += new /obj/effect/overlay/redsparkles(M,10)
		M.vis_contents += new /obj/effect/overlay/red_downwards_lines(M,10)
		owner.adjustBruteLoss(-leech_amount)
		owner.vis_contents += new /obj/effect/overlay/greensparkles(owner,10)

/spell/targeted/projectile/life_leech/choose_prox_targets(mob/user = usr, var/atom/movable/spell_holder)
	var/list/targets = ..()
	for(var/mob/living/M in targets)
		if(M.stat == DEAD) //no dead targets
			targets.Remove(M)
	return targets

/spell/targeted/projectile/life_leech/is_valid_target(var/atom/target)
	if(!istype(target))
		return 0
	if(target == holder)
		return 0

	return (isturf(target) || isturf(target.loc))

//Our projectile.
/obj/item/projectile/spell_projectile/life_leech
	name = "Life Leech"
	icon_state = "fireball"
	animate_movement = 2
	linear_movement = 0

/obj/item/projectile/spell_projectile/life_leech/to_bump(var/atom/A)
	if(!isliving(A))
		forceMove(get_turf(A))
	return ..()