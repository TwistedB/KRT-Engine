draw_set_font(fntMenu2);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

var option = options[menu];
var selected = select[menu];
var length = array_length(options[menu]);
var index = 0;

draw_sprite_ext(global.display.languageFlag, 0, 50, 50, 1, 1, 0, c_white, 1);

switch (menu)
{
	case MENU_OPTIONS.KCONTROLS:
		
		while (true)
		{
			var curr_option = option[index];
			
			if (!is_string(curr_option))
			{
				break;
			}
			
			var control_name = string_lower(curr_option);
			var control = variable_struct_get(global.controls, control_name);
			var bind = control_bind(control.keyboard);
			
			if (changing_controls && selected == index)
			{
				bind = "---";
			}
			
			draw_text(
				x,
				y + spacing * index,
				string("{0} Button: {1}", curr_option, bind)
			);
			
			index++;
		}
		
	break;
	
	
	case MENU_OPTIONS.CCONTROLS:
		
		while (true)
		{
			var curr_option = option[index];
			
			if (!is_string(curr_option))
			{
				break;
			}
			
			var control_name = string_lower(curr_option);
			var control = variable_struct_get(global.controls, control_name);
			var bind = control_bind(control.controller, true);
			
			if (changing_controls && selected == index)
			{
				bind = "---";
			}
			
			draw_text(
				x,
				y + spacing * index,
				string("{0} Button: {1}", curr_option, bind)
			);
			
			index++;
		}
		
	break;
	
	
	case MENU_OPTIONS.OPTIONS:
	case MENU_OPTIONS.ONLINE:
		index = 0;
	break;
}


for (var i = index; i < length; i++)
{
	var curr_option = option[i];
	
	draw_text(x, y + spacing * i, curr_option.label + curr_option.get_value());
}


draw_sprite(sprCherry, 0, x - 20, y + 15 + spacing * selected);

// BOTTOM PROMPTS
draw_set_font(fntMenu3);
draw_set_halign(fa_center);

if (menu == MENU_OPTIONS.CCONTROLS)
{
	if (changing_controls)
	{
		draw_text(400, 550, "Press a button...");
	}
	else if (!global.controllerConnected)
	{
		draw_text(400, 550, "No controller connected");
	}
	else
	{
		draw_text(
			225,
			550,
			string(
				"[{0}] Back",
				control_bind(global.controls_menu.back.controller, true)
			)
		);
		
		draw_text(
			550,
			550,
			string(
				"[{0}] Accept",
				control_bind(global.controls_menu.accept.controller, true)
			)
		);
	}
}
else if (menu == MENU_OPTIONS.KCONTROLS)
{
	if (changing_controls)
	{
		draw_text(400, 550, "Press a key...");
	}
	else
	{
		draw_text(225, 550, string("[{0}] Back", control_bind(global.controls_menu.back.keyboard)));
		
		draw_text(550, 550, string( "[{0}] Accept", control_bind(global.controls_menu.accept.keyboard)));
	}
}
else
{
	var back_bind;
	var accept_bind;
	
	if (global.controllerConnected)
	{
		back_bind = control_bind(global.controls_menu.back.controller, true);
		accept_bind = control_bind(global.controls_menu.accept.controller, true);
	}
	else
	{
		back_bind = control_bind(global.controls_menu.back.keyboard);
		accept_bind = control_bind(global.controls_menu.accept.keyboard);
	}
	
	draw_text(225, 550, string("[{0}] Back", back_bind));
	draw_text(550, 550, string("[{0}] Accept", accept_bind));
}

draw_set_halign(fa_left);