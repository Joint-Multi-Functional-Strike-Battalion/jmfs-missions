/*
    initServer.sqf - server only.

    Everything below reads the database's structure, not files: there is no
    config\ folder in this mission (see description.ext).
*/

/* role-access grants stored on the server by the admin panel (persistent across missions) */
YMF_roleGrants = +(profileNamespace getVariable ["YMF_roleGrants_persistent", []]);
publicVariable "YMF_roleGrants";

/* dynamic groups --------------------------------------------------------------- */
// each entry becomes [name, roles, condition, group, [unit per role]]. THE ORBAT
// IS TAC//PAC'S: the table starts empty here and PAC's boot fills it from the
// database's order of battle (jmfsb_groups_fnc_orbatApply) once its structure is in.
YMF_dynamicGroups = [];
[YMF_dynamicGroups] remoteExecCall ["jmfsb_groups_fnc_updateGroups", -2, "YMF_DG_JIP"];
addMissionEventHandler ["HandleDisconnect", jmfsb_groups_fnc_handleDisconnect];

/* radar and datalink ---------------------------------------------------------- */
// Every vehicle of a class in the unit's <unit>.radar list (pac.jmsb.info) joins
// its side's sensor network the moment it exists - a class event handler,
// applied to what is already placed, not a loop over `vehicles`.
{
    if (isClass (configFile >> "CfgVehicles" >> _x)) then {
        [_x, "init", {
            params ["_veh"];
            if (local _veh) then {
                [_veh] call jmfsb_common_fnc_setDatalink;
                _veh setVehicleRadar 1;
            };
        }, true, [], true] call CBA_fnc_addClassEventHandler;
    };
} forEach (["radar", "classes"] call jmfsb_pac_fnc_cfgList);
