if(freezeControls = false)
{
	change_volume();
	
	if(keyboard_check_pressed(global.controls.down))
	{
		pauseOption++;
	}
	
	if(keyboard_check_pressed(global.controls.up))
	{
		pauseOption++;
	}
	
	if(pauseOption <= 0)
	{
		pauseOption = selectLength;
	}
	
	if(pauseOption > selectLength)
	{
		pauseOption = 1;
	}
	
	if(keyboard_check_pressed(global.controls.jump))
	{
		if(pauseOption = 1)
		{
			instance_activate_all();
			
			with(objPause)
			{
				instance_destroy();	
			}
		
			io_clear();
		}
		
		if(pauseOption = 2)
		{
			instance_create_depth(192, 48, depth-10, objOptions);
			freezeControls = true;
		}
	}
}

	if(freezeControls = true)
	{
		if(!instance_exists(objOptions))
		{
			freezeControls = false;
		}
	}