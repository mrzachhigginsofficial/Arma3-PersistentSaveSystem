/*
Restores Ravage data.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading Ravage data from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _ravage = ["ravage", _slot] call skhpersist_fnc_LoadData;

private _hunger = [_ravage, "hunger"] call skhpersist_fnc_GetByKey;
private _thirst = [_ravage, "thirst"] call skhpersist_fnc_GetByKey;
private _radiation = [_ravage, "radiation"] call skhpersist_fnc_GetByKey;

player setVariable ["hunger", _hunger];
player setVariable ["thirst", _thirst];
player setVariable ["radiation", _radiation];