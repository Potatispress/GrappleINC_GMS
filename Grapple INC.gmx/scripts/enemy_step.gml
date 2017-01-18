///enemy_step()

var horAxis = sign(obj_player.x - x);
var jump = collision_circle(x + (sprite_width / 2) * horAxis, y, 16, obj_block, false, true);

var gndDetDist = 4;
var onGround = collision_circle(x, y + sprite_height / 2, gndDetDist, obj_block, false, true);

var xForce = moveForce * horAxis;

if(onGround) {
    if(jump && !hasJumped) {
        physics_apply_impulse(phy_com_x, phy_com_y, 0, jumpForce);
        hasJumped = true;
        alarm[0] = room_speed / 2;
    }
} else { //not on ground! :D
    xForce *= 0.4;
}

physics_apply_force(phy_com_x, phy_com_y, xForce, 0);
