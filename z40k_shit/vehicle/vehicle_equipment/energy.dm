/obj/item/device/vehicle_equipment/weaponry/taser
	name = "\improper taser system"
	desc = "A weak taser system for space pods, fires electrodes that shock upon impact."
	icon_state = "pod_taser"
	projectile_type = /obj/item/projectile/energy/electrode
	shot_cost = 10
	fire_sound = "sound/weapons/Taser.ogg"
	verb_name = "Fire Taser System"
	verb_desc = "Fire ze tasers!"

/obj/item/device/vehicle_equipment/weaponry/taser/burst
	name = "\improper burst taser system"
	desc = "A weak taser system for space pods, this one fires 3 at a time."
	icon_state = "pod_b_taser"
	shot_cost = 35
	shots_per = 3
	fire_delay = 20
	verb_name = "Fire Burst Taser System"
	verb_desc = "Fire ze tasers!"

/obj/item/device/vehicle_equipment/weaponry/laser
	name = "\improper laser system"
	desc = "A weak laser system for space pods, fires concentrated bursts of energy"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/beam
	shot_cost = 150
	fire_sound = 'sound/weapons/Laser.ogg'
	fire_delay = 15
	verb_name = "Fire Laser System"
	verb_desc = "Fire ze lasers!"
	