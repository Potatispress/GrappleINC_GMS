///read_map(filename)

var filename = argument0;
//var roomIndex = argument1;

var file = file_text_open_read(filename);
var jsonData = "";

if(file) {
    while(!file_text_eof(file)) {
        jsonData += file_text_readln(file);
    }
    
    file_text_close(file);
} else {
    show_error("Unable to read file: " + filename, true);
}

var levelMap = json_decode(jsonData);
if(levelMap == -1) {
    show_error("Failed to decode json.", true);
}

var tileSizeX = real(levelMap[? "tilewidth"]);
var tileSizeY = real(levelMap[? "tileheight"]);
var tilesets = levelMap[? "tileset"];

var tileMap = ds_map_create();

if(ds_exists(tilesets, ds_type_list)) {
    // TODO: Multiple tilesets per tmx-file
} else {
    read_tileset(tileMap, real(tilesets[? "firstgid"]), tilesets[? "source"] + ".json");
}

var layer = levelMap[? "layer"];

if(ds_exists(layer, ds_type_list)) {
    
} else {
    var layerWidth = real(layer[? "width"]);
    var layerHeight = real(layer[? "height"]);
    var layerData = layer[? "data"];
    var layerText = layerData[? "#text"];
    var layerEncoding = layerData[? "encoding"];
    var layerCompression = layerData[? "compression"];
    
    if(layerEncoding == "csv") {
        var i = 0;
        var lastTextIterator = 1;
        var textIterator = 1;
        while(textIterator < string_length(layerText)) {
            if(string_char_at(layerText, textIterator) == ",") {
                var value = real(string_digits(string_copy(layerText, lastTextIterator, textIterator - lastTextIterator)));
                
                if(value != 0) {
                    var tileX = tileSizeX * (i % layerWidth);
                    var tileY = tileSizeY * (i div layerWidth);
                    
                    create_tile(tileMap[? value], tileX, tileY, 100);
                }
                
                lastTextIterator = textIterator;
                i++;
            }
            
            textIterator++;
            
            
        }
    }
}






// EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEHH more destruction pl0x
ds_map_destroy(levelMap);

