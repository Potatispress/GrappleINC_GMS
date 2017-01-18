///GTMX_AddMapProperty(InMap, GXML_PropertyElement)

var Map = argument0;
var PropertyElement = argument1;

GTMX_SetMapProperty(
    Map,
    GXML_GetAttribute(PropertyElement, "name"),
    GXML_GetAttribute(PropertyElement, "value")
);
