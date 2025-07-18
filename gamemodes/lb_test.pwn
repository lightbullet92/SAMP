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

#define KILLPRICE 500
#define POCKETMONEY 20000

#define INACTIVE_PLAYER_ID 255

new total_vehicles_from_files=0;
new total_pickups_from_files=0;
new total_classes_from_files=0;

new gActivePlayers[MAX_PLAYERS];
new playerName[MAX_PLAYERS][24];

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
	ShowNameTags(1);
	EnableStuntBonusForAll(1);

    //Classes

	//From LVDM
	//total_classes_from_files += LoadClassesFromFile("classes/lvdm/unique.txt");
	//total_classes_from_files += LoadClassesFromFile("classes/lvdm/cops.txt");
	//total_classes_from_files += LoadClassesFromFile("classes/lvdm/civil.txt");
	//total_classes_from_files += LoadClassesFromFile("classes/lvdm/workers.txt");
	//total_classes_from_files += LoadClassesFromFile("classes/lvdm/characters.txt");

	//From Grand Larceny
	total_classes_from_files += LoadClassesFromFile("classes/gl/main.txt");
	printf("Total classes from files: %d",total_classes_from_files);

	//Vehicles
	// SPECIAL
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/trains.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/pilots.txt");
   	// LAS VENTURAS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/lv_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/lv_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/lv_gen.txt");
    // SAN FIERRO
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/sf_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/sf_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/sf_gen.txt");
    // LOS SANTOS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/ls_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/ls_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/ls_gen_inner.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/ls_gen_outer.txt");
    // OTHER AREAS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/whetstone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/bone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/flint.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/tierra.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/gl/red_county.txt");
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
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        //ResetPlayerMoney(playerid);
	}
	else
	{
		SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
		playercash = GetPlayerMoney(playerid);
		GivePlayerMoney(killerid, KILLPRICE);
		if (playercash > 0)  {
			if (playercash > KILLPRICE)
			{
				playercash -= KILLPRICE;
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
	new filename[128];
	new File:file_stats;
	GetPlayerName(playerid, playerName[playerid], 24);
	format(filename,sizeof(filename),"stats/%s.txt", playerName[playerid]);
    if(!fexist(filename))
    {
        file_stats = fopen(filename,filemode:io_append);
		GivePlayerMoney(playerid, POCKETMONEY);
	    fclose(file_stats);
    }
	else
	{
		new player_cash[128];
		file_stats = fopen(filename,filemode:io_read);
		fread(file_stats, player_cash);
		GivePlayerMoney(playerid, strval(player_cash));
		fclose(file_stats);
	}
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~SA:MP ~g~Light Bullet Server",5000,5);
	SendPlayerFormattedText(playerid, "Welcome to SA:MP Light Bullet Server.", 0);
	gActivePlayers[playerid]++;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	new filename[128];
	new tmp[128];
	new File:file_stats;
	format(filename,sizeof(filename),"stats/%s.txt", playerName[playerid]);
	file_stats = fopen(filename,filemode:io_write);
	format(tmp,sizeof(tmp),"%d", GetPlayerMoney(playerid));
	fwrite(file_stats, tmp);
	fclose(file_stats);
	gActivePlayers[playerid]--;
    return 1;
}
