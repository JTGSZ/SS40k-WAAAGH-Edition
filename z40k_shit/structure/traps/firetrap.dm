//Fire shooting pipe
/obj/structure/traps/fire_trap
	name = "mysterious pipe"
	desc = "A pipe looking out from a wall."
	icon_state = "pipe"

	anchored = 1
	density = 0

	var/fire_projectile = /obj/item/projectile/fire_breath
	var/fire_sound = 'z40k_shit/sounds/flamer.ogg'

	var/last_fired
	var/fire_cooldown = 2 SECONDS
	currently_active = TRUE
	
//Fire blasts from this trap fire in a straight line, without expanding at the end
/obj/structure/traps/fire_trap/no_spread
	fire_projectile = /obj/item/projectile/fire_breath/straight

/obj/structure/traps/fire_trap/no_spread/two_second
	fire_cooldown = 3 SECONDS

/obj/structure/traps/fire_trap/New()
	..()
	last_fired = world.time
	processing_objects.Add(src)

/obj/structure/traps/fire_trap/Destroy()
	processing_objects.Remove(src)
	..()

/obj/structure/traps/fire_trap/process()
	if(currently_active)
		if(world.time > last_fired + fire_cooldown)
			last_fired = world.time
			turn_my_ass_over()

/obj/structure/traps/fire_trap/turn_my_ass_over()
	var/obj/item/projectile/A = new fire_projectile(get_turf(src))

	if(!A)
		return 0

	playsound(src, fire_sound, 50, 1)
	var/turf/T = get_step(src, get_turf(src))
	var/turf/U = get_step(src, dir) //Turf in front of us
	A.original = U
	A.target = U
	A.current = T
	A.starting = T
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	spawn()
		A.OnFired()
		A.process()

/obj/structure/traps/fire_trap/synced
	scenario_controller_timing = TRUE
	scenario_controller_id = 1
