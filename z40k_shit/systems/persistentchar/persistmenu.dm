/datum/interactive_persistence/proc/PersistMenu(mob/user)
	if(!user || !user.client)
		return

	var/dat = "<html><link href='./common.css' rel='stylesheet' type='text/css'><body>"

	if(IsGuestKey(user.key))
		dat += "Please create an account to access the persistence menu."
	else

		dat += "<b>Your Potential: [potential].</b><br>"

	//user << browse(dat, "window=preferences;size=560x580")
	var/datum/browser/popup = new(user, "persistencemenu", "<div align='center'>CharPersistence Menu</div>", 240, 340)
	popup.set_content(dat)
	popup.open(0)