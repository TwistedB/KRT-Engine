//end step
var cam = camera_properties(0);

if (instance_exists(targetObject)) {
	target_x = targetObject.x - cam.view_w / 2;
	target_y = targetObject.y - cam.view_h / 2;
}

now_x = lerp(now_x, target_x, CAM_SMOOTH);
now_y = lerp(now_y, target_y, CAM_SMOOTH);

if (!leave_room) {
	now_x = clamp(now_x, 0, room_width - cam.view_w);
	now_y = clamp(now_y, 0, room_height - cam.view_h);
}

if(instance_exists(objShake))
{
	camera_set_view_pos(cam.view_cam, now_x+objShake.shakex, now_y+objShake.shakey);
	camera_set_view_size(cam.view_cam, camWidth*RES_SCALE, camHeight*RES_SCALE);
}else
{
	camera_set_view_pos(cam.view_cam, now_x, now_y);
	camera_set_view_size(cam.view_cam, camWidth*RES_SCALE, camHeight*RES_SCALE);
}

CAM_SMOOTH = ogSmooth;

