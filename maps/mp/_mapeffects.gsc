#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\_functions;
#include common_scripts\utility;


Meteoros()
{

}

Niebla()
{
	level.blizzardpoint = (-1136,-2469,100);
	level._effect[ "FOW" ] = loadfx( "dust/nuke_aftermath_mp" );
	PlayFX(level._effect[ "FOW" ], level.blizzardpoint + ( 0 , 0 , 200 ));
}

LuzdeArbol(pos)
{
	switch(randomInt(2))
	{
		case 0: 
		level.treelight = level.greenlightfx; 
		break;
		case 1: 
		level.treelight = level.redlightfx; 
		break;
	}
	PlayFX(level.treelight,pos);
	wait 1;
}

Relampagos()
{
    	while(1)
	{
	    	playFX(level._effect[ "lightning" ], (-323,-834,2733));
		wait 1;
	}
}