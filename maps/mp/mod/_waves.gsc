#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;
#include common_scripts\utility;

main(){
	wait 3;

	level thread NukeQuake();
	iPrintlnBold("^1Zombies Incoming");
	level notify("nuevaola");

	level.wave = 1;
	level thread setupWave();
	level thread watchWaves();
}

setupWave()
{
	level.ztotal = level.wave * 10;
	level.zkilled = 0;
	level.zombiesLeft = 0;

	level.zombieHealth = level.wave * 75;

	if( level.ztotal > level.config["WAVE_MAX_ZOMBIES"] ){
		zombiesToSpawn = level.config["WAVE_MAX_ZOMBIES"];
		level.zombiesLeft = level.ztotal - zombiesToSpawn;
	}
	else
		zombiesToSpawn = level.ztotal;

	level.currZombieID = zombiesToSpawn;
	level maps\mp\mod\_zombies::createZombies( 0, zombiesToSpawn, level.zombieHealth );
}

addZombieToWave(){
	if( level.zombiesLeft > 0 ){
		level maps\mp\mod\_zombies::createZombies( level.currZombieID, level.currZombieID + 1, level.zombieHealth );
		level.currZombieID++;

		level.zombiesLeft--;
	}
}

watchWaves()
{
	while(1)
	{
		if(maps\mp\mod\_functions::Zombiesconvida() <= 0)
		{
			wonWave();
		}

		wait 0.08;
	}
}

wonWave(){
	level.wave++;

	foreach(ply in level.players)
	{
		ply thread maps\mp\gametypes\_hud_message::hintMessage("^4Humans Have survived the Wave");
		ply maps\mp\perks\_perks::givePerk( "frag_grenade_mp" );

		if(ply.tieneque == 1)
		{
			ply notify("menuresponse", game["menu_team"], "allies");
			ply allowSpectateTeam( "freelook", false );
			ply.tieneque = 0;
		}
		wait 0.05;
	}

	wait level.config["WAVE_DELAY"];

	foreach( ply in level.players ){
		ply thread maps\mp\gametypes\_hud_message::hintMessage("^1Wave " + level.wave );
		wait .05;
	}

	level thread setupWave();
}