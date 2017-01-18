///GXML_GetAttribute(InElement, AttributeName)

var ElementMap = argument0;
var AttributeName = argument1;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to get attribute - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}

// Check if the name exists, else throw an error.
if(!GXML_AttributeExists(ElementMap, AttributeName)) {
    show_error("Failed to get attribute - attribute name invalid: " + string(AttributeName), true);
    return 0;
}

return ds_map_find_value(ElementMap, AttributeName);
