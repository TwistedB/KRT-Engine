if choicecount > 0
{
    if is_pressed(vk_up) && choice > 0
        choice -= 1
    if is_pressed(vk_down) && choice < choicecount-1
        choice += 1
    if is_pressed(vk_shift)
    {
        t = -5
        dialogueid = 0
		skipCounter = -10
        text = dialoguetextchoice[choice]
        choicecount = 0
		typewriter = 0
		nextid = true
        active = true
    }
}

if (active)
{
    t++
	skipCounter ++
}
else 
    instance_destroy();    

if t < 0
    faceindex = 0
else if t mod 8*dialoguespeed == 0
{
    faceindex += 1
    if faceindex > 2
        faceindex = 1
}

#region Once the current string of dialogue ends, continue to the next one
if typewriter > string_length(text[dialogueid]) && !nextid
{	
	if(keyboard_check_pressed(global.controls.jump))
	{
	    t = -5
		skipCounter = -10;
	    nextid = true
	    if dialogueid < array_length(text)-1
	        dialogueid += 1
	    else 
	        active = false
	    exit
	}
}else if typewriter < string_length(text[dialogueid]) && skipCounter > 0
{
	if(keyboard_check_pressed(global.controls.jump))
	{
		var dAt = -1;
		var acceptable = true;
		for(var i = 1; i <= string_length(text[dialogueid]); ++i)
		    if string_pos(string_char_at(text[dialogueid], i), "$") == 1 {
		        acceptable = false;
				dAt = i;
				
				if(acceptable = false)
				{
					if charat(dAt) == "$"
					{
				        var g = real(charat(dAt+2));
				        switch charat(dAt+1)
				        {
				            // S = Speed, I = Dialogue Image, D = Delay, C = Choice, E = Event
				            case "S":
				                dialoguespeed = g*2
				                break
				            case "I":
				                currentimage = g
				                break
				            case "D":
				                t = g*10
				                break
				            case "C":
				                choicecount = g
				                break
				            case "E":
				                event_user(g)
				                break
				        }
				        text[dialogueid] = string_delete(text[dialogueid], dAt, 3);		
					}		
				}
		    }
			
			drawntext = text[dialogueid]
			typewriter = string_length(text[dialogueid])
			t = 10;
	}
	
}
#endregion

#region Add letters to drawn text + Special symbol effects
if t mod dialoguespeed == 0 && t > 0 && choicecount == 0
{
    if nextid 
    {
        typewriter = 0
        drawntext = ""
        nextid = false
    }
    typewriter += 1
    if charat(typewriter) == "$"
    {
        var g = real(charat(typewriter+2));
        switch charat(typewriter+1)
        {
            // S = Speed, I = Dialogue Image, D = Delay, C = Choice, E = Event
            case "S":
                dialoguespeed = g*2
                break
            case "I":
                currentimage = g
                break
            case "D":
                t = g*10
                break
            case "C":
                choicecount = g
                break
            case "E":
                event_user(g)
                break
        }
        typewriter += 3
    }
    drawntext += charat(typewriter)
    if typewriter < string_length(text[dialogueid])
        audio_play_sound(sndShoot,-1,false,1,0,random_range(0.7,1))
}
#endregion