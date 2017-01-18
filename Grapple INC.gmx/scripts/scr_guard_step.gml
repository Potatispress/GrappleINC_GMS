
onGround = collision_circle(phy_com_x, phy_com_y + 10.5, 0.7, obj_block, false, true);

if(distance_to_point(obj_player.x, obj_player.y) < range){
    inRange = true;
} else {
    inRange = false;
}

if(collision_line(x + offSetX,y + offSetY, obj_player.phy_com_x, obj_player.phy_com_y, obj_block, false, true)){
    lineOfSight = false;
} else {
    lineOfSight = true;
}

if(readyToShoot && lineOfSight && !isHookedOn && inRange){
    instance_create(phy_com_x - 2, phy_com_y - 5, obj_enemy_bullet);
    readyToShoot = false;
    audio_play_sound(snd_gun_shot, 70, false);
    alarm[0] = 20;
}

if(!lineOfSight || isHookedOn || !inRange){
    readyToShoot = false;
    aiming = true;
    alarm[0] = 999999;
    alarm[1] = 999999;
    if(!isHookedOn && onGround){
        sprite_index = spr_guard_idle;
    }
}

if(lineOfSight && aiming && !isHookedOn && inRange && onGround){
    alarm[1] = 60;
    aiming = false;
    sprite_index = spr_guard_aim;
    audio_play_sound(snd_detected, 50, false);
}


if(!instance_exists(obj_hook_two) && isHookedOn && onGround){
    isHookedOn = false;
    phy_rotation = 0;
    phy_fixed_rotation = true;
    sprite_index = spr_guard_idle;
    image_speed = 1;
}

if(!onGround && sprite_index != spr_guard_panic){
    sprite_index = spr_guard_panic;
    image_speed = 0.1;
}


