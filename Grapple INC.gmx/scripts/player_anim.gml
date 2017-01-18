
draw_self();

curSpd = phy_speed_x;
curHSpd = phy_speed_y;

var breakSpd = 3 * global.timeM;
var runSpd = 1.5 * global.timeM;

if(instance_exists(obj_hook_two)){
    if(obj_hook_two.isHooked){
        breakSpd *= 0.2;
        runSpd *= 0.2;
    }
}

if (curSpd > 0){
    facing = 1;
}
if (curSpd < 0){
    facing = 0;
}

if (!onGround){
    if (curHSpd < -0.1){
        if (curSpd > 0.1){
            sprite_index = spr_player_jump_R;
        } else {
            sprite_index = spr_player_jump_L;
        }
    } else if (curHSpd > -0.1){
        if (curSpd > 0.1){
            sprite_index = spr_player_fall_R;
        } else {
            sprite_index = spr_player_fall_L;
        }
    }
} else {
    if (curSpd > 0.1){
        
        if (curSpd < oldSpd && curSpd < breakSpd){
        
            sprite_index = spr_player_brake_R;
        
        } else if (curSpd < runSpd){
            sprite_index = spr_player_start_R;
        
        } else if(curSpd > runSpd) {
        
            sprite_index = spr_player_run_R;
        }
    } else if(curSpd < -0.1){
        if (curSpd > oldSpd && curSpd > -breakSpd){
        
            sprite_index = spr_player_brake_L;
        
        } else if (curSpd > -runSpd){
            sprite_index = spr_player_start_L;
        
        } else if(curSpd < -runSpd) {
        
            sprite_index = spr_player_run_L;
        }
    
    } else {
        if(facing){
            if (sprite_index != spr_player_clock_R){
                sprite_index = spr_player_idle_R;
            }
            if (!alarmed){
                alarm[0] = random_range(alarmTimeMin, alarmTimeMax);
                alarmed = true;
            }
            if (image_index == 20 && sprite_index == spr_player_clock_R){
                sprite_index = spr_player_idle_R;
            }
        } else {
            if (sprite_index != spr_player_clock_L){
                sprite_index = spr_player_idle_L;
            }
            if (!alarmed){
                alarm[0] = random_range(alarmTimeMin, alarmTimeMax);
                alarmed = true;
            }
            if (image_index == 20 && sprite_index == spr_player_clock_L){
                sprite_index = spr_player_idle_L;
            }
        }
    }
}

if(debug_mode){
    if(instance_exists(obj_hook)){
        if (obj_hook.isHooked){
            var hookDist = distance_to_object(obj_hook);
            var hookDir = degtorad (point_direction(x, y, obj_hook.x, obj_hook.y) + 90);
            
            draw_text(x - 150, y - 130, "hookDist - " + string(hookDist));
            draw_text(x - 150, y - 110, "hookDir - " + string(hookDir));
            draw_text(x - 150, y - 150, "joint Max - " + string(physics_joint_get_value(obj_hook.rope, phy_joint_max_length)));
           
        }
    }
}


oldSpd = phy_speed_x;
