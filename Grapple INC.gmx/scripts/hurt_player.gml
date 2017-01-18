///hurt_player(damage)

var damage = argument0;

if( !obj_player.isInvul) {
    obj_player.health -= damage;
    if(obj_player.health <= 0) {
        //TODO: dead state!
        game_restart();
    } else {
        obj_player.isInvul = true;
        obj_player.alarm[0] = room_speed;
    }
}
