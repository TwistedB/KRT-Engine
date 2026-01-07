draw_set_font(fntArial)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_alpha(0.7)
draw_rectangle_color(96,456,704,596,c_black,c_black,c_black,c_black,false)

draw_set_alpha(1)
draw_text_ext(128,472,drawntext,26,472)
if choicecount > 0
{
    draw_set_alpha(0.7)
    draw_rectangle_color(272,296,528,432,c_black,c_black,c_black,c_black,false)
    
    draw_set_halign(fa_middle)
    draw_set_valign(fa_center)
    for(i = 0; i < choicecount; i += 1)
        draw_text(400,296+32*i,dialoguechoice[i])
    
    draw_set_alpha(0.5+lengthdir_y(30,current_time/10)*0.1)
    gpu_set_blendmode_ext(bm_inv_dest_color,bm_inv_dest_color)
    draw_rectangle_color(272,296+32*choice,528,328+32*choice,c_white,c_white,c_white,c_white,false)
    gpu_set_blendmode(bm_normal)
}
draw_sprite_ext(dialogueimage[currentimage],faceindex,650,464+68,-2,2,0,c_white,1)