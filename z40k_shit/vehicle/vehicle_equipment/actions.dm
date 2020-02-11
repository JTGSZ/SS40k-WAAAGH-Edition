//Tank base action
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
		W.fire_weapons()


//Turretbase
/datum/action/groundturret/fire_weapons
	name = "Fire weapons"
	button_icon_state = "weapon"

/datum/action/groundturret/fire_weapons/Trigger()
	..()
	var/obj/groundturret/S = target
	if(S.ES && S.ES.weapon_system)
		var/obj/item/device/vehicle_equipment/weaponry/W = S.ES.weapon_system
		W.fire_weapons()

////////////////////////////////////////////////////////////
/obj/item/device/vehicle_equipment/weaponry/proc/action(atom/target)
	return

/datum/action/groundturret/pilot/toggle_testweapon
	name = "Toggle Engine"
	button_icon_state = "engine_off"

/datum/action/groundturret/pilot/toggle_engine/Trigger()
	..()
	var/obj/groundtank/S = target
	//S.toggle_engine_yeah()
	//if(S.engine_toggle)
	//	button_icon_state = "engine_on"
	//else
	//	button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/groundturret/proc/toggle_engine_yeah()
	if(usr!=get_pilot())
		return

	//src.engine_toggle = !engine_toggle
	
	//to_chat(src.get_pilot(), "<span class='notice'>Engine [engine_toggle?"starting up":"shutting down"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
