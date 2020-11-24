/*
Restores data for units marked in editor.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading custom units from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _units = ["units", _slot] call skhpersist_fnc_LoadData;

{
    {
        deleteVehicle _x;
    } forEach (units _x);
} forEach PSave_CustomUnitsToSave;

PSave_CustomUnitsToSave = [];

{
    private _unit = [nil, _x, nil] call skhpersist_fnc_LoadUnitData;    
    [_unit, PSave_CustomUnitsToSave, false] call skhpersist_fnc_MarkForSave;
} forEach _units;