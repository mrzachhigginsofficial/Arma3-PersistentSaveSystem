/*
Stores data for specified variables.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving custom variables to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _missionNamespaceVariables = [];

{
    _missionNamespaceVariables pushBack [_x, missionNamespace getVariable _x];
} forEach PSave_CustomMissionNamespaceVariablesToSave;

private _allVariables =
[
	["missionNamespace", _missionNamespaceVariables]
];

["variables", _allVariables, _slot] call skhpersist_fnc_SaveData;