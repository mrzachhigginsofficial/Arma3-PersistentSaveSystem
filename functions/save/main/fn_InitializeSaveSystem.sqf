["Initializing persistent save system."] call skhpersist_fnc_LogToRPT;

// ------------------------------------------------------------------------------------
// PREFIX FOR SAVE-RELATED VARIABLES
// ------------------------------------------------------------------------------------
PSave_SaveGamePrefix = "PSave_TestMission";

// ------------------------------------------------------------------------------------
// ARRAYS WITH CUSTOM OBJECTS TO BE SAVED
// ------------------------------------------------------------------------------------
PSave_CustomContainersToSave = [];
PSave_CustomVariablesToSave = [];
PSave_CustomUnitsToSave = [];
PSave_CustomVehiclesToSave = [];

// ------------------------------------------------------------------------------------
// EVENT HANDLERS (provide paths to .sqf files or the code directly)
// ------------------------------------------------------------------------------------

// Functions to call after load.
// Params: _slot (save slot)
PSave_OnLoadEH = [];

// Functions to call after save.
// Params: _slot (save slot)
PSave_OnSaveEH = [];

// ------------------------------------------------------------------------------------
// MODS - RAVAGE
// ------------------------------------------------------------------------------------
PSave_OnLoadEH pushBack "mods\ravage\fn_LoadRavageData.sqf";
PSave_OnSaveEH pushBack "mods\ravage\fn_SaveRavageData.sqf";

// ------------------------------------------------------------------------------------
// SAVE SYSTEMS
// ------------------------------------------------------------------------------------

// You can create and use your own save system if you want, instead of the default one.
[] call skhpersist_fnc_InitTriggerSaveSystem;

// ------------------------------------------------------------------------------------
// ADDITIONAL SCRIPTS
// ------------------------------------------------------------------------------------
// Looks for cars near the player in a loop.
// Each car will get an action, which will allow to mark it for save.
[1000, "Car", PSave_CustomVehiclesToSave] spawn skhpersist_fnc_FindObjectsToAddActions;

// ------------------------------------------------------------------------------------
// DON'T CHANGE THESE VARIABLES MANUALLY
// ------------------------------------------------------------------------------------
PSave_LoadInProgress = false;
PSave_SaveInProgress = false;