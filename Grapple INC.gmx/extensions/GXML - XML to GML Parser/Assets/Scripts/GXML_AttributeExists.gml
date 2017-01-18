///GXML_AttributeExists(InElement, AttributeName)

var ElementMap = argument0;
var AttributeName = argument1;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to test attribute - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}

// If the name isn't undefined and exists in the element, it's valid.
return (
    !is_undefined(AttributeName) && 
    ds_map_exists(ElementMap, AttributeName)
); 

