/*
Stores player data.
*/

params ["_slot"];

private _playerArray = [player, true] call skhpersist_fnc_GenerateUnitArray;
["player", _playerArray, _slot] call skhpersist_fnc_SaveData;