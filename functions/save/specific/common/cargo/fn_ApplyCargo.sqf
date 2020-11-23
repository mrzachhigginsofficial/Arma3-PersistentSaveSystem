/*
Adds cargo from _cargoArray to given _container.
*/

params ["_container", "_cargoArray"];

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

private _itemsArray = [_cargoArray, "items"] call skhpersist_fnc_GetByKey;
private _magazinesArray = [_cargoArray, "magazines"] call skhpersist_fnc_GetByKey;
private _weaponsArray = [_cargoArray, "weapons"] call skhpersist_fnc_GetByKey;

[_container, _itemsArray, { params ["_c", "_n", "_cnt"]; _c addItemCargo [_n, _cnt]; }] call _AddAllToCargo;
[_container, _magazinesArray, { params ["_c", "_n", "_cnt"]; _c addMagazineCargo [_n, _cnt]; }] call _AddAllToCargo;
[_container, _weaponsArray, { params ["_c", "_n", "_cnt"]; _c addWeaponCargo [_n, _cnt]; }] call _AddAllToCargo;
