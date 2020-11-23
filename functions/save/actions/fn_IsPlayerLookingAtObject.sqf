/*
Checks, whether player is looking at given _object and his distance from it is <= _maxDistance.
To prevent player from having to target the object exactly at a correct direction, he can target to the left
or the right from the object's center, but no more than _maxAngleDifference (in degrees).

Returns true, if player is looking at given _object, otherwise false.
*/

params ["_object", "_maxDistance", "_maxAngleDifference"];

private _unitLookingAtObject = false;

if (player distance _object <= _maxDistance) then
{
    private _atan = ((getPos _object select 0) - (getPos player select 0)) atan2 ((getPos _object select 1) - (getPos player select 1));

    if (_atan < 0) then
    {
        _atan = _atan + 360;
    };
    
    if (_atan <= getDir player + _maxAngleDifference && _atan >= getDir player - _maxAngleDifference) then
    {
        _unitLookingAtObject = true;
    };
};

_unitLookingAtObject;