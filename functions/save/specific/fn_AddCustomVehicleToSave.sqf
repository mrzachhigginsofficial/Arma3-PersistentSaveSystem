/*
Makes specified _vehicle saveable.
*/

params ["_vehicle"];

[format ["Trying to add vehicle %1 to save.", _vehicle]] call skhpersist_fnc_LogToRPT;

if (PSave_CustomVehiclesToSave find _vehicle == -1) then 
{
	[format ["Adding vehicle %1 to save.", _vehicle]] call skhpersist_fnc_LogToRPT;
	PSave_CustomVehiclesToSave pushBack _vehicle;
}
else
{
	[format ["Vehicle %1 is already added for saving.", _vehicle]] call skhpersist_fnc_LogToRPT;
};