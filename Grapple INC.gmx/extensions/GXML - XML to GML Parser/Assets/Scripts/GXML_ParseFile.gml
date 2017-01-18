///GXML_ParseFile(FileName)

var FileName = argument0;

var FileRead = file_text_open_read(FileName);

if(FileRead == -1) {
    show_error("Failed to read file.", true);
    return 0;
}

// Create a temporary context stack, where new elements are added for new scopes in XML.
var ContextStack = ds_stack_create();
// The base Element for the file.
var FileElement = GXML_CreateElement(FileName);

ds_stack_push(ContextStack, FileElement);

enum GXML_States {
    Content,
    Element
}

// The characters which are skipped when finding content data.
var DataSkipChars = ' ' + chr(10) + chr(13);

// Variables for that should be persistant over several text lines.
var CurrentState = GXML_States.Content;
var ContentString = "";
var ElementString = "";

// Read through the entire file.
while(!file_text_eof(FileRead)) {
    var Line = file_text_readln(FileRead);
    var LineLength = string_length(Line);
    
    // Go through each line.
    for(var LineIt = 1; LineIt <= LineLength; LineIt++) {
        var Char = string_char_at(Line, LineIt);
        
        switch(CurrentState) {
            // 'Content' state, parse of everything outside of the '<' and '>' characters.
            case GXML_States.Content: {
                // If the '<' is encountered, save potential "scrap" data found into the current context, and enter the element state
                if(Char == '<') {
                    if(!is_undefined(ContentString) && string_length(ContentString) > 0) {
                        // If you have trouble parsing, try uncommenting the following line to find the problematic characters:
                        //show_debug_message("Adding content to " + GXML_GetTag(ds_stack_top(ContextStack)) + " with value: '" + ContentString + "' (UTF-8: " + string(ord(ContentString)) + ")");                        
                        
                        GXML_AddContent(ds_stack_top(ContextStack), ContentString);
                    }
                    ContentString = "";
                    ElementString = "";
                    CurrentState = GXML_States.Element;
                // Else, if the character isn't found among the skip-characters, add it to the Content.
                } else if(string_count(Char, DataSkipChars) == 0) {
                    ContentString += Char;
                }
                
                break;
            // 'Element' state, parse everything inside the '<' and '>' characters.
            } case GXML_States.Element: {
                // If the end of the element is found.
                if(Char == '>') {
                    
                    // Setup several temporary variables needed for parsing.
                    var FoundTag = false;
                    var ElementTag = "";
                    var AddContext = true;
                    var EndContext = false;
                    
                    var ReadAttributeName = false;
                    var ReadAttributeValue = false;
                    var ReadAttributeValueStart = false;
                    var AttributeNames = ds_list_create();
                    var AttributeValues = ds_list_create();
                    
                    var ElementLength = string_length(ElementString);
                    
                    // Iterate through the element string.
                    for(var ElementIt = 1; ElementIt <= ElementLength; ElementIt++) {
                        var ElementChar = string_char_at(ElementString, ElementIt);
                        
                        // If the tag (the first characters in an element) has been found.
                        if(FoundTag) {
                            // If reading an attribute name.
                            if(ReadAttributeName) {
                                // When encountering the '=' sign, start reading the corresponding value.
                                if(ElementChar == '=') {
                                    ReadAttributeName = false;
                                    ReadAttributeValue = true;
                                // Else add a character to the attribute's name.
                                } else {
                                    AttributeNames[| ds_list_size(AttributeNames) - 1] += ElementChar;
                                }
                            // After the attribute name has been read, read the corresponding value.
                            } else if(ReadAttributeValue) {
                                // Stupid but working solution for detecting if the '"' character is the start or end of the value.
                                if(ReadAttributeValueStart) {
                                    if(ElementChar == '"') {
                                        ReadAttributeValue = false;
                                        ReadAttributeValueStart = false;
                                    } else {
                                        AttributeValues[| ds_list_size(AttributeValues) - 1] += ElementChar;
                                    }
                                // Start the value reading when the first '"' character is encountered.
                                } else {
                                    if(ElementChar == '"') {
                                        ReadAttributeValueStart = true;
                                    }
                                }
                            // If a '/' character is encountered, the element doesn't increase scope.
                            } else if(ElementChar == '/' || ElementChar == '?') {
                                AddContext = false;
                            // Else, if the character is not a ' ', we assume an attribute has been encountered.
                            } else if(ElementChar != ' ') {
                                ReadAttributeName = true;
                                
                                ds_list_add(AttributeNames, "");
                                ds_list_add(AttributeValues, "");
                                
                                AttributeNames[| ds_list_size(AttributeNames) - 1] += ElementChar;
                            }
                        // If we haven't found the tag yet.
                        } else {
                            // The tag is completed if a ' ' character is found and the tag is not empty.
                            if(ElementChar == ' ') {
                                if(ElementTag != "") {
                                    FoundTag = true;
                                }
                            // If we find a '/' character...
                            } else if(ElementChar == '/') {
                                // ...before the tag is completed, we assume we found the end of a scope.
                                if(ElementTag == "") {
                                    EndContext = true;
                                // ...after the tag is completed, we assume the element doesn't increase scope.
                                } else {
                                    AddContext = false;
                                }
                            // If an '?' character is encountered, it's the xml info, and doesn't increase scope.
                            } else if(ElementChar == '?') {
                                AddContext = false;
                            // Else, it's another character in the tag's name.
                            } else {
                                ElementTag += ElementChar;
                            }
                        }
                    }
                    
                    // If the tag started with a '/', we assume it's ending a scope.
                    if(EndContext) {
                        // Get the tag of the current scope, to make sure we're really ending that scope.
                        var CurrentScopeTag = GXML_GetTag(ds_stack_top(ContextStack));
                        // If they are not the same, throw an error as there are very likely XML document error.
                        if(CurrentScopeTag != ElementTag) {
                            show_error("Failed to parse XML - Open context with tag '" + CurrentScopeTag + "' could not be closed by '" + ElementTag + "'.", true);
                        }
                        ds_stack_pop(ContextStack);
                    // If the tag didn't start with '/', it's a new element.
                    } else {
                        // Create the element.
                        var NewElement = GXML_CreateElement(ElementTag);
                        
                        // Add the attributes from the double lists.
                        for(var i = 0; i < ds_list_size(AttributeNames); i++) {
                            GXML_AddAttribute(NewElement, AttributeNames[|i], AttributeValues[|i]);
                        }
                        
                        // Add this element to the element currently scoped.
                        GXML_AddContent(ds_stack_top(ContextStack), NewElement);
                        
                        // If the element does not end with '/', further the scope.
                        if(AddContext) {
                            ds_stack_push(ContextStack, NewElement);
                        }
                    }
                    
                    // Cleanup the temporary lists.
                    ds_list_destroy(AttributeNames);
                    ds_list_destroy(AttributeValues);
                    
                    // Reset state.
                    CurrentState = GXML_States.Content;
                
                // If the end of the element hasn't been found yet.
                } else {
                    ElementString += Char;
                }
                
                break;
            } default: {
                show_error("Unknown state index: " + string(CurrentState), true);
            }
            
        }
    }
}

ds_stack_pop(ContextStack);
if(ds_stack_size(ContextStack) > 0) {
    show_error("Failed to parse XML - " + string(ds_stack_size(ContextStack)) + " elements are not closed correctly.", true);
    return 0;
}

// Close the file and destroy the context stack - the file element now holds the entire structure.
file_text_close(FileRead);
ds_stack_destroy(ContextStack);

return FileElement;
