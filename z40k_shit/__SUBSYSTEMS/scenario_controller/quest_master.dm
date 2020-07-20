/*
	The actual job quests are in like, systems/jobquests
	The purpose of this is to store variables to reference to help the scenario master out.
	Cause, we need to keep track of who gets what job_quest anyways to properly move them
	without scanning all mobs on the map etc.
*/
/datum/job_quest/global_tracker
	var/mob/living/harlequin
	var/mob/living/tzeentch_champion
	var/mob/living/slaanesh_champion

