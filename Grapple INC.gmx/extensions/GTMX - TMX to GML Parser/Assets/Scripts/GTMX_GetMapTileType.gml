///GTMX_GetMapTileType(Map, GlobalID)

var Map = argument0;
var GlobalID = argument1;

return ds_list_find_value(Map[? "tiletypes"], GlobalID);
