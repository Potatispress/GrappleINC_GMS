///GTMX_GetMapLayer(Map, Index)

var Map = argument0;
var Index = argument1;

return ds_list_find_value(Map[? "layers"], Index);
