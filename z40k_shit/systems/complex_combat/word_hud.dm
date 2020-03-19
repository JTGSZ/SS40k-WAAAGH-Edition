
//Im doing this on roles because im feeling lazy.
//Nevermind
//Anyways See: onclick human.dm line 379 for our entry
//We basically have to call update_powerwords_hud on the mob when we need to update it.

//Location of the power words area thing. See: _defines.dm for the rest
#define ui_powerwords "CENTER-1.5,NORTH-1:10"

/datum/hud/proc/powerwords_hud()
	// Display our currently active words.
	powerwords_display = getFromPool(/obj/abstract/screen)
	powerwords_display.name = "POWER WORDS"
	powerwords_display.icon = 'z40k_shit/icons/slightly_black_rectangle.dmi'
	powerwords_display.icon_state = "dark128x42"
	powerwords_display.screen_loc = ui_powerwords

	mymob.client.screen += list(powerwords_display)

/mob/living/carbon/human/proc/update_powerwords_hud()
	if(hud_used)
		if(!hud_used.powerwords_display)
			hud_used.powerwords_hud()
			//hud_used.human_hud(hud_used.ui_style)
		
		var/conversion_string //Basically this is our conversion string, we now exist.
		conversion_string = word_combo_chain //Then we make it our word combo chain
		//Then we regex stuff - Basically we can get our colors on this way.
		if(findtext(conversion_string, "grapple")) //This one is grab
			conversion_string = replacetext(conversion_string, "grapple", "<font color='#FFFF00'><i> Grapple </i></font>") 
		if(findtext(conversion_string, "disarm")) //This one is disarm
			conversion_string = replacetext(conversion_string, "disarm", "<font color='#0000FF'> Disarm </font>") 
		if(findtext(conversion_string, "knockback")) //This one is help
			conversion_string = replacetext(conversion_string, "knockback", "<font color='#00FF00'> Knockback </font>") 
		if(findtext(conversion_string, "hurt")) //This one is hurt
			conversion_string = replacetext(conversion_string, "hurt", "<font color='#FF0000'> HURT </font>") 
		if(findtext(conversion_string, "charge")) //This one is charge action
			conversion_string = replacetext(conversion_string, "charge", "<font color='#FF9933'><b> Charge! </b></font>") 
		if(findtext(conversion_string, "parry")) //This one is parry action
			conversion_string = replacetext(conversion_string, "parry", "<font color='#EE82EE'><b> Parry! </b></font>") 
		if(findtext(conversion_string, "pierce")) //Pierce action
			conversion_string = replacetext(conversion_string, "pierce", "<font color='#00ffea'><b><i> PIERCE! </i></b></font>") 
		if(findtext(conversion_string, "overcharge")) //Pierce action
			conversion_string = replacetext(conversion_string, "overcharge", "<font color='#8602f1'><b><i> Overcharge! </i></b></font>") 
		if(findtext(conversion_string, "saw")) //Pierce action
			conversion_string = replacetext(conversion_string, "saw", "<font color='#ff0055'><b><i> Saw! </i></b></font>") 


		hud_used.powerwords_display.maptext_width = 128
		hud_used.powerwords_display.maptext_height = 42
		hud_used.powerwords_display.maptext = "<div align='left' valign='top' style='position:relative; top:0px; left:6px'>\
				<br>\
				[conversion_string]<br>\
				</div>"
	return