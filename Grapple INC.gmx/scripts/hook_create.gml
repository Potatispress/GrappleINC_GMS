
jointList = ds_list_create();
phy_bullet = true;

phyRoomPtM = 0.05;
var spd = 0.8 * global.timeM;
var dir = degtorad (point_direction(x,y, mouse_x, mouse_y) + 90); //+90 cuz game maker sucks
owner = obj_player;
minDist = 1;
maxDist = 15.5;

isHooked = false;

show_debug_message(dir);

var xSpd = sin(dir) * spd;
var ySpd = cos(dir) * spd;

physics_apply_impulse(phy_com_x, phy_com_y, xSpd, ySpd);

audio_play_sound(snd_hook_shoot, 80, false);
