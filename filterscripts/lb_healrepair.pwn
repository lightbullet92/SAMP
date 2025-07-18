#define FILTERSCRIPT

#include <a_samp>
#include <core>
#include <float>
#include <a_vehicles>

#include "../include/lb_indexers.inc"

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256],idx;
    cmd = strtok(cmdtext,idx);
	if(strcmp(cmd, "/kill", true) == 0) {
        new Float:health;
        GetPlayerHealth(playerid, health);
        if(health != 0.0)
            SetPlayerHealth(playerid, 0.0);
    	return 1;
	}
    if(strcmp(cmd, "/heal", true) == 0) {
        new string[255];
        SetPlayerHealth(playerid, 100.0);
        format(string,sizeof(string),"You have been successfully healed.");
        SendClientMessage(playerid,0x00FF00FF,string);
        return 1;
    }
    if(strcmp(cmd, "/repair", true) == 0) {
        new string[255];
        if(IsPlayerInAnyVehicle(playerid)) {
            new Float:vehiclehealth;
            GetVehicleHealth (GetPlayerVehicleID(playerid), vehiclehealth);
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
                if(vehiclehealth < 1000.0)
                {
                    Repair(GetPlayerVehicleID(playerid));
                    format(string,sizeof(string),"Your vehicle has been successfully repaired.");
                    SendClientMessage(playerid,0x00FF00FF,string);
                }
                else
                {
                    format(string,sizeof(string),"Your vehicle is already repaired.");
                    SendClientMessage(playerid,0x00FF00FF,string);
                }
            }
            if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
                format(string,sizeof(string),"You can't repair the vehicle from the passenger seat.");
                SendClientMessage(playerid,0xFF0000FF,string);
            }
        }
        else
        {
            format(string,sizeof(string),"To repair a vehicle, you need to get into it.");
            SendClientMessage(playerid,0xFF0000FF,string);
        }
        return 1;
    }
    return 0;
}

stock Repair(vehicleid)
{
    new Float:x, Float:y, Float:z;
    new Float:angle;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    SetVehiclePos(vehicleid, x, y, z + 1.5);
    SetVehicleZAngle(vehicleid, angle);
    //RepairVehicle(vehicleid);
    SetVehicleHealth(vehicleid, 1000);
}
