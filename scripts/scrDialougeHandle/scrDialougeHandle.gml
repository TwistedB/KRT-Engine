enum STATE_VN
{
	START,
	READING,
	WAIT_INPUT,
	CHOICE,
	AUTO_WAIT,
	FINISHED,
}

enum MODE_VN
{
	NORMAL,
	SKIP,
	AUTO,
	BACKLOG,
}

function startVN()
{
	advance = dialouge[lineCurrent];
	
	autoAdvance = false;
	
	// event_start
	if variable_struct_exists(advance, "event_start")
	{
		advance.event_start();
	}
	
	// auto advance
	if variable_struct_exists(advance, "autoAdvance")
	{
		autoAdvance = advance.autoAdvance;
	}

	// auto speed
	if variable_struct_exists(advance, "autoModeSpeed")
	{
		maxAutoCounter = advance.autoModeSpeed;
		autoCounter = maxAutoCounter;
	}
	
	// mode lock
	if variable_struct_exists(advance, "modeLock")
	{
		modeLock = advance.modeLock;
	}
	
	// mode hide
	if variable_struct_exists(advance, "modeHide")
	{
		modeHide = advance.modeHide;
	}
	
	// mode set
	if variable_struct_exists(advance, "modeSet")
	{
		mode = advance.modeSet;
	}

	// goto
	if variable_struct_exists(advance, "goto")
	{
		lineCurrent = advance.goto;
		advance = dialouge[lineCurrent];
	}

	// speaker
	if variable_struct_exists(advance, "speaker")
	{
		nameplateText = advance.speaker;
	}
	
	// focus id
	if variable_struct_exists(advance, "focusId")
	{
		VNPortraitFocus(advance.focusId);
	}
	
	// focus off
	if variable_struct_exists(advance, "focusOff")
	{
		if(advance.focusOff)
		{
			VNPortraitFocusOff()
		}
	}
	
	// speed
	if variable_struct_exists(advance, "tspeed")
	{
		typeSpeed = advance.tspeed;
	}
	
	// player_move
	if variable_struct_exists(advance, "player_move")
	{
		playerMove = advance.player_move;
	}
	
	//sound
	if variable_struct_exists(advance, "sound")
	{
		var sndString = asset_get_index(advance.sound);
		audio_play_sound(sndString, 0, 0);
	}

	// choice
	if variable_struct_exists(advance,"choice")
	{
		inputLock = 5;
		choiceIndex = 0;
		state = STATE_VN.CHOICE;
		return;
	}

	// text
	if variable_struct_exists(advance,"texts")
	{
		var parsed = VNParseEffects(advance.texts);

		textFull = VNWrapText(parsed.text, 760);
		textEffects = VNRemapEffectsToWrapped(textFull, parsed.effects);
		
		var np = nameplateText;
		if(np != "")
		{
			np += ": "
		}
		
		array_push(global.backlog, [np, textFull])

		text = "";
		cutoff = 0;
		timer = 0;

		currentTypeSpeed = typeSpeed;
		textWaitTimer = 0;
		textShake = false;
		textEffectReadIndex = 0;

		state = STATE_VN.READING;
	}
	else
	{
		scrVNNext();
		return;
	}

	// characters
	if variable_struct_exists(advance, "characters")
	{
		VNCharacters(advance.characters);
	}
}

function scrVNAdvance(_dialouge)
{
	nameplateText = _dialouge
}

function handleVNTyping()
{	
	if(mode = MODE_VN.NORMAL)
	{
		VNtypeText();

		if(keyboard_check_pressed(dioControls.advance) && inputLock <= 0 && backlogOpen = false)
		{
			text = textFull;
			cutoff = string_length(textFull);
			state = STATE_VN.WAIT_INPUT;
		}
	}else if(mode = MODE_VN.SKIP)
	{		
		text = textFull;
		cutoff = string_length(textFull);
		state = STATE_VN.WAIT_INPUT;	
	}else if(mode = MODE_VN.AUTO)
	{
		VNtypeText();
	}
}

function waitForVNPlayerAdvance()
{
	if(autoAdvance = true)
	{
		state = STATE_VN.AUTO_WAIT
	}
	
	if(mode = MODE_VN.NORMAL)
	{
		if(keyboard_check_pressed(dioControls.advance) && inputLock <= 0 && backlogOpen = false)
		{
			scrVNNext();
		}
	}else if(mode = MODE_VN.SKIP)
	{
		if(skipCounter <= 0)
		{
			skipCounter = maxSkipCounter;
			scrVNNext();
		}
	}else if(mode = MODE_VN.AUTO)
	{
		if(autoCounter <= 0)
		{
			autoCounter = maxAutoCounter;
			
			scrVNNext();
		}
	}
}

function scrVNNext()
{
	lineCurrent++;

	if(lineCurrent >= array_length(dialouge))
	{
		state = STATE_VN.FINISHED;
		return;
	}

	advance = dialouge[lineCurrent];

	state = STATE_VN.START;
}

function handleVNChoice()
{
	var c = advance.choices;

	if keyboard_check_pressed(dioControls.up) && backlogOpen = false
	{
		choiceIndex--;
	}

	if keyboard_check_pressed(dioControls.down) && backlogOpen = false
	{
		choiceIndex++;
	}

	choiceIndex = clamp(choiceIndex,0,array_length(c)-1);

	if(keyboard_check_pressed(dioControls.advance) && inputLock <= 0 && backlogOpen = false)
	{
		inputLock = 2;
		
		var selected = c[choiceIndex];

		if variable_struct_exists(selected,"event_choose")
		{
			selected.event_choose();
			return;
		}

		if variable_struct_exists(selected,"goto")
		{
			lineCurrent = selected.goto;
			advance = dialouge[lineCurrent];
			state = STATE_VN.START;
			return;
		}

		scrVNNext();
	}
}

function VNEnd()
{
	with(objVNBase)
	{
		state = STATE_VN.FINISHED;
	}
}

function VNautoAdvanceTimer()
{
	autoTimer--;

	if(autoTimer <= 0)
	{
		scrVNNext();
		autoTimer = 1;
	}
}