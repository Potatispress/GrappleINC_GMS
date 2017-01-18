///CreateMap(filename, roomIndex)

var filename = argument0;
//var roomIndex = argument1;

var file = file_text_open_read(filename);
var jsonData = "";

if(file) {
    while(!file_text_eof(file)) {
        jsonData += file_text_readln(file);
    }
    
    file_text_close(file);
}

var levelMap = json_decode(jsonData);

var tileSizeX = levelMap[? "tilewidth"];
var tileSizeY = levelMap[? "tileheight"];
var tilesets = levelMap[? "tileset"];

if(ds_exists(tilesets, ds_type_list)) {

} else {
}
