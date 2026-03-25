if(keyboard_check_pressed(dioControls.skip) && modeLock = false)
{
	if(mode = MODE_VN.SKIP)
	{
		mode = MODE_VN.NORMAL;
	}else
	{
		mode = MODE_VN.SKIP;
	}
}

if(keyboard_check_pressed(dioControls.auto) && modeLock = false)
{
	if(mode = MODE_VN.AUTO)
	{
		mode = MODE_VN.NORMAL;
	}else
	{
		autoCounter = maxAutoCounter;
		mode = MODE_VN.AUTO;
	}
}

if(keyboard_check_pressed(dioControls.backlog) && modeLock = false)
{
	if(mode = MODE_VN.BACKLOG)
	{
		mode = MODE_VN.NORMAL;
	}else
	{
		mode = MODE_VN.BACKLOG;
		backlogGoToBottom = true;
	}	
}

if(mode = MODE_VN.BACKLOG)
{
	backlogOpen = true;
}else
{
	backlogOpen = false;
}	

if(backlogOpen)
{
	if(keyboard_check(dioControls.up)) 
	{
		backlogScroll -= 4;
	}

	if(keyboard_check(dioControls.down)) 
	{
		backlogScroll += 4;
	}
}

backlogScroll = clamp(backlogScroll, 0, backlogMaxScroll);

if(mode = MODE_VN.AUTO)
{
	if(text = textFull)
	{
		if(autoCounter >= 0)
		{
			autoCounter--;
		}
	}
}

VNPortraitStep();

switch(state)
{
	case STATE_VN.START: startVN(); break;
    case STATE_VN.READING: handleVNTyping(); break;
    case STATE_VN.WAIT_INPUT: waitForVNPlayerAdvance(); break;
    case STATE_VN.CHOICE: handleVNChoice(); break;
    case STATE_VN.AUTO_WAIT: VNautoAdvanceTimer(); break;
	case STATE_VN.FINISHED: instance_destroy();
}

if(skipCounter >= 0)
{
	skipCounter--;
}

if(inputLock > 0)
{
	inputLock--;
}

