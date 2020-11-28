/*
Creates a data array for given _unit.
If the unit _isLeader, then his group will also be added to a resulting array.

Returns a generated data array.
*/

params ["_unit", "_isLeader"];

private _GenerateOrdersArray =
{
    params ["_unit"];

    private _ordersArray = [];

    _ordersArray pushBack ["behaviour", behaviour _unit];
    _ordersArray pushBack ["unitPos", unitPos _unit];

    _ordersArray;
};

private _GenerateGroupOrdersArray =
{
    params ["_leader"];

    private _group = group _leader;

    private _groupOrdersArray = [];

    _groupOrdersArray pushBack ["combatMode", combatMode _group];
    _groupOrdersArray pushBack ["formation", formation _group];
    _groupOrdersArray pushBack ["formationDir", formationDirection _group];
    _groupOrdersArray pushBack ["speedMode", speedMode _group];

    _groupOrdersArray;
};

[format ["Generating unit array for unit %1 (leader: %2).", _unit, _isLeader]] call skhpersist_fnc_LogToRPT;

private _unitArray = [];

_unitArray pushBack ["class", typeOf _unit];
_unitArray pushBack ["damages", getAllHitPointsDamage _unit];
_unitArray pushBack ["posRotation", [_unit] call skhpersist_fnc_GeneratePositionAndRotationArray];
_unitArray pushBack ["loadout", getUnitLoadout _unit];
_unitArray pushBack ["side", side _unit];
_unitArray pushBack ["skill", skill _unit];
_unitArray pushBack ["name", (name _unit) splitString " "];
_unitArray pushBack ["face", face _unit];
_unitArray pushBack ["speaker", speaker _unit];
_unitArray pushBack ["pitch", pitch _unit];
_unitArray pushBack ["rating", rating _unit];
_unitArray pushBack ["stamina", getStamina _unit];
_unitArray pushBack ["fatigue", getFatigue _unit];
_unitArray pushBack ["orders", [_unit] call _GenerateOrdersArray];

if (_isLeader) then
{
    _unitArray pushBack ["group", [_unit] call skhpersist_fnc_GenerateGroupArray];
    _unitArray pushBack ["groupOrders", [_unit] call skhpersist_fnc_GenerateGroupOrdersArray];
};

_unitArray;