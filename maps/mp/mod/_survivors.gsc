#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include common_scripts\utility;
#using_animtree( "multiplayer" );

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////Humans////////////////////////
////////////////////////////////////////////////////////

main()
{
	level thread onPlayerConnect();
	PrecacheShellShock( "death" );
	PrecacheShellShock( "damage_mp" );
	PrecacheShellShock( "pain" );
	self.speed = 0;
	self.jugger = 0;
	self.beer = 0;
	self.daiquiri = 0;
	self.stamin = 0;
	self thread maps\mp\mod\magicweapons\_raygun::inicio();
	self thread maps\mp\mod\magicweapons\_flamethrower::init();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player.hud_damagefeedback.color = (1,0,0);

		player thread onPlayerSpawned();
		player thread SiempreHumanos();
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "spawned_player" );
		self notify("menuresponse", game["menu_team"], "allies");
		wait 0.05;
		self notify("menuresponse", "changeclass", "class1");
		self thread Superviviente();
		self thread Pantalla();
		self thread Dinerillo();
		self thread onDeath();
		self thread NoIralaMierda();

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
	for(;;)
	{
		self waittill("death");
		self notify("menuresponse", game["menu_team"], "spectator");
        self allowSpectateTeam( "freelook", true );
        self.sessionstate = "spectator";
        self setContents( 0 );
		self.tieneque = 1;
		self thread DestruirTodoelHUD();
	}
}

NoIralaMierda()
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


SiempreHumanos()
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

Dinerillo()
{
	self endon("disconnect");
	self endon("death");
	self.dinero = 10000;
      	self.dineroS = self createFontString( "objective", 2 );
	self.dineroS setPoint( "", "",320,-190);
      	self thread Destruirhud(self.dineroS);
	while(1)
	{
		self.dineroS setText("Cash:" + self.dinero);
		wait 0.15;
	}
}

Pantalla()
{
	self endon("disconnect");
	self endon("death");
	wait 0.1;
      	self.Ronda = self createFontString( "objective", 2 );
	self.Ronda setPoint( "", "",320,-165);
      	self thread Destruirhud(self.Ronda);
      	self thread Destruirhudr(self.Ronda);
	self thread BarradeVida();
	self thread ContadorMunicion();
	while(1)
	{
		self.Ronda setText("Round:" + level.ola);
		wait 0.15;
	}
}


ContadorMunicion()
{	
      	self.Blood = createIcon("cardtitle_bloodsplat", 150, 32);
      	self.Blood setPoint( "", "", 320, -190);   
      	self thread Destruirhud(self.Blood);
      	self thread Destruirhudr(self.Blood);
      	self.ZombiHud = createIcon("cardtitle_zombie_3", 150, 28);
      	self.ZombiHud setPoint( "", "", 320, -160);   
      	self thread Destruirhud(self.ZombiHud);
      	self thread Destruirhudr(self.ZombiHud);
       	self.ammoBoard = self createFontString( "default", 2 );
	self.ammoBoard setPoint( "", "", 310, -115);
      	self thread Destruirhud(self.ammoBoard);
      	self thread Destruirhudr(self.ammoBoard);
      	self.stockBoard = self createFontString( "default", 2 );
	self.stockBoard setPoint( "", "", 349, -115);
      	self thread Destruirhud(self.stockBoard);
      	self thread Destruirhudr(self.stockBoard);
      	self.ammoBoard3 = self createFontString( "default", 2 );
	self.ammoBoard3 setPoint( "", "", 330, -115);
	self.ammoBoard3 setText("/");
      	self thread Destruirhud(self.ammoBoard3);
     	self thread Destruirhudr(self.ammoBoard3);
	while(1)
	{
	      	self.Clip = self getWeaponAmmoClip(self getCurrentWeapon());
            		self.Stock = self getWeaponAmmoStock(self getCurrentWeapon());
	      	self.ammoBoard setValue(self.Clip);
            		self.stockBoard setValue(self.Stock);
		if(self getWeaponAmmoClip(self getCurrentWeapon()) <= 5)
		{
			self.ammoBoard.color = (1,0,0);
		}
		else
		{
			self.ammoBoard.color = (255, 255, 255);
		}
		if(self getWeaponAmmoStock(self getCurrentWeapon()) <= 5)
		{
			self.stockBoard.color = (1,0,0);
		}
		else
		{
			self.stockBoard.color = (255, 255, 255);
		}
            	wait 0.1;
	}
}

BarradeVida()
{
        	self.useBar = createPrimaryProgressBar( -250 );
    	self.useBar.bar.x = 260;
    	self.useBar.x = 320;
    	self.useBar.bar.y = -135;
    	self.useBar.y = -135;
	for(;;)
        	{
                	self.usebar updateBar( self.health/100, 100 );
                	if(self.health < 75 && self.health < 50 != true)
                	{
						self.usebar.color = (0,0,0);
						self.usebar.bar.color = (0.3,0,1);
						self.usebar.alpha = 0.5;
                	}
                	else if(self.health < 50 && self.health > 25)
                	{
						self.usebar.color = (0,0,0);
						self.usebar.bar.color = (0.9,0,1);
						self.usebar.alpha = 1;
                	}
                	else if(self.health < 50)
                	{
						self.usebar.color = (0,0,0);
						self.usebar.bar.color = (1,0,0);
						self.usebar.alpha = 0.5;
                	}
                	else if(self.health > 75)
                	{
						self.usebar.color = (0,0,0);
						self.usebar.bar.color = (0,0,1);
						self.usebar.alpha = 0.5;
                	}
              wait 0.05;
        	}
}

DestruirTodoelHUD()
{
	self.Ronda destroy();
	self.useBar destroy();
	self.useBar.bar destroy();
	self.Blood destroy();
	self.ZombiHud destroy();
	self.ammoBoard destroy();
	self.stockBoard destroy();
	self.ammoBoard3 destroy();
}

Superviviente()
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