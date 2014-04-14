#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include common_scripts\utility;
#using_animtree( "multiplayer" );

main()
{
	level thread onPlayerConnect();
	PrecacheShellShock( "death" );
	PrecacheShellShock( "damage_mp" );
	PrecacheShellShock( "pain" );

	self thread maps\mp\mod\magicweapons\_raygun::inicio();
	self thread maps\mp\mod\magicweapons\_flamethrower::init();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player.hud_damagefeedback.color = (1,0,0);

		player notify("menuresponse", game["menu_team"], "allies");
		if(level.gameState == "intermission" || level.gameState == "starting")
		{
			player notify("menuresponse", game["menu_team"], "allies");
		}

		player thread onPlayerSpawned();
		player thread onDeath();
		player thread playerConfig();
		player thread alwaysSurvivor();
	}
}

playerConfig(){
	for(i = 0; i < level.numDvar; i++){
		self setClientDvar(level.dvars[i], level.dvarValues[i]);
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );
	self.money = level.config["PLAYER_START_MONEY"];

	for(;;)
	{
		self waittill( "spawned_player" );

		self notify("menuresponse", game["menu_team"], "allies");
		wait 0.05;
		self notify("menuresponse", "changeclass", "class1");

		self setSpawnPoint();

		self thread survivor();
		self thread mapBounds();

		self.isAlive = true;

		self.speed = 0;
		self.jugger = 0;
		self.beer = 0;
		self.daiquiri = 0;
		self.stamin = 0;

		self thread maps\mp\mod\_HUD::setupHUD();
		
		self thread maps\mp\mod\_functions::UFO();
		self thread maps\mp\mod\_functions::testBind();

		if(self isHost() && getDvar("mapname") == "mp_brecourt")
		{
			level thread maps\mp\mod\_maptools::Niebla();
		}
	}
}

onDeath()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("death");
		self.isAlive = false;
		self notify("menuresponse", game["menu_team"], "spectator");
        self allowSpectateTeam( "freelook", true );
        self.sessionstate = "spectator";
        self setContents( 0 );
		self.tieneque = 1;
	}
}

setSpawnPoint(){
	self setOrigin(level.reaparicion+(randomInt(50),randomInt(50),0));
	self.health = 100;
	self.maxhealth = 100;
}

mapBounds()
{
	while(1)
	{
		if(getDvar("mapname") == "mp_derail" && self.origin[2] >= 290)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_estate" && self.origin[2] >= 100)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_highrise" && self.origin[2] <= 3198)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_invasion" && self.origin[2] <= 460)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_rundown" && self.origin[2] <= 13)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_overgrown" && self.origin[2] <= -1500)
		{
			self suicide();
		}
		if(getDvar("mapname") == "mp_rust" && self.origin[2] <= -800)
		{
			self suicide();
		}
	wait 0.05;
	}
}


alwaysSurvivor()
{
	while(1)
	{
		if(self.team == "axis")
		{
			self notify("menuresponse", game["menu_team"], "allies");
			wait 0.05;
			self notify("menuresponse", "changeclass", "class1");
			return;
		}
		if(self.team != "spectator" && self.tieneque == 1)
		{
			self notify("menuresponse", game["menu_team"], "spectator");
		}
	wait 0.05;
	}
}

survivor()
{
	self TakeAllWeapons();
	self _ClearPerks();
	self giveWeapon("beretta_mp",0,false);
	self giveWeapon("onemanarmy_mp",0,false);
	self maps\mp\perks\_perks::givePerk( "frag_grenade_mp" );
	wait 0.05;
	self switchToWeapon("beretta_mp",0,false);
	self giveMaxAmmo("beretta_mp",0,false);
	SetPlayerIgnoreRadiusDamage( true );
	self thread nightvision();
	self VisionSetNakedForPlayer( level.vision, 0 );
}

FuegoRapido()
{
	self setClientDvar("perk_weapReloadMultiplier" , "0.0001"); 
	self maps\mp\perks\_perks::givePerk("specialty_fastreload");
	self thread FuegoR();
}

FuegoR()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	while(1) 
	{
		self setWeaponAmmoStock(self getCurrentWeapon(), 99);
		wait 0.05; 
	}
}

nightvision() 
{
	self endon("disconnect");
	self endon("death");
    self notifyOnPlayerCommand("nightvision", "+actionslot 1");

    for(;;)
    {
		self waittill("nightvision");
		self playSoundToPlayer( "item_nightvision_on", self );
		self VisionSetNakedForPlayer( "default_night_mp", 0.5 );

		self waittill("nightvision");
		self playSoundToPlayer( "item_nightvision_off", self );
		if( isDefined(level.vision) )
      		self VisionSetNakedForPlayer( level.vision, 0.5 );
      	else
      		self VisionSetNakedForPlayer( getDvar( "mapname" ), 0.5 );
     }
}