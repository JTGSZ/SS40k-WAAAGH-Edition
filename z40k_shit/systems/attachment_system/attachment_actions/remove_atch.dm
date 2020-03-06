/obj/item/weapon/gun/energy/complexweapon/lasgun/verb/remove_attachment() 
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
			