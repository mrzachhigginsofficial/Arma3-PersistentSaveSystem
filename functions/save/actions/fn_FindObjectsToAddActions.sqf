/*
Looks for nearby objects of given _objectsType, which player may want to add to the stored data.
Only objects found in given _radius will be processed by this function.
It adds an action, which will allow the player to persist them - in case player performs an action,
object will be stored in specified _array, which is further processed during saving.
*/
params ["_radius", "_objectsType", "_GetArrayFunction"];

private _AddAction =
{
    params ["_text", "_Function", "_object", "_GetArrayFunction", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    _object addAction [_text, 
    {
        private _thisAction = _this # 2;

        private _params = _this # 3;
        private _object = _params # 0;
        private _GetArrayFunction = _params # 1;
        private _Function = _params # 2;
        private _CurrentFunction = _params # 3;
        private _MirrorFunction = _params # 4;
        private _AddAction = _params # 5;

        [_object, _GetArrayFunction] call _Function;
        [_object, _GetArrayFunction, _MirrorFunction, _CurrentFunction, _AddAction] call _MirrorFunction;
        _object removeAction _thisAction;
    }, 
    [_object, _GetArrayFunction, _Function, _CurrentFunction, _MirrorFunction, _AddAction], 1.5, false, true, "", "true", 5];
};

private _AddMarkAction =
{
    params ["_object", "_GetArrayFunction", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    ["Mark for persistent save",
    {
        [_object, [] call _GetArrayFunction] call skhpersist_fnc_MarkForSave;
    }, _object, _GetArrayFunction, _CurrentFunction, _MirrorFunction, _AddAction] call _AddAction;
};

private _AddUnmarkAction =
{
    params ["_object", "_GetArrayFunction", "_CurrentFunction", "_MirrorFunction", "_AddAction"];

    ["Unmark from persistent save",
    {
        [_object, [] call _GetArrayFunction] call skhpersist_fnc_UnmarkForSave;
    }, _object, _GetArrayFunction, _CurrentFunction, _MirrorFunction, _AddAction] call _AddAction;
};

private _handledObjects = [];
private _storedActions = [];

[format ["Looking for objects of type %1 to add mark actions to.", _objectsType]] call skhpersist_fnc_LogToRPT;

while {alive player} do
{
    sleep 1;
    private _objectsArray = player nearObjects [_objectsType, _radius];

    if (PSave_RefreshActions) then
    {
        {
            (_handledObjects # _forEachIndex) removeAction _x;
        } forEach _storedActions;

        _storedActions = [];
        _handledObjects = [];
        PSave_RefreshActions = false;
    };
    
    if (!PSave_LoadInProgress) then
    {
        {
            if (!(_x in _handledObjects)) then
            {
                private _action = objNull;

                if (!(_x in ([] call _GetArrayFunction))) then
                {
                    _action = [_x, _GetArrayFunction, _AddMarkAction, _AddUnmarkAction, _AddAction] call _AddMarkAction;
                }
                else
                {
                    _action = [_x, _GetArrayFunction, _AddUnmarkAction, _AddMarkAction, _AddAction] call _AddUnmarkAction;
                };

                _handledObjects pushBack _x;
                _storedActions pushBack _action;
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