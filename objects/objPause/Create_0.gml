if (instance_number(objPause) > 1) {
	instance_destroy();
	exit;
}

pause_screen = sprite_create_from_surface(application_surface, 0, 0, display_get_gui_width(), display_get_gui_height(), false, false, 0, 0);