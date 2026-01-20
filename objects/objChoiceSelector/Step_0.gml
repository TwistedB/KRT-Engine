if(keyboard_check_pressed(global.controls.down))
{
	choiceNumber += 1;
}

if(keyboard_check_pressed(global.controls.up))
{
	choiceNumber -= 1;
}

if(choiceNumber < 0)
{
	choiceNumber = array_length(choices)-1;
}

if(choiceNumber > array_length(choices)-1)
{
	choiceNumber = 0;
}

if(keyboard_check_pressed(global.controls.jump))
{
	with(objDialouge)
	{
		instance_destroy();
	}
	
	var talk = choices[choiceNumber].choiceSpawn;
	Talk([talk]);
	
	if(instance_exists(objDialouge))
	{
		objDialouge.cutoff = 0;
	}
	
	with(objChoiceBox)
	{
		instance_destroy();
	}
	
	instance_destroy();
}