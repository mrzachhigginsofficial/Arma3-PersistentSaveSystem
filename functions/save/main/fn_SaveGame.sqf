/*
Performs a persistent save on given _slot.
*/

params ["_slot"];

[_slot] call skhpersist_fnc_ClearSave;

[_slot] call skhpersist_fnc_SaveMetadata;
[_slot] call skhpersist_fnc_SavePlayer;
[_slot] call skhpersist_fnc_SaveCustomContainers;
[_slot] call skhpersist_fnc_SaveCustomUnits;
[_slot] call skhpersist_fnc_SaveCustomVehicles;
[_slot] call skhpersist_fnc_SaveEnvironmentInfo;
[_slot] call skhpersist_fnc_SaveMapMarkers;

{
	[] call _x;
} forEach PSave_OnSaveEH;

saveProfileNamespace;

hint format ["Persistent save done!"];