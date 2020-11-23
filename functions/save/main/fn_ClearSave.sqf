/*
Removes all persisted data for given save _slot.
*/

// _slot is optional - if not specified, all data persisted by
// this system will be removed (i.e. only with prefix = PSave_SaveGamePrefix).
params ["_slot"];

private "_variables";

if (isNil { _slot }) then
{
	_variables = [] call skhpersist_fnc_ListExistingVariables;
}
else
{
	_variables = [_slot] call skhpersist_fnc_ListExistingVariables;
};

{
	profileNamespace setVariable [_x, nil];
} forEach _variables;

saveProfileNamespace;

{
	[] call _x;
} forEach PSave_OnClearEH;

hint format ["Save has been cleaned up!"];