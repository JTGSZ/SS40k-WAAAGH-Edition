
//Collection of animations I can reuse for stuff.
//It all comes from goon2016, so credits to them.
//Most of its kinda broken tho.

//Fades something to greyscale
/proc/animate_fade_grayscale(var/atom/A, var/time=5)
	if (!istype(A) && !istype(A, /client))
		return
	A.color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1)
	animate(A, color=list(0.33, 0.33, 0.33, 0, 0.33, 0.33, 0.33, 0, 0.33, 0.33, 0.33, 0, 0, 0, 0, 1), time=time, easing=SINE_EASING)
	return

//Fades something out
/proc/animate_melt_pixel(var/atom/A)
	if (!istype(A))
		return
	//A.alpha = 200
	animate(A, pixel_y = 0, time = 50 - A.pixel_y, alpha = 175, easing = BOUNCE_EASING)
	animate(alpha = 0, easing = LINEAR_EASING)
	return

//Does a sideways fadeout
/proc/animate_explode_pixel(var/atom/A)
	if (!istype(A))
		return
	var/floatdegrees = rand(5, 20)
	var/side = 1
	side = pick(-1, 1)
	animate(A, pixel_x = rand(-64, 64), pixel_y = rand(-64, 64), transform = matrix(floatdegrees * (side == 1 ? 1:-1), MATRIX_ROTATE), time = 10, alpha = 0, easing = SINE_EASING)
	return

/proc/animate_revenant_shockwave(var/atom/A, var/loopnum = -1, floatspeed = 20, random_side = 1)
	if (!istype(A))
		return
	var/floatdegrees = rand(5, 20)
	var/side = 1
	if(random_side) side = pick(-1, 1)

	spawn(rand(1,10))
		animate(A, pixel_y = 8, transform = matrix(floatdegrees * (side == 1 ? 1:-1), MATRIX_ROTATE), time = floatspeed, loop = loopnum, easing = SINE_EASING)
		animate(pixel_y = 0, transform = matrix(floatdegrees * (side == 1 ? -1:1), MATRIX_ROTATE), time = floatspeed, loop = loopnum, easing = SINE_EASING)
	return

//Scales an object way up and covers screen
/proc/animate_glitchy_freakout(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix()
	var/looper = rand(3,5)
	while(looper > 0)
		looper--
		M.Scale(rand(1,4),rand(1,4))
		animate(A, transform = M, pixel_x = A.pixel_x + rand(-12,12), pixel_z = A.pixel_z + rand(-12,12), time = 3, loop = 1, easing = LINEAR_EASING)
		animate(transform = matrix(rand(-360,360), MATRIX_ROTATE), time = 3, loop = 1, easing = LINEAR_EASING)
		M.Scale(1,1)
		animate(transform = M, pixel_x = 0, pixel_z = 0, time = 1, loop = 1, easing = LINEAR_EASING)
		animate(transform = null, time = 1, loop = 1, easing = LINEAR_EASING)

//A fading leap upwards, Needs Scaling fixed
/proc/animate_fading_leap_up(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix()
	var/do_loops = 15
	while (do_loops > 0)
		do_loops--
		animate(A, transform = M, pixel_z = A.pixel_z + 12, alpha = A.alpha - 17, time = 1, loop = 1, easing = LINEAR_EASING)
		M.Scale(1.2,1.2)
		sleep(1)
	A.alpha = 0

//A fading leap downwards, Needs scaling fixed
/proc/animate_fading_leap_down(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix()
	var/do_loops = 15
	M.Scale(18,18)
	while (do_loops > 0)
		do_loops--
		animate(A, transform = M, pixel_z = A.pixel_z - 12, alpha = A.alpha + 17, time = 1, loop = 1, easing = LINEAR_EASING)
		M.Scale(0.8,0.8)
		sleep(1)
	animate(A, transform = M, pixel_z = 0, alpha = 255, time = 1, loop = 1, easing = LINEAR_EASING)

//Stretches something upwards and fades it out.
/proc/animate_teleport(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix(1, 3, MATRIX_SCALE)
	animate(A, transform = M, pixel_y = 32, time = 10, alpha = 50, easing = CIRCULAR_EASING)
	M.Scale(0,4)
	animate(transform = M, time = 5, color = "#1111ff", alpha = 0, easing = CIRCULAR_EASING)
	animate(transform = null, time = 5, color = "#ffffff", alpha = 255, pixel_y = 0, easing = ELASTIC_EASING)
	return

//Fades something out and keeps it invis
/proc/animate_teleport_wiz(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix(0, 4, MATRIX_SCALE)
	animate(A, color = "#ddddff", time = 20, alpha = 70, easing = LINEAR_EASING)
	animate(transform = M, pixel_y = 32, time = 20, color = "#2222ff", alpha = 0, easing = CIRCULAR_EASING)
	animate(time = 8, transform = M, alpha = 5) //Do nothing, essentially
	animate(transform = null, time = 5, color = "#ffffff", alpha = 255, pixel_y = 0, easing = ELASTIC_EASING)
	return

//Fades something between red and blue
/proc/animate_rainbow_glow_old(var/atom/A)
	if (!istype(A))
		return
	animate(A, color = "#FF0000", time = rand(5,10), loop = -1, easing = LINEAR_EASING)
	animate(color = "#00FF00", time = rand(5,10), loop = -1, easing = LINEAR_EASING)
	animate(color = "#0000FF", time = rand(5,10), loop = -1, easing = LINEAR_EASING)
	return

//Shockwave use on turfs
/proc/animate_shockwave(var/atom/A)
	if (!istype(A))
		return
	var/punchstr = rand(10, 20)
	var/original_y = A.pixel_y
	animate(A, transform = matrix(punchstr, MATRIX_ROTATE), pixel_y = 16, time = 2, color = "#eeeeee", easing = BOUNCE_EASING)
	animate(transform = matrix(-punchstr, MATRIX_ROTATE), pixel_y = original_y, time = 2, color = "#ffffff", easing = BOUNCE_EASING)
	animate(transform = null, time = 3, easing = BOUNCE_EASING)
	return

//Loops something southwards
/proc/animate_glitchy_fuckup1(var/atom/A)
	if (!istype(A))
		return

	animate(A, pixel_z = A.pixel_z + -128, time = 3, loop = -1, easing = LINEAR_EASING)
	animate(pixel_z = A.pixel_z + 128, time = 0, loop = -1, easing = LINEAR_EASING)

//Loops something northwest
/proc/animate_glitchy_fuckup2(var/atom/A)
	if (!istype(A))
		return

	animate(A, pixel_x = A.pixel_x + rand(-128,128), pixel_z = A.pixel_z + rand(-128,128), time = 2, loop = -1, easing = LINEAR_EASING)
	animate(pixel_x = 0, pixel_z = 0, time = 0, loop = -1, easing = LINEAR_EASING)

//Scales something from large to small rapidly
/proc/animate_glitchy_fuckup3(var/atom/A)
	if (!istype(A))
		return
	var/matrix/M = matrix()
	var/matrix/MD = matrix()
	var/list/scaley_numbers = list(0.25,0.5,1,1.5,2)
	M.Scale(pick(scaley_numbers),pick(scaley_numbers))
	animate(A, transform = M, time = 1, loop = -1, easing = LINEAR_EASING)
	animate(transform = MD, time = 1, loop = -1, easing = LINEAR_EASING)
