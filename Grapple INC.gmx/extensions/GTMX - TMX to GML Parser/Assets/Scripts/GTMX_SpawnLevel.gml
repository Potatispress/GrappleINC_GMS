///GTMX_SpawnLevel(Map)

var Map = argument0;

var SpawnedLevel = ds_map_create();

var SpawnedTiles = ds_list_create();
var SpawnedObjects = ds_list_create();

SpawnedLevel[? "tiles"] = SpawnedTiles;
SpawnedLevel[? "objects"] = SpawnedObjects;

var LayerCount = GTMX_GetMapLayerCount(Map);

var TileWidth = GTMX_GetMapProperty(Map, "tilewidth");
var TileHeight = GTMX_GetMapProperty(Map, "tileheight");


var DefaultDepth = 1000;

for(var LayerIndex = 0; LayerIndex < LayerCount; LayerIndex++) {
    var LayerData = GTMX_GetMapLayer(Map, LayerIndex);
    
    for(var tX = 0; tX < ds_grid_width(LayerData); tX++) {
        for(var tY = 0; tY < ds_grid_height(LayerData); tY++)  {
            var GlobalID = LayerData[# tX, tY];
            if(GlobalID != 0) {
                ds_list_add(
                    SpawnedTiles,
                    GTMX_SpawnTile(
                        GTMX_GetMapTileType(Map, GlobalID),
                        tX * TileWidth,
                        tY * TileHeight,
                        DefaultDepth - LayerIndex
                    )
                );
            }
        }
    }
}

var ObjectCount = GTMX_GetMapObjectCount(Map);

for(var ObjectIndex = 0; ObjectIndex < ObjectCount; ObjectIndex++) {
    var ObjectData = GTMX_GetMapObject(Map, ObjectIndex);
    
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
                        Instance.image_yscale = ObjectData[? "height"] / TileType[? "tileheight"];
                        
                    }
                    if(ds_map_exists(ObjectData, "rotation")) {
                        Instance.image_angle = -ObjectData[? "rotation"];
                        Instance.phy_rotation = ObjectData[? "rotation"];
                    }
                    
                    ds_list_add(SpawnedObjects, Instance);
                }
            }
        }
    }
}

return SpawnedLevel;
