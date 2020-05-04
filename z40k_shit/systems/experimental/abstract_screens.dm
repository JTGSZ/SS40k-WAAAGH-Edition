/obj/abstract/screen/viscons
	icon = 'z40k_shit/icons/screens.dmi'
	icon_state = "blank"


/* Ghost Bodies
*/
/obj/abstract/screen/viscons/ghostbodies
	name = "Ghost Body Select"
	var/given_body = "god"
	var/colorable = FALSE

/obj/abstract/screen/viscons/ghostbodies/Click(location, control, params)
	if(!usr)
		return 1

	if(!isobserver(usr))
		return 1

	
	
	usr.icon_state = given_body
	
	if(colorable)
		switch(alert("Do you want to pick a color?",,"Yes","No","Maybe"))
			if("Yes")
				var/pckcolor = input("Color Wheel") as color|null
				//var/icon/I = icon('z40k_shit/icons/mob/ghostbodies.dmi',"[given_body]]")
				//I.Blend(color,ICON_ADD)
				//usr.icon = I
				usr.color = pckcolor
			if("No")
				usr.color = null
				//usr.icon = 'z40k_shit/icons/mob/ghostbodies.dmi'
			if("Maybe")
				//var/icon/I = icon('z40k_shit/icons/mob/ghostbodies.dmi',"[given_body]]")
				//I.Blend(rgb(rand(0,255), rand(0,255), rand(0,255)), ICON_ADD)
				usr.color = rgb(rand(0,255), rand(0,255), rand(0,255))
				
	else
		usr.color = null
		//usr.icon = 'z40k_shit/icons/mob/ghostbodies.dmi'


