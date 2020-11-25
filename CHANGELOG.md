# Changelog

## v0.3.0 (pre-release)

- Added possibility to store and restore missionNamespace variables.

## v0.2.0 (pre-release)

- Removed EH for save clearing.
- Added basic Ravage mod handling.
- Added skhpersist_fnc_LogToRPT, which allows to store data to .RPT file with prefix being added automatically.
- Added logging to .RPT in strategic places to help with bug analysis.
- Magazines in containers are now stored with ammo left (this also fixes for example fuel canisters in Ravage).
- Added handling for both paths to scripts and a code in event handlers.
- Removed custom code to add actions for marking / unmarking vehicles (addAction is all we need).
- Uniforms, vests and backpacks inside a vehicle's cargo are now stored and restored along with their own cargo.
- Turrets ammo in vehicles is now stored and restored.

## v0.1.0 (pre-release)

- Initialized repository.
- Added basic saving and loading data using profileNamespace.
- Added save slots to allow multiple saves per scenario.
- Added possibility to add actions to mark something to be stored (for now only cars).
- Storing and restoring:
  - environment data,
  - map markers data,
  - player's data,
  - custom containers,
  - custom units,
  - custom vehicles,
  - unit's groups.
- Added trigger-based radio save system.