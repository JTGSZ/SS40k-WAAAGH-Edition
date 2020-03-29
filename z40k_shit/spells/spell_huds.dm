//See: _defines.dm, basically this is the starting screen location for it.
#define ui_generic_master "EAST-0:-4,NORTH-2:-6" //Used as compile time value

//Icons are actually held in icons/mob/screen_spells.dmi
/obj/abstract/screen/movable/spell_master/ork_racial
	name = "Ork Racial Abilities"
	icon_state = "ork_spell_ready"

	open_state = "genetics_open"
	closed_state = "genetics_closed"

	screen_loc = ui_generic_master

