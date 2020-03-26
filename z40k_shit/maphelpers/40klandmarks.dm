
/obj/effect/landmark/start
	name = "start"
	icon = 'z40k_shit/icons/40klandmarks.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/start/New()
	..()
	tag = "start*[name]"
	invisibility = 101

	return 1

//Observer Start
/obj/effect/landmark/observer
	name = "Observer-Start"

/obj/effect/landmark/latejoin
	name = "JoinLate"
	//Place where latejoins end up

/obj/effect/landmark/newplayerstart //Basically spawnbox, mobs load in here and move to other locs
	name = "start"					//Also handles the lobby screen area

//Imperial Guard
/obj/effect/landmark/start/general
	name = "General"
	icon_state = "general"
	landmark_override = TRUE

/obj/effect/landmark/start/commissar
	name = "Commissar"
	icon_state = "commissar"
	landmark_override = TRUE

/obj/effect/landmark/start/inquisitor
	name = "Inquisitor"
	icon_state = "inquisitor"
	landmark_override = TRUE

/obj/effect/landmark/start/preacher
	name = "Preacher"
	icon_state = "preacher"
	landmark_override = TRUE

/obj/effect/landmark/start/IG_Cadian_Sergeant
	name = "Sergeant"
	icon_state = "cadian_trooper_sgt"
	landmark_override = TRUE

/obj/effect/landmark/start/IG_Cadian_Weapon_Specialist
	name = "Weapon Specialist"
	icon_state = "cadian_specialist"
	landmark_override = TRUE

/obj/effect/landmark/start/IG_Cadian_Trooper
	name = "Trooper"
	icon_state = "cadian_trooper"
	landmark_override = TRUE

/obj/effect/landmark/start/primaris_psyker
	name = "Primaris Psyker"
	icon_state = "primaris_psyker"
	landmark_override = TRUE

//Orks
/obj/effect/landmark/start/basicOrk
	name = "Slugga Boy"
	icon_state = "basic_ork"
	landmark_override = TRUE

/obj/effect/landmark/start/orknob
	name = "Ork Nob"
	icon_state = "ork_nob"
	landmark_override = TRUE

/obj/effect/landmark/start/orkboss
	name = "Ork Warboss"
	icon_state = "ork_warboss"
	landmark_override = TRUE
	