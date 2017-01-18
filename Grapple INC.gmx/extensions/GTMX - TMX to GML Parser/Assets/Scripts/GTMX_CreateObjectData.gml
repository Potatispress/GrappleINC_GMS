///GTMX_CreateObjectData(InMap, GXML_ObjectGroup)

var Map = argument0;
var ObjectGroupElement = argument1;
var ObjectCount = GXML_GetContentCount(ObjectGroupElement);

var TileTypes = Map[? "tiletypes"];
var ObjectAddList = Map[? "objects"];

for(var ObjectIndex = 0; ObjectIndex < ObjectCount; ObjectIndex++) {
    
    var Object = GXML_GetContent(ObjectGroupElement, ObjectIndex);
    
    var ObjectMap = ds_map_create();
    ObjectMap[? "id"] = real(GXML_GetAttribute(Object, "id"));
    ObjectMap[? "x"] = real(GXML_GetAttribute(Object, "x"));
    ObjectMap[? "y"] = real(GXML_GetAttribute(Object, "y"));
            
    if(GXML_AttributeExists(Object, "width")) {
        ObjectMap[? "width"] = real(GXML_GetAttribute(Object, "width"));
    }
    if(GXML_AttributeExists(Object, "height")) {
        ObjectMap[? "height"] = real(GXML_GetAttribute(Object, "height"));
    }
    if(GXML_AttributeExists(Object, "rotation")) {
        ObjectMap[? "rotation"] = real(GXML_GetAttribute(Object, "rotation"));
    }
    if(GXML_AttributeExists(Object, "gid")) {
        ObjectMap[? "tiletype"] = TileTypes[| real(GXML_GetAttribute(Object, "gid"))];
    }
    // There is currently no support for shapes.
    
    ds_list_add(ObjectAddList, ObjectMap);
}
