/*
Adds cargo from _cargoArray to given _container.
*/

params ["_container", "_cargoArray"];

[format ["Applying cargo array to container %1.", _container]] call skhpersist_fnc_LogToRPT;

clearItemCargo _container;
clearMagazineCargo _container;
clearWeaponCargo _container;

private _AddAllToCargo =
{
    params ["_container", "_cargoArray", "_AddToCargo"];
    
    {
        private _name = _x;
        private _count = (_cargoArray select 1) select _forEachIndex;
        [_container, _name, _count] call _AddToCargo;
    } forEach (_cargoArray select 0);
};

private _AddAllMagazinesToCargo =
{
    params ["_container", "_cargoArray"];

    {
        private _name = _x select 0;
        private _ammo = _x select 1;

        _container addMagazineAmmoCargo [_name, 1, _ammo];
    } forEach _cargoArray;
};

private _AddAllWeaponsToCargo =
{
    params ["_container", "_cargoArray"];

    {
        _container addWeaponWithAttachmentsCargo [_x, 1];
    } forEach _cargoArray;
};

private _itemsArray = [_cargoArray, "items"] call skhpersist_fnc_GetByKey;
private _magazinesArray = [_cargoArray, "magazines"] call skhpersist_fnc_GetByKey;
private _weaponsArray = [_cargoArray, "weapons"] call skhpersist_fnc_GetByKey;

[_container, _itemsArray, { params ["_c", "_n", "_cnt"]; _c addItemCargo [_n, _cnt]; }] call _AddAllToCargo;
[_container, _magazinesArray] call _AddAllMagazinesToCargo;
[_container, _weaponsArray] call _AddAllWeaponsToCargo;
