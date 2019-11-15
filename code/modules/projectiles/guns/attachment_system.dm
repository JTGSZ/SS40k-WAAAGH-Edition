//Within is the attachment system, mostly because all of the additional text was confusing me.

/*
	EXAMPLE LIST/LISTS FOR ATTACHMENT HANDLING
												*/
/obj/item/weapon/gun/energy/laser/lasgun
	var/list/attachments = list()

/*
			ATTACHMENTS
								*/

/*
	ATTACHMENTS
				*/
/obj/item/weapon/attachment
	var/total_limit = 0

/obj/item/weapon/attachment/bayonet //Bayonet
	name = "bayonet"
	desc = "A bayonet made to be attached to a lasgun."
	icon = 'icons/obj/IGstuff/IGequipment.dmi'
	icon_state = "bayonet"
	item_state = "bayonet"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/IGequipment_left.dmi', "right_hand" = 'icons/mob/in-hand/right/IGequipment_right.dmi')
	siemens_coefficient = 1
	sharpness = 1.5
	force = 10.0
	throwforce = 10.0
	throw_speed = 3
	throw_range = 7
	total_limit = 1 //How many of these we can have on one gun.
	w_class = W_CLASS_SMALL
	starting_materials = list(MAT_IRON = 12000)
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = Tc_MATERIALS + "=1"
	sharpness_flags = SHARP_TIP | SHARP_BLADE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")

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
	EXAMPLE ATTACKBY
					*/

/obj/item/weapon/gun/energy/laser/lasgun/attackby(var/obj/item/A, var/mob/user) //Loading
	if(istype(A, /obj/item/weapon/attachment))
		var/obj/item/weapon/attachment/ATCH = A
		GunAttachment(ATCH, user)

/*
	THE VERB TO HANDLE REMOVAL OF ATTACHMENTS
												*/

/obj/item/weapon/gun/energy/laser/lasgun/verb/remove_attachment()
	set name = "Remove Attachment"
	set category = "Object"
	set desc = "Remove an attachment from your gun."

	var/mob/M = usr
	if(!M.mind)
		return 0

	var/remove_acc = input(usr,"Which attachment do you want to remove?", "", "Cancel") as null|anything in attachments
	if(remove_acc != "Cancel")
		var/obj/item/weapon/attachment/ATCH = remove_acc
		usr.put_in_hands(ATCH) //We remove the accessory picked from contents
		attachments -= ATCH
		return

/*
	THE GUN ATTACHMENT PROC, OCCURS ON ATTACKBY
												*/
/obj/item/weapon/gun/energy/laser/lasgun/proc/GunAttachment(var/obj/item/weapon/attachment/ATCH, var/mob/user)
	var/obj/item/weapon/attachment/A = ATCH
	var/iteration = 0
	if(istype(ATCH, /obj/item/weapon/attachment)) //If it is the type of attachment or a child.
		if(ATCH.total_limit) //If total limit is not 0
			for(A in attachments)
				iteration++
				if(iteration >= ATCH.total_limit)
					to_chat(user, "<span class = 'notice'> You've reached the limitations of how many [ATCH.name]s you can attach to \the [src].</span>")
					return
		if(user)
			if(user.drop_item(ATCH, src))
				to_chat(user, "<span class='notice'>You attach [ATCH.name] to \the [src].</span>")
				attachments += ATCH
				ATCH.update_icon()
				update_icon()
			else
				return

