#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\mod\_functions;

setupHUD(){
	self endon("disconnect");
	self endon("death");

	self thread waveHUD();
	self thread ammoHUD();
	self thread moneyHUD();

	if( !isDefined(self.hud) )
		self thread scoreHUD();

	self thread clockHUD();

	if( !isDefined(self.hud) )
		self.hud = true;
}

waveHUD(){
	self endon("disconnect");
	self endon("death");

	xPos = -40;
	yPos = 0;

	margin = 5;

	self.HUDcurrZombies = maps\mp\mod\_functions::Zombiesconvida();
	self.HUDoldZombies = self.currZombies;

	self.waveHUD = newClientHudElem( self );
	self.waveHUD.alignX = "noscale";
	self.waveHUD.alignY = "noscale";
	self.waveHUD.horzAlign = "left";
	self.waveHUD.vertAlign = "bottom";
	self.waveHUD.x = xPos + 16 + margin;
	self.waveHUD.y = yPos;
	self.waveHUD.foreground = true;
	self.waveHUD.fontScale = 1.5;
	self.waveHUD.font = "objective";
	self.waveHUD.alpha = 1;
	self.waveHUD.glow = 1;
	self.waveHUD.glowColor = ( 0, 1, 0 );
	self.waveHUD.glowAlpha = 0;
	
	if( self.HUDcurrZombies == 0 )
		self.waveHUD.color = ( 1, 0, 0 );
	else
		self.waveHUD.color = ( 1, ( self.HUDcurrZombies / level.ztotal), 0 );

	self.waveHUD.hideWhenInMenu = true;
	self.waveHUD setValue( self.HUDcurrZombies );

	self.waveShader = newClientHudElem( self );
	self.waveShader.alignX = "noscale";
	self.waveShader.alignY = "noscale";
	self.waveShader.horzAlign = "left";
	self.waveShader.vertAlign = "bottom";
	self.waveShader.x = xPos;
	self.waveShader.y = yPos + 1;
	self.waveShader.foreground = true;
	self.waveShader.alpha = 1;
	self.waveShader.hideWhenInMenu = true;
	self.waveShader setShader( "cardicon_biohazard", 16, 16 );
	self.waveShader.shader = "cardicon_biohazard";

	if( self.HUDcurrZombies == 0 )
		self.waveShader.color = ( 1, 0, 0 );
	else
		self.waveShader.color = ( 1, ( self.HUDcurrZombies / level.ztotal), 0 );

	margin = 5;

	self.waveBGShader = newClientHudElem( self );
	self.waveBGShader.alignX = "noscale";
	self.waveBGShader.alignY = "noscale";
	self.waveBGShader.horzAlign = "left";
	self.waveBGShader.vertAlign = "bottom";
	self.waveBGShader.x = xPos - margin;
	self.waveBGShader.y = yPos + 1 - margin;
	self.waveBGShader.foreground = false;
	self.waveBGShader.alpha = .6;
	self.waveBGShader.hideWhenInMenu = true;
	self.waveBGShader setShader( "black", 62, margin + 16 + margin );
	self.waveBGShader.shader = "black";

	self thread destroyOnDeath( self.waveShader );
	self thread destroyOnDeath( self.waveHUD );
	self thread destroyOnDeath( self.waveBGShader );

	self thread waveHUDThink();
}

waveHUDThink(){
	self endon("disconnect");
	self endon("death");

	for( ;; ){
		self.HUDcurrZombies = maps\mp\mod\_functions::Zombiesconvida();

		if( self.HUDcurrZombies != self.HUDoldZombies ){

			self.waveHUD setValue( self.HUDcurrZombies );
			self.waveHUD.color = ( 1, ( (self.HUDcurrZombies / level.ztotal)), 0 );
			self.waveShader.color = ( 1, ( (self.HUDcurrZombies / level.ztotal)), 0 );

			self.HUDoldZombies = self.HUDcurrZombies;
		}
		
		wait .1;
	}
}

ammoHUD(){
	self endon("disconnect");
	self endon("death");

	xPos = -60;
	yPos = 0;

	margin = 5;

	self.ammoClipHUD = newClientHudElem( self );
	self.ammoClipHUD.alignX = "noscale";
	self.ammoClipHUD.alignY = "noscale";
	self.ammoClipHUD.horzAlign = "right";
	self.ammoClipHUD.vertAlign = "bottom";
	self.ammoClipHUD.x = xPos + 16 + margin;
	self.ammoClipHUD.y = yPos;
	self.ammoClipHUD.foreground = true;
	self.ammoClipHUD.fontScale = 1.5;
	self.ammoClipHUD.font = "objective";
	self.ammoClipHUD.alpha = 1;
	self.ammoClipHUD.glow = 1;
	self.ammoClipHUD.glowColor = ( 0, 1, 0 );
	self.ammoClipHUD.glowAlpha = 0;
	self.ammoClipHUD.color = ( 1.0, 1.0, 0 );
	self.ammoClipHUD.hideWhenInMenu = true;
	self.ammoClipHUD setValue( 0 );

	self.ammoStockHUD = newClientHudElem( self );
	self.ammoStockHUD.alignX = "noscale";
	self.ammoStockHUD.alignY = "noscale";
	self.ammoStockHUD.horzAlign = "right";
	self.ammoStockHUD.vertAlign = "bottom";
	self.ammoStockHUD.x = xPos + 16 + margin + 35 + margin * 2;
	self.ammoStockHUD.y = yPos;
	self.ammoStockHUD.foreground = true;
	self.ammoStockHUD.fontScale = 1.5;
	self.ammoStockHUD.font = "objective";
	self.ammoStockHUD.alpha = 1;
	self.ammoStockHUD.glow = 1;
	self.ammoStockHUD.glowColor = ( 0, 1, 0 );
	self.ammoStockHUD.glowAlpha = 0;
	self.ammoStockHUD.color = ( 1.0, 1.0, 0 );
	self.ammoStockHUD.hideWhenInMenu = true;
	self.ammoStockHUD setValue( 0 );

	self.ammoHUDSeperator = newClientHudElem( self );
	self.ammoHUDSeperator.alignX = "noscale";
	self.ammoHUDSeperator.alignY = "noscale";
	self.ammoHUDSeperator.horzAlign = "right";
	self.ammoHUDSeperator.vertAlign = "bottom";
	self.ammoHUDSeperator.x = xPos + 16 + margin + 35;
	self.ammoHUDSeperator.y = yPos;
	self.ammoHUDSeperator.foreground = true;
	self.ammoHUDSeperator.fontScale = 1.5;
	self.ammoHUDSeperator.font = "objective";
	self.ammoHUDSeperator.alpha = 1;
	self.ammoHUDSeperator.glow = 1;
	self.ammoHUDSeperator.glowColor = ( 0, 1, 0 );
	self.ammoHUDSeperator.glowAlpha = 0;
	self.ammoHUDSeperator.color = ( 1.0, 1.0, 0 );
	self.ammoHUDSeperator.hideWhenInMenu = true;
	self.ammoHUDSeperator setText("|");

	self.ammoShader = newClientHudElem( self );
	self.ammoShader.alignX = "noscale";
	self.ammoShader.alignY = "noscale";
	self.ammoShader.horzAlign = "right";
	self.ammoShader.vertAlign = "bottom";
	self.ammoShader.x = xPos;
	self.ammoShader.y = yPos + 1;
	self.ammoShader.foreground = true;
	self.ammoShader.alpha = 1;
	self.ammoShader.hideWhenInMenu = true;
	self.ammoShader setShader( "cardicon_bullets_50cal", 16, 16 );
	self.ammoShader.shader = "cardicon_bullets_50cal";
	self.ammoShader.color = ( 1, 1, 0 );

	self.ammoBGShader = newClientHudElem( self );
	self.ammoBGShader.alignX = "noscale";
	self.ammoBGShader.alignY = "noscale";
	self.ammoBGShader.horzAlign = "right";
	self.ammoBGShader.vertAlign = "bottom";
	self.ammoBGShader.x = xPos - margin;
	self.ammoBGShader.y = yPos + 1 - margin;
	self.ammoBGShader.foreground = false;
	self.ammoBGShader.alpha = .6;
	self.ammoBGShader.hideWhenInMenu = true;
	self.ammoBGShader setShader( "black", 114, margin + 16 + margin );
	self.ammoBGShader.shader = "black";

	self thread destroyOnDeath( self.ammoClipHUD );
	self thread destroyOnDeath( self.ammoStockHUD );
	self thread destroyOnDeath( self.ammoHUDSeperator );
	self thread destroyOnDeath( self.ammoShader );
	self thread destroyOnDeath( self.ammoBGShader );

	self.currWep = self getCurrentWeapon();
	self.ammoClip = self getWeaponAmmoClip( self.currWep );
	self.ammoStock = self getWeaponAmmoStock( self.currWep );

	if( self.currWep != "none" ){
		self.ammoClipHUD setValue( self.ammoClip );
		self.ammoStockHUD setValue( self.ammoStock );

		self.ammoClipHUD.x = xPos + 16 + margin;
		self.ammoClipHUD.y = yPos;

		if( self.ammoClip < 100 && self.ammoClip > 9 ){
			self.ammoClipHUD.x += 10;
		} else if( self.ammoClip < 10 && self.ammoClip >= 0 ) {
			self.ammoClipHUD.x += 20;
		}
	}

	self thread ammoHUDThink( xPos, yPos, margin );
}

ammoHUDThink( xPos, yPos, margin ){
	self endon("disconnect");
	self endon("death");

	for( ;; ){
		if( self.ammoClip != self getWeaponAmmoClip( self.currWep ) || self.ammoStock != self getWeaponAmmoStock( self.currWep ) || self.currWep != self getCurrentWeapon() ){
			self.currWep = self getCurrentWeapon();
			self.ammoClip = self getWeaponAmmoClip( self.currWep );
			self.ammoStock = self getWeaponAmmoStock( self.currWep );

			if( self.currWep == "none" )
				continue;

			self.ammoClipHUD setValue( self.ammoClip );
			self.ammoStockHUD setValue( self.ammoStock );

			self.ammoClipHUD.x = xPos + 16 + margin;
			self.ammoClipHUD.y = yPos;

			if( self.ammoClip < 100 && self.ammoClip > 9 ){
				self.ammoClipHUD.x += 10;
			} else if( self.ammoClip < 10 && self.ammoClip >= 0 ) {
				self.ammoClipHUD.x += 20;
			}
		}

		wait .001;
	}
}

moneyHUD(){
	self endon("disconnect");
	self endon("death");

	self.oldMoney = self.money;

	xPos = -55;
	yPos = -30;

	margin = 5;

	self.moneyHUD = newClientHudElem( self );
	self.moneyHUD.alignX = "noscale";
	self.moneyHUD.alignY = "noscale";
	self.moneyHUD.horzAlign = "right";
	self.moneyHUD.vertAlign = "bottom";
	self.moneyHUD.x = xPos + 16 + margin;
	self.moneyHUD.y = yPos;
	self.moneyHUD.foreground = true;
	self.moneyHUD.fontScale = 1.5;
	self.moneyHUD.font = "objective";
	self.moneyHUD.alpha = 1;
	self.moneyHUD.glow = 1;
	self.moneyHUD.glowColor = ( 0, 1, 0 );
	self.moneyHUD.glowAlpha = 0;
	self.moneyHUD.color = ( 1.0, 1.0, 0 );
	self.moneyHUD.hideWhenInMenu = true;
	self.moneyHUD setText( "$  " + self.money );

	self thread destroyOnDeath( self.moneyHUD );

	self thread moneyHUDThink();
}

moneyHUDThink(){
	self endon("disconnect");
	self endon("death");

	for( ;; ){
		if( self.oldMoney != self.money ){
			self.moneyHUD setText( "$  " + self.money );

			self.oldMoney = self.money;
		}

		wait .05;
	}
}

scoreHUD(){
	self endon("disconnect");

	if( isDefined(self.HUDscore) )
		return;

	self notifyOnPlayerCommand("showHost", "+scores");
	self notifyOnPlayerCommand("hideHost", "-scores");

	for(;;)
	{
		self waittill("showHost");
		self.HUDscore = self createFontString("hudmedium", 1.4);
		self.HUDscore setPoint("BOTTOMLEFT", "BOTTOMLEFT", 85, -25);
		self.HUDscore setText( level.hostname );
		self waittill("hideHost");
		self.HUDscore destroy();
	}
}

clockHUD(){
	self endon("disconnect");
	self endon("death");

	xPos = -50;
	yPos = 0;

	margin = 5;

	self.clockMHUD = newClientHudElem( self );
	self.clockMHUD.alignX = "noscale";
	self.clockMHUD.alignY = "noscale";
	self.clockMHUD.horzAlign = "center";
	self.clockMHUD.vertAlign = "bottom";
	self.clockMHUD.x = xPos + 16 + margin;
	self.clockMHUD.y = yPos;
	self.clockMHUD.foreground = true;
	self.clockMHUD.fontScale = 1.5;
	self.clockMHUD.font = "objective";
	self.clockMHUD.alpha = 1;
	self.clockMHUD.glow = 1;
	self.clockMHUD.glowColor = ( 0, 1, 0 );
	self.clockMHUD.glowAlpha = 0;
	self.clockMHUD.color = ( 1.0, 1.0, 0 );
	self.clockMHUD.hideWhenInMenu = true;
	self.clockMHUD setValue( 0 );

	self.clockHUDSeperator = newClientHudElem( self );
	self.clockHUDSeperator.alignYnX = "noscale";
	self.clockHUDSeperator.alignY = "noscale";
	self.clockHUDSeperator.horzAlign = "center";
	self.clockHUDSeperator.vertAlign = "bottom";
	self.clockHUDSeperator.x = xPos + 16 + margin + 10;
	self.clockHUDSeperator.y = yPos;
	self.clockHUDSeperator.foreground = true;
	self.clockHUDSeperator.fontScale = 1.5;
	self.clockHUDSeperator.font = "objective";
	self.clockHUDSeperator.alpha = 1;
	self.clockHUDSeperator.glow = 1;
	self.clockHUDSeperator.glowColor = ( 0, 1, 0 );
	self.clockHUDSeperator.glowAlpha = 0;
	self.clockHUDSeperator.color = ( 1.0, 1.0, 0 );
	self.clockHUDSeperator.hideWhenInMenu = true;
	self.clockHUDSeperator setText(":");

	self.clockSHUD = newClientHudElem( self );
	self.clockSHUD.alignYnX = "noscale";
	self.clockSHUD.alignY = "noscale";
	self.clockSHUD.horzAlign = "center";
	self.clockSHUD.vertAlign = "bottom";
	self.clockSHUD.x = xPos + 16 + margin + 10 + 5;
	self.clockSHUD.y = yPos;
	self.clockSHUD.foreground = true;
	self.clockSHUD.fontScale = 1.5;
	self.clockSHUD.font = "objective";
	self.clockSHUD.alpha = 1;
	self.clockSHUD.glow = 1;
	self.clockSHUD.glowColor = ( 0, 1, 0 );
	self.clockSHUD.glowAlpha = 0;
	self.clockSHUD.color = ( 1.0, 1.0, 0 );
	self.clockSHUD.hideWhenInMenu = true;
	self.clockSHUD setText( 0 );

	self.clockSSHUD = newClientHudElem( self );
	self.clockSSHUD.alignYnX = "noscale";
	self.clockSSHUD.alignY = "noscale";
	self.clockSSHUD.horzAlign = "center";
	self.clockSSHUD.vertAlign = "bottom";
	self.clockSSHUD.x = xPos + 16 + margin + 10 + 5 + 10;
	self.clockSSHUD.y = yPos;
	self.clockSSHUD.foreground = true;
	self.clockSSHUD.fontScale = 1.5;
	self.clockSSHUD.font = "objective";
	self.clockSSHUD.alpha = 1;
	self.clockSSHUD.glow = 1;
	self.clockSSHUD.glowColor = ( 0, 1, 0 );
	self.clockSSHUD.glowAlpha = 0;
	self.clockSSHUD.color = ( 1.0, 1.0, 0 );
	self.clockSSHUD.hideWhenInMenu = true;
	self.clockSSHUD setText( 0 );

	self.clockShader = newClientHudElem( self );
	self.clockShader.alignX = "noscale";
	self.clockShader.alignY = "noscale";
	self.clockShader.horzAlign = "center";
	self.clockShader.vertAlign = "bottom";
	self.clockShader.x = xPos;
	self.clockShader.y = yPos + 1;
	self.clockShader.foreground = true;
	self.clockShader.alpha = 1;
	self.clockShader.hideWhenInMenu = true;
	self.clockShader setShader( "cardicon_compass", 16, 16 );
	self.clockShader.shader = "cardicon_compass";
	self.clockShader.color = ( 1, 1, 0 );

	self.clockBGShader = newClientHudElem( self );
	self.clockBGShader.alignX = "noscale";
	self.clockBGShader.alignY = "noscale";
	self.clockBGShader.horzAlign = "center";
	self.clockBGShader.vertAlign = "bottom";
	self.clockBGShader.x = xPos - margin;
	self.clockBGShader.y = yPos + 1 - margin;
	self.clockBGShader.foreground = false;
	self.clockBGShader.alpha = .6;
	self.clockBGShader.hideWhenInMenu = true;
	self.clockBGShader setShader( "black", 63 + margin, margin + 16 + margin );
	self.clockBGShader.shader = "black";

	self thread destroyOnDeath( self.clockMHUD );
	self thread destroyOnDeath( self.clockHUDSeperator );
	self thread destroyOnDeath( self.clockSHUD );
	self thread destroyOnDeath( self.clockSSHUD );
	self thread destroyOnDeath( self.clockShader );
	self thread destroyOnDeath( self.clockBGShader );

	self thread clockHUDThink( xPos, yPos, margin );
}

clockHUDThink( xPos, yPos, margin ){
	self endon("disconnect");
	self endon("death");

	for( ;; ){
		seconds = getTimePassed() / 1000;
		secondsToMinutes = seconds / 60;
		minutesInt = int( secondsToMinutes );

		minutesToSeconds = minutesInt * 60;

		restSeconds = int( seconds - minutesToSeconds );

		seconds = int( restSeconds / 10 );
		sSeconds = restSeconds % 10;

		self.clockHUDSeperator.x = xPos + 16 + margin + 10;
		self.clockSHUD.x = xPos + 16 + margin + 10 + 5;
		self.clockSSHUD.x = xPos + 16 + margin + 10 + 5 + 10;

		if( minutesInt == 1 ){
			self.clockHUDSeperator.x = self.clockHUDSeperator.x - 3;
			self.clockSHUD.x = self.clockSHUD.x - 3;
			self.clockSSHUD.x = self.clockSSHUD.x - 3;
		}

		if( seconds == 1 ){
			self.clockSSHUD.x = self.clockSSHUD.x - 3;
		}

		if( restSeconds < 0 ){
			self.clockMHUD setValue( 0 );
			self.clockSHUD setValue( 0 );
			self.clockSSHUD setValue( 0 );
		} else {
			self.clockMHUD setValue( minutesInt );
			self.clockSHUD setValue( seconds );
			self.clockSSHUD setValue( sSeconds );
		}

		wait .1;
	}
}

speedColaHUD(){
	self endon("disconnect");
	self endon("death");

	xPos = level.config["HUD_PERK_X"];
	yPos = level.config["HUD_PERK_Y"];

	self.HUDspeedCola = newClientHudElem( self );
	self.HUDspeedCola.alignX = "noscale";
	self.HUDspeedCola.alignY = "noscale";
	self.HUDspeedCola.horzAlign = "right";
	self.HUDspeedCola.vertAlign = "middle";
	self.HUDspeedCola.x = xPos;
	self.HUDspeedCola.y = yPos;
	self.HUDspeedCola.foreground = true;
	self.HUDspeedCola.alpha = 1;
	self.HUDspeedCola.hideWhenInMenu = true;
	self.HUDspeedCola setShader( level.config["SPEED_ICON"], 32, 32 );
	self.HUDspeedCola.shader = level.config["SPEED_ICON"];
	self.HUDspeedCola.color = ( 1, 1, 1 );

	self thread destroyOnDeath(self.HUDspeedCola);
}

staminUpHUD(){
	self endon("disconnect");
	self endon("death");

	xPos = level.config["HUD_PERK_X"];
	yPos = level.config["HUD_PERK_Y"];

	perkNum = 1;

	self.HUDstaminUp = newClientHudElem( self );
	self.HUDstaminUp.alignX = "noscale";
	self.HUDstaminUp.alignY = "noscale";
	self.HUDstaminUp.horzAlign = "right";
	self.HUDstaminUp.vertAlign = "middle";
	self.HUDstaminUp.x = xPos;
	self.HUDstaminUp.y = yPos + ( ( 32 * perkNum ) + ( level.config["HUD_PERK_MARGIN"] * perkNum ) + level.config["HUD_PERK_MARGIN"]);
	self.HUDstaminUp.foreground = true;
	self.HUDstaminUp.alpha = 1;
	self.HUDstaminUp.hideWhenInMenu = true;
	self.HUDstaminUp setShader( level.config["STAMIN_ICON"], 32, 32 );
	self.HUDstaminUp.shader = level.config["STAMIN_ICON"];
	self.HUDstaminUp.color = ( 1, 1, 1 );

	self thread destroyOnDeath(self.HUDstaminUp);
}

destroyOnDeath(elem){
	self waittill("death");
	elem destroy();
}