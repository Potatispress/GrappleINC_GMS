///GTMX_SpawnObject(ObjectData)

var ObjectData = argument0;

if(ds_map_exists(ObjectData, "tiletype")) {
    var TileType = ObjectData[? "tiletype"];
    
    if(ds_exists(TileType[? "properties"], ds_type_map)) {
        var TileProperties = TileType[? "properties"];
        
        if(ds_map_exists(TileProperties, "object_type")) {
            var ObjectTypeName = TileProperties[? "object_type"];
            
            var FoundObject = false;
            var ObjectIndexCounter = 0;
            while(object_exists(ObjectIndexCounter)) {
                if(object_get_name(ObjectIndexCounter) == ObjectTypeName) {
                    FoundObject = true;
                    break;
                }
            
                ObjectIndexCounter++;
            }
            if(FoundObject) {
                var Instance = instance_create(ObjectData[? "x"], ObjectData[? "y"], ObjectIndexCounter);
                
                if(ds_map_exists(ObjectData, "width")) {
                    Instance.image_xscale = ObjectData[? "width"] / TileType[? "tilewidth"];
                }
                if(ds_map_exists(ObjectData, "height")) {
                    Instance.y -= ObjectData[? "height"];
                    Instance.image_yscale = ObjectData[? "height"] / TileType[? "tileheight"];
                }
                if(ds_map_exists(ObjectData, "rotation")) {
                    Instance.image_angle = -ObjectData[? "rotation"];
                    Instance.phy_rotation = ObjectData[? "rotation"];
                }
                switch(ObjectTypeName) {
                    case "obj_block_static":
                    case "obj_block_noGrapple":
                    case "obj_spike":
                        with(Instance) {
                            block_collision_setup();
                        }
                        break;
                    default: 
                        break;
                }
                
                return Instance;
            }
        }
    }
}

return -1;
