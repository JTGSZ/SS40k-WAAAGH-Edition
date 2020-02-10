/datum/locking_category/groundtank

/obj/groundtank/proc/attachturret(var/obj/groundturret/GT)


/obj/groundtank/lock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

	AM.layer = layer + 0.1
	AM.plane = plane
	AM.pixel_y += 9 * PIXEL_MULTIPLIER

/obj/groundtank/unlock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

	AM.reset_plane_and_layer()
	AM.pixel_y = initial(AM.pixel_y)
