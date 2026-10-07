draw_set_font(fntTitle);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(400, 40, "KingSlendy\nRedBatNick\nTwistedB\nGMS2 Engine");

var accept_bind;

if (global.controllerConnected = false)
{
	accept_bind = control_bind(global.controls_menu.accept.keyboard);
}else
{
	accept_bind = control_bind(global.controls_menu.accept.controller, true);
}

draw_set_font(fntMenu3);
draw_text(380, 550, string("[{0}] Start", accept_bind));
draw_set_halign(fa_left);