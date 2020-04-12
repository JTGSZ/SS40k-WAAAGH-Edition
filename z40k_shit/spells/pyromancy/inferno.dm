/spell/targeted/projectile/inferno
	name = "Inferno"
	desc = "Witchfire - Shoots out a gout of flames ."
	user_type = USER_TYPE_PSYKER
	specialization = SSPYROMANCY

	proj_type = /obj/item/projectile/fire_breath
	invocation_type = SpI_NONE
	school = "evocation"

	spell_flags = WAIT_FOR_CLICK
	spell_aspect_flags = SPELL_FIRE

	var/pressure = 0 //Basically controls the spread //455 is normal they add 150 to it per level up to 5
	var/temperature = 0 //Controls the damage + heat. normally 488.15, 1643.15 is instant death
	var/fire_duration = 0

	hud_state = "inferno"

/spell/targeted/projectile/inferno/spawn_projectile(var/location, var/direction)
	
	return new proj_type(location,direction,P = pressure, T = temperature, F_Dur = fire_duration)

/spell/targeted/projectile/inferno/cast(list/targets, mob/user = usr)
	var/mob/living/psyker = user

	pressure = 500 + (psyker.attribute_sensitivity/2)
	temperature = 500 + (psyker.attribute_sensitivity/2)
	fire_duration = psyker.attribute_willpower
	..()
