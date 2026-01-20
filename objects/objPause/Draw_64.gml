#region Pause Overlay
if (global.game_paused) {
	draw_sprite(pause_screen, 0, 0, 0);
	
	draw_set_alpha(0.4);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
	
	draw_set_font(fntPause);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "PAUSED");
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	draw_set_font(fntPause2);
    draw_text(20, 516, string("Master Volume: {0}%", ceil(global.display.master_volume * 100)));
    draw_text(20, 541, string("Deaths: {0}", global.deaths));
    draw_text(20, 566, string("Time: {0}", formatted_time(global.time)));
}
#endregion