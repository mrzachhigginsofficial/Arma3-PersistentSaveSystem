/*
Restores data of vehicles marked by player.
Data is loaded from given save _slot.
*/

params ["_slot"];

private _vehicles = ["vehicles", _slot] call skhpersist_fnc_LoadData;

{
    deleteVehicle _x;
} forEach PSave_CustomVehiclesToSave;

PSave_CustomVehiclesToSave = [];

{
    private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
    private _fuel = [_x, "fuel"] call skhpersist_fnc_GetByKey;
    private _damages = [_x, "damages"] call skhpersist_fnc_GetByKey;
    private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;
    private _posRotation = [_x, "posRotation"] call skhpersist_fnc_GetByKey;
    
    private _vehicle = _class createVehicle [0, 0, 0];
    [_vehicle, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;
    _vehicle setFuel _fuel;
    [_vehicle, _damages] call skhpersist_fnc_ApplyDamages;
    [_vehicle, _cargo] call skhpersist_fnc_ApplyCargo;
    
    [_vehicle, PSave_CustomVehiclesToSave] call skhpersist_fnc_MarkForSave;
} forEach _vehicles;