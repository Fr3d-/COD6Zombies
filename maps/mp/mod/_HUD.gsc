#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\mod\_functions;

setupHUD(){
	if( !isDefined(self.hud) )
		self.hud = [];

	self thread healthHUD();
	self thread ammoHUD();
	self thread roundHUD();
	self thread moneyHUD();
	self thread scoreHUD();
}

healthHUD(){
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

	self thread destroyOnDeath( self.usebar );
}

ammoHUD()
{	
	self.Blood = createIcon("cardtitle_bloodsplat", 150, 32);
	self.Blood setPoint( "", "", 320, -190);   

	self.ZombiHud = createIcon("cardtitle_zombie_3", 150, 28);
	self.ZombiHud setPoint( "", "", 320, -160);   
	self.ammoBoard = self createFontString( "default", 2 );
	self.ammoBoard setPoint( "", "", 310, -115);

	self.stockBoard = self createFontString( "default", 2 );
	self.stockBoard setPoint( "", "", 349, -115);

	self.ammoBoard3 = self createFontString( "default", 2 );
	self.ammoBoard3 setPoint( "", "", 330, -115);
	self.ammoBoard3 setText("/");

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

	destroyOnDeath( self.Blood );
	destroyOnDeath( self.ZombiHud );
	destroyOnDeath( self.ammoBoard );
	destroyOnDeath( self.stockBoard );
	destroyOnDeath( self.ammoBoard3 );
}

roundHUD(){
	self endon("disconnect");
	self endon("death");

	self.Ronda = self createFontString( "objective", 2 );
	self.Ronda setPoint( "", "",320,-165);

	while(1)
	{
		self.Ronda setText("Round:" + level.ola);
		wait 0.15;
	}

	destroyOnDeath(self.Ronda);
}

moneyHUD(){
	self endon("disconnect");
	self endon("death");

	self.dinero = level.config["PLAYER_START_MONEY"];
  	self.dineroS = self createFontString( "objective", 2 );
	self.dineroS setPoint( "", "",320,-190);

	while(1)
	{
		self.dineroS setText("Cash:" + self.dinero);
		wait 0.15;
	}

	destroyOnDeath(self.dineroS);
}

scoreHUD(){
	self endon("disconnect");

	if( isDefined(self.hud.score) )
		return;

	self notifyOnPlayerCommand("showHost", "+scores");
	self notifyOnPlayerCommand("hideHost", "-scores");

	for(;;)
	{
		self waittill("showHost");
		self.hud.score = self createFontString("hudmedium", 1.4);
		self.hud.score setPoint("BOTTOMLEFT", "BOTTOMLEFT", 85, -25);
		self.hud.score setText( level.hostname );
		self waittill("hideHost");
		self.hud.score destroy();
	}
}

destroyOnDeath(elem){
	self waittill("death");
	elem destroy();
}