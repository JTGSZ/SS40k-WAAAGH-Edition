//This is just the role that is appended to the player client.

/datum/role/ork_raider
	name = ORKRAIDER
	id = ORKRAIDER
	special_role = ORKRAIDER
	required_pref = ORKRAIDER
	logo_state = "vox-logo"

//All these procs run after the setup and they have the shit appended to the player fully
/datum/role/ork_raider/OnPostSetup()
	.=..()
	if(!.)
		return

//Just whats in the stat panel if they have the mind
/datum/role/ork_raider/StatPanel()
	var/datum/faction/ork_raiders/orkraider = faction
	if (!istype(orkraider))
		return
	var/dat = "Raid time left: <b>[num2text((orkraider.time_left /(2*60)))]:[add_zero(num2text(orkraider.time_left/2 % 60), 2)]</b>"
	return dat
	