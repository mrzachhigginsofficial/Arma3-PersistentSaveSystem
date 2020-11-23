/*
Initializies trigger save system data.
*/

// Number of loading slots (default = 9, ALPHA through INDIA).
TriggerSaveSystem_SaveSlots = 9;

// Next save slot to be used.
TriggerSaveSystem_NextSaveSlot = 1;

// Triggers for each save slot.
TriggerSaveSystem_SlotTriggers = [nil, nil, nil, nil, nil, nil, nil, nil, nil];

// Save game trigger.
TriggerSaveSystem_SaveTrigger = [] call skhpersist_fnc_CreateSaveTrigger;

PSave_OnLoadEH pushBack { [] call skhpersist_fnc_UpdateRadioTriggers; };
PSave_OnSaveEH pushBack { [] call skhpersist_fnc_UpdateRadioTriggers; };
PSave_OnClearEH pushBack { [] call skhpersist_fnc_UpdateRadioTriggers; };

[] call skhpersist_fnc_UpdateRadioTriggers;