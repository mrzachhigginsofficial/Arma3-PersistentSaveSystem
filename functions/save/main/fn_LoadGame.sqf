/*
Loads the game state on given save _slot.
*/

params ["_slot"];

[format ["Loading data from slot %1", _slot]] call skhpersist_fnc_LogToRPT;

[_slot] call skhpersist_fnc_LoadPlayer;
[_slot] call skhpersist_fnc_LoadCustomContainers;
[_slot] call skhpersist_fnc_LoadCustomUnits;
[_slot] call skhpersist_fnc_LoadCustomVehicles;
[_slot] call skhpersist_fnc_LoadEnvironmentInfo;
[_slot] call skhpersist_fnc_LoadMapMarkers;

{
	[_x, [_slot]] call skhpersist_fnc_CallFunctionFromFileOrCode;
} forEach PSave_OnLoadEH;

hint format ["Persistent load done!"];
[format ["Loading data from slot %1 done.", _slot]] call skhpersist_fnc_LogToRPT;