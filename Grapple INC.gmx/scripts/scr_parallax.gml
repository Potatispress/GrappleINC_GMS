
//camSpd = obj_cam.x;
camPosX = obj_cam.x;
camPosY = obj_cam.y;

//background_hspeed[0] = camSpd * 0.8;
//background_hspeed[1] = camSpd * 0.7;
//background_hspeed[2] = camSpd * 0.6;
//background_hspeed[3] = camSpd * 0.5;
if(camPosX - (view_wview[0] / 2) > 0 && camPosX + (view_wview[0] / 2) < room_width){
    background_x[0] = camPosX * 0.8;
    background_x[1] = camPosX * 0.7;
    background_x[2] = camPosX * 0.6;
    background_x[3] = camPosX * 0.5;
}

if(camPosY - (view_hview[0] / 2) > 0 && camPosY + (view_hview[0] / 2) < room_height){
    background_y[0] = camPosY * 0.62 -200;
    background_y[1] = camPosY * 0.55 + 30;
    background_y[2] = camPosY * 0.48 + 110;
    background_y[3] = camPosY * 0.41 + 40;
}
