//Within is the attachment system, mostly because all of the additional text was confusing me.

/*
	EXAMPLE LIST/LISTS FOR ATTACHMENT HANDLING
												*/
/obj/item/weapon/gun/energy/laser/lasgun
	var/list/attachments = list()

//Attachment flags are in the EARLY LOAD folder
/*
			ATTACHMENTS
								*/

/*
	ATTACHMENTS
				*/
/obj/item/weapon/attachment
	name = "the great ancestor"
	desc = "If you see this object, say something on discord."
	icon_state = "bayonet"
	item_state = "bayonet"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	siemens_coefficient = 1
	sharpness = 1.5
	w_class = W_CLASS_SMALL
	starting_materials = list(MAT_IRON = 12000)
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = Tc_MATERIALS + "=1"
	sharpness_flags = SHARP_TIP | SHARP_BLADE
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/fire_sound //Holder for firesound path on attachments, mostly for the flag.
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	
	//---------ATTACHMENT CONTROL VARIABLES---------//
	var/atch_total_limit = 0 //0 is infinity, basically how many of an attachment you can have.
	var/atch_effect_flags = 0 //FLAGS go here to determine how the effects system handles something.
	var/atch_possible = TRUE //Can we even attach this to the other object?
	var/atch_verb //What we will attach a verb path to for transfer back and forth.

/obj/item/weapon/attachment/bayonet //Bayonet
	name = "bayonet"
	desc = "A bayonet made to be attached to a lasgun."
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "bayonet"
	item_state = "bayonet"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	force = 10.0
	throwforce = 10.0
	throw_speed = 3
	throw_range = 7
	
	//Attachment variables
	atch_total_limit = 1 //How many of these we can have on one gun.
	atch_effect_flags = MELEE_DMG | MELEE_SOUNDSWAP

/obj/item/weapon/attachment/bayonet/attackby(obj/item/weapon/W, mob/user)
	..()
	if(user.is_in_modules(src))
		return
	if(iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(1, user))
			to_chat(user, "You slice the handle off of \the [src].")
			playsound(user, 'sound/items/Welder.ogg', 50, 1)
			if(src.loc == user)
				user.drop_item(src, force_drop = 1)
				var/obj/item/weapon/metal_blade/I = new (get_turf(user))
				user.put_in_hands(I)
			else
				new /obj/item/weapon/metal_blade(get_turf(src.loc))
			qdel(src)
			return

/*
	DEBUGGING ATTACKBY - Used for debugging of course.
						*/

///obj/item/weapon/gun/energy/laser/lasgun/attackby(var/obj/item/A, var/mob/user) //Loading
//	if(istype(A, /obj/item/weapon/attachment))
//		var/obj/item/weapon/attachment/ATCH = A
//		GunAttachment(ATCH, user)

/*
	THE VERB TO HANDLE REMOVAL OF ATTACHMENTS
												*/

/obj/item/weapon/gun/energy/laser/lasgun/verb/remove_attachment() 
	set name = "Remove Attachment"
	set category = "Object"
	set desc = "Remove an attachment from your gun."

	var/mob/M = usr
	if(!M.mind)
		return

	if(!attachments.len)
		to_chat(M, "<span class='notice'> [src] appears to be devoid of anything attached to it.</span>")
		return
	else if(attachments.len)
		var/remove_acc = input(M,"Which attachment do you want to remove?", "", "Cancel") as null|anything in attachments
		if(remove_acc != "Cancel")
			var/obj/item/weapon/attachment/ATCH = remove_acc
			M.put_in_hands(ATCH) //We remove the accessory picked from contents
			attachments -= ATCH
			AttachmentEffect(ATCH,M,0,0) //We are removing object, user/M did it, it is false, no special handling
			return

/*
	THE GUN ATTACHMENT PROC, OCCURS ON ATTACKBY
												*/
/obj/item/weapon/gun/energy/laser/lasgun/proc/GunAttachment(var/obj/item/weapon/attachment/ATCH, var/mob/user)
	var/obj/item/weapon/attachment/A = ATCH
	var/iteration = 0
	
	if(!ATCH.atch_possible) //Can we attach this object to the other object?
		to_chat(user, "<span class = 'notice'> You can't figure out how to attach this to [src].</span>")
		return
	
	if(istype(ATCH, /obj/item/weapon/attachment)) //If it is the type of attachment or a child.
		if(!ATCH.atch_total_limit == 0) //If total limit is not 0
			for(A in attachments)
				iteration++
				if(iteration >= ATCH.atch_total_limit)
					to_chat(user, "<span class = 'notice'> You've reached the limitations of how many [ATCH.name]s you can attach to \the [src].</span>")
					return
		if(user)
			if(user.drop_item(ATCH, src))
				to_chat(user, "<span class='notice'>You attach [ATCH.name] to \the [src].</span>")
				attachments += ATCH
				AttachmentEffect(ATCH,user,1,0) //We are adding an object, user did it, it is true, no special handling.
				ATCH.update_icon()
				update_icon()
			else
				return


/*
	EFFECTS HANDLER
						*/
//How I should handle it..
//One thing of note is that we will always enter and always exit if attachment is occurring.
/obj/item/weapon/gun/energy/laser/lasgun/proc/AttachmentEffect(var/obj/item/weapon/attachment/ATCH, var/mob/user, var/onORoff, var/specialhandler)

	if(specialhandler) //If we have special handling (Which means I intend to handle it on the object)
		return //We just return
	
	if(onORoff) //If we are going on
		if(ATCH.atch_effect_flags & MELEE_DMG) //We add force on from attachment
			src.force += ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Swap melee noises
			src.hitsound = ATCH.hitsound
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Swap gunfire noises
			src.fire_sound = ATCH.fire_sound
		if(ATCH.atch_effect_flags & VERB_OBJ) //Add the verb to the source object
			src.verbs += ATCH.atch_verb

	if(!onORoff) //If we are going off
		if(ATCH.atch_effect_flags & MELEE_DMG) //We remove force from attachment
			src.force -= ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Set hitsound to initial sound.
			src.hitsound = initial(src.hitsound)
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Set fire_sound to initial sound.
			src.fire_sound = initial(src.fire_sound)
		if(ATCH.atch_effect_flags & VERB_OBJ) //Remove verb from source object.
			src.verbs -= ATCH.atch_verb