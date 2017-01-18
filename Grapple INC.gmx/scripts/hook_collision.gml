///hook_collision()

// --- Must be run in a collision event! ---


// if there somehow was no collision, stop the script, else it'd crash!
// also, if the hook is already hooked, simply quit the script 
curDist = phyRoomPtM * point_distance(x, y, obj_player.x, obj_player.y);
if (curDist > maxDist && !isHooked) {
    instance_destroy();
} else {
    if(phy_collision_points == 0 || isHooked) {
        return false;
    }
    
    isHooked = true;
    
    
    var colInst = other; // In a collision event, other returns the collision-instance
    colx = phy_collision_x[0];
    coly = phy_collision_y[0];
    
    phy_position_x = colx;
    phy_position_y = coly;
    
    
    var weld = physics_joint_weld_create(id, colInst, colx, coly, 0, 10, 12, true);
    
    distance = point_distance(x, y, owner.phy_com_x, owner.phy_com_y);
    rope = physics_joint_rope_create(id, owner, phy_com_x, phy_com_y, owner.x, owner.y, 2, false);
    
    physics_joint_set_value(rope, phy_joint_max_length, curDist + 0.2);
    
    if(instance_exists(self)){
        ds_list_add(jointList, weld);
        ds_list_add(jointList, rope);
    }
    //Fixa fixture och cillision group stuff
    //physics_fixture_set_collision_group( , 1);
    /*
    if(instance_exists(obj_hook)&&instance_exists(obj_hook_two)){
        with(obj_player){
            scr_doubleHook_create();
        }
    }*/
}

/*

// Chain for visuals, play with at your own risk!

chainFix = physics_fixture_create();

physics_fixture_bind(chainFix, id);

physics_fixture_set_chain_shape(chainFix, false);


var chainPartLength = 16;
var ownerAngle = arctan2(owner.y - y, owner.x - x);

for(var i = 0; i < distance / chainPartLength; i += chainPartLength) {
    var fixX = sin(ownerAngle) * i;
    var fixY = cos(ownerAngle) * i;
    
    physics_fixture_add_point(chainFix, fixX, fixY);
}
*/

//sprite_set_offset(spr_hook, 3,3)

//instance_destroy();
