/*
Applies hitpoint damages to given _entity, based on _hitpointsArray.
*/

params ["_entity", "_hitpointsArray"];

{
    private _key = _x;
    private _value = (_hitpointsArray select 2) select _forEachIndex;
    _entity setHitPointDamage [_key, _value];
} forEach (_hitpointsArray select 0);