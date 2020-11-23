/*
Creates a group array for given _leader.
It will contain all units under _leader's command (except for him).

Returns a generated group array.
*/

params ["_leader"];

private _groupArray = units group _leader;
private _unitsData = [];

{
    if (_x != _leader) then
    {
        _unitsData pushBack ([_x, false] call skhpersist_fnc_GenerateUnitArray);
    };
} forEach _groupArray;

_unitsData;