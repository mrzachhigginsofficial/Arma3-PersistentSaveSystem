/*
Restores data of vehicles marked by player.
Data is loaded from given save _slot.
*/

params ["_slot"];

private _ClearTurretMagazines =
{
    params ["_vehicle"];

    {
        private _turretPath = _x;

        {
            _vehicle removeMagazinesTurret [_x, _turretPath];
        } forEach (_vehicle magazinesTurret  _turretPath)
    } forEach (allTurrets _vehicle);
};

private _ApplyTurrets =
{ 
    params ["_vehicle", "_turretArray"];

    [_vehicle] call _ClearTurretMagazines;

    {
        private _class = _x select 0;
        private _turretPath = _x select 1;
        private _ammo = _x select 2;

        _vehicle addMagazineTurret [_class, _turretPath, _ammo];
    } forEach _turretArray;
};

[format ["Loading custom vehicles from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _vehicles = ["vehicles", _slot] call skhpersist_fnc_LoadData;

{
    deleteVehicle _x;
    PSave_CustomVehiclesToSave deleteAt _forEachIndex;
} forEach PSave_CustomVehiclesToSave;

{
    private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
    private _fuel = [_x, "fuel"] call skhpersist_fnc_GetByKey;
    private _damages = [_x, "damages"] call skhpersist_fnc_GetByKey;
    private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;
    private _posRotation = [_x, "posRotation"] call skhpersist_fnc_GetByKey;
    private _turretArray = [_x, "turrets"] call skhpersist_fnc_GetByKey;
    
    private _vehicle = _class createVehicle [0, 0, 0];
    [_vehicle, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;
    _vehicle setFuel _fuel;
    [_vehicle, _damages] call skhpersist_fnc_ApplyDamages;
    [_vehicle, _cargo] call skhpersist_fnc_ApplyCargo;
    [_vehicle, _turretArray] call _ApplyTurrets;
    
    [_vehicle, PSave_CustomVehiclesToSave] call skhpersist_fnc_MarkForSave;
} forEach _vehicles;