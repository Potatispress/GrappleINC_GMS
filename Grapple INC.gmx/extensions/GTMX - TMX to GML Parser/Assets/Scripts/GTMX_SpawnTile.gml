///GTMX_SpawnTile(Type, x, y, depth)

var Type = argument0;
var TileX = argument1;
var TileY = argument2;
var TileDepth = argument3;

return tile_add(
    Type[? "image"], 
    Type[? "left"], 
    Type[? "top"], 
    Type[? "tilewidth"], 
    Type[? "tileheight"], 
    TileX, 
    TileY, 
    TileDepth
);
