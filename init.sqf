// If we are not a Server
if (!isServer) then {
	// This is our join in progress player
	_isJip = isNull player;
	// Wait until they are actually a player
	waitUntil {!(isNull player)};
	// Then gives the player a false value for has healaction
	player setvariable ["hasHealAction", false, true];
// Otherwise....
} else {
	{
		// Set hasHealAction for NPCs
		_x setvariable ["hasHealAction", false, true];
	// For each unit minus playableUnits
	} foreach (allUnits);
};

paraTeamLead   addEventHandler ["respawn", {_this execVM "dogfunctions.sqf"}];

{
	_x setvariable ["damageHist", [ ]];
	_x addEventHandler
		["handleDamage",
			{	_unit 	= _this select 0;
				_part 	= _this select 1;
				_dam	= _this select 2;
				_source	= _this select 4;
				_list 	= (_unit getvariable "damageHist") + [[_part,_dam,_source,diag_tickTime]];
				
				_unit setvariable ["damageHist", _list];

				// If the unit does not have a heal action...
				if !(_unit getvariable "hasHealAction") then {
					// Then set healAction variable to true (to avoid duplicates)
					_unit setvariable ["hasHealAction", true, true];
					// Set a global variable to reference later in another out of scope script
					healTarget = _unit;
					// Broadcast the variable to everyone has it
					publicVariable "healTarget";

					// Call multiplayer function to add the action on all clients
					 [{ [ player, healTarget ] spawn fnc_yink_addHealAction},"BIS_fnc_spawn",side player,true] call BIS_fnc_MP;
				};
			}
		];
	//_bleedout = [_x] spawn yink_fnc_bleed_out;
} foreach allUnits;

sleep 5;

_unit   = injuredPilot;
_part 	= "body";
_dam	= 0.31;
_source	= "Grenade";
_list 	= [[_part,_dam,_source,diag_tickTime]];

_unit setvariable ["damageHist", _list];
_unit setvariable ["hasHealAction", false, true];

_unit addAction ["Treat Patient", yink_fnc_diag];

nul = [] execVM "civySideMissions\initCivySide.sqf";
nul = [] execVM "natoSideMissions\initNatoSide.sqf";

islandStatusOn = false;
islandStatusCount = 0;