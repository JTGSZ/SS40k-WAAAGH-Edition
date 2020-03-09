
//Named Master Control cause it sounds badass lol
/*
	DATUM ATTACHMENT SYSTEM
							*/
//Revision 3/6/2020 - JTGSZ

//Within is the attachment system, mostly because all of the additional text was confusing me.
//See: tactical_light.dm
/obj/item/weapon
	var/currently_zoomed = FALSE

/obj/item/weapon/New()
	ATCHSYS = new(src)
	..()

/obj/item/weapon/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W,/obj/item/weapon/attachment))
		ATCHSYS.attachment_handler(W,TRUE,user)

/datum/attachment_system
	var/obj/item/weapon/gun/my_atom //Holder for what spawned our asses
	var/list/attachments = list() //Container of all the attachments we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.
	var/initial_meleesound
	var/initial_firesound

/datum/attachment_system/New(var/obj/CHOSEN_ONE)//Basically new is used as a standard proc call too
	..()
	if(istype(CHOSEN_ONE)) //Our chosen one is the place we are spawned into
		my_atom = CHOSEN_ONE

	var/RAGH = new /datum/action/item_action/warhams/attachment/remove_atch(my_atom)
	my_atom.actions_types += RAGH

/datum/attachment_system/proc/attachment_handler(var/obj/item/weapon/attachment/ATCH, var/going_in, var/mob/user)

	if(going_in)
		attachments += ATCH
		if(ATCH.tied_action)
			action_storage += ATCH.tied_action
			new ATCH.tied_action(my_atom)
		ATCH.my_atom = my_atom


		if(ATCH.atch_effect_flags & MELEE_DMG) //We add force on from attachment
			my_atom.force += ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Swap melee noises
			initial_meleesound = my_atom.hitsound
			my_atom.hitsound = ATCH.hitsound
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Swap gunfire noises
			initial_firesound = my_atom.fire_sound
			my_atom.fire_sound = ATCH.fire_sound
		if(ATCH.atch_effect_flags & TOGGLE_ACTION)  //Add the action to the source object
			my_atom.actions_types |= ATCH.tied_action

	else //The inverse of going in, which is !going_in, or technically null

		if(ATCH.tied_action)
			action_storage -= ATCH.tied_action
			for(var/datum/action/A in my_atom.actions)
				if(istype(A, ATCH.tied_action))
					qdel(A)
		
		ATCH.my_atom = null

		if(ATCH.atch_effect_flags & MELEE_DMG) //We remove force from attachment
			my_atom.force -= ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Set hitsound to initial sound.
			my_atom.hitsound = initial_meleesound
			initial_meleesound = null
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Set fire_sound to initial sound.
			my_atom.fire_sound = initial_firesound
			initial_firesound = null
		if(ATCH.atch_effect_flags & TOGGLE_ACTION) //Remove action from source object.
			my_atom.actions_types.Remove(ATCH.tied_action)



