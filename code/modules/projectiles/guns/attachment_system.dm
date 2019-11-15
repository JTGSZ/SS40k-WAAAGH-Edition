//Within is the attachment system, mostly because all of the additional text was confusing me.

/*
	EXAMPLE LIST/LISTS FOR ATTACHMENT HANDLING
												*/
/obj/item/weapon/gun/energy/laser/lasgun
	var/list/attachments = list()

/*
	LIST OF EXAMPLE ATTACHMENTS
								*/

/obj/item/weapon/attachment
	var/SumATCHlimit = 1							
/obj/item/weapon/attachment/bayonet
/obj/item/weapon/attachment/bayonet/bayonet1
	name = "TestObject1"
/obj/item/weapon/attachment/bayonet/bayonet2
	name = "TestObject2"
/obj/item/weapon/attachment/bayonet/bayonet3
	name = "TestObject3"

/*
	EXAMPLE ATTACKBY
					*/

/obj/item/weapon/gun/energy/laser/lasgun/attackby(var/obj/item/A as obj, mob/user as mob) //Loading
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
		usr.put_in_hands(remove_acc) //We remove the accessory picked from contents
		var/obj/item/weapon/attachment/ATCH = remove_acc
		var/numberval = attachments["[ATCH.name]"]["Amount"]
		numberval--
		attachments["[ATCH.name]"] = list("Object" = remove_acc, "Amount" = numberval)
		return

/*
	THE GUN ATTACHMENT PROC, OCCURS ON ATTACKBY
												*/
/obj/item/weapon/gun/energy/laser/lasgun/proc/GunAttachment(var/obj/item/weapon/attachment/ATCH, var/mob/user)
	if(istype(ATCH, /obj/item/weapon/attachment)) //If it is the type of attachment or a child.
		if(user)
			if(user.drop_item(ATCH, src))
				to_chat(user, "<span class='notice'>You attach [ATCH.name] to \the [src].</span>")
			else
				return
		
		var/TotalATCHnumberval = 0
		var/ATCHname = ATCH.name

		var/numberval = attachments["[ATCHname]"]["Amount"]
		TotalATCHnumberval++
		var/ATCHlimit = ATCH.SumATCHlimit
		if(numberval == ATCHlimit)
			to_chat(user, "<span class='notice'>You have reached the limitations of how much of [ATCHname] this object can hold.</span>")
			return 0
		else
			attachments["[ATCHname]"] = list("Object" = ATCH, "Amount" = TotalATCHnumberval)
			ATCH.update_icon()
			update_icon()
			return 1

	return 0
