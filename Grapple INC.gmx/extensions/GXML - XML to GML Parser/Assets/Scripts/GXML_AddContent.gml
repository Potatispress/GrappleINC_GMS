///GXML_AddContent(InElement, Content)

var ElementMap = argument0;
var Content = argument1;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to add content - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}
// Check if the variables are valid, else throw an error.
if(is_undefined(Content)) {
    show_error("Failed to add content - content undefined: " + string(Content), true);
    return 0;
}

// Add the content to the content list in the element map.
ds_list_add(GXML_GetContentList(ElementMap), Content);

return 1;
