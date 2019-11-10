/datum/job/commissar
	title = "Commissar"
	flag = COMMISSAR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Regiment General"
	selection_color = "#ffdddd"
	req_admin_notify = 1
	access = list()
	minimal_access = list()
	minimal_player_age = 30

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/hos

/datum/job/commissar/reject_new_slots()
	if(security_level == SEC_LEVEL_RED)
		return FALSE
	else
		return "Red Alert"


/datum/job/IG_Trooper_Sergeant //This will be IG sergeant
	title = "Sergeant"
	flag = WARDEN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/warden

/datum/job/inquisitor //This will be inquisitor
	title = "Inquisitor"
	flag = INQUISITOR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Emperor"
	selection_color = "#ffeeee"
	access = list()
	minimal_access = list()
	alt_titles = list("Forensic Technician","Gumshoe")
	minimal_player_age = 7
	outfit_datum = /datum/outfit/detective

/datum/job/IG_trooper //This will be converted to the basic guardsman.
	title = "Trooper"
	flag = IGTROOPER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 50
	supervisors = "Commissar and your Platoon Sergeant."
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/security
	access = list()
	minimal_access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/officer

/datum/job/IG_trooper/get_total_positions()
	. = ..()

	var/datum/job/assistant = job_master.GetJob("Assistant")
	if(assistant.current_positions > 5)
		. = clamp(. + assistant.current_positions - 5, 0, 99)
