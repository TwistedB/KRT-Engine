if (!is_held(vk_anykey) && !global.controllerConnected)
{
	exit;
}


// CHANGE KEYBOARD CONTROL
if (changing_controls && menu == MENU_OPTIONS.KCONTROLS)
{
	if (keyboard_check_pressed(vk_anykey))
	{
		var key = keyboard_key;
		
		if (key == 160 || key == 161)
		{
			key = 16;
		}
		
		var control_name = string_lower(
			options[MENU_OPTIONS.KCONTROLS][select[menu]]
		);
		
		var control = variable_struct_get(global.controls, control_name);
		control.keyboard = key;
		
		save_config();
		audio_play_sound(sndJump, 0, false);
		changing_controls = false;
		exit;
	}
	exit;
}


// CHANGE CONTROLLER CONTROL
// CHANGE CONTROLLER CONTROL
if (changing_controls && menu == MENU_OPTIONS.CCONTROLS)
{
	if (global.controllerConnected)
	{
		// Wait until all controller buttons AND the left stick are released.
		if (!controller_ready)
		{
			var stick_h = gamepad_axis_value(global.controller, gp_axislh);
			var stick_v = gamepad_axis_value(global.controller, gp_axislv);
			
			if (!gamepad_button_check(global.controller, gp_face1)
			&& !gamepad_button_check(global.controller, gp_face2)
			&& !gamepad_button_check(global.controller, gp_face3)
			&& !gamepad_button_check(global.controller, gp_face4)
			&& !gamepad_button_check(global.controller, gp_shoulderl)
			&& !gamepad_button_check(global.controller, gp_shoulderr)
			&& !gamepad_button_check(global.controller, gp_shoulderlb)
			&& !gamepad_button_check(global.controller, gp_shoulderrb)
			&& !gamepad_button_check(global.controller, gp_select)
			&& !gamepad_button_check(global.controller, gp_start)
			&& !gamepad_button_check(global.controller, gp_stickl)
			&& !gamepad_button_check(global.controller, gp_stickr)
			&& !gamepad_button_check(global.controller, gp_padu)
			&& !gamepad_button_check(global.controller, gp_padd)
			&& !gamepad_button_check(global.controller, gp_padl)
			&& !gamepad_button_check(global.controller, gp_padr)
			&& abs(stick_h) < 0.5
			&& abs(stick_v) < 0.5)
			{
				controller_ready = true;
			}
			
			exit;
		}
		
		// Check normal controller buttons first.
		var buttons = [
			gp_face1,
			gp_face2,
			gp_face3,
			gp_face4,
			gp_shoulderl,
			gp_shoulderr,
			gp_shoulderlb,
			gp_shoulderrb,
			gp_select,
			gp_start,
			gp_stickl,
			gp_stickr,
			gp_padu,
			gp_padd,
			gp_padl,
			gp_padr
		];
		
		for (var i = 0; i < array_length(buttons); i++)
		{
			if (gamepad_button_check_pressed(global.controller, buttons[i]))
			{
				var control_name = string_lower(
					options[MENU_OPTIONS.CCONTROLS][select[menu]]
				);
				
				var control = variable_struct_get(global.controls, control_name);
				control.controller = buttons[i];
				
				save_config();
				audio_play_sound(sndJump, 0, false);
				changing_controls = false;
				exit;
			}
		}
		
		// Check left stick as D-Pad.
		var stick_h = gamepad_axis_value(global.controller, gp_axislh);
		var stick_v = gamepad_axis_value(global.controller, gp_axislv);
		
		var stick_button = -1;
		
		if (stick_h < -0.5)
		{
			stick_button = gp_padl;
		}
		else if (stick_h > 0.5)
		{
			stick_button = gp_padr;
		}
		else if (stick_v < -0.5)
		{
			stick_button = gp_padu;
		}
		else if (stick_v > 0.5)
		{
			stick_button = gp_padd;
		}
		
		if (stick_button != -1)
		{
			var control_name = string_lower(
				options[MENU_OPTIONS.CCONTROLS][select[menu]]
			);
			
			var control = variable_struct_get(global.controls, control_name);
			control.controller = stick_button;
			
			save_config();
			audio_play_sound(sndJump, 0, false);
			changing_controls = false;
			exit;
		}
	}
	
	exit;
}

if (is_pressed(global.controls_menu.up))
{
	select[menu]--;
	audio_play_sound(sndDoubleJump, 0, false);
}

if (is_pressed(global.controls_menu.down))
{
	select[menu]++;
	audio_play_sound(sndDoubleJump, 0, false);
}


var length = array_length(options[menu]);
select[menu] += length;
select[menu] %= length;

var option = options[menu];
var selected = select[menu];


// MENU ACTIONS
switch (menu)
{
	case MENU_OPTIONS.OPTIONS:
		
		// Exception for certain options
		if (is_pressed(global.controls_menu.accept)
		|| selected > 0 && selected <= 4)
		{
			option[selected].on_select();
		}
		
		if (is_pressed(global.controls_menu.back))
		{
			save_config();
			
			if (room = rOptions)
			{
				room_goto(rFiles);
			}
			
			instance_destroy();
		}
		
	break;
	
	
	case MENU_OPTIONS.KCONTROLS:
		if (keyboard_check_pressed(global.controls_menu.accept.keyboard))
		{
			if (selected == length - 1)
			{
				option[selected].on_select();
			}
			else
			{
				changing_controls = true;
				audio_play_sound(sndJump, 0, false);
				exit;
			}
		}
		
		if (is_pressed(global.controls_menu.back))
		{
			menu = MENU_OPTIONS.OPTIONS;
			select[menu] = 0;
			audio_play_sound(sndJump, 0, false);
		}
		
	break;
	
	
	case MENU_OPTIONS.CCONTROLS:
		
		// changing a controller control.
		if (global.controllerConnected)
		{
			if (gamepad_button_check_pressed(
				global.controller,
				global.controls_menu.accept.controller
			))
			{
				if (selected == length - 1)
				{
					option[selected].on_select();
				}
				else
				{
					changing_controls = true;
					controller_ready = false;
					audio_play_sound(sndJump, 0, false);
					exit;
				}
			}
		}
		
		// Either keyboard OR controller can back out.
		if (is_pressed(global.controls_menu.back))
		{
			menu = MENU_OPTIONS.OPTIONS;
			select[menu] = 0;
			audio_play_sound(sndJump, 0, false);
		}
		
	break;
	
	
	case MENU_OPTIONS.ONLINE:
		
		if (is_pressed(global.controls_menu.accept))
		{
			option[selected].on_select();
		}
		
		if (is_pressed(global.controls_menu.back))
		{
			menu = MENU_OPTIONS.OPTIONS;
			select[menu] = 0;
			audio_play_sound(sndJump, 0, false);
		}
		
	break;
}