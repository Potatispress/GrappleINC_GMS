
curDist = 0.05 * point_distance(obj_hook.x, obj_hook.y, obj_hook_two.x, obj_hook_two.y);

connectRope = physics_joint_rope_create(obj_hook, obj_hook_two, obj_hook.phy_com_x, obj_hook.phy_com_y, obj_hook_two.phy_com_x, obj_hook_two.phy_com_y, 0, false);

physics_joint_set_value(connectRope, phy_joint_max_length, curDist + 0.2);

connected = true;

show_debug_message("Connected hooks!");
