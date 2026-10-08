/*
    initPlayerLocal.sqf - every client, once its player exists (JIP included).
*/

/* quiet the AI radio chatter ------------------------------------------------ */
{ _x setSpeaker "NoVoice" } forEach playableUnits;
{ _x setVariable ["BIS_noCoreConversations", true] } forEach allUnits;
0 fadeRadio 0;
enableSentences false;

/* rank: TAC//PAC puts the player's database rank on him (jmfsb_pac_fnc_applyRank) */
[player] call jmfsb_players_fnc_setRank;

/* dynamic groups: back into the role on respawn ----------------------------- */
player addEventHandler ["Respawn", { _this call jmfsb_groups_fnc_onRespawn }];

/* welcome screen: the unit's welcome document from the database ------------- */
[] call jmfsb_pac_fnc_welcomeShow;
