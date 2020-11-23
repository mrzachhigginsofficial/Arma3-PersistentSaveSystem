/*
Checks, whether player is looking at given _object.
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