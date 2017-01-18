///cam_create()


cam = instance_create(x + 220,y + 100,obj_cam);
view_object = cam;
view_hborder = view_wview/2;
view_vborder = view_hview/2;

h_dist = 0;
v_dist = 0;

cam.xTo = x + h_dist;
cam.yTo = y - v_dist;

camOffset = 1;

cam_spd = 15;
