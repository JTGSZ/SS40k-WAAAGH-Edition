/*
/mob/verb/state_persist_details()
	if(client)
		var/client/C = usr.client
		to_chat(usr,"Potential: [C.persist.potential]")
		to_chat(usr,"ghost_form: [C.persist.ghost_form], ghost_red:[C.persist.ghost_red], ghost_green:[C.persist.ghost_green],ghost_blue:[C.persist.ghost_blue]")

/mob/verb/check_clients()
	for(var/client/C in clients)
		to_chat(usr,"Client: [C]")
	to_chat(usr,"Clients: [clients.len]")

/mob/verb/save_db()
	for(var/client/C in clients)
		C.persist.save_persistence_sqlite(C.ckey,C,TRUE)
		to_chat(usr,"Client: [C], [C.ckey]")

/mob/verb/increase_potential()
	for(var/client/C in clients)
		C.persist.potential += 1
		to_chat(usr,"Client: [C], [C.ckey]")
		to_chat(usr,"Potential: [C.persist.potential]")

/mob/verb/change_color()
	var/client/C = usr.client
	icon_state = C.persist.ghost_form
	color = rgb(C.persist.ghost_red,C.persist.ghost_green,C.persist.ghost_blue)

/mob/verb/clear_values()
	var/client/C = usr.client
	C.persist.potential = 0
	C.persist.ghost_form = "ghost_standard"
	C.persist.ghost_red = 0
	C.persist.ghost_green = 0
	C.persist.ghost_blue = 0
*/
