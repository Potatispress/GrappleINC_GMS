///read_tileset(tileMapIndex, firstGID, filename)

var tileMap = argument0;
var firstGID = argument1;
var filename = argument2;

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

var tsMap = json_decode(jsonData)
if(tsMap == -1) {
    show_error("Unable to decode tileset json data.", true);
}

var name = tsMap[? "name"];
var tileWidth = real(tsMap[? "tilewidth"]);
var tileHeight = real(tsMap[? "tileheight"]);
var tileCount = real(tsMap[? "tilecount"]);
var columns = real(tsMap[? "columns"]);

var tileImages = ds_list_create();

// Spritesheet based tileset
if(tsMap[? "image"] != undefined && ds_exists(tsMap[? "image"], ds_type_map)) {
    var image = tsMap[? "image"];
    
    // Please note that 'image' is a ds_map.
    var source = image[? "source"];
    
    ds_list_add(tileImages, background_add(source, false, false));
    
// Image based tileset
} else if(tsMap[? "tile"] != undefined && ds_exists(tsMap[? "tile"], ds_type_list)) {
    var tile = tsMap[? "tile"];

    // TODO: Implement image based tilesets
    
    ds_list_destroy(tile);
}

if(ds_list_size(tileImages) == 0) {
    show_error("There were no images in the " + name + " tileset.", true);
} else if(ds_list_size(tileImages) == 1) {
    for(var curTile = 0; curTile < tileCount; curTile++) {
        var xTile = curTile % columns;
        var yTile = curTile div columns;
        
        var curMap = ds_map_create();
        
        curMap[? "background"] = tileImages[|0];
        curMap[? "left"] = xTile * tileWidth;
        curMap[? "top"] = yTile * tileHeight;
        curMap[? "width"] = tileWidth;
        curMap[? "height"] = tileHeight;
        
        tileMap[? firstGID + curTile] = curMap;
    }
} else {
    // TODO: Implement image based tilesets
}

ds_map_destroy(image);
ds_list_destroy(tileImages);
ds_map_destroy(tsMap);
