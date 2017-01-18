///hook_destroy()

for(var i = 0; i < ds_list_size(jointList); i++) {
    // With ds_lists, you can use list[| index] to get or set a value. using only list[index] won't work
    physics_joint_delete(jointList[| i]);
}
ds_list_destroy(jointList);

if(obj_player.connected){
    obj_player.connected = false;

}


