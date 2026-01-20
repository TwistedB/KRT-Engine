myDialouge = [];
myCharacterEffects = [];
//myCharaceters[
//[characterObj, [effect1, effect2], [-1], [effect1]]
//[characterObj, [effect1, effect2], [-1], [effect1]]
//]
myCharacters = [];
myEvent = [];

myDestroyEvent = -1;

if(instance_exists(objPlayer))
{
	objPlayer.frozen = true;
}

//[choiceName, choiceDialouge, choiceEvent]
myChoices = [-1]

if (instance_number(objDialouge) > 1) {
	instance_destroy();
	exit;
}

with(objDCharacter)
{
	depth = other.depth+1;
}

spamDelay = 3;

message_current = 0;
timer = 0;
cutoff = 0;

//variables that move up
t = 0;
r = 0;
r2 = 75;

amplitude = 4;
freq = 2;

increment = 1;

done = false;

//text position
tX = 30;
tY = 480;

modifier = 0;

lineFinished = false;

delay = 1;

//needed because it takes 1 frame to add variables
alarm[0] = 1

function checkDialougeEvent()
{
	if(myEvent[message_current] != "-1")
	{
		//Trigger event if myEvent does not start with $
		if(string_char_at(myEvent[message_current], 1) != "$")
		{
			activate_trigger(myEvent[message_current])
		}else
		{
			//if character = $S change dialouge speed
			if(string_char_at(myEvent[message_current], 2) == "S")
			{
				delay = string_char_at(myEvent[message_current], 3)
			}
		}
	}
}