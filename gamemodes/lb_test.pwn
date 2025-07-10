#include <a_samp>
#include <core>
#include <float>
#include "../include/lb_common.inc"
#include "../include/lb_indexers.inc"
#include "../include/lb_formatted.inc"

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

#define INACTIVE_PLAYER_ID 255

new total_vehicles_from_files=0;
new total_pickups_from_files=0;
new total_classes_from_files=0;

new gActivePlayers[MAX_PLAYERS];

main()
{
	print("\n----------------------------------");
	print("Running SA:MP ~Light Bullet Server\n");
	print("           Coded By");
	print("       Light Bullet team");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Light Bullet SA:MP Server");

	ShowPlayerMarkers(0);
	ShowNameTags(0);
	EnableStuntBonusForAll(1);

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

    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//new s[256];
	//format(s,256,"Picked up %d",pickupid);
	//SendClientMessage(playerid,0xFFFFFFFF,s);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	new killprice = 500;
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        //ResetPlayerMoney(playerid);
	}
	else
	{
		SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
		playercash = GetPlayerMoney(playerid);
		GivePlayerMoney(killerid, killprice);
		if (playercash > 0)  {
			if (playercash > killprice)
			{
				playercash -= killprice;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, playercash);
			}
			else
				ResetPlayerMoney(playerid);
		}
	}
 	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256],idx;
    cmd = strtok(cmdtext,idx);
    //

	return 0;
}

public OnPlayerConnect(playerid)
{
	gActivePlayers[playerid]++;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	gActivePlayers[playerid]--;
    return 1;
}
