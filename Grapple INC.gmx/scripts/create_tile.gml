///create_tile(tileIndex, x, y, depth)

var tile = argument0;
var tx = argument1;
var ty = argument2;
var tdepth = argument3;

tile_add(
    tile[? "background"],
    tile[? "left"],
    tile[? "top"],
    tile[? "width"],
    tile[? "height"],
    tx, ty,
    tdepth
);
