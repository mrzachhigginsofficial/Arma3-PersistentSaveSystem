/*
Handles adding and removing mark / unmark actions, when player is near an _object.
*/
params ["_object", "_maxDistance", "_maxAngleDifference", "_actionParameters", "_ActionFunction"];

[format ["Handling player looking at object %1", _object]] call skhpersist_fnc_LogToRPT;

while {alive player} do
{
    [_object, _maxDistance, _maxAngleDifference] call skhpersist_fnc_WaitUntilPlayerLooksAtObject;
    
    private _actions = [_object, _actionParameters] call _ActionFunction;
    
    [_object, _maxDistance, _maxAngleDifference] call skhpersist_fnc_WaitUntilPlayerDoesNotLookAtObject;
    
    {
        player removeAction _x;
    } forEach _actions;
};