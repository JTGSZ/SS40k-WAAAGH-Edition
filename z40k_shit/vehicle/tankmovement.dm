
#define GROUNDTANK_MOVEDELAY_FAST 0.4
#define GROUNDTANK_MOVEDELAY_MEDIUM 1
#define GROUNDTANK_MOVEDELAY_SLOW 3
#define GROUNDTANK_MOVEDELAY_DEFAULT GROUNDTANK_MOVEDELAY_SLOW

/obj/groundtank
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/movement_delay = GROUNDTANK_MOVEDELAY_DEFAULT //Speed of the vehicle decreases as this value increases. Anything above 6 is slow, 1 is fast and 0 is very fast


/obj/groundtank/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, glide_size_override = 0)
	var/oldloc = loc
	. = ..()
	if(Dir && (oldloc != NewLoc))
		loc.Entered(src, oldloc)

/obj/groundtank
	var/velocity = 0

/obj/groundtank/process() // We are on ssobj dw


/obj/groundtank/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != get_pilot()) //If user is not pilot return false
		return 0 //Stop hogging the wheel!
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false. Delay
		return 0

	set_glide_size(DELAY2GLIDESIZE(movement_delay))
	switch(direction)
		if(NORTH)
			Move(get_step(src,src.dir), src.dir) //How we move
			if(velocity =< 70) //Limited to 70 forward velocity
				velocity++

		if(SOUTH)
			Move(get_step(src,turn(src.dir, -180)), src.dir)
			if(velocity >= -50) //Limited to negative 50 reverse velocity
				velocity--

		if(EAST)
			src.dir = turn(src.dir, 90) //Tank controls
		if(WEST)
			src.dir = turn(src.dir, -90) //Technically its reversed too


		//Move(get_step(src,direction), direction) //How we move
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
