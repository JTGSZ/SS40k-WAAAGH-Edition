

/obj/groundtank/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, glide_size_override = 0)
	var/oldloc = loc
	. = ..()
	if(Dir && (oldloc != NewLoc))
		loc.Entered(src, oldloc)

/obj/groundtank
	var/acceleration = 500 //Scale of 0 to 1000
	var/engine_cooldown = FALSE //To stop people from starting it on and off rapidly
	var/enginemaster_sleep_time = 1 //How long the enginemaster sleeps at the end of its loop.
	var/movement_delay = 3 //Speed of turning
	var/movement_warning_oncd = FALSE

/obj/groundtank/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != get_pilot()) //If user is not pilot return false
		return 0 //Stop hogging the wheel!
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false. Delay
		return 0
	if(!engine_toggle)
		if(!movement_warning_oncd)
			to_chat(user, "<span class='notice'> You mash the pedals and move the controls in the unpowered [src].</span>")
			movement_warning_oncd = TRUE
			spawn(20)
				movement_warning_oncd = FALSE
			return 0
		else
			return 0

	set_glide_size(DELAY2GLIDESIZE(movement_delay))
	switch(direction)
		if(NORTH)
			//Move(get_step(src,src.dir), src.dir) //How we move
			if(acceleration <= 1000) //var to max
				acceleration += 25

		if(SOUTH)
			//Move(get_step(src,turn(src.dir, -180)), src.dir)
			if(acceleration >= 0) //var to min
				acceleration -= 25
	
		if(EAST)
			src.dir = turn(src.dir, 90) //Tank controls

		if(WEST)
			src.dir = turn(src.dir, -90) //Technically its reversed too

	
	to_chat(user,"We are currently at [acceleration] acceleration")
	to_chat(user,"And we are currently at [movement_delay] movement_delay")

	accelerationscale()

		//Move(get_step(src,direction), direction) //How we move
	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay

//Basically the plan is that while they have the switch on we will run this loop.
//This loop will basically check to make sure theres someone in the tank.
//We will time based on world time between each action.

/obj/groundtank/proc/trigger_engine()
	while(engine_toggle)
		enginemove()
		sleep(enginemaster_sleep_time)

/obj/groundtank/proc/enginemove()
	if(acceleration >= 400) //If we are moving forward
		Move(get_step(src,src.dir), src.dir)
		acceleration -= 5
	if(acceleration <= 300) //If we are in reverse
		Move(get_step(src,turn(src.dir, -180)), src.dir)
		acceleration += 5

/obj/groundtank/proc/accelerationscale()
	switch(acceleration)
		if(0 to 100) //Max reverse
			enginemaster_sleep_time = 3 //Delay between each movement loop
		if(100 to 200) //Mid Reverse
			enginemaster_sleep_time = 6
			movement_delay = 3
		if(200 to 300) //Low Reverse
			movement_delay = 4
			enginemaster_sleep_time = 10
		if(300 to 400) //Neutral
			return
		if(400 to 500) //Min Forward
			movement_delay = 4
			enginemaster_sleep_time = 12
		if(500 to 600) //Med Forward
			movement_delay = 3
			enginemaster_sleep_time = 6
		if(600 to 700) //Med-High Forward
			enginemaster_sleep_time = 4
		if(700 to 900) //Max Forward
			enginemaster_sleep_time = 1
			movement_delay = 2
		if(900 to 1000)
			enginemaster_sleep_time = 1
			movement_delay = 1

/datum/action/groundtank/pilot/toggle_engine
	name = "Toggle Engine"
	button_icon_state = "engine_off"

/datum/action/groundtank/pilot/toggle_engine/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_engine_yeah()
	if(S.engine_toggle)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/groundtank/proc/toggle_engine_yeah()
	if(usr!=get_pilot())
		return
	
	src.engine_toggle = !engine_toggle
	
	if(engine_toggle) //If Engine toggle is true, and we are not on cooldown
		if(!engine_cooldown) //if engine cooldown is false
			to_chat(src.get_pilot(), "Engine Cooldown is now [engine_cooldown]")
			engine_cooldown = TRUE //Engine cooldown becomes true
			spawn(10) //we spawn to give everything time to finish so we don't lock them up
				trigger_engine() //Then we trigger engine which has a while loop (that would lock them up)
				to_chat(src.get_pilot(), "Engine Triggered")
			spawn(30)
				engine_cooldown = FALSE
				to_chat(src.get_pilot(), "Engine Cooldown is now [engine_cooldown]")
	else
		acceleration = 500 //We set acceleration back to neutral if the engine is turned off.
	
	to_chat(src.get_pilot(), "<span class='notice'>Engine [engine_toggle?"starting up":"shutting down"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)

