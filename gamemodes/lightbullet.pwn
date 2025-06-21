#include <a_samp>
#include <core>
#include <float>
#include "../include/lb_common.inc"
#include "../include/lb_indexers.inc"
#include "../include/lb_formatted.inc"

new total_vehicles_from_files=0;
new total_pickups_from_files=0;
new total_classes_from_files=0;

#pragma tabsize 0

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define PocketMoney 50000 // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define NUMVALUES 4

forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);

//------------------------------------------------------------------------------------------------------

new CashScoreOld;
new iSpawnSet[MAX_PLAYERS];

new Float:gRandomPlayerSpawns[23][3] = {
{1958.3783,1343.1572,15.3746},
{2199.6531,1393.3678,10.8203},
{2483.5977,1222.0825,10.8203},
{2637.2712,1129.2743,11.1797},
{2000.0106,1521.1111,17.0625},
{2024.8190,1917.9425,12.3386},
{2261.9048,2035.9547,10.8203},
{2262.0986,2398.6572,10.8203},
{2244.2566,2523.7280,10.8203},
{2335.3228,2786.4478,10.8203},
{2150.0186,2734.2297,11.1763},
{2158.0811,2797.5488,10.8203},
{1969.8301,2722.8564,10.8203},
{1652.0555,2709.4072,10.8265},
{1564.0052,2756.9463,10.8203},
{1271.5452,2554.0227,10.8203},
{1441.5894,2567.9099,10.8203},
{1480.6473,2213.5718,11.0234},
{1400.5906,2225.6960,11.0234},
{1598.8419,2221.5676,11.0625},
{1318.7759,1251.3580,10.8203},
{1558.0731,1007.8292,10.8125},
//{-857.0551,1536.6832,22.5870},   Out of Town Spawns
//{817.3494,856.5039,12.7891},
//{116.9315,1110.1823,13.6094},
//{-18.8529,1176.0159,19.5634},
//{-315.0575,1774.0636,43.6406},
{1705.2347,1025.6808,10.8203}
};

new Float:gCopPlayerSpawns[2][3] = {
{2297.1064,2452.0115,10.8203},
{2297.0452,2468.6743,10.8203}
};

//Round code stolen from mike's Manhunt :P
//new gRoundTime = 3600000;                   // Round time - 1 hour
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
//new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min

new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

main()
{
		print("\n----------------------------------");
		print("  Running SA:MP ~Light Bullet Server\n");
		print("             Coded By");
		print("         Light Bullet team");
		print("----------------------------------\n");
}

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestSpawn(playerid)
{
	//printf("OnPlayerRequestSpawn(%d)",playerid);
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//new s[256];
	//format(s,256,"Picked up %d",pickupid);
	//SendClientMessage(playerid,0xFFFFFFFF,s);
}

//------------------------------------------------------------------------------------------------------

public MoneyGrubScoreUpdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
				//format(string, sizeof(string), "$$$ %s is now in the lead $$$", name);
				//SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

/*public GrubModeReset()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerScore(i, PocketMoney);
			SetPlayerRandomSpawn(i, classid);
		}
	}

}*/

//------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~SA:MP ~g~Light Bullet Server",5000,5);
	SendPlayerFormattedText(playerid, "Welcome to SA:MP Light Bullet Server, For help type /help.", 0);
	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();
	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	gActivePlayers[playerid]--;
}
//------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx;

	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/help", true) == 0) {
		SendPlayerFormattedText(playerid,"SA:MP Light Bullet Server Coded By Light Bullet Team.",0);
		SendPlayerFormattedText(playerid,"Type: /objective : to find out what to do in this gamemode.",0);
		SendPlayerFormattedText(playerid,"Type: /givecash [playerid] [money-amount] to send money to other players.",0);
		SendPlayerFormattedText(playerid,"Type: /tips : to see some tips from the creator of the gamemode.", 0);
    return 1;
	}
	if(strcmp(cmd, "/objective", true) == 0) {
		SendPlayerFormattedText(playerid,"This gamemode is faily open, there's no specific win / endgame conditions to meet.",0);
		SendPlayerFormattedText(playerid,"In SA:MP Light Bullet Server, when you kill a player, you will receive whatever money they have.",0);
		SendPlayerFormattedText(playerid,"Consequently, if you have lots of money, and you die, your killer gets your cash.",0);
		SendPlayerFormattedText(playerid,"However, you're not forced to kill players for money, you can always gamble in the", 0);
		SendPlayerFormattedText(playerid,"Casino's.", 0);
    return 1;
	}
	if(strcmp(cmd, "/tips", true) == 0) {
		SendPlayerFormattedText(playerid,"Spawning with just a desert eagle might sound lame, however the idea of this",0);
		SendPlayerFormattedText(playerid,"gamemode is to get some cash, get better guns, then go after whoever has the",0);
		SendPlayerFormattedText(playerid,"most cash. Once you've got the most cash, the idea is to stay alive(with the",0);
		SendPlayerFormattedText(playerid,"cash intact)until the game ends, simple right?", 0);
    return 1;
	}
	
 	if(strcmp(cmd, "/givecash", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);
		
		//printf("givecash_command: %d %d",giveplayerid,moneys);

		
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "You have sent %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "You have recieved $%d from %s(player: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
			}
		}
		else {
				format(string, sizeof(string), "%d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}
	
	// PROCESS OTHER COMMANDS
	
	
	return 0;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	GivePlayerMoney(playerid, PocketMoney);
	SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);
	TogglePlayerClock(playerid,1);
	return 1;
}

public SetPlayerRandomSpawn(playerid)
{
	if (iSpawnSet[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else if (iSpawnSet[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        ResetPlayerMoney(playerid);
	} else {
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
			playercash = GetPlayerMoney(playerid);
			if (playercash > 0)  {
				GivePlayerMoney(killerid, playercash);
				ResetPlayerMoney(playerid);
			}
			else
			{
			}
     	}
 	return 1;
}

/* public OnPlayerDeath(playerid, killerid, reason)
{   haxed by teh mike
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new playercash;
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "*** %s drowned.)", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "*** %s died. (%s)", name, deathreason);
				} else {
				    format(string, sizeof(string), "*** %s died.", name);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "*** %s killed %s. (%s)", killer, name, deathreason);
		} else {
				format(string, sizeof(string), "*** %s killed %s.", killer, name);
			}
		}
	SendClientMessageToAll(COLOR_RED, string);
		{
		playercash = GetPlayerMoney(playerid);
		if (playercash > 0)
		{
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
		else
		{
		}
	}
 	return 1;
}*/

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	iSpawnSet[playerid] = 0;
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public GameModeExitFunc()
{
	GameModeExit();
}

public OnGameModeInit()
{
	SetGameModeText("Light Bullet's DM~MG");

	ShowPlayerMarkers(1);
	ShowNameTags(1);
	EnableStuntBonusForAll(0);

	//Classes
	total_classes_from_files += LoadClassesFromFile("classes/unique.txt");
	total_classes_from_files += LoadClassesFromFile("classes/cops.txt");
	total_classes_from_files += LoadClassesFromFile("classes/civil.txt");
	total_classes_from_files += LoadClassesFromFile("classes/workers.txt");
	total_classes_from_files += LoadClassesFromFile("classes/characters.txt");
	printf("Total classes from files: %d",total_classes_from_files);

	//Vehicles
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/car_spawns.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/13_additions.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/uber_haxed.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/uncommented.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/22_4_update.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/25_4_update.txt");
	printf("Total vehicles from files: %d",total_vehicles_from_files);

	//Pickups
	total_pickups_from_files += LoadStaticPickupsFromFile("pickups/25_4_update.txt");
	printf("Total pickups from files: %d",total_pickups_from_files);

	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
}
