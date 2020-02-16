/obj/complex_vehicle/complex_chassis
	name = "I'm just a parent"
	desc = "Please don't spawn me"

//Base vehicle
/obj/complex_vehicle/complex_chassis/leman_russ
	name = "Leman Russ"
	icon_state = "lemanruss"
	desc = "Its a LEMAN RUSS."
	mainturret = /obj/complex_vehicle/complex_turret/demolisher/

//Punisher
/obj/complex_vehicle/complex_chassis/leman_russ/punisher
	mainturret = /obj/complex_vehicle/complex_turret/punisher/

/obj/complex_vehicle/complex_turret/punisher
	name = "Punisher Turret"
	icon_state = "turret_punisher"
	var/obj/complex_vehicle/complex_turret/PUN

/obj/complex_vehicle/complex_turret/punisher/New()
	..()
	PUN = new /obj/item/device/vehicle_equipment/weaponry/punisher(src.loc)
	PUN.forceMove(src)
	ES.make_it_end(src, PUN, TRUE, get_pilot())

//Demolisher
/obj/complex_vehicle/complex_chassis/leman_russ/demolisher
	mainturret = /obj/complex_vehicle/complex_turret/demolisher

/obj/complex_vehicle/complex_turret/demolisher
	name = "Demolisher Turret"
	icon_state = "turret_demolisher"
	var/obj/complex_vehicle/complex_turret/DEMO

/obj/complex_vehicle/complex_turret/demolisher/New()
	..()
	DEMO = new /obj/item/device/vehicle_equipment/weaponry/demolisher(src.loc)
	DEMO.forceMove(src)
	ES.make_it_end(src, DEMO,TRUE,get_pilot())

//Battlecannon
/obj/complex_vehicle/complex_chassis/leman_russ/battlecannon
	mainturret = /obj/complex_vehicle/complex_turret/battlecannon

/obj/complex_vehicle/complex_turret/battlecannon
	name = "Battlecannon Turret"
	icon_state = "turret_battlecannon"
	var/obj/complex_vehicle/complex_turret/BATC

/obj/complex_vehicle/complex_turret/battlecannon/New()
	..()
	BATC = new /obj/item/device/vehicle_equipment/weaponry/battlecannon
	BATC.forceMove(src)
	ES.make_it_end(src,BATC,TRUE,get_pilot())
