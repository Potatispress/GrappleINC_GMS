///GXML_DestroyElement(Element, Recursive)

var ElementMap = argument0;
var Recursive = argument1;

// Check if the element exists, else throw an error.
if(!GXML_IsElement(ElementMap)) {
    show_error("Failed to destroy element - no element with the index " + string(ElementMap) + " exists!", true);
    return 0;
}

var ContentList = GXML_GetContentList(ElementMap);

// If Recursive, we go through the content and destroy all found sub elements.
if(Recursive) {
    for(var ContentIndex = 0; ContentIndex < ds_list_size(ContentList); ContentIndex++) {
        if(GXML_IsElement(ContentList[| ContentIndex])) {
            GXML_DestroyElement(ContentList[| ContentIndex], Recursive);
        }
    }
}

ds_list_destroy(ContentList);
ds_map_destroy(ElementMap);

return 1;
