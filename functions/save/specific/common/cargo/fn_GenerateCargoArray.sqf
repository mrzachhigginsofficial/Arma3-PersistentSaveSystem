/*
Creates a cargo array for given _container.

Returns a generated cargo array.
*/

params ["_container"];

private _CallEventHandlers =
{
    params ["_itemType", "_array"];

    private _itemNamesArray = (_array select 1);

    {
        private _function = _x;
        private _additionalArray = [];

        {
            private _additionalData = [_itemType, _x] call compile preprocessFileLineNumbers _function;
            _additionalArray pushBack _additionalData;
        } forEach (_itemNamesArray select 0);

        _array pushBack _additionalArray;

    } forEach PSave_OnCargoDataSavedEH;
};

[format ["Generating cargo array for container %1.", _container]] call skhpersist_fnc_LogToRPT;

private _itemsArray = ["items", getItemCargo _container];
private _magazinesArray = ["magazines", magazinesAmmoCargo _container];
private _weaponsArray = ["weapons", weaponsItemsCargo _container];

["ITEM", _itemsArray] call _CallEventHandlers;
["MAGAZINE", _magazinesArray] call _CallEventHandlers;
["WEAPON", _weaponsArray] call _CallEventHandlers;

private _cargo =
[
    _itemsArray,
    _magazinesArray,
    _weaponsArray
];

_cargo;