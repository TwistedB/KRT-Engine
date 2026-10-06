function is_held(control)
{
	if (control == vk_anykey)
	{
		if (keyboard_check(vk_anykey))
			return true;
		
		if (gamepad_is_connected(global.controller))
		{
			for (var button = 0; button < gp_select; button++)
			{
				if (gamepad_button_check(global.controller, button))
					return true;
			}
		}
		
		return false;
	}
	
	if (is_struct(control))
	{
		if (control.keyboard != -1)
		{
			if (keyboard_check(control.keyboard))
				return true;
		}
		
		if (control.controller != -1)
		{
			if (gamepad_is_connected(global.controller))
			{
				if (gamepad_button_check(global.controller, control.controller))
					return true;
			}
		}
		
		return false;
	}
	
	return keyboard_check(control);
}

function is_pressed(control)
{
	if (control == vk_anykey)
	{
		if (keyboard_check_pressed(vk_anykey))
			return true;
		
		if (gamepad_is_connected(global.controller))
		{
			for (var button = 0; button < gp_select; button++)
			{
				if (gamepad_button_check_pressed(global.controller, button))
					return true;
			}
		}
		
		return false;
	}
	
	if (is_struct(control))
	{
		if (control.keyboard != -1)
		{
			if (keyboard_check_pressed(control.keyboard))
				return true;
		}
		
		if (control.controller != -1)
		{
			if (gamepad_is_connected(global.controller))
			{
				if (gamepad_button_check_pressed(global.controller, control.controller))
					return true;
			}
		}
		
		return false;
	}
	
	return keyboard_check_pressed(control);
}

function is_released(control)
{
	if (control == vk_anykey)
	{
		if (keyboard_check_released(vk_anykey))
			return true;
		
		if (gamepad_is_connected(global.controller))
		{
			for (var button = 0; button < gp_select; button++)
			{
				if (gamepad_button_check_released(global.controller, button))
					return true;
			}
		}
		
		return false;
	}
	
	if (is_struct(control))
	{
		if (control.keyboard != -1)
		{
			if (keyboard_check_released(control.keyboard))
				return true;
		}
		
		if (control.controller != -1)
		{
			if (gamepad_is_connected(global.controller))
			{
				if (gamepad_button_check_released(global.controller, control.controller))
					return true;
			}
		}
		
		return false;
	}
	
	return keyboard_check_released(control);
}

function control_bind(control, controller = false)
{
	if (controller)
	{
		switch (control)
		{
			case gp_face1: return "A";
			case gp_face2: return "B";
			case gp_face3: return "X";
			case gp_face4: return "Y";
			
			case gp_shoulderl: return "LB";
			case gp_shoulderr: return "RB";
			case gp_shoulderlb: return "LT";
			case gp_shoulderrb: return "RT";
			
			case gp_select: return "Back";
			case gp_start: return "Start";
			
			case gp_stickl: return "L3";
			case gp_stickr: return "R3";
			
			case gp_padu: return "D-Pad Up";
			case gp_padd: return "D-Pad Down";
			case gp_padl: return "D-Pad Left";
			case gp_padr: return "D-Pad Right";
			
			default:
				if (control == -1 || control == -2147483648)
					return "---";
				
				return string(control);
		}
	}
	
	
	// Keyboard
	switch (control)
	{
		// Special
		case vk_space: return "Space";
		case vk_shift: return "Shift";
		case vk_control: return "Control";
		case vk_alt: return "Alt";
		case vk_enter: return "Enter";
		case vk_up: return "Up";
		case vk_down: return "Down";
		case vk_left: return "Left";
		case vk_right: return "Right";
		case vk_backspace: return "Backspace";
		case vk_tab: return "Tab";
		case vk_insert: return "Insert";
		case vk_delete: return "Delete";
		case vk_pageup: return "Page Up";
		case vk_pagedown: return "Page Down";
		case vk_home: return "Home";
		case vk_end: return "End";
		case vk_escape: return "Escape";
		case vk_printscreen: return "Print Screen";
		case vk_f1: return "F1";
		case vk_f2: return "F2";
		case vk_f3: return "F3";
		case vk_f4: return "F4";
		case vk_f5: return "F5";
		case vk_f6: return "F6";
		case vk_f7: return "F7";
		case vk_f8: return "F8";
		case vk_f9: return "F9";
		case vk_f10: return "F10";
		case vk_f11: return "F11";
		case vk_f12: return "F12";
		case vk_lshift: return "Left Shift";
		case vk_rshift: return "Right Shift";
		case vk_lcontrol: return "Left Control";
		case vk_rcontrol: return "Right Control";
		case vk_lalt: return "Left Alt";
		case vk_ralt: return "Right Alt";
		
		// Numpad
		case 96: return "0";
		case 97: return "1";
		case 98: return "2";
		case 99: return "3";
		case 100: return "4";
		case 101: return "5";
		case 102: return "6";
		case 103: return "7";
		case 104: return "8";
		case 105: return "9";
		case 106: return "*";
		case 107: return "+";
		case 109: return "-";
		case 110: return ".";
		case 111: return "/";
		
		// Misc.
		case 186: return ";";
		case 187: return "=";
		case 188: return ",";
		case 189: return "-";
		case 190: return ".";
		case 191: return "/";
		case 192: return "`";
		case 219: return "[";
		case 220: return "\\";
		case 221: return "]";
		case 222: return "'";
		
		default: return chr(control);
	}
}