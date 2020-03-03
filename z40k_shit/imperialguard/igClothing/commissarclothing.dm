
/obj/item/clothing/head/iguard/commissarcap
	name = "Commissar Cap"
	desc = "An armored cap with the imperial insignia on it, symbolizing the authority of a Commissar."
	icon_state = "commissarcap" //Check: Its there
	item_state = "commissarcap" //Check: Its there
	armor = list(melee = 75, bullet = 50, laser = 20,energy = 30, bomb = 35, bio = 100, rad = 95)
	body_parts_covered = HEAD|EARS|EYES|MASKHEADHAIR
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

/obj/item/clothing/under/iguard/commissar
	name = "commissar uniform"
	desc = "Its a uniform fit for a commissar."
	icon_state = "commissar" //Check: Its there
	item_state = "commissar" //Check Its there:
	_color = "commissar"

/obj/item/clothing/suit/armor/iguard/comissarcoat
	name = "commissar coat"
	desc = "A large coat with comissar stripes and heavy reinforcements."
	icon_state = "commissarcoat" //Check: Its there
	item_state = "commissarcoat" //Check: Its there
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 50, rad = 50)
	body_parts_covered = FULL_TORSO
	allowed = list(/obj/item/weapon/gun/projectile/automatic/complexweapon/boltpistol,
					/obj/item/weapon/complexweapon/chainsword
					)
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	