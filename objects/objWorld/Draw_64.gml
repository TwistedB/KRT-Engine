#region Debug Overlay
if (global.overlay && global.debug_enable) {
    var spacing = 20;
    draw_set_font(fntMenu3);
	draw_set_color(c_white);

	#region Initialize Overlay Variables
    var xx = "N/A";
	var hspd = "N/A";
		
    var yy = "N/A";
    var vspd = "N/A";
		
	var align = "N/A";
    var align_relative = "N/A";
		
	var angle = "N/A";
		
	var grav = "N/A";
	var grav_dir = "N/A";
		
	var jump_left = "N/A";
	var jump_total = "N/A";
	#endregion
		
	#region Set Overlay Variables
    if (instance_exists(objPlayer)) {
        xx = objPlayer.x;
		hspd = objPlayer.hspd;
			
        yy = objPlayer.y;
        vspd = objPlayer.vspd;
			
		align = objPlayer.max_hspd % 3;
		align_relative = xx % 3;
		
		angle = objPlayer.image_angle;
			
		grav = objPlayer.grav_amount;
		grav_dir = objPlayer.gravity_direction;
			
		jump_left = objPlayer.jump_left;
		jump_total = objPlayer.jump_total;
    }
	#endregion
		
	#region Draw Overlay Info
	var info = [
		string("FPS: {0} (real: {1})", fps, fps_real),
		string("X: {0} (hspd: {1})", xx, hspd),
		string("Y: {0} (vspd: {1})", yy, vspd),
		string("Align: {0} (relative: {1})", align, align_relative),
		string("Angle: {0}", angle),
		string("Gravity: {0} (direction: {1})", grav, grav_dir),
		string("Jumps: {0} (total: {1})", jump_left, jump_total),
		string("Room: {0} (number: {1})", room_get_name(room), room),
		string("Object counter: {0}", instance_count),
	];
		
	var length = array_length(info);
	if (!global.debug_enable) {
		length = 6;
	} if (!global.game_started) {
		length = 1;
	}
		
	for (var i = 0; i < length; i++) {
		draw_text_outline(20, 20 + spacing * i, info[i], c_black);
	}
	#endregion
	
    if (room = rTitle) {
		draw_set_color(c_red);
        draw_text_outline(20, 20, "Debug Mode", c_black);
    }
}
#endregion

#region Black Bars
if(global.display.fullscreen)
{
	var windowWidth = window_get_width();
	var windowHeight = window_get_height();

	var guiWidth = display_get_gui_width();
	var guiHeight = display_get_gui_height();

	var offsetX = (windowWidth - guiWidth) / 2;
	var offsetY = (windowHeight - guiHeight) / 2;

	draw_set_color(c_black);

	// Left
	draw_rectangle(-offsetX, 0, -1, guiHeight, false);

	// Right
	draw_rectangle(guiWidth, 0, guiWidth + offsetX, guiHeight, false);

	draw_set_color(c_white);
}
#endregion