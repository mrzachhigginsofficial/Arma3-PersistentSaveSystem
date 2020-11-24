["Initializing persistent save system."] call skhpersist_fnc_LogToRPT;

// Prefix for save-related variables.
PSave_SaveGamePrefix = "PSave_TestMission";

// Arrays with custom objects to be stored.
PSave_CustomContainersToSave = [];
PSave_CustomUnitsToSave = [];
PSave_CustomVehiclesToSave = [];

// Functions to call after load (provide the function code or name directly).
PSave_OnLoadEH = [];

// Functions to call after save (provide the function code or name directly).
PSave_OnSaveEH = [];

// You can create and use your own save system if you want, instead of the default one.
[] call skhpersist_fnc_InitTriggerSaveSystem;

// Functions to call while loading (provide paths to .sqf files).
PSave_CustomLoadScripts = [];

// Functions to call while saving (provide paths to .sqf files).
PSave_CustomSaveScripts = [];

// Mod-specific data saving.
// <Ravage>
PSave_CustomLoadScripts pushBack "mods\ravage\fn_LoadRavageData.sqf";
PSave_CustomSaveScripts pushBack "mods\ravage\fn_SaveRavageData.sqf";
// </Ravage>

// Looks for cars near the player in a loop.
// Each car will get an action, which will allow to mark it for save.
[1000, "Car", PSave_CustomVehiclesToSave] spawn skhpersist_fnc_FindObjectsToAddActions;