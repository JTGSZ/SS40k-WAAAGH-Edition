/obj/structure/nuke_computer
	name = "Mysterious Console"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	var/authorized = FALSE

/obj/structure/nuke_computer/New()
	..()

/obj/structure/nuke_computer/Destroy()
	..()

/obj/structure/nuke_computer/attack_hand(mob/user)
	lets_a_go(user)

/obj/structure/mekanical_shouta/attackby(obj/item/weapon/W, mob/user)
	//if()

/obj/structure/nuke_computer/proc/lets_a_go(mob/user)
/*	var/dat
	dat += {"<B>Build Recipes</B><BR>
			<HR>
			<B>Build Object:</B><BR>
			<I>The requirements are afterwards, click the button for a desc of the object.</I><BR>"}
	for(var/datum/crafting_recipes/recipe in src.possible_recipes)
		dat += "<A href='byond://?src=\ref[src];build=1;recipe=\ref[recipe]'>[recipe.title]</A> <A href='byond://?src=\ref[src];desc=1;recipe=\ref[recipe]'>[recipe.build_desc]</A><BR>"
	dat += "<HR>"
	if(src.temp)
		dat += "[src.temp]"
	var/datum/browser/popup = new(user, "craftbuilder", "Crafting Menu")
	popup.set_content(dat)
	popup.open()*/

/obj/structure/nuke_computer/Topic(href, href_list)
	if(usr.stat != DEAD)
		return
	var/mob/living/L = usr
	if(!istype(L))
		return
/*
	if(href_list["free_recruit"])//We don't have time to wait for the recruiter, just grab whoever applied first!
		if(!our_boy)
			our_boy = usr.client
			master.plugin_ourboy(usr.client)
		else
			to_chat(usr, "<span class='warning'>Uhm, Someone got the role before you. Bitch</span>")
	
	lets_a_go(L)*/