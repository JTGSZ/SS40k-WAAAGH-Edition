/*
	Within is just containers for job quests
											*/

/datum/job_quest
	var/title = "You Got Nothin"
	var/current_stage = 0 //basically a number because we are a switch statement.
	var/mob/living/our_protagonist = null //A link to the master aka the mob we are attached to for reference purposes.

/datum/job_quest/proc/main_body()
	return
