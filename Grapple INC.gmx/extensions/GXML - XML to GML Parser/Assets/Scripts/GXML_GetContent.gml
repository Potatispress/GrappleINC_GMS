///GXML_GetContent(InElement, ContentIndex)

var ElementMap = argument0;
var ContentIndex = argument1;

// Get and temporarily save the list's ds index.
var ContentList = GXML_GetContentList(ElementMap);

// Check if the index is within list bounds, else throw an error.
if(ContentIndex < 0 || ContentIndex >= ds_list_size(ContentList)) {
    show_error("Failed to get content - index " + string(ContentIndex) + " out of range!", true);
    return 0;
}

return ContentList[| ContentIndex];
