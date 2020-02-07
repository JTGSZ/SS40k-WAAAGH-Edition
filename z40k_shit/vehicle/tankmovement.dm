
#define GROUNDTANK_MOVEDELAY_FAST 0.4
#define GROUNDTANK_MOVEDELAY_MEDIUM 1
#define GROUNDTANK_MOVEDELAY_SLOW 3
#define GROUNDTANK_MOVEDELAY_DEFAULT GROUNDTANK_MOVEDELAY_FAST

/obj/groundtank
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/movement_delay = GROUNDTANK_MOVEDELAY_DEFAULT //Speed of the vehicle decreases as this value increases. Anything above 6 is slow, 1 is fast and 0 is very fast


/obj/groundtank/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, glide_size_override = 0)
	var/oldloc = loc
	. = ..()
	if(Dir && (oldloc != NewLoc))
		loc.Entered(src, oldloc)

	/*	if(NORTH)
			step(src, pick(NORTHEAST, NORTHWEST))
		if(SOUTH)
			step(src, pick(SOUTHEAST, SOUTHWEST))
		if(EAST)
			step(src, pick(NORTHEAST, SOUTHEAST))
		if(WEST)
			step(src, pick(NORTHWEST, SOUTHWEST))
*/
/obj/groundtank/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != get_pilot()) //If user is not pilot return false
		return 0 //Stop hogging the wheel!
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false
		return 0
	var/moveship = 1
	if(battery && battery.charge >= ES.movement_charge && health)//The movement segment of this proc
		src.dir = direction

		if(inertia_dir == turn(direction, 180))
			inertia_dir = 0
			moveship = 0

		if(moveship)
			set_glide_size(DELAY2GLIDESIZE(movement_delay))
			Move(get_step(src,direction), direction) //How we move
			inertia_dir = direction
	else
		return 0
	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay

/obj/groundtank/proc/change_speed() //This delays each movement
	if(usr != get_pilot())
		return
	if(movement_delay == GROUNDTANK_MOVEDELAY_FAST)
		movement_delay = GROUNDTANK_MOVEDELAY_SLOW
		to_chat(usr, "<span class='notice'>Thrusters strength: low.</span>")
	else if(movement_delay == GROUNDTANK_MOVEDELAY_MEDIUM)
		movement_delay = GROUNDTANK_MOVEDELAY_FAST
		to_chat(usr, "<span class='notice'>Thrusters strength: high.</span>")
	else
		movement_delay = GROUNDTANK_MOVEDELAY_MEDIUM
		to_chat(usr, "<span class='notice'>Thrusters strength: medium.</span>")

#undef GROUNDTANK_MOVEDELAY_FAST
#undef GROUNDTANK_MOVEDELAY_MEDIUM
#undef GROUNDTANK_MOVEDELAY_SLOW
#undef GROUNDTANK_MOVEDELAY_DEFAULT
