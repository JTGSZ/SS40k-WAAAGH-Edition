/*
	DYNAMIC EQUIPMENT DATUM
							*/
//Work in progress
//So forgive me if things aren't as optimized as they need to be.
//Things must first start to exist and function before we think about how to optimally route them.
//Love - JTGSZ (3/5/2020)

/datum/comvehicle/equipment
	var/obj/my_atom //Holder for what spawned our asses
	var/weapons_allowed = 5 //How many weapons we have can attach by default.
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.

/datum/comvehicle/equipment/New(var/obj/CV)
	..()
	if(istype(CV))
		my_atom = CV
/*
Proc call vars. - Attachment Master
 (1) master user	-	Must be a mob. Usually get_pilot()
 (2) master object	-	Must be source object... or at least a object.
 (3) attached equipment		-	Must be of the type. /obj/item/device/vehicle_equipment ...Unless you add all the vars.
 (4) attach or detach	-	Basically either TRUE or FALSE
*/
/datum/comvehicle/equipment/proc/make_it_end(var/massa_man, var/obj/complex_vehicle/massa_obj, var/obj/item/device/vehicle_equipment/bitch, var/slide_in)
	//Make room for the entry bitch.
	if(slide_in)
		bitch.my_atom = massa_obj //My bitches atom is the massa object.
		equipment_systems += bitch //We add bitch to our equipment list
		if(bitch.tied_action) //If bitch has a tied action.
			var/datum/action/complex_vehicle_equipment/dicks = new bitch.tied_action(massa_obj) //new abstract construct spawned into massa obj.

			spawn(1)
				dicks.id = bitch.id //The actions ID is now the objects ID, tying them together.
	
			if(massa_man) //If we have a massa man
				dicks.Grant(massa_man) //grant him our dicks.
		
		if(istype(bitch,/obj/item/device/vehicle_equipment/dozer_blade)) //Dozerblade
			massa_obj.dozer_blade = TRUE
	else //I'm pullin out.
		bitch.my_atom = null //you don't got no atom bitch.
		equipment_systems -= bitch //and you leavin our equipment_systems
		
		var/ocean_of_semen = locate(bitch.tied_action) in action_storage //I'll find yo action in our storage.
		if(ocean_of_semen) //And if you got it.
			action_storage -= ocean_of_semen //This ocean of semen is leaving me.
			var/datum/action/ARSE = ocean_of_semen
			if(massa_man)
				ARSE.Remove(massa_man) //And I'm removing your ass too.
		
		if(istype(bitch,/obj/item/device/vehicle_equipment/dozer_blade)) //Dozerblade
			massa_obj.dozer_blade = FALSE
		

/*
	VEHICLE EQUIPMENT PARENT
							*/
//Here mostly so we can append stuff fast during development
/obj/item/device/vehicle_equipment
	name = "equipment"
	var/tied_action //The action button tied to the object
	var/obj/my_atom //Basically the object we are attached to.
	var/id			//The ID we share with our action button if we have one.
	
//Our ID is tied to the action button ID. Theoretically theres a 1 in 10000 chance for a magic button.
/obj/item/device/vehicle_equipment/New()
	id = rand(1, 10000)

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return

/*
	VEHICLE EQUIPMENT WEAPONERY PARENT
										*/
//Parent of all weapon objects.
/obj/item/device/vehicle_equipment/weaponry
	name = "weapon parent"
	desc = "You shouldn't be seeing this"
	icon = 'z40k_shit/icons/complex_vehicle/vehicle_equipment.dmi'
	var/projectile_type //Type of Projectile
	var/fire_delay = 10 //Delay on when next action can be done.
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.
	var/weapon_online = FALSE //Is our weapon online or not, we are checked in the click loop.
	var/next_firetime = 0 //Basically Holds our cooldown
	var/list/fire_sound = list('z40k_shit/sounds/slugga_1.ogg') //Fire sound when we fire
	var/projectile_max = 45 //Max amount of projectiles we will spit out

/obj/item/device/vehicle_equipment/weaponry/New()
	..() //Gives us our ID

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/device/vehicle_equipment/weaponry/action(atom/target)
	return