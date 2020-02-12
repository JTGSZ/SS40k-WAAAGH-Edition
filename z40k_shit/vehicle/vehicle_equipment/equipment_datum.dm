/datum/comvehicle/equipment
	var/obj/my_atom //Holder for what spawned our asses
	var/weapons_allowed = 5 //How many weapons we have can attach by default.
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.

	//Eh fuck this shit, we jus gonna ork kustom shoota this shit up.
	var/ballistics = 0
	var/missiles = 0
	var/explosives = 0

/datum/comvehicle/equipment/New(var/obj/CV)
	..()
	if(istype(CV))
		my_atom = CV

/datum/comvehicle/equipment/proc/make_it_end(var/massa, var/obj/item/device/vehicle_equipment/bitch, var/slide_in)
	if(slide_in)
		bitch.my_atom = massa
		equipment_systems += bitch
		
		if(bitch.tied_action)
			action_storage += bitch.tied_action
	else
		bitch.my_atom = null
		equipment_systems -= bitch
		
		if(bitch.tied_action)
			action_storage -= bitch.tied_action
		

/obj/item/device/vehicle_equipment
	name = "equipment"
	var/tied_action //The action button tied to the object
	var/obj/my_atom //OH MY ATOM
	var/systems_online = FALSE //So we can check whether they are online or not.
	
/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.