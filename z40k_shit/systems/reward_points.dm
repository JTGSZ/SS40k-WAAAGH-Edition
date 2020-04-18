/*
	Basically where we put the procs for the goodboy points.

TODO: As of 4/17/2020 -Love JTGSZ
	Design it lol
*/
var/list/potentials

/proc/LoadRewardpoints()
	potentials = json_decode(file2text("potentials.json"))

/proc/AddPoints(ckey, total_points)
	return