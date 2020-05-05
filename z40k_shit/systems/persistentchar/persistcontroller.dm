/*
	Within is a disjointed save proc for the potential system.
																*/
/*
You may ask what is this? 
Its basically rewardpoints for doing shit, we do not want to save everything
At the end of the round, maybe in the future there will be more tables etc for persistent chars.
But the preferences menu and other stuff will need cleaned up and such.
*///This needs to be appended to gameticker.dm or the mode end segment.

/datum/interactive_persistence
	var/database/persistdb = ("persistence.sqlite")
	var/client/client
	var/potential = 0
	var/ghost_form = "ghost_standard"
	var/ghost_red = 0
	var/ghost_green = 0
	var/ghost_blue = 0
	var/persistenceloaded = 0

/*
	We write a new database file and put our table into it.
	Make sure to keep this commented out unless you are writing a new database.
	Basically you just log in and enter the game and the ability to write it is on commands tab.
	Its not all that important compared to char data, so wipe it or add more tables.
	Step by Step instructions for - How to do things the bad way.
	1. Change the above persistdb to something randomly named.
	2. Uncomment the below.
	3. Write via the verb.
	4. Delete the random db file it made.
	5. Change filename to the db you just wrote the table into.
*/
/*
/mob/verb/write_new_database()
	var/database/persistdb = ("persistence.sqlite")
	var/database/query/Q = new()
	var/sql={"CREATE TABLE "persistence" (
	`ID`			INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`ckey`			INTEGER UNIQUE,
	`potential`		INTEGER,
	`ghost_form`	TEXT,
	`ghost_red`		INTEGER,
	`ghost_green`	INTEGER,
	`ghost_blue`	INTEGER
);"}

	Q.Add(sql)
	Q.Execute(persistdb)
*/
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
	
/datum/interactive_persistence/New(client/C)
	client=C
	if(istype(C))
		var/theckey = C.ckey
		var/thekey = C.key
		spawn()
			if(!IsGuestKey(thekey))
				while(!SS_READY(SShumans)) //Basically this stops anything from occurring before humans r loaded
					sleep(1)
				if(load_persistence_sqlite(theckey,C))
					persistenceloaded = 1
				else
					save_persistence_sqlite(theckey,C,FALSE)
					persistenceloaded = 1

/datum/interactive_persistence/proc/save_persistence_sqlite(var/ckey, var/user, var/journeyend = FALSE)
	var/database/query/check = new
	var/database/query/q = new
	if(!ckey)
		message_admins("BAD DATA ALMOST WRITTEN INTO DATABASE, HOLY SHIT WHATS WRONG WITH BYOND.")
		return 0 //Hell no 

	check.Add("SELECT ckey FROM persistence WHERE ckey = ?", ckey)
	if(check.Execute(persistdb))
		if(!check.NextRow())
			q.Add("INSERT into persistence (ckey, potential, ghost_form, ghost_red, ghost_green, ghost_blue)\
			 VALUES (?,		?,			?,			?,		?,			?)",\
					ckey, potential, ghost_form, ghost_red, ghost_green, ghost_blue)
			if(!q.Execute(persistdb))
				message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [q.Error()] - [q.ErrorMsg()]")
				WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
				return 0
		else
			q.Add("UPDATE persistence SET potential=?,ghost_form=?,ghost_red=?,ghost_green=?,ghost_blue=? WHERE ckey = ?",\
										potential, 	ghost_form,		ghost_red,	ghost_green,	ghost_blue,		ckey)
			if(!q.Execute(persistdb))
				message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [q.Error()] - [q.ErrorMsg()]")
				WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
				return 0
	else
		message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [check.Error()] - [check.ErrorMsg()]")
		WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
		return 0
	
	if(journeyend)
		to_chat(user, "Your potential increases, your current potential is [potential].")
	return 1


/datum/interactive_persistence/proc/load_persistence_sqlite(var/ckey,var/user)
	var/list/persistence_one = new
	var/database/query/check = new
	var/database/query/q = new

	check.Add("SELECT ckey FROM persistence WHERE ckey = ?", ckey)
	if(check.Execute(persistdb))
		if(!check.NextRow())
			return 0
	else
		message_admins("Error in load_persistence_sqlite [__FILE__] ln:[__LINE__] #: [check.Error()] - [check.ErrorMsg()]")
		WARNING("Error in load_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
		return 0
	q.Add("SELECT * FROM persistence WHERE ckey = ?", ckey)
	if(q.Execute(persistdb))
		while(q.NextRow())
			var/list/row = q.GetRowData()
			for(var/a in row)
				persistence_one[a] = row[a]

	potential 	= text2num(persistence_one["potential"]) 
	ghost_form	= persistence_one["ghost_form"]
	ghost_red 	= text2num(persistence_one["ghost_red"])
	ghost_green = text2num(persistence_one["ghost_green"])
	ghost_blue 	= text2num(persistence_one["ghost_blue"])

	if(isnull(ghost_form))
		ghost_form = "ghost_standard"

	potential 	= sanitize_integer(potential, 0, 1000, initial(potential))
	ghost_red 	= sanitize_integer(ghost_red, 0, 255, initial(ghost_red))
	ghost_green	= sanitize_integer(ghost_green, 0, 255, initial(ghost_green))
	ghost_blue	= sanitize_integer(ghost_blue, 0, 255, initial(ghost_blue))

	return 1

