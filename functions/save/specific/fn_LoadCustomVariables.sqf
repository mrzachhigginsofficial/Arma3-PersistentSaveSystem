/*
Restores data of specified variables.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading custom variables from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _allVariables = ["variables", _slot] call skhpersist_fnc_LoadData;
private _missionNamespaceVariables = [_allVariables, "missionNamespace"] call skhpersist_fnc_GetByKey;

{
	PSave_CustomMissionNamespaceVariablesToSave deleteAt _forEachIndex;
} forEach PSave_CustomMissionNamespaceVariablesToSave;

{
    private _key = _x select 0;
	private _value = _x select 1;

	missionNamespace setVariable [_key, _value];

	PSave_CustomMissionNamespaceVariablesToSave pushBack _key;
} forEach _missionNamespaceVariables;