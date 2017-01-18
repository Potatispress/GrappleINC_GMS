///GXML_IsElement(Content)

var Content = argument0;

// Boolean returns false if any of the checks are false.
return (
    !is_undefined(Content) &&
    is_real(Content) &&
    ds_exists(Content, ds_type_map) && 
    !is_undefined(ds_map_find_value(Content, "GXML_MARKUP"))
);
