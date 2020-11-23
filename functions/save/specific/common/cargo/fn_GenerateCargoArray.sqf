/*
Creates a cargo array for given _container.

Returns a generated cargo array.
*/

params ["_container"];

private _cargo =
[
    ["items", getItemCargo _container],
    ["magazines", getMagazineCargo _container],
    ["weapons", getWeaponCargo _container]
];

_cargo;