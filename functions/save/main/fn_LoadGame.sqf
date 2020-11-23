/*
Loads the game state on given save _slot.
*/

params ["_slot"];

[] call _RemoveObjectsBeforeLoad;

[_slot] call skhpersist_fnc_LoadPlayer;
[_slot] call skhpersist_fnc_LoadCustomContainers;
[_slot] call skhpersist_fnc_LoadCustomUnits;
[_slot] call skhpersist_fnc_LoadCustomVehicles;
[_slot] call skhpersist_fnc_LoadEnvironmentInfo;
[_slot] call skhpersist_fnc_LoadMapMarkers;

{
	[] call _x;
} forEach PSave_OnLoadEH;

hint format ["Persistent load done!"];