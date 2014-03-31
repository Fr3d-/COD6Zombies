#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\mod\_functions;

setupHUD(){
	if( !isDefined(self.hud) )
		self.hud = [];

	self thread waveHUD();
	self thread ammoHUD();
	self thread moneyHUD();
	self thread scoreHUD();
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
		self.waveHUD.color = ( 1, ( self.HUDcurrZombies / level.ztotal[level.ola]), 0 );

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
		self.waveShader.color = ( 1, ( self.HUDcurrZombies / level.ztotal[level.ola]), 0 );

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
	self endon("death");

	for( ;; ){
		self.HUDcurrZombies = maps\mp\mod\_functions::Zombiesconvida();

		if( self.HUDcurrZombies != self.HUDoldZombies ){

			self.waveHUD setValue( self.HUDcurrZombies );
			self.waveHUD.color = ( 1, ( (self.HUDcurrZombies / level.ztotal[level.ola])), 0 );
			self.waveShader.color = ( 1, ( (self.HUDcurrZombies / level.ztotal[level.ola])), 0 );

			self.HUDoldZombies = self.HUDcurrZombies;
		}
		
		wait .1;
	}
}

ammoHUD(){
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
	self.money = level.config["PLAYER_START_MONEY"];
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