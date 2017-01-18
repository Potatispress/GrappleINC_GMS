///GTMX_CreateLayerData(GXML_Layer)

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
var DataGrid = ds_grid_create(TileCountX, TileCountY);
var DataString = GXML_GetContent(GXML_GetContent(GXML_Layer, 0), 0);

switch(DataEncoding) {
    case "csv": {
        var CurValue = "";
        var Counter = 0;
        for(var StringIt = 1; StringIt < string_length(DataString); StringIt++) {
            var Char = string_char_at(DataString, StringIt);
            if(Char == ',') {
                DataGrid[# Counter mod TileCountX, Counter div TileCountX] = real(CurValue);
                CurValue = "";
                Counter++;
            } else {
                CurValue += Char;
            }
        }
        DataGrid[# Counter mod TileCountX, Counter div TileCountX] = real(CurValue);
        break;
    }
    case "base64": {
        show_error(
            "Failed to create layer data from layer " + 
            GXML_GetAttribute(GXML_Layer, "name") + 
            " - Base64 parsing is not yet supported.", true
        );
        break;
    }
}

return DataGrid;


