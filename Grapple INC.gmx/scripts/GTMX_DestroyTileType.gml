///GTMX_DestroyTileType(TypeIndex)

var TypeIndex = argument0;


if(ds_exists(TypeIndex, ds_type_map) && ds_map_exists(TypeIndex, "gid")) {
    if(ds_exists(real(TypeIndex[? "properties"]), ds_type_map)) {
        ds_map_destroy(real(TypeIndex[? "properties"]));
    }

    ds_map_destroy(TypeIndex);
}
