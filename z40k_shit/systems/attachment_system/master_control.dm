
//Named Master Control cause it sounds badass lol
/*
	DATUM ATTACHMENT SYSTEM
							*/
//Revision 3/6/2020 - JTGSZ

//Within is the attachment system, mostly because all of the additional text was confusing me.
//See: tactical_light.dm

/datum/attachment_system
	var/obj/my_atom //Holder for what spawned our asses
	var/list/attachments = list() //Container of all the attachments we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.

/datum/attachment_system/New(var/obj/CHOSEN_ONE)//Basically new is used as a standard proc call too
	..()
	if(istype(CHOSEN_ONE)) //Our chosen one is the place we are spawned into
		my_atom = CHOSEN_ONE

/*
	EFFECTS HANDLER
						*/
//How I should handle it..
//One thing of note is that we will always enter and always exit if attachment is occurring.
/obj/item/weapon/gun/energy/complexweapon/lasgun/proc/AttachmentEffect(var/obj/item/weapon/attachment/ATCH, var/mob/user, var/onORoff, var/specialhandler)

	if(specialhandler) //If we have special handling (Which means I intend to handle it on the object)
		return //We just return
	
	if(onORoff) //If we are going on
		if(ATCH.atch_effect_flags & MELEE_DMG) //We add force on from attachment
			src.force += ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Swap melee noises
			src.hitsound = ATCH.hitsound
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Swap gunfire noises
			src.fire_sound = ATCH.fire_sound
		if(ATCH.atch_effect_flags & TOGGLE_ACTION)  //Add the action to the source object
			//var/datum/action/item_action/toggle_taclight/makelight = new /datum/action/item_action/toggle_taclight(src)
			src.actions_types |= ATCH.tied_action

	if(!onORoff) //If we are going off
		if(ATCH.atch_effect_flags & MELEE_DMG) //We remove force from attachment
			src.force -= ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Set hitsound to initial sound.
			src.hitsound = initial(src.hitsound)
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Set fire_sound to initial sound.
			src.fire_sound = initial(src.fire_sound)
		if(ATCH.atch_effect_flags & TOGGLE_ACTION) //Remove action from source object.
			src.actions_types.Remove(ATCH.tied_action)