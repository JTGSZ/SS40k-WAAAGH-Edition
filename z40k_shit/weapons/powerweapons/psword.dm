/*
Eldar PSword
*/

/obj/item/weapon/powersword/eldar
	name = "Power Sword"
	desc = "The last thing a Mon'Keigh will ever see."
	icon_state = "ps_off"
/*	icon_on = "ps_on"
	icon_off = "ps_off"
	switchsound = 'sound/effects/Poweron.ogg'*/
	slot_flags = SLOT_BELT
	force = 30.0
	throwforce = 7
	w_class = 3
	origin_tech = "combat=8"
	attack_verb = list("stabbed", "slashed", "torn", "cut")