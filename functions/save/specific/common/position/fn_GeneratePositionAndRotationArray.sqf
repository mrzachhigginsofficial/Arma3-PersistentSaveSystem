/*
Creates a position / rotation array for given _entity.

Returns a generated position / rotation array.
*/

params ["_entity"];

[
    getPosATL _entity,
    getDir _entity
];