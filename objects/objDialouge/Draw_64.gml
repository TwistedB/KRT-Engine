draw_set_font(fntArial);
draw_set_halign(fa_left);
draw_set_colour(c_white);

draw_sprite_ext(sprDialougeBox, 0, 400, 608, 1, 1, 0, c_white, 1);

//how many messages are in the array
var message_end = array_length(myDialouge)

if(array_length(myCharacters) != 0)
{
	if(instance_exists(myCharacters[0][0]))
	{
		if(myCharacters[0][0].currentlyTalking = true)
		{
			draw_sprite_ext(sprWhiteBox, 0, 80, 368, 6, 1.5, 0, c_black, 1);
			draw_text(120, 386, myCharacters[0][0].myName)
		}
	}

	if(instance_exists(myCharacters[1][0]))
	{	
		if(myCharacters[1][0].currentlyTalking = true)
		{
			draw_sprite_ext(sprWhiteBox, 0, 528, 368, 6, 1.5, 0, c_black, 1);
			draw_text(120+480, 386, myCharacters[1][0].myName)
		}
	}
}

if(message_end > 0)
{
	var charWidth = 11;
	var lineEnd = 35;
	var line = 0;
	var space = 0;
	var i = 1;
	
	//Typewriter
	if(cutoff < string_length(myDialouge[message_current]))
	{
		if(timer >= delay)
		{
			cutoff++;
			timer = 0;
		}
		else timer++;
	}
	
	//next message
	if(keyboard_check_pressed(global.controls.jump) && done = false && spamDelay <= 0)
	{
		spamDelay = 3;
		if(lineFinished = true)
		{
			//if we still have more messages go to next one
			if(message_current < message_end-1)
			{
				message_current++;
				cutoff = 0;
				lineFinished = false;
				checkDialougeEvent()
				
				with(objDCharacter)
				{
					CharacterEventCheck()
				}
			}else
			{
				done = true;
				if(myChoices[0] = -1)
				{
					instance_destroy();
				}else
				{
					var cs = instance_create_depth(x, y, depth, objChoiceSelector);
					for (var c = 0; c < array_length(myChoices); ++c) {
					    var choiceBox = instance_create_depth(288, 258+(c*64), depth-1, objChoiceBox);
						choiceBox.choiceName = myChoices[c][0];
						choiceBox.choiceNumber = c;
						choiceBox.choiceSpawn = myChoices[c][1];
						array_push(cs.choices, choiceBox);
					}
				}
			}
		}else
		{
			cutoff = string_length(myDialouge[message_current]);		
			lineFinished = false;
		}
	}
	
	//draw text
	while(i <= string_length(myDialouge[message_current]) && i <= cutoff)
	{
		//check for modifier 
		if(string_char_at(myDialouge[message_current], i) == "$")
		{
			modifier = real(string_char_at(myDialouge[message_current], ++i));
			i++;
		}
		
		//text effects
		switch(modifier)
		{
			case 0: //normal
			{
				draw_set_colour(c_white);
				draw_text(tX+(space*charWidth), tY+(13*line), string_char_at(myDialouge[message_current], i));
				break;
			}
			case 1: //shaky
			{
				draw_set_colour(c_white);
				draw_text(tX+(space*charWidth)+random_range(-1, 1), tY+(13*line)+random_range(-1, 1), string_char_at(myDialouge[message_current], i));
				break;			
			}
			case 2: //sine movement
			{
				var so = t + i;
				var shift = sin(so*pi*freq/room_speed)*amplitude;
				draw_set_colour(c_white);
				draw_text(tX+(space*charWidth), tY+(13*line)+shift, string_char_at(myDialouge[message_current], i));
				break;
			}	
			case 3: //rainbow
			{
				var col = make_colour_hsv(r+i, 255, 255);
				var col2 = make_colour_hsv(r2+i, 255, 255);
				draw_text_transformed_colour(tX+(space*charWidth), tY+(13*line), string_char_at(myDialouge[message_current], i), 1, 1, 0, col, col, col2, col2, 1);
				break;
			}
		}
		
		//go to next line
		var length = 0;
		while(string_char_at(myDialouge[message_current], i) != " " && i <= string_length(myDialouge[message_current]))
		{
			i++;
			length++;
		}
		
		if(space+length > lineEnd)
		{
			space = 0;
			line++;
		}
		i -= length
		
		space++;
		i++;
	}
	
	if(i >= string_length(myDialouge[message_current]))
	{
		lineFinished = true;
	}
}