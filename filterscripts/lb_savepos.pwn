#define FILTERSCRIPT

#include <a_samp>
#include <core>
#include <float>

#include "../include/lb_commands.inc"
#include "../include/lb_indexers.inc"

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256],idx;
    cmd = strtok(cmdtext,idx);
    if(strcmp(cmd,"/savepos",true)==0)
    {
        new tmp[256];
        tmp = strtok(cmdtext,idx);
        if(!strlen(tmp))
            SendClientMessage(playerid,0xFFFFF00,"Please, try: /savepos [name]");
        else
        {
            new Float:x, Float:y, Float:z, Float:angle;
            new filename[] = "custom/saved.txt";
            GetPlayerPos(playerid, x, y, z);
            if(IsPlayerInAnyVehicle(playerid))
                GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
            else
                GetPlayerFacingAngle(playerid, angle);
            SavePosToFile(filename,tmp,x, y, z, angle);
            SendClientMessage(playerid,0x0000FF,"Position saved.");
        }
        return 1;
    }
    return 0;
}
