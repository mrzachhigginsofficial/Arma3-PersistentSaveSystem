// Prefix for save-related variables.
PSave_SaveGamePrefix = "PSave_TestMission";

// Arrays with custom objects to be stored.
PSave_CustomContainersToSave = [];
PSave_CustomUnitsToSave = [];
PSave_CustomVehiclesToSave = [];

// Functions to call after load.
PSave_OnLoadEH = [];

// Functions to call after save.
PSave_OnSaveEH = [];

// Functions to call after save is cleared (removed).
PSave_OnClearEH = [];

// You can create and use your own save system if you want, instead of the default one.
[] call skhpersist_fnc_InitTriggerSaveSystem;

// Looks for cars near the player in a loop.
// Each car will get an action, which will allow to mark it for save.
[1000, "Car", PSave_CustomVehiclesToSave] spawn skhpersist_fnc_FindObjectsToAddActions;