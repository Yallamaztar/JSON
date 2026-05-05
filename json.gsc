/*
 * GSC JSON library made for Plutonium t6 (Black Ops II)
 * Still a work in progress, will be adding file parsing etc.. 
 * =========================================================
 * So far has support for creating JSON objects and arrays, 
 * adding key-value pairs, and converting values to their 
 * JSON string representations.
 * =========================================================
 * Dependencies:
 *   Requires the strings utility library:
 *   https://github.com/Yallamaztar/strings
 *
 *   This library relies on the following functions:
 *     - sprintf()
 *     - replace()
 *     - join()
 *     - starts_with()
 *     - IsBoolean()
 *
 *   Make sure to include/import the strings library
 *   before using this JSON module.
 * =========================================================
 * Example of building a JSON object:
 * ```
 * init() {
 *   // player object
 *   player = json_object();
 *   player = object_add(player, "name", "Ghost");
 *   player = object_add(player, "rank", 55);
 *
 *   // weapons array
 *   weapons = json_array();
 *   weapons = array_add(weapons, "ak47");
 *   weapons = array_add(weapons, "mp7");
 *   weapons = array_to_string(weapons);
 *
 *   // stats object (nested)
 *   stats = json_object();
 *   stats = object_add(stats, "kills", 120);
 *   stats = object_add(stats, "deaths", 30);
 *   stats = object_to_string(stats);
 *
 *   // attach nested structures
 *   player = object_add(player, "weapons", weapons);
 *   player = object_add(player, "stats", stats);
 *
 *   final = object_to_string(player);
 *   println(final); // prints: {"name":"Ghost","rank":55,"weapons":["ak47","mp7"],"stats":{"kills":120,"deaths":30}}
 * }
 * ```
 * =========================================================
 */

#include scripts\strings;

/* 
 * json_object() Returns a new JSON object
 *
 * Returns:
 *   A new JSON object
 *
 * Example Usage:
 * ```
 * obj = json_object();
 * ```
 */
json_object() {
    return [];
}

/* 
 * object_add(obj, key, value) Adds a key-value pair to a JSON object
 *
 * Params:
 *   obj   - The JSON object to add the key-value pair to
 *   key   - The key for the new pair
 *   value - The value for the new pair
 *
 * Returns:
 *   The updated JSON object
 *
 * Example Usage:
 * ```
 * obj = object_add(obj, "key", "value");
 * ```
 */
object_add(obj, key, value) {
    obj[obj.size] = json_kv(key, value);
    return obj;
}

/* 
 * object_to_string(obj) Finalizes a JSON object
 *
 * Params:
 *   obj - The JSON object to finalize
 *
 * Returns:
 *   The finalized JSON object
 *
 * Example Usage:
 * ```
 * obj = object_to_string(obj);
 * ```
 */
object_to_string(obj) {
    return "{" + join(obj, ",") + "}";
}

/* 
 * json_array() Returns a new JSON array
 *
 * Returns:
 *   A new JSON array
 *
 * Example Usage:
 * ```
 * arr = json_array();
 * ```
 */
json_array() {
    return [];
}

/* 
 * array_add(arr, value) Adds a value to a JSON array
 *
 * Params:
 *   arr   - The JSON array to add the value to
 *   value - The value to add
 *
 * Returns:
 *   The updated JSON array
 *
 * Example Usage:
 * ```
 * arr = array_add(arr, "value");
 * ```
 */
array_add(arr, value) {
    arr[arr.size] = json_value(value);
    return arr;
}

/* 
 * array_to_string(arr) Finalizes a JSON array
 *
 * Params:
 *   arr - The JSON array to finalize
 *
 * Returns:
 *   The finalized JSON array
 *
 * Example Usage:
 * ```
 * arr = array_to_string(arr);
 * ```
 */
array_to_string(arr) {
    return "[" + join(arr, ",") + "]";
}

/* 
 * json_kv(key, value) Creates a key-value pair for a JSON object
 *
 * Params:
 *   key   - The key for the new pair
 *   value - The value for the new pair
 *
 * Returns:
 *   The JSON key-value pair
 *
 * Example Usage:
 * ```
 * kvp = json_kv("key", "value");
 * ```
 */
json_kv(key, value) {
    return sprintf("\"%s\":%s", key, json_value(value));
}

/* 
 * json_value(value) Converts a value to its JSON string representation
 *
 * Params:
 *   value - The value to convert
 *
 * Returns:
 *   The JSON string representation of the value
 *
 * Example Usage:
 * ```
 * json_str = json_value("value");
 * ```
 */
json_value(value) {
    if (!isdefined(value)) {
        return "null";
    }

    if (isString(value) && (starts_with(value, "{") || starts_with(value, "["))) {
        return value;
    }

    if (IsString(value)) {
        value = replace(value, "\\", "\\\\");
        value = replace(value, "\"", "\\\"");
        return "\"" + value + "\"";
    }

    if (IsBoolean(value)) {
        return sprintf("%t", value);
    }

    return value + "";
}