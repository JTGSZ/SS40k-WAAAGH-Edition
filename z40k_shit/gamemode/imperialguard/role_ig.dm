//This is just the role that is appended to the player client.

/datum/role/imperial_guard
	name = IMPERIALGUARDSMEN
	id = IMPERIALGUARDSMEN
	special_role = IMPERIALGUARDSMEN
	required_pref = IMPERIALGUARDSMEN
	disallow_job = TRUE
	logo_state = "vox-logo"

//All these procs run after the setup and they have the shit appended to the player fully
/datum/role/imperial_guard/OnPostSetup()
	.=..()
	if(!.)
		return

/datum/role/imperial_guard/chief_vox
	logo_state = "vox-logo"

//Just whats in the stat panel if they have the mind
/datum/role/imperial_guard/StatPanel()
	var/datum/faction/imperial_guard/iguard = faction
	if (!istype(iguard))
		return
	var/dat = "Raid time left: <b>[num2text((iguard.time_left /(2*60)))]:[add_zero(num2text(iguard.time_left/2 % 60), 2)]</b>"
	return dat
	