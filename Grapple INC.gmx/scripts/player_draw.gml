///player_draw()
if(instance_exists(obj_hook)){
    jointList = obj_hook.jointList;

    for(var i = 0; i < ds_list_size(jointList); i++) {
        var joint = jointList[|i];
        
        var x1 = physics_joint_get_value(joint, phy_joint_anchor_1_x);
        var x2 = physics_joint_get_value(joint, phy_joint_anchor_2_x);
        var y1 = physics_joint_get_value(joint, phy_joint_anchor_1_y);
        var y2 = physics_joint_get_value(joint, phy_joint_anchor_2_y);
        
        //show_debug_message(string(x1) + ", " + string(y1) + " - " + string(x2) + ", " + string(y2));
        
        draw_set_colour(c_black);
        draw_line(x1, y1, x2, y2);
        
    }
}
if(instance_exists(obj_hook_two)){
    //jointList = obj_hook_two.jointList;
    with(obj_hook_two) {
        for(var i = 0; i < ds_list_size(jointList); i++) {
            var joint = jointList[|i];
            
            var x1 = physics_joint_get_value(joint, phy_joint_anchor_1_x);
            var x2 = physics_joint_get_value(joint, phy_joint_anchor_2_x);
            var y1 = physics_joint_get_value(joint, phy_joint_anchor_1_y);
            var y2 = physics_joint_get_value(joint, phy_joint_anchor_2_y);
            
            //show_debug_message(string(x1) + ", " + string(y1) + " - " + string(x2) + ", " + string(y2));
            
            draw_set_colour(c_black);
            draw_line(x1, y1, x2, y2);
        }
    }
}

if(mouse_button == mb_right && global.slowMotion){
    draw_set_colour(c_red);
    var dir = degtorad (point_direction(x,y, mouse_x, mouse_y) + 90); //+90 cuz game maker sucks
    initialCheckDist = 800;
    checkDist = initialCheckDist;
    ray = collision_line(x,y - 2, x + sin(dir) * checkDist, y + cos(dir) * checkDist, obj_block, false, true);
    
    if(ray){
        //checkDist /= 2;
        for(var i = 1; i < 20; i++){
            if(collision_line(x,y - 2, x + sin(dir) * checkDist, y + cos(dir) * checkDist, obj_block, false, true)){
                checkDist -= initialCheckDist / power(2,i);
            } else {
                checkDist += initialCheckDist / power(2,i);
            }
        }
        colx = x + sin(dir) * checkDist;
        coly = y + cos(dir) * checkDist;
    } else {
        colx = x + sin(dir) * initialCheckDist;
        coly = y + cos(dir) * initialCheckDist; 
    }
    draw_line(x,y - 2, colx - 1, coly - 1 );
    draw_set_colour(c_black);
}

draw_self();

if(debug_mode) {
    draw_set_alpha(1);
    draw_set_colour(c_red);
    
    physics_draw_debug();
    
    if(!onGround) {
        draw_set_colour(c_white);
    }
    draw_circle(x, y + player_height / 2, 4, true);
    
    draw_set_colour(c_white);
}
