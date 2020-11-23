/*
Adds given _object to _array of objects, which should be saved.
It's duplicate-safe (it's not possible to add the same object twice).
*/
params ["_object", "_array"];

if (_array find _object == -1) then
{
    _array pushBack _object;
    hint format ["%1 will be saved!", typeOf _object];
};