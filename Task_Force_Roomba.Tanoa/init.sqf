/*
    init.sqf - runs on every machine at mission start, before initServer.sqf
    and initPlayerLocal.sqf. Mission-wide switches only: anything with logic
    in it lives in the mod (z\jmfsb), and anything a mission maker tunes lives
    under config\. https://community.bistudio.com/wiki/Initialization_Order
*/

if (!isMultiplayer) then {["Mission is running in a singleplayer environment.", "init", true, false] call jmfsb_diag_fnc_warning};

enableSaving [false, false];
enableSentences false;

// ambient wildlife off, ambient sounds on, wind at full strength
enableEnvironment [false, true, 1];

// ACE dragging limits, in grams. The shipped ACE (3.21) still reads these two
// globals rather than a CBA setting - checked against ace_dragging.pbo.
ACE_maxWeightCarry = 800;
ACE_maxWeightDrag = 12000;

// every chat channel open for text, none for voice - ACRE carries voice
{ _x enableChannel [true, false] } forEach [0, 1, 2, 3, 4, 5]; // global, side, command, group, vehicle, direct

["Initialization completed.", "init", false, false] call jmfsb_diag_fnc_info;
