///GTMX_CreateTileType(GlobalID, TileImage, LeftOffset, TopOffset, TileWidth, TileHeight, TileProperties)

var GlobalID = argument0;
var TileImage = argument1;
var LeftOffset = argument2;
var TopOffset = argument3;
var TileWidth = argument4;
var TileHeight = argument5;
var TileProperties = argument6;

var TileType = ds_map_create();

TileType[? "gid"] = GlobalID;
TileType[? "image"] = TileImage;
TileType[? "left"] = LeftOffset;
TileType[? "top"] = TopOffset;
TileType[? "tilewidth"] = TileWidth;
TileType[? "tileheight"] = TileHeight;
TileType[? "properties"] = TileProperties;

return TileType;
