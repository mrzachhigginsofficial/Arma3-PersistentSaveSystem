/*
Stores Ravage data.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving Ravage data to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _ravageArray = [];

_ravageArray pushBack ["hunger", player getVariable ["hunger", 100]];
_ravageArray pushBack ["thirst", player getVariable ["thirst", 100]];
_ravageArray pushBack ["radiation", player getVariable ["radiation", 0]];

["ravage", _ravageArray, _slot] call skhpersist_fnc_SaveData;