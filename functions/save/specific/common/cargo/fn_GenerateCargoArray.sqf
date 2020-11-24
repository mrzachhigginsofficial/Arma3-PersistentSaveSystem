/*
Creates a cargo array for given _container.

Returns a generated cargo array.
*/

params ["_container"];

[format ["Generating cargo array for container %1.", _container]] call skhpersist_fnc_LogToRPT;

private _cargo =
[
    ["items", getItemCargo _container],
    ["magazines", getMagazineCargo _container],
    ["weapons", getWeaponCargo _container]
];

_cargo;