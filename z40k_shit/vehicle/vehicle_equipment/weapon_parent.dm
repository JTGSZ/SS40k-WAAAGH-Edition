/obj/item/device/vehicle_equipment/weaponry
	name = "pod weapon"
	desc = "You shouldn't be seeing this"
	icon = 'icons/pods/ship.dmi'
	icon_state = "blank"
	var/projectile_type
	var/fire_sound
	var/fire_delay = 10
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.

/obj/item/device/vehicle_equipment/weaponry/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.

