/*
Waits in loop, until player stops looking at given _object.
*/

params ["_object", "_maxDistance", "_maxAngleDifference"];

[format ["Waiting until player no longer looks at object %1.", _object]] call skhpersist_fnc_LogToRPT;

while { ([_object, _maxDistance, _maxAngleDifference] call skhpersist_fnc_IsPlayerLookingAtObject) } do
{
    // Try again.
};

[format ["Player doesn't look at object %1 anymore.", _object]] call skhpersist_fnc_LogToRPT;