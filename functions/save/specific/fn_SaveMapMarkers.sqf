/*
Stores map markers.
Data is saved to given save _slot.
*/

params ["_slot"];

private _markersArray = [];

{
    private _marker = [];
    
    _marker pushBack ["name", _x];
    
    _marker pushBack ["alpha", markerAlpha _x];
    _marker pushBack ["brush", markerBrush _x];
    _marker pushBack ["color", markerColor _x];
    _marker pushBack ["dir", markerDir _x];
    _marker pushBack ["position", markerPos _x];
    _marker pushBack ["shape", markerShape _x];
    _marker pushBack ["size", markerSize _x];
    _marker pushBack ["text", markerText _x];
    _marker pushBack ["type", markerType _x];
    
    _markersArray pushBack _marker;
} forEach allMapMarkers;

["markers", _markersArray, _slot] call skhpersist_fnc_SaveData;