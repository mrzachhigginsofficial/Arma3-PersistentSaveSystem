/*
Executes either a specified code or a function in given path,
depending on what has been provided in params.

Returns a value returned by called function (can be nil).
*/

params ["_functionToCall", "_arrayOfParams"];

private "_result";
private _type = typeName _functionToCall;

if (_type == "STRING") then
{
	_result = _arrayOfParams call compile preprocessFileLineNumbers _functionToCall;
}
else
{
	if (_type == "CODE") then
	{
		_result = _arrayOfParams call _functionToCall;
	}
	else
	{
		[format ["Wrong function type provided (%1, expected STRING or CODE).", _type]] call skhpersist_fnc_LogToRPT;
	};
};

_result;