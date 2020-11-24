/*
Looks for nearby objects of given _objectsType, which player may want to add to the stored data.
Only objects found in given _radius will be processed by this function.
It adds an action, which will allow the player to persist them - in case player performs an action,
object will be stored in specified _array, which is further processed during saving.
*/
params ["_radius", "_objectsType", "_array"];

private _AddAction =
{
    params ["_text", "_function", "_object", "_array", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    _object addAction [_text, 
    {
        private _thisAction = _this select 2;

        private _params = _this select 3;
        private _object = _params select 0;
        private _array = _params select 1;
        private _function = _params select 2;
        private _CurrentFunction = _params select 3;
        private _MirrorFunction = _params select 4;
        private _AddAction = _params select 5;

        [_object, _array] call _function;
        [_object, _array, _MirrorFunction, _CurrentFunction, _AddAction] call _MirrorFunction;
        _object removeAction _thisAction;
    }, 
    [_object, _array, _function, _CurrentFunction, _MirrorFunction, _AddAction], 1.5, false, true, "", "true", 5];
};

private _AddMarkAction =
{
    params ["_object", "_array", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    ["Mark for persistent save",
    {
        [_object, _array] call skhpersist_fnc_MarkForSave;
    }, _object, _array, _CurrentFunction, _MirrorFunction, _AddAction] call _AddAction;
};

private _AddUnmarkAction =
{
    params ["_object", "_array", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    ["Unmark from persistent save",
    {
        [_object, _array] call skhpersist_fnc_UnmarkForSave;
    }, _object, _array, _CurrentFunction, _MirrorFunction, _AddAction] call _AddAction;
};

private _handledObjects = [];

[format ["Looking for objects of type %1 to add mark actions to.", _objectsType]] call skhpersist_fnc_LogToRPT;

while {alive player} do
{
    sleep 1;
    private _objectsArray = player nearObjects [_objectsType, _radius];
    
    if (!PSave_LoadInProgress) then
    {
        {
            if (!(_x in _handledObjects)) then
            {
                if (!(_x in _array)) then
                {
                    [_x, _array, _AddMarkAction, _AddUnmarkAction, _AddAction] call _AddMarkAction;
                }
                else
                {
                    [_x, _array, _AddUnmarkAction, _AddMarkAction, _AddAction] call _AddUnmarkAction;
                };

                _handledObjects pushBack _x;
            };
        } forEach _objectsArray;

        // Clear null values.
        {
            if (isNil { _x}) then
            {
                _handledObjects deleteAt _forEachIndex;
            };
        } forEach _handledObjects;
    };
};