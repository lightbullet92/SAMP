#include <a_samp>
#include <core>
#include <float>
#include "../include/lb_common.inc"
#include "../include/lb_indexers.inc"
#include "../include/lb_formatted.inc"
#include "../include/lb_spawns.inc"

new total_vehicles_from_files=0;
new total_pickups_from_files=0;
new total_classes_from_files=0;

new playerName[MAX_PLAYERS][24];
//new playerMoney = 0;

new gPlayerCitySelection[MAX_PLAYERS];
new gPlayerHasCitySelected[MAX_PLAYERS];
new gPlayerLastCitySelectionTick[MAX_PLAYERS];

new Text:txtClassSelHelper;
new Text:txtLosSantos;
new Text:txtSanFierro;
new Text:txtLasVenturas;

#pragma tabsize 0

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define PocketMoney 50000 // Amount player recieves on spawn.
#define KILLPRICE 500
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define COLOR_NORMAL_PLAYER 0xFF4444FF

#define CITY_LOS_SANTOS 	0
#define CITY_SAN_FIERRO 	1
#define CITY_LAS_VENTURAS 	2

#define NUMVALUES 4

//forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);

//------------------------------------------------------------------------------------------------------

//new CashScoreOld;

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

ClassSel_SetupCharSelection(playerid)
{
   	if(gPlayerCitySelection[playerid] == CITY_LOS_SANTOS) {
		SetPlayerInterior(playerid,11);
		SetPlayerPos(playerid,508.7362,-87.4335,998.9609);
		SetPlayerFacingAngle(playerid,0.0);
    	SetPlayerCameraPos(playerid,508.7362,-83.4335,998.9609);
		SetPlayerCameraLookAt(playerid,508.7362,-87.4335,998.9609);
	}
	else if(gPlayerCitySelection[playerid] == CITY_SAN_FIERRO) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,-2673.8381,1399.7424,918.3516);
		SetPlayerFacingAngle(playerid,181.0);
    	SetPlayerCameraPos(playerid,-2673.2776,1394.3859,918.3516);
		SetPlayerCameraLookAt(playerid,-2673.8381,1399.7424,918.3516);
	}
	else if(gPlayerCitySelection[playerid] == CITY_LAS_VENTURAS) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,349.0453,193.2271,1014.1797);
		SetPlayerFacingAngle(playerid,286.25);
    	SetPlayerCameraPos(playerid,352.9164,194.5702,1014.1875);
		SetPlayerCameraLookAt(playerid,349.0453,193.2271,1014.1797);
	}
	
}

//----------------------------------------------------------
// Used to init textdraws of city names

ClassSel_InitCityNameText(Text:txtInit)
{
  	TextDrawUseBox(txtInit, 0);
	TextDrawLetterSize(txtInit,1.25,3.0);
	TextDrawFont(txtInit, 0);
	TextDrawSetShadow(txtInit,0);
    TextDrawSetOutline(txtInit,1);
    TextDrawColor(txtInit,0xEEEEEEFF);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
}

//----------------------------------------------------------

ClassSel_InitTextDraws()
{
    // Init our observer helper text display
	txtLosSantos = TextDrawCreate(10.0, 380.0, "Los Santos");
	ClassSel_InitCityNameText(txtLosSantos);
	txtSanFierro = TextDrawCreate(10.0, 380.0, "San Fierro");
	ClassSel_InitCityNameText(txtSanFierro);
	txtLasVenturas = TextDrawCreate(10.0, 380.0, "Las Venturas");
	ClassSel_InitCityNameText(txtLasVenturas);

    // Init our observer helper text display
	txtClassSelHelper = TextDrawCreate(10.0, 415.0, " Press ~b~~k~~GO_LEFT~ ~w~or ~b~~k~~GO_RIGHT~ ~w~to switch cities.~n~ Press ~r~~k~~PED_FIREWEAPON~ ~w~to select.");
	TextDrawUseBox(txtClassSelHelper, 1);
	TextDrawBoxColor(txtClassSelHelper,0x222222BB);
	TextDrawLetterSize(txtClassSelHelper,0.3,1.0);
	TextDrawTextSize(txtClassSelHelper,400.0,40.0);
	TextDrawFont(txtClassSelHelper, 2);
	TextDrawSetShadow(txtClassSelHelper,0);
    TextDrawSetOutline(txtClassSelHelper,1);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
    TextDrawColor(txtClassSelHelper,0xFFFFFFFF);
}

//----------------------------------------------------------

ClassSel_SetupSelectedCity(playerid)
{
	if(gPlayerCitySelection[playerid] == -1) {
		gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
	}
	
	if(gPlayerCitySelection[playerid] == CITY_LOS_SANTOS) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,1630.6136,-2286.0298,110.0);
		SetPlayerCameraLookAt(playerid,1887.6034,-1682.1442,47.6167);
		
		TextDrawShowForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	}
	else if(gPlayerCitySelection[playerid] == CITY_SAN_FIERRO) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,-1300.8754,68.0546,129.4823);
		SetPlayerCameraLookAt(playerid,-1817.9412,769.3878,132.6589);
		
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawShowForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	}
	else if(gPlayerCitySelection[playerid] == CITY_LAS_VENTURAS) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,1310.6155,1675.9182,110.7390);
		SetPlayerCameraLookAt(playerid,2285.2944,1919.3756,68.2275);
		
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawShowForPlayer(playerid,txtLasVenturas);
	}
}

//----------------------------------------------------------

ClassSel_SwitchToNextCity(playerid)
{
    gPlayerCitySelection[playerid]++;
	if(gPlayerCitySelection[playerid] > CITY_LAS_VENTURAS) {
	    gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
	}
	PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_SwitchToPreviousCity(playerid)
{
    gPlayerCitySelection[playerid]--;
	if(gPlayerCitySelection[playerid] < CITY_LOS_SANTOS) {
	    gPlayerCitySelection[playerid] = CITY_LAS_VENTURAS;
	}
	PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_HandleCitySelection(playerid)
{
	new Keys,ud,lr;
    GetPlayerKeys(playerid,Keys,ud,lr);
    
    if(gPlayerCitySelection[playerid] == -1) {
		ClassSel_SwitchToNextCity(playerid);
		return;
	}

	// only allow new selection every ~500 ms
	if( (GetTickCount() - gPlayerLastCitySelectionTick[playerid]) < 500 ) return;
	
	if(Keys & KEY_FIRE) {
	    gPlayerHasCitySelected[playerid] = 1;
	    TextDrawHideForPlayer(playerid,txtClassSelHelper);
		TextDrawHideForPlayer(playerid,txtLosSantos);
		TextDrawHideForPlayer(playerid,txtSanFierro);
		TextDrawHideForPlayer(playerid,txtLasVenturas);
	    TogglePlayerSpectating(playerid,0);
	    return;
	}
	
	if(lr > 0) {
	   ClassSel_SwitchToNextCity(playerid);
	}
	else if(lr < 0) {
	   ClassSel_SwitchToPreviousCity(playerid);
	}
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

public OnPlayerConnect(playerid)
{
	new filename[128];
	new File:file_stats;
	GetPlayerName(playerid, playerName[playerid], 24);
	format(filename,sizeof(filename),"stats/%s.txt", playerName[playerid]);
    if(!fexist(filename))
    {
        file_stats = fopen(filename,filemode:io_append);
		GivePlayerMoney(playerid, PocketMoney);
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
	SendPlayerFormattedText(playerid, "Welcome to SA:MP Light Bullet Server, For help type /help.", 0);

	gPlayerCitySelection[playerid] = -1;
	gPlayerHasCitySelected[playerid] = 0;
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();

	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();
	
	return 1;
}

//------------------------------------------------------------------------------------------------------
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
	new randSpawn = 0;

	//GivePlayerMoney(playerid, PocketMoney);
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,1);

	gPlayerHasCitySelected[playerid] = 0;

	if(CITY_LOS_SANTOS == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_LosSantos));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_LosSantos[randSpawn][0],
		 gRandomSpawns_LosSantos[randSpawn][1],
		 gRandomSpawns_LosSantos[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_LosSantos[randSpawn][3]);
	}
	else if(CITY_SAN_FIERRO == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_SanFierro));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_SanFierro[randSpawn][0],
		 gRandomSpawns_SanFierro[randSpawn][1],
		 gRandomSpawns_SanFierro[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_SanFierro[randSpawn][3]);
	}
	else if(CITY_LAS_VENTURAS == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_LasVenturas));
 	    SetPlayerPos(playerid,
		 gRandomSpawns_LasVenturas[randSpawn][0],
		 gRandomSpawns_LasVenturas[randSpawn][1],
		 gRandomSpawns_LasVenturas[randSpawn][2]);
		SetPlayerFacingAngle(playerid,gRandomSpawns_LasVenturas[randSpawn][3]);
	}

	GivePlayerWeapon(playerid,WEAPON_COLT45,100);

	return 1;
}



//------------------------------------------------------------------------------------------------------

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

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	if(gPlayerHasCitySelected[playerid]) {
		ClassSel_SetupCharSelection(playerid);
		return 1;
	} else {
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) {
			TogglePlayerSpectating(playerid,1);
    		TextDrawShowForPlayer(playerid, txtClassSelHelper);
    		gPlayerCitySelection[playerid] = -1;
		}
  	}
    
	return 0;
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
	SetGameModeText("Light Bullet's SA:MP server");

	ShowPlayerMarkers(0);
	ShowNameTags(1);
	EnableStuntBonusForAll(1);

	ClassSel_InitTextDraws();

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

	//From LVDM
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/car_spawns.txt");
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/13_additions.txt");
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/uber_haxed.txt");
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/uncommented.txt");
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/22_4_update.txt");
	//total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lvdm/25_4_update.txt");
	
	//From Grand Larceny
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

	//SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	
	// changing cities by inputs
	if( !gPlayerHasCitySelected[playerid] &&
	    GetPlayerState(playerid) == PLAYER_STATE_SPECTATING ) {
	    ClassSel_HandleCitySelection(playerid);
	    return 1;
	}
	
	// No weapons in interiors
	//if(GetPlayerInterior(playerid) != 0 && GetPlayerWeapon(playerid) != 0) {
	//    //SetPlayerArmedWeapon(playerid,0); // fists
	//    return 0; // no syncing until they change their weapon
	//}
	
	// Don't allow minigun
	if(GetPlayerWeapon(playerid) == WEAPON_MINIGUN) {
	    Kick(playerid);
	    return 0;
	}
	
	// No jetpacks allowed
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
	    Kick(playerid);
	    return 0;
	}

	return 1;
}
