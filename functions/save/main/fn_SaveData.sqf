/*
Stores a single _key -> _value pair in profileNamespace on given save _slot.
It doesn't persist them automatically!
*/

params ["_key", "_value", "_slot"];

profileNamespace setVariable [format ["%1.%2.%3", PSave_SaveGamePrefix, _slot, _key], _value];