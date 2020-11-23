/*
Creates a radio trigger with given _text on _radio channel (e.g. ALPHA),
which will execute given _function.
*/
params ["_text", "_radio", "_function"];

private _trigger = createTrigger ["EmptyDetector", [0, 0, 0]];
_trigger setTriggerText _text;
_trigger setTriggerActivation [_radio, "PRESENT", true];
_trigger setTriggerStatements ["this", _function, ""];

_trigger;