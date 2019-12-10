/datum/job/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 65
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_eva)
	minimal_access = list(access_medical, access_morgue, access_surgery, access_virology)
	alt_titles = list("Emergency Physician", "Nurse", "Surgeon")
	outfit_datum = /datum/outfit/doctor

/datum/job/doctor/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/storage/belt/medical(H.back), slot_in_backpack)
