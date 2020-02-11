/*/comvehicle base action
/datum/action/groundtank/fire_weapons
	name = "Fire weapons"
	button_icon_state = "weapon"

/datum/action/groundtank/fire_weapons/Trigger()
	..()
	var/obj/groundtank/S = target
	if(S.ES && S.ES.weapon_system)
		var/obj/item/device/vehicle_equipment/weaponry/W = S.ES.weapon_system
		var/list/passengers = S.get_passengers()
		if(passengers.Find(owner) && !S.passenger_fire)
			to_chat(owner, "<span class = 'warning'>Passenger gunner system disabled.</span>")
			return
//		W.fire_weapons()


//Turret base action
/datum/action/groundturret/fire_weapons
	name = "Fire weapons"
	button_icon_state = "weapon"

/datum/action/groundturret/fire_weapons/Trigger()
	..()
	var/obj/groundturret/S = target
	if(S.ES && S.ES.weapon_system)
		var/obj/item/device/vehicle_equipment/weaponry/W = S.ES.weapon_system
//		W.fire_weapons()*/

////////////////////////////////////////////////////////////

