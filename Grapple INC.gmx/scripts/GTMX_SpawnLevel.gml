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
                        TileWidth,
                        TileHeight,
                        DefaultDepth - LayerIndex
                    )
                );
            }
        }
    }
}

var ObjectCount = GTMX_GetMapObjectCount(Map);

for(var ObjectIndex = 0; ObjectIndex < ObjectCount; ObjectIndex++) {
    var Instance = GTMX_SpawnObject(GTMX_GetMapObject(Map, ObjectIndex));
    if(Instance) {
        ds_list_add(SpawnedObjects, Instance);
    }
}

return SpawnedLevel;
