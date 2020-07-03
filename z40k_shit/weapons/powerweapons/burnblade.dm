/obj/item/weapon/powersword/burning
	name = "Burning Blade"
	desc = "A Loi Pattern Burning Blade. Initially a malfunctioning power sword, the overheating of the blade has been put to use in combat. Good at burning heretics."
	icon_state = "burningblade_off"
//	icon_on = "burningblade_on"
//	icon_off = "burningblade_off"
//	item_on = "cutlass1"
	force = 45
//	stunforce = 10
//	piercingpower = 35

/obj/item/weapon/powersword/burning/attack(mob/living/M, mob/user)
	..()
	if(user.a_intent == "harm" && status)
		M.fire_stacks += 2
		M.IgniteMob()
		M.take_organ_damage(0, 10) //Yes, this is additional fire damage since it is a burning blade. But also notice how this ignores armor.