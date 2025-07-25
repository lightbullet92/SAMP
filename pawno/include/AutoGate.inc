#include <a_samp>
#define MAX_GATES	20
new GateCount = 0, GateTimer = -1,SomeoneNearGate[MAX_GATES];
enum gatesinfo
{
	Created,
	Model,
	Float:closeX,
	Float:closeY,
	Float:closeZ,
	Float:rotX,
	Float:rotY,
	Float:rotZ,
	Float:openX,
	Float:openY,
	Float:openZ,
	NameCanEnter[24],
	Distance,
	GateObject
}
new Gate[MAX_GATES][gatesinfo];
forward CheckGates();


/*
native AddAutoGate(modelid,Float:cX,Float:cY,Float:cZ,Float:rX,Float:rY,Float:rZ,Float:oX,Float:oY,Float:oZ,namecanenter[24],open_distance)
*/

stock AddAutoGate(modelid,Float:cX,Float:cY,Float:cZ,Float:rX,Float:rY,Float:rZ,Float:oX,Float:oY,Float:oZ,namecanenter[24],open_distance)
{
	GateCount++;
	new ID = GateCount;
	Gate[ID][Created] = 1;
	Gate[ID][Model] = modelid;
	Gate[ID][closeX] = cX;
	Gate[ID][closeY] = cY;
	Gate[ID][closeZ] = cZ;
	Gate[ID][rotX] = rX;
	Gate[ID][rotY] = rY;
	Gate[ID][rotZ] = rZ;
	Gate[ID][openX] = oX;
	Gate[ID][openY] = oY;
	Gate[ID][openZ] = oZ;
	format(Gate[ID][NameCanEnter],24,"%s",namecanenter);
	Gate[ID][Distance] = open_distance;
	Gate[ID][GateObject] = CreateObject(modelid,cX,cY,cZ,rX,rY,rZ);
	if(GateTimer == -1)
	{
		GateTimer = SetTimer("CheckGates",100,1);
	}
	return 1;
}

public CheckGates()
{
	for(new ID = 0; ID < MAX_GATES; ID++)
	{
		if(Gate[ID][Created] == 1)
		{
			for(new i = 0; i < GetMaxPlayers(); i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerNearGateAndCanHeEnter(i,ID))
					{
						SomeoneNearGate[ID] = 1;
					}else
					{
						if(SomeoneNearGate[ID] == 0)
						{
							MoveObject(Gate[ID][GateObject],Gate[ID][closeX],Gate[ID][closeY],Gate[ID][closeZ],1);
						}
					}
				}
			}
			if(SomeoneNearGate[ID] == 1)
			{
				MoveObject(Gate[ID][GateObject],Gate[ID][openX],Gate[ID][openY],Gate[ID][openZ],1);
			}
			SomeoneNearGate[ID] = 0;
		}
	}
	return 1;
}

stock IsPlayerNearGateAndCanHeEnter(playerid, gateid)
{
	new nameofthisplayer[24]; GetPlayerName(playerid,nameofthisplayer,24);
	if(PlayerToPoint(Gate[gateid][Distance],playerid,Gate[gateid][closeX],Gate[gateid][closeY],Gate[gateid][closeZ]) && !strfind(nameofthisplayer,Gate[gateid][NameCanEnter],true))
	{
		return 1;
	}
	return 0;
}

stock PlayerToPoint(Float:radi,playerid,Float:x,Float:y,Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}