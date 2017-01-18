// Camera movement
cam.xTo = x + h_dist;
cam.yTo = y + v_dist;

/*
if (onGround){
    v_dist = 40;
} else {
    v_dist = 0;
}
*/

if(keyboard_check_pressed(vk_shift)){
    camOffset = 2;
}
if(keyboard_check_released(vk_shift)){
    camOffset = 1;
}

var mouseDist = distance_to_point(mouse_x, mouse_y);
var mouseDir = degtorad (point_direction(x, y, mouse_x, mouse_y) + 90);

h_dist = sin(mouseDir) * mouseDist * 0.3 * camOffset + phy_speed_x * 20;
v_dist = cos(mouseDir) * mouseDist * 0.3 * camOffset + phy_speed_y * 15;


cam.x += (cam.xTo-cam.x)/cam_spd;
cam.y += (cam.yTo-cam.y)/cam_spd;
