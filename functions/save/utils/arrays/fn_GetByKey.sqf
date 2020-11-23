/*
Allows to get a value from an array by _key, instead of index.
If element for given _key doesn't exist, nil is returned.
*/

params ["_array", "_key"];

private "_value";

{
    if (_key == (_x select 0)) exitWith { _value = _x select 1 };
} forEach _array;

_value;