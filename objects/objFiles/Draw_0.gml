for (var i = 0; i < global.total_saves; i++) {
	var data = datas[i];
    draw_sprite(sprFilesBar, 0, x - 32, y + spacing * i);
	
	//Name
    draw_set_alpha(1);
	draw_set_font(fntMenu);
    draw_set_color(c_black);
	draw_set_halign(fa_left);
    draw_text(x, y + spacing * i, string("Data{0}", i + 1));
    
	//Difficulty
	draw_set_font(fntMenu2);
	draw_set_halign(fa_center);
    
    var draw_diff = data.difficulty;
    
    if (menu == 1 && select[0] == i) {
        draw_diff = string("< {0} >", global.difficulties[select[menu]]);
    }
    
    draw_text(x + 48, y + 46 + spacing * i, draw_diff);
    
	//Deaths and Time
	draw_set_font(fntMenu3);
    draw_set_halign(fa_left);
    draw_text(x, y + 78 + spacing * i, string("Deaths: {0}", data.deaths));
    draw_text(x, y + 100 + spacing * i, string("Time: {0}", formatted_time(data.time)));
    
	//Secrets and Bosses
    for (var j = 0; j < array_length(global.items.secrets); j++) {
        draw_sprite_ext(images_secrets[j], 0, x + 160 + 32 * j, y + 16 + spacing * i, 1, 1, 0, (data.items.secrets[j]) ? c_white : c_black, 1);
    }
    
    for (var j = 0; j < array_length(global.items.bosses); j++) {
        draw_sprite_ext(images_bosses[j], 0, x + 160 + 32 * j, y + 48 + spacing * i, 1, 1, 0, (data.items.bosses[j]) ? c_white : c_black, 1);
    }
      
	//Clear
    if (data.clear) {
		draw_set_font(fntMenu4);
        draw_set_halign(fa_center);
        draw_text(x + 284, y + 92 + spacing * i, "Clear!");
    }
        
    if (select[0] == i) {
        draw_sprite(sprCherry, 0, 52, y + 60 + spacing * i);
        draw_sprite(sprCherry, 0, room_width - 56, y + 60 + spacing * i);
    }
}

draw_set_font(fntMenu3);
draw_set_halign(fa_center);

var back_bind;
var options_bind;
var accept_bind;

if (global.controllerConnected = false)
{
	back_bind = control_bind(global.controls_menu.back.keyboard);
	accept_bind = control_bind(global.controls_menu.accept.keyboard);
	options_bind = control_bind(global.controls_menu.options.keyboard);
}else
{
	back_bind = control_bind(global.controls_menu.back.controller, true);
	accept_bind = control_bind(global.controls_menu.accept.controller, true);
	options_bind = control_bind(global.controls_menu.options.controller, true);
}
	
draw_text(225, 550, string("[{0}] Back", back_bind));
draw_text(380, 550, string("[{0}] Options", options_bind));
draw_text(550, 550, string("[{0}] Accept", accept_bind));
draw_set_halign(fa_left);