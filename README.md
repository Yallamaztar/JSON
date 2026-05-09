# GSC JSON Library (Plutonium T6 / Black Ops II)

A Lightweight JSON Library for [**Plutonium T6 (Black Ops II)**](https://plutonium.pw/), enabling easy creation, parsing, and serialization of JSON objects and arrays

---

## Features:

- Create and manipulate JSON objects and arrays
- Lightweight key-value storage system built for GSC constraints
- Full support for nested data structures (objects within arrays and vice versa)
- Optional file I/O support for persistent data storage
- Serialize GSC data structures into valid JSON strings
- Parse JSON strings back into usable GSC arrays and objects
- Object utilities: ``add, get, remove, check existence, clear, and key enumeration``
- Array utilities: ``push, pop, remove, search, clear, and stringify``
---

## Dependencies

This library requires the **strings utility library**:

* **https://github.com/Yallamaztar/strings**

### Required functions:
- `sprintf()`
- `IsBoolean()`
- `strlen()`
- `len()`
- `substr()`

Make sure to have this strings library in your `scripts\` dir **before using this module**.

---

## Example Usage

```cpp
#include scripts\json;
#include scripts\strings;

init() {
    // Create a JSON-like object (key-value array)
    player = json_object();

    // Add properties
    player = object_add(player, "name", "Alex");
    player = object_add(player, "age", 22);
    player = object_add(player, "admin", false);

    // Create a JSON array
    scores = json_array();

    // Add values to array
    scores = array_add(scores, 10);
    scores = array_add(scores, 25);
    scores = array_add(scores, 99);

    // Attach array to object
    player = object_add(player, "scores", scores);

    // Convert object to JSON string
    json = object_jsonify(player);

    printlnf("^2Generated JSON:^7 %s", json);
    // Generated JSON: {"name":"Alex","age":22,"admin":false,"scores":[10,25,99]}

    // Parse JSON string back into a GSC array
    parser = new_parser(json);
    parsed = stringify(parser);

    // Access parsed values
    printlnf("^3Parsed name:^7 %s", parsed["name"]);     // Alex
    printlnf("^3Parsed age:^7 %d", parsed["age"]);       // 22
    printlnf("^3Parsed admin:^7 %t", parsed["admin"]);   // 0 -> booleans are represented by: 0 (false) | 1 (true)
    printlnf("^3Parsed scores:^7 %a", parsed["scores"]); // [10,25,99]

    /* NEW file I/O functions */
    // required for using file I/O functions
    allow_fileIO(); 

    // write JSON object to file
    write("players.json", player);

    // read JSON object back from file (auto parsed)
    data = read("players.json");

    printlnf("[players.json] name: %s", data["name"]);      // Alex
    printlnf("[players.json] age: %d", data["age"]);        // 22
    printlnf("[players.json] is admin: %t", data["admin"]); // 0 -> booleans are represented by: 0 (false) | 1 (true)
    printlnf("[players.json] scores: %a", data[scores]);    // [10,25,99]
}
```

---

## API Reference

Refer to each functions implementation in the source for detailed behavior

### File I/O API
- `allow_fileIO()`
  - Enables file I/O operations

- `write(file, obj)`
  - Writes a JSON object to a file

- `read(file)`
  - Reads a JSON object from a file

---

### Object API (key-value arrays)
- `json_object()`
  - Creates a new empty JSON-like object (key-value array)

- `object_add(obj, key, value)`
  - Adds a key-value pair to an object

- `object_remove(obj, key)`
  - Removes a key-value pair by key from an object

- `object_get(obj, key)`
  - Gets the value associated with a key in a JSON object

- `object_has(obj, key)` 
  - Checks if a key exists in a JSON object

- `object_clear(obj)`
  - Clears a JSON object

- `object_keys(obj)`
  - Returns a json array of all keys

- `object_jsonify(obj)`
  - Converts an object into a JSON string representation

---

### Array API

- `json_array()`
  - Creates a new empty array

- `array_add(arr, value)`
  - Adds a value to an array

- `array_remove(arr, value)`
  - Removes a matching value from an array

- `array_has(arr, value)`
  - Checks if a value exists in a JSON array

- `array_clear(arr)`
  - Clears a JSON array

- `array_pop(arr)`
  - Removes the last element from a JSON array

- `array_jsonify(arr)`
  - Converts an array into a JSON string representation

---

### Parser API

- `new_parser(s)`
  - Creates a new JSON parser instance from a string

- `stringify(parser)`
  - Parses a JSON string into GSC data structures

---

### Parser Core

Internal parsing functions used by `stringify()`:

- `parse_object(p)`
- `parse_string(p)`
- `parse_array(p)`
- `parse_number(p)`
- `parse_boolean(p)`

---

### Serialization Helpers

- `json_stringify_value(v)`
  - Converts any supported GSC value into a JSON-safe string

- `json_kv(key, value)`
  - Creates a key-value pair entry used internally for objects

---

### Utility Functions

- `consume(p, expected)`
  - Consumes the expected character from the parser stream

- `skip_whitespaces(p)`
  - Skips whitespace characters in the input string

- `get_current_char(p)`
  - Returns the current character being parsed