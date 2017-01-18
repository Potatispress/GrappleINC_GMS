///GTMX_SpawnTile(Type, x, y, MapTileWidth, MapTileHeight, depth)

var Type = argument0;
var TileX = argument1;
var TileY = argument2;
var MapTileWidth = argument3;
var MapTileHeight = argument4;
var TileDepth = argument5;

return tile_add(
    Type[? "image"], 
    Type[? "left"], 
    Type[? "top"], 
    Type[? "tilewidth"], 
    Type[? "tileheight"], 
    TileX, 
    TileY - Type[? "tileheight"] + MapTileHeight, 
    TileDepth
);
