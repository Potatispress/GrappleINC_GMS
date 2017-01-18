///GXML_AddAttribute(InElement, AttributeName, AttributeValue)

var ElementMap = argument0;
var AttributeName = argument1;
var AttributeValue = argument2;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to add attribute - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}
// Check if the variables are valid, else throw an error.
if(is_undefined(AttributeName) || is_undefined(AttributeValue)) {
    show_error(
        "Failed to add attribute - name and/or value undefined: " + 
        string(AttributeName) + "=" + string(AttributeValue), true
    );
    return 0;
}

// Set the key in the map to the value.
ElementMap[? AttributeName] = AttributeValue;

return 1;
