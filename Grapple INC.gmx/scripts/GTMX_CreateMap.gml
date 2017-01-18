///GTMX_CreateMap(GXML_Map)

var GXML_Map = argument0;

show_debug_message("Creating map at time: " + string(get_timer() / 1000000));

var Map = ds_map_create();

Map[? "images"]     = ds_list_create();
Map[? "tiletypes"]  = ds_list_create();
Map[? "layers"]     = ds_list_create();
Map[? "objects"]    = ds_list_create();
Map[? "properties"] = ds_map_create();

GTMX_SetMapProperty(Map, "orientation", GXML_GetAttribute(GXML_Map, "orientation"));
GTMX_SetMapProperty(Map, "renderorder", GXML_GetAttribute(GXML_Map, "renderorder"));
GTMX_SetMapProperty(Map, "width",       real(GXML_GetAttribute(GXML_Map, "width")));
GTMX_SetMapProperty(Map, "height",      real(GXML_GetAttribute(GXML_Map, "height")));
GTMX_SetMapProperty(Map, "tilewidth",   real(GXML_GetAttribute(GXML_Map, "tilewidth")));
GTMX_SetMapProperty(Map, "tileheight",  real(GXML_GetAttribute(GXML_Map, "tileheight")));

// Grapple INC specific fix :P
GTMX_SetMapProperty(Map, "filepath",    "Tiled/");

var MapContent = GXML_GetContentList(GXML_Map);

for(var ContentIndex = 0; ContentIndex < ds_list_size(MapContent); ContentIndex++) {
    var ContentElement = MapContent[| ContentIndex];
    if(!GXML_IsElement(ContentElement)) {
        continue;
    }
    var ElementTag = GXML_GetTag(ContentElement);
    
    switch(ElementTag) {
        // Add Map Properties
        case "properties": {
            for(var PropertyIndex = 0; PropertyIndex < GXML_GetContentCount(ContentElement); PropertyIndex++) {
                var PropertyElement = GXML_GetContent(ContentElement, PropertyIndex);
                if(!GXML_IsElement(PropertyElement) || GXML_GetTag(PropertyElement) != "property") {
                    continue;
                }
                GTMX_AddMapProperty(Map, PropertyElement);
            }
            break;
        }
        // Add Tileset
        case "tileset": {
            GTMX_CreateTileTypesFromTileset(Map, ContentElement);
            break;
        }
        // Add Layer
        case "layer": {
            ds_list_add(Map[? "layers"], GTMX_CreateLayerData(ContentElement)); 
            break;
        }
        // Add Objects
        case "objectgroup": {
            GTMX_CreateObjectData(Map, ContentElement);
            break;
        }
    }
}

show_debug_message("Map creation complete at time: " + string(get_timer() / 1000000));

return Map;
