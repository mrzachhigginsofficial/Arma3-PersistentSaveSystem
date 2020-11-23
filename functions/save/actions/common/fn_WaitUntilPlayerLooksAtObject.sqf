/*
Waits in loop, until player starts looking at given _object.
*/

params ["_object", "_maxDistance", "_maxAngleDifference"];

while { !([_object, _maxDistance, _maxAngleDifference] call skhpersist_fnc_IsPlayerLookingAtObject) } do
{
    // Try again.
};