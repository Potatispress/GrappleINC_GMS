///GTMX_CreateMapFromFile(FileName)

var FileName = argument0;

var FileElement = GXML_ParseFile(FileName);
var MapElement = GXML_GetContent(FileElement, 1);

var Map = GTMX_CreateMap(MapElement);

GXML_DestroyElement(FileElement, true);

return Map;
