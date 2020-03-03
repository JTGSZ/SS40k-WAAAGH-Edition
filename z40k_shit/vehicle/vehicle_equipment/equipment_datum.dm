/datum/comvehicle/equipment
	var/obj/my_atom //Holder for what spawned our asses
	var/weapons_allowed = 5 //How many weapons we have can attach by default.
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.

/datum/comvehicle/equipment/New(var/obj/CV)
	..()
	if(istype(CV))
		my_atom = CV

//user, object, attach or detach
/datum/comvehicle/equipment/proc/make_it_end(var/obj/complex_vehicle/massa_obj, var/obj/item/device/vehicle_equipment/bitch, var/slide_in, var/massa_man)
	if(slide_in)
		bitch.my_atom = massa_obj
		equipment_systems += bitch
		if(bitch.tied_action)
			var/datum/action/complex_vehicle_equipment/dicks = new bitch.tied_action(massa_obj)

			spawn(1)
				dicks.id = bitch.id //The actions ID is now the objects ID, tying them together.
	
			if(massa_man)
				dicks.Grant(massa_man)
		
		if(istype(bitch,/obj/item/device/vehicle_equipment/dozer_blade))
			massa_obj.dozer_blade = TRUE
		
		update_icon()
	
	else
		bitch.my_atom = null
		equipment_systems -= bitch
		
		var/ocean_of_semen = locate(bitch.tied_action) in action_storage
		if(ocean_of_semen)
			action_storage -= ocean_of_semen
			var/datum/action/ARSE = ocean_of_semen
			if(massa_man)
				ARSE.Remove(massa_man)
		
		if(istype(bitch,/obj/item/device/vehicle_equipment/dozer_blade))
			massa_obj.dozer_blade = FALSE
		
		update_icon()

/obj/item/device/vehicle_equipment
	name = "equipment"
	var/tied_action //The action button tied to the object
	var/obj/my_atom //OH MY ATOM
	var/id
	
/obj/item/device/vehicle_equipment/New()
	id = rand(1, 10000)

/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.

/obj/item/device/vehicle_equipment/weaponry
	name = "weapon parent"
	desc = "You shouldn't be seeing this"
	icon = 'z40k_shit/icons/complex_vehicle/vehicle_equipment.dmi'
	var/projectile_type
	var/fire_delay = 10 //Delay on when next action can be done.
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.
	var/weapon_online = FALSE
	var/next_firetime = 0 //Basically Holds our cooldown
	var/list/fire_sound = list('z40k_shit/sounds/slugga_1.ogg')
	var/projectile_max = 45

/obj/item/device/vehicle_equipment/weaponry/New()
	..()

/obj/item/device/vehicle_equipment/weaponry/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.