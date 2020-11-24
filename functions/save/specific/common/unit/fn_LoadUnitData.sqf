/*
Loads and applies given _unitData to _unit and assigns it to given _leader (if specified).
*/

params ["_unit", "_unitData", "_leader"];

private _CreateUnitIfDoesntExist =
{
    params ["_unit", "_class", "_side"];
    
    if (isNil { _unit }) then
    {
        _unit = (createGroup _side) createUnit [_class, [0, 0, 0], [], 0, "FORM"];
    };
    
    _unit;
};

private _RemoveOtherUnitsFromGroup =
{
    params ["_unit"];
    
    {
        if (_unit != _x) then
        {
            deleteVehicle _x;
        };
    } forEach (units _unit);
};

private _JoinUnitToLeaderIfSpecified =
{
    params ["_unit", "_leader"];
    
    if (!isNil { _leader }) then
    {
        [_unit] joinSilent _leader;
    };
};

private _LoadUnitsInGroup =
{
    params ["_leader", "_group"];
    
    {
       [nil, _x, _leader] call skhpersist_fnc_LoadUnitData;
    } forEach _group;
};

private _RestoreUnitsName =
{
    params ["_unit", "_nameArray"];
    
    private _firstName = "";
    private _surname = "";
    private _joinedNames = "";
    
    if (count _nameArray == 1) then
    {
        _surname = _nameArray select 0;
        _joinedNames = _surname;
    }
    else
    {
        _firstName = _nameArray select 0;
        _surname = _nameArray select 1;
        _joinedNames = format ["%1 %2", _firstName, _surname];
    };
    
    _unit setName [_joinedNames, _firstName, _surname];
};

[format ["Loading unit data for unit %1.", _unit]] call skhpersist_fnc_LogToRPT;

private _class = [_unitData, "class"] call skhpersist_fnc_GetByKey;
private _side = [_unitData, "side"] call skhpersist_fnc_GetByKey;
private _group = [_unitData, "group"] call skhpersist_fnc_GetByKey;
        
_unit = [_unit, _class, _side] call _CreateUnitIfDoesntExist;
_unit setVariable ["BIS_enableRandomization", false];

[_unit] call _RemoveOtherUnitsFromGroup;
[_unit, _leader] call _JoinUnitToLeaderIfSpecified;
[_unit, _group] call _LoadUnitsInGroup;

[_unit, _unitData, _RestoreUnitsName] spawn {
    params ["_unit", "_unitData", "_RestoreUnitsName"];
    
    private _loadout = [_unitData, "loadout"] call skhpersist_fnc_GetByKey;
    private _damages = [_unitData, "damages"] call skhpersist_fnc_GetByKey;
    private _posRotation = [_unitData, "posRotation"] call skhpersist_fnc_GetByKey;
    private _skill = [_unitData, "skill"] call skhpersist_fnc_GetByKey;
    private _name = [_unitData, "name"] call skhpersist_fnc_GetByKey;
    private _face = [_unitData, "face"] call skhpersist_fnc_GetByKey;
    private _speaker = [_unitData, "speaker"] call skhpersist_fnc_GetByKey;
    private _pitch = [_unitData, "pitch"] call skhpersist_fnc_GetByKey;
    private _rating = [_unitData, "rating"] call skhpersist_fnc_GetByKey;
    private _stamina = [_unitData, "stamina"] call skhpersist_fnc_GetByKey;
    private _fatigue = [_unitData, "fatigue"] call skhpersist_fnc_GetByKey;
    
    [_unit, _name] call _RestoreUnitsName;

    [_unit, _damages] call skhpersist_fnc_ApplyDamages;
    [_unit, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;
    
    _unit setSkill _skill;
    _unit setUnitLoadout _loadout;
    _unit setFace _face;
    _unit setSpeaker _speaker;
    _unit setPitch _pitch;
    _unit setStamina _stamina;
    _unit setFatigue _fatigue;

    if (rating _unit > _rating) then
    {
        _unit addRating -(rating _unit - _rating);
    }
    else
    {
        _unit addRating (_rating - rating _unit);
    };
};

_unit;