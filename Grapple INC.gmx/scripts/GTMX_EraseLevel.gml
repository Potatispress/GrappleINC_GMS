///GTMX_EraseLevel(Level)

var Level = argument0;
var SpawnedTiles = Level[? "tiles"];
var SpawnedObjects = Level[? "objects"];

for(var TileIndex = 0; TileIndex < ds_list_size(SpawnedTiles); TileIndex++) {
    tile_delete(SpawnedTiles[| TileIndex]);
}
for(var ObjectIndex = 0; ObjectIndex < ds_list_size(SpawnedObjects); ObjectIndex++) {
    if(instance_exists(SpawnedObjects[|ObjectIndex])) {
        with(SpawnedObjects[|ObjectIndex]) {
            instance_destroy();
        }
    }
}

ds_list_destroy(SpawnedTiles);
ds_map_destroy(Level);
