///GTMX_CreateLayerData(GXML_Layer)

show_debug_message("Creating new layerdata at time: " + string(get_timer() / 1000000));

var GXML_Layer = argument0;

var TileCountX = real(GXML_GetAttribute(GXML_Layer, "width"));
var TileCountY = real(GXML_GetAttribute(GXML_Layer, "height"));

var DataElement = GXML_GetContent(GXML_Layer, 0);
var DataEncoding = -1;
if(GXML_AttributeExists(DataElement, "encoding")) {
    DataEncoding = GXML_GetAttribute(DataElement, "encoding");
} else {
    show_error(
        "Failed to create layer data from layer " + 
        GXML_GetAttribute(GXML_Layer, "name") + 
        " - XML encoding format not supported, switch to CSV or Base64.", true
    );
}

if(GXML_AttributeExists(DataElement, "compression")) {
    show_error(
        "Failed to create layer data from layer " + 
        GXML_GetAttribute(GXML_Layer, "name") + 
        " - compression setting is not supported. Only uncompressed formats are allowed.", true
    );
}

var DataGrid = ds_grid_create(TileCountX, TileCountY);
var DataString = GXML_GetContent(GXML_GetContent(GXML_Layer, 0), 0);

show_debug_message(" - decoding started at time: " + string(get_timer() / 1000000));

switch(DataEncoding) {
    case "csv": {
        var CurValue = 0;
        var Counter = 0;
        for(var StringIt = 1; StringIt < string_length(DataString); StringIt++) {
            var Char = string_char_at(DataString, StringIt);
            if(Char == ',') {
                DataGrid[# Counter mod TileCountX, Counter div TileCountX] = CurValue;
                CurValue = 0;
                Counter++;
            } else {
                CurValue *= 10;
                CurValue += real(Char);
            }
        }
        DataGrid[# Counter mod TileCountX, Counter div TileCountX] = real(CurValue);
        break;
    }
    case "base64": {
        var LayerBuffer = buffer_base64_decode(DataString);
        var TileCount  = TileCountX * TileCountY;
        
        for(var TileIt = 0; TileIt < TileCount; TileIt++) {
            DataGrid[# TileIt mod TileCountX, TileIt div TileCountX] = buffer_read(LayerBuffer, buffer_u32);
        }
        
        buffer_delete(LayerBuffer);
        break;
    }
}

show_debug_message("Layerdata creation complete at time: " + string(get_timer() / 1000000));

return DataGrid;


