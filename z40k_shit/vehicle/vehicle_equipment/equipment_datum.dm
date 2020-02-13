/datum/comvehicle/equipment
	var/obj/my_atom //Holder for what spawned our asses
	var/weapons_allowed = 5 //How many weapons we have can attach by default.
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.

	//Eh fuck this shit, we jus gonna ork kustom shoota this shit up.
	var/testgun = 0

/datum/comvehicle/equipment/New(var/obj/CV)
	..()
	if(istype(CV))
		my_atom = CV

/datum/comvehicle/equipment/proc/weapon_toggle(var/obj/item/device/vehicle_equipment/bitch, var/toggle_switch)
	for(bitch in equipment_systems)
		if(toggle_switch)
			if(!bitch.systems_online)
				bitch.systems_online = TRUE
				break
			else
				bitch.systems_online = FALSE
				break

//user, object, attach or detach
/datum/comvehicle/equipment/proc/make_it_end(var/obj/groundtank/massa_obj, var/obj/item/device/vehicle_equipment/bitch, var/slide_in, var/massa_man)
	to_chat(world, "equipment handler params are [massa_obj], [bitch], [slide_in], [massa_man]")

	to_chat(world, "bitch.tied_action is [bitch.tied_action]")

	if(slide_in)
		bitch.my_atom = massa_obj
		equipment_systems += bitch
		
		new bitch.tied_action(massa_obj)
		var/datum/action/ASS = bitch.tied_action
		if(massa_man)
			to_chat(world, "ASS is [ASS]")
			ASS.Grant(massa_man)
	else
		bitch.my_atom = null
		equipment_systems -= bitch
		
		var/ocean_of_semen = locate(bitch.tied_action) in action_storage
		to_chat(world, "ocean of semen has returned [ocean_of_semen]")
		if(ocean_of_semen)
			action_storage -= ocean_of_semen
			var/datum/action/ARSE = ocean_of_semen
			to_chat(world, "ARSE is [ARSE]")
			if(massa_man)
				ARSE.Remove(massa_man)

/obj/item/device/vehicle_equipment
	name = "equipment"
	var/tied_action //The action button tied to the object
	var/obj/my_atom //OH MY ATOM
	var/systems_online = FALSE //So we can check whether they are online or not.
	
/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.

/obj/item/device/vehicle_equipment/weaponry
	name = "pod weapon"
	desc = "You shouldn't be seeing this"
	icon = 'icons/pods/ship.dmi'
	icon_state = "blank"
	var/projectile_type
	var/fire_sound = 'z40k_shit/sounds/slugga_1.ogg'
	var/fire_delay = 10
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.

/obj/item/device/vehicle_equipment/weaponry/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.