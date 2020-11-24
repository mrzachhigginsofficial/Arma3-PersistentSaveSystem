/*
Creates a cargo array for given _container.

Returns a generated cargo array.
*/

params ["_container"];

private _GetBackpacksArray =
{
    params ["_container"];

    private _backpacksArray = [];
    private _backpacksInContainer = everyBackpack _container;

    {
        private _backpackClass = typeOf _x;
        private _cargo = [_x] call skhpersist_fnc_GenerateCargoArray;

        private _currentBackpackArray = [];

        _currentBackpackArray pushBack ["class", _backpackClass];
        _currentBackpackArray pushBack ["cargo", _cargo];

        _backpacksArray pushBack _currentBackpackArray;
    } forEach _backpacksInContainer;
    
    _backpacksArray;
};

[format ["Generating cargo array for container %1.", _container]] call skhpersist_fnc_LogToRPT;

private _itemsArray = ["items", getItemCargo _container];
private _magazinesArray = ["magazines", magazinesAmmoCargo _container];
private _weaponsArray = ["weapons", weaponsItemsCargo _container];
private _backpacksArray = ["backpacks", [_container] call _GetBackpacksArray];
//private _vestsArray = ["vests", [_container] call _GetBackpacksArray];
//private _uniformsArray = ["uniforms", [_container] call _GetBackpacksArray];

private _cargo =
[
    _itemsArray,
    _magazinesArray,
    _weaponsArray,
    _backpacksArray
];

_cargo;