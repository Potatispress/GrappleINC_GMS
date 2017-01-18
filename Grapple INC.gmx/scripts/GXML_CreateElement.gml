///GXML_CreateElement(Tag)

var Tag = argument0;

// Create a list DS for the element's content.
var ContentList = ds_list_create();

// Create a map DS for the element's attributes.
var ElementMap = ds_map_create();

// Set the tag on the occupied key "GXML_TAG"
ElementMap[? "GXML_TAG"] = Tag;
// Set a flag on the occupied key "GXML_MARKUP", for internal checks.
ElementMap[? "GXML_MARKUP"] = true;
// Set the content list on the occupied key "GXML_CONTENT".
ElementMap[? "GXML_CONTENT"] = ContentList;

// Return the element - which is really just a ds_map.
return ElementMap;
