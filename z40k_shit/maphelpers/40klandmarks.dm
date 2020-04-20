
/obj/effect/landmark/start
	name = "start"
	icon = 'z40k_shit/icons/40klandmarks.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/effect/landmark/start/New()
	..()
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

/obj/effect/landmark/start/orkmek
	name = "Mek"
	icon_state = "ork_mek"
	landmark_override = TRUE

/obj/effect/landmark/start/orktankbusta
	name = "Ork Tankbusta"
	icon_state = "ork_tankbusta"
	landmark_override = TRUE

//Civilians
/obj/effect/landmark/start/assistant
	name = "Assistant"
	icon_state = "civ_assistant"
	landmark_override = TRUE

/obj/effect/landmark/start/bartender
	name = "Bartender"
	icon_state = "civ_bartender"
	landmark_override = TRUE

/obj/effect/landmark/start/clown
	name = "Clown"
	icon_state = "civ_clown"
	landmark_override = TRUE

/obj/effect/landmark/start/mime
	name = "Mime"
	icon_state = "civ_mime"
	landmark_override = TRUE

/obj/effect/landmark/start/chef
	name = "Chef"
	icon_state = "civ_chef"
	landmark_override = TRUE

/obj/effect/landmark/start/doctor
	name = "Medical Doctor"
	icon_state = "civ_doctor"
	landmark_override = TRUE

/obj/effect/landmark/start/janitor
	name = "Janitor"
	icon_state = "civ_janitor"
	landmark_override = TRUE
