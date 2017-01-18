///GTMX_QuickRespawnLevel(Level, Map)

var Level = argument0;
var Map = argument1;

var SpawnedObjects = Level[? "objects"];

for(var ObjectIndex = 0; ObjectIndex < ds_list_size(SpawnedObjects); ObjectIndex++) {
    if(instance_exists(SpawnedObjects[|ObjectIndex])) {
        with(SpawnedObjects[|ObjectIndex]) {
            instance_destroy();
        }
    }
}

var ObjectCount = GTMX_GetMapObjectCount(Map);

for(var ObjectIndex = 0; ObjectIndex < ObjectCount; ObjectIndex++) {
    var Instance = GTMX_SpawnObject(GTMX_GetMapObject(Map, ObjectIndex));
    if(Instance) {
        ds_list_add(SpawnedObjects, Instance);
    }
}
