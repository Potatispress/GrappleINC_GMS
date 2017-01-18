///Player Death


switch (room_get_name(room)){
    case "room_tutorial":
    case "room_level_one":
    case "room_end":
    case "room_swing":
    case "room_boxSwing":
    case "room_paralaxShowcase":{
    
        room_restart();
        break;
    }
    default:
    
    if(instance_exists(obj_hook)){
        with(obj_hook){
            instance_destroy();
        }
    }
    if(instance_exists(obj_hook_two)){
        with(obj_hook_two){
            instance_destroy();
        }
    }
    with(obj_player){
        instance_destroy();
    }
    with(obj_guard){
        instance_destroy();
    }
    
    //GTMX_EraseLevel(map_creator.Level);
    //map_creator.Level = GTMX_SpawnLevel(map_creator.Map);
    
    GTMX_QuickRespawnLevel(map_creator.Level, map_creator.Map);
    
    //room_restart();
    break;
}
