/// @function sc_Shake(time,intensity);
/// @param {real} time How long to shake
/// @param {real} intensity How much to shake
function scrShake(_time,_intensity){
if instance_number(objShake) = 0 then instance_create_depth(0,0,0,objShake)
    with (objShake) {
    shakelen = _time
    shakeint = _intensity }
}

/// @function scrFlash(time,intensity);
/// @param {real} how long the flash should hold
/// @param {real} fade out speed
function scrFlash(_time,_fade){
if instance_number(objFlash) = 0 then instance_create_depth(0,0,-500,objFlash)
    with (objFlash) {
    flashlen = _time
    flashfade = _fade }
}

function InvertColors()
{
    gpu_set_blendmode_ext(bm_inv_dest_colour,bm_zero);
    draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_white,c_white,false);
    gpu_set_blendmode(bm_normal);
}

function c_rainbow (divider) {
	randomize ()
	var rainbow = make_color_hsv ((current_time / divider) mod 255,255,255);
	return rainbow;
} 
