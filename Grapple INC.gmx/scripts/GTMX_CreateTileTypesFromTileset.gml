///GTMX_CreateTileTypesFromTileset(InMap, GXML_Tileset)

var Map = argument0;
var Tileset = argument1;

var MapImages = Map[? "images"];
var TileTypes = Map[? "tiletypes"];
var Path = GTMX_GetMapProperty(Map, "filepath");

var FirstGID = real(GXML_GetAttribute(Tileset, "firstgid"));

var UseTSX = GXML_AttributeExists(Tileset, "source");
if(UseTSX) {
    var TilesetSourceElement = GXML_ParseFile(Path + GXML_GetAttribute(Tileset, "source"));
    
    Tileset = GXML_GetContent(TilesetSourceElement, 1);
}

var TileWidth   = real(GXML_GetAttribute(Tileset, "tilewidth"));
var TileHeight  = real(GXML_GetAttribute(Tileset, "tileheight"));
var TileCount   = real(GXML_GetAttribute(Tileset, "tilecount"));
var Columns     = real(GXML_GetAttribute(Tileset, "columns"));

var ImageCollection = true;
var Image = -1;

var TileData = ds_list_create();

var Content = GXML_GetContentList(Tileset);

for(var ContentIndex = 0; ContentIndex < ds_list_size(Content); ContentIndex++) {
    var ContentElement = Content[| ContentIndex];
    if(GXML_IsElement(ContentElement)) {
        var Tag = GXML_GetTag(ContentElement);
        
        // If the tileset is based on a Tileset Image, we'll find that image here.
        if(Tag == "image") {
            var Source = Path + GXML_GetAttribute(ContentElement, "source");
            Image = background_add(Source, false, false);
            ds_list_add(MapImages, Image);
            
            ImageCollection = false;
        } else if(Tag == "tile") {
            var LocalTileID = real(GXML_GetAttribute(ContentElement, "id"));
            
            // Tile Properties
            var LocalTileData = ds_map_create();
            
            var LocalTileContent = GXML_GetContentList(ContentElement);
            
            for(var TileContentIndex = 0; TileContentIndex < ds_list_size(LocalTileContent); TileContentIndex++) {
                var TileContent = LocalTileContent[| TileContentIndex];
                
                var TileContentTag = GXML_GetTag(TileContent);
                if(TileContentTag == "properties") {
                    var PropertyContent = GXML_GetContentList(TileContent);
                    
                    for(var PropertyIndex = 0; PropertyIndex < ds_list_size(PropertyContent); PropertyIndex++) {
                        var PropertyElement = PropertyContent[|PropertyIndex];
                        LocalTileData[? GXML_GetAttribute(PropertyElement, "name")] = GXML_GetAttribute(PropertyElement, "value");
                    }
                } else if(TileContentTag == "image") {
                    LocalTileData[? "image_source"] = Path + GXML_GetAttribute(TileContent, "source");
                    LocalTileData[? "image_width"] = real(GXML_GetAttribute(TileContent, "width"));
                    LocalTileData[? "image_height"] = real(GXML_GetAttribute(TileContent, "height"));
                }
            }
            
            TileData[|LocalTileID] = LocalTileData;
        }
    }
}

for(var GlobalID = FirstGID; GlobalID < FirstGID + TileCount; GlobalID++) {
    var TileProperties = TileData[| GlobalID - FirstGID];
    if(TileProperties == 0) {
        TileProperties = -1;
    }
    
    if(ImageCollection) {
        if(TileProperties == -1) {
            show_error("Image Collection Tile contains no tile data.", true);
            return 0;
        }
        
        var TileImage = background_add(TileProperties[? "image_source"], false, false);
        ds_list_add(MapImages, TileImage);
        
        TileTypes[| GlobalID] = GTMX_CreateTileType(
            GlobalID,
            TileImage,
            0,
            0,
            TileProperties[? "image_width"],
            TileProperties[? "image_height"],
            TileProperties
        );
    } else {
        TileTypes[| GlobalID] = GTMX_CreateTileType(
            GlobalID, 
            Image, 
            ((GlobalID - FirstGID) mod Columns) * TileWidth,
            ((GlobalID - FirstGID) div Columns) * TileHeight,
            TileWidth,
            TileHeight,
            TileProperties
        );
    }
}

if(UseTSX) {
    GXML_DestroyElement(TilesetSourceElement, true);
}

ds_list_destroy(TileData);
