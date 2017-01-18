///GTMX_DestroyMap(Map)

var Images = Map[? "images"];
for(var ImageIndex = 0; ImageIndex < ds_list_size(Images); ImageIndex++) {
    if(!is_undefined(Images[| ImageIndex])) {
        background_delete(Images[| ImageIndex]);
    }
}
ds_list_destroy(Images);

var TileTypes = Map[? "tiletypes"];
for(var TileIndex = 0; TileIndex < ds_list_size(TileTypes); TileIndex++) {
    if(!is_undefined(TileTypes)) {
        GTMX_DestroyTileType(TileTypes[| TileIndex]);
    }
}
ds_list_destroy(TileTypes);

var Layers = Map[? "layers"];
for(var LayerIndex = 0; LayerIndex < ds_list_size(Layers); LayerIndex++) {
    ds_grid_destroy(Layers[| LayerIndex]);
}
ds_list_destroy(Layers);

var Objects = Map[? "objects"];
for(var ObjectIndex = 0; ObjectIndex < ds_list_size(Objects); ObjectIndex++) {
    ds_map_destroy(Objects[| ObjectIndex]);
}
ds_list_destroy(Objects);

ds_map_destroy(Map[? "properties"]);

ds_map_destroy(Map);
