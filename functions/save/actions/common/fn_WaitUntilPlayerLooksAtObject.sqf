/*
Waits in loop, until player starts looking at given _object.
*/

params ["_object", "_maxDistance", "_maxAngleDifference"];

[format ["Waiting until player looks at object %1.", _object]] call skhpersist_fnc_LogToRPT;

while { !([_object, _maxDistance, _maxAngleDifference] call skhpersist_fnc_IsPlayerLookingAtObject) } do
{
    // Try again.
};

[format ["Player looks at object %1.", _object]] call skhpersist_fnc_LogToRPT;