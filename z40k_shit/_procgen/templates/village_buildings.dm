/* Contained within is vault definitions for village buildings used in loada_village.dm
Basically the list is what we pick from, and the definitions are the maps themselves.
*/

/datum/loada_gen
	var/list/village_templates = list()

//bar tempalte 1
/datum/map_element/vault/bar_template_one
	file_path = "maps/procgenmaps/village_buildings/bar_template_1.dmm"
	only_spawn_once = 1
