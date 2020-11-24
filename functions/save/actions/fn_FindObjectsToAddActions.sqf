/*
Looks for nearby objects of given _objectsType, which player may want to add to the stored data.
Only objects found in given _radius will be processed by this function.
It adds an action, which will allow the player to persist them - in case player performs an action,
object will be stored in specified _array, which is further processed during saving.
*/
params ["_radius", "_objectsType", "_array"];

private _AddActionToMarkForSave =
{
    params ["_object", "_array"];

    private _AddActions = {
        params ["_object", "_parameters"];
        
        private _array = _parameters select 0;
        private _actions = [];
        
        if (!(_object in _array)) then
        {
            _actions pushBack (player addAction [format ["Add to persistent save (%1)", typeOf _object],
            {
                private _object = _this select 3 select 0;
                private _unit = _this select 3 select 1;
                private _array = _this select 3 select 2;
                [_object, _array] call skhpersist_fnc_MarkForSave;
                _unit removeAction (_this select 2);
            },
            [_object, player, _array]]);
        }
        else
        {
            _actions pushBack (player addAction [format ["Remove from persistent save (%1)", typeOf _object],
            {
                private _object = _this select 3 select 0;
                private _unit = _this select 3 select 1;
                private _array = _this select 3 select 2;
                [_object, _array] call skhpersist_fnc_UnmarkForSave;
                _unit removeAction (_this select 2);
            },
            [_object, player, _array]]);
        };
        
        _actions;
    };

    [_object, 5, 25, [_array], _AddActions] call skhpersist_fnc_HandlePlayerLookingAtObject;
};

private _handledObjects = [];

[format ["Looking for objects of type %1 to add mark actions to.", _objectsType]] call skhpersist_fnc_LogToRPT;

while {alive player} do
{
    sleep 1;
    private _objectsArray = player nearObjects [_objectsType, _radius];
    
    {
        if (!(_x in _handledObjects)) then
        {
            [_x, _array] spawn _AddActionToMarkForSave;
            _handledObjects pushBack _x;
        };
    } forEach _objectsArray;
};