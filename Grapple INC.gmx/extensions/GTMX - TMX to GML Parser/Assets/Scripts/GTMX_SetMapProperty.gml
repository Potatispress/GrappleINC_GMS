///GTMX_SetMapProperty(Map, PropertyName, PropertyValue)

var Map = argument0;
var PropertyName = argument1;
var PropertyValue = argument2;

var MapProperties = Map[? "properties"];
MapProperties[? PropertyName] = PropertyValue;
