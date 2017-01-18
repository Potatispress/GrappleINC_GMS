///GXML_GetTag(InElement)

var ElementMap = argument0;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to get tag - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}

return ElementMap[? "GXML_TAG"];
