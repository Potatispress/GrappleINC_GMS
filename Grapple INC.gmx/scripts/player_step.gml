///player_step()



var horAxis = keyboard_check(keyRight) - keyboard_check(keyLeft);
var jump = keyboard_check_pressed(keyJump);
var gndDetDist = 2;
var yForce = 0.3;
onGround = collision_circle(x, y + player_height / 2, gndDetDist, obj_block, false, true);//kollar om du står på något!

if(mouse_check_button_pressed(keySlow) && global.slowMotion){
    global.timeM = 0.2;
    phy_speed_x *= global.timeM;
    phy_speed_y *= global.timeM;
    physics_world_gravity(0 , 0.95);
    phy_angular_damping *= global.timeM;
    physics_fixture_set_density(fix, 0.1 * global.timeM);
    physics_fixture_set_linear_damping(fix, 0.1 * global.timeM);
    maxSpd *= global.timeM;
    jumpForce *= global.timeM;
    image_speed *= global.timeM;
}
if(mouse_check_button_released(keySlow) && global.slowMotion){
    
    phy_speed_x /= global.timeM;
    phy_speed_y /= global.timeM;
    physics_world_gravity(0 , 25);
    phy_angular_damping /= global.timeM;
    physics_fixture_set_density(fix, 0.1 / global.timeM);
    physics_fixture_set_linear_damping(fix, 0.1 / global.timeM);
    maxSpd /= global.timeM;
    jumpForce /= global.timeM;
    image_speed /= global.timeM;
    global.timeM = 1;
}

var xForce = moveForce * horAxis * global.timeM;
yForce *= global.timeM;


if(onGround) {
    if(jump) {
        physics_apply_impulse(phy_com_x, phy_com_y, 0, jumpForce);
        instance_create(x, y + 9, obj_particle_jump);
        canJump = false;
        alarm[4] = 40;
    }
} else { //not on ground! :D
    xForce *= 0.2;
    if(jump) {
        
        if(instance_exists(obj_hook)){
            if(obj_hook.isHooked && canJump){
                physics_apply_impulse(phy_com_x, phy_com_y, 0, jumpForce*0.8);
                instance_create(x, y + 9, obj_particle_jump);
                canJump = false;
                alarm[4] = 40;
            }
            with(obj_hook)
                instance_destroy();
        } else if(instance_exists(obj_hook_two)){
            with(obj_hook_two)
                instance_destroy();
        }
        
    }
    
}

if(horAxis == -sign(phy_speed_x) && horAxis != 0){
    if(onGround){
        xForce *= 0.4;
    } else {    
        xForce *= 1.8;
    }
}

if(instance_exists(obj_hook)){
    if (obj_hook.isHooked){
        if (phy_speed_x < maxSpd && phy_speed_x > -maxSpd && onGround){
            physics_apply_force(phy_com_x, phy_com_y, xForce, 0);
        } else {
            if (xForce != 0 && !onGround){
                if(instance_exists(obj_hook_two)){
                    if (obj_hook_two.isHooked){
                        xForce *= 1.5;
                        
                        
                        
                    } else {
                        //xForce *= 2;
                    }
                }
                
                physics_apply_force(phy_com_x, phy_com_y, xForce, yForce);
            }
        }
    }
} else {
    if (phy_speed_x < maxSpd && phy_speed_x > -maxSpd || horAxis == -sign(phy_speed_x)){
        physics_apply_force(phy_com_x, phy_com_y, xForce, 0);
    }
}

if(keyboard_check_pressed(ord('T'))){
    global.slowMotion = !global.slowMotion;
}
if(keyboard_check_pressed(ord('Y'))){
    hookToggling = !hookToggling;
}

if(keyboard_check_released(ord('R'))) {
    alarm[2] = 1;
}
if(keyboard_check_released(ord('L'))) {
    room_restart();
}

if(keyboard_check_released(vk_add)) {
    room_goto_next();
}
if(keyboard_check_released(vk_subtract)) {
    room_goto_previous();
}

if(keyboard_check_released(vk_escape)) {
    game_end();
}

if(mouse_check_button_released(mb_left) && !hookToggling) {
    if (instance_exists(obj_hook)){
        with (obj_hook){
            instance_destroy();
        }
        physics_apply_impulse(phy_com_x, phy_com_y, 0, -yForce*0.3);
    }    
}
if(mouse_check_button_pressed(mb_left)) {
    if (!instance_exists(obj_hook)){
        instance_create(x,y, obj_hook);
    } else {
        with (obj_hook){
            instance_destroy();
        }
        if(xForce){
            physics_apply_impulse(phy_com_x, phy_com_y, 0, -yForce*0.3);
        }
    }    
}
    

if(mouse_check_button_pressed(mb_right) && !global.slowMotion){
    
    if (!instance_exists(obj_hook_two)){
        instance_create(x,y, obj_hook_two);
    } else {
        with (obj_hook_two){
            instance_destroy();
        }
    }
}


if (!onGround){
    physics_set_friction(fix_player, 0.2);
} else {
    physics_set_friction(fix_player, 2);
    if(wasInAir){
        show_debug_message("landed");
        alarm[1] = 4;
        canJump = true;
    }
}

/*
if(keyboard_check(vk_alt)){
    physics_apply_force(phy_com_x, phy_com_y, 0, 30);
}
*/

if(instance_exists(obj_hook)){
    if (obj_hook.isHooked){
        var hookDist = distance_to_object(obj_hook);
        var hookDir = degtorad (point_direction(x, y, obj_hook.x, obj_hook.y) + 90);
        var ropeDist = physics_joint_get_value(obj_hook.rope, phy_joint_max_length);
        
        if(hookDist > ropeDist) {
            var ropeRest = 20;
            var difDist = hookDist - ropeDist;
            
            var xForce = sin(hookDir) * pullForce * (difDist / ropeRest);
            var yForce = cos(hookDir) * pullForce * (difDist / ropeRest);
            physics_apply_force(phy_com_x, phy_com_y, xForce, yForce);
        }
        
        //obj_player physics_apply_force(x,y,x,y);
    }
}

if(y > room_height + 150){
    alarm[2] = 1; 
}

wasInAir = !onGround;
