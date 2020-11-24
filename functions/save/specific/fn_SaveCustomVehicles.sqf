/*
Stores data for marked vehicles.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving custom vehicles to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _vehicles = [];

{
    private _vehicle = _x;
    private _vehicleArray = [];
    
    _vehicleArray pushBack ["class", typeOf _vehicle];
    _vehicleArray pushBack ["fuel", fuel _vehicle];
    _vehicleArray pushBack ["damages", getAllHitPointsDamage _vehicle];
    _vehicleArray pushBack ["cargo", [_vehicle] call skhpersist_fnc_GenerateCargoArray];
    _vehicleArray pushBack ["posRotation", [_vehicle] call skhpersist_fnc_GeneratePositionAndRotationArray];
        
    _vehicles pushBack _vehicleArray;

} forEach PSave_CustomVehiclesToSave;

["vehicles", _vehicles, _slot] call skhpersist_fnc_SaveData;