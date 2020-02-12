
/obj/item/device/vehicle_equipment
	name = "equipment"
	var/tied_action //The action button tied to the object
	
/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.
