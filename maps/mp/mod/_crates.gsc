#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\mod\_functions;

notEnoughMoney(){
	self iPrintLn("Not enough cash");
}

cooldown(){
	self.onCooldown = true;
	wait level.config["CRATE_COOLDOWN_TIME"];
	self.onCooldown = false;
}

AmmoMatic(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );

	invisblock = spawn("script_model", pos+(0,0,60));
	invisblock Solid();
	invisblock.angles = angle;
	invisblock CloneBrushmodelToScriptmodel( level.airDropCrateCollision );

	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( level.config["AMMO_ICON"], 10, 10);
	block.headIcon setWaypoint( true, true, false );

	trigger = spawn("trigger_radius", pos, 0, level.config["CRATE_DISTANCE"] + 100, level.config["CRATE_DISTANCE"] + 100);
	trigger.angles = angle;
	trigger thread ammoThink(pos);
	wait 0.01;
}

ammoThink(pos) 
{ 
	self endon("disconnect"); 

	while(1) 
	{ 
		self waittill("trigger", ply);

		if( Distance(pos, ply.origin) <= level.config["CRATE_DISTANCE"] && !ply.onCooldown )
		{
	  		ply setLowerMessage("activate", "^7[^1" + level.config["AMMO_NAME"] + "^7][^3" + level.config["AMMO_PRICE"] + "^7]\n" + "Hold ^3[{+activate}]^7 for an ammo refill");

	  		if( ply useButtonPressed() ){
	  			if( ply.money >= level.config["AMMO_PRICE"] ){

					ply ClearLowerMessage("activate", 1);
					ply.money -= level.config["AMMO_PRICE"];
					ply maps\mp\killstreaks\_airdrop::refillAmmo();  
					ply playLocalSound( "ammo_crate_use" );
					ply thread Millonario();
				} else {
					ply notEnoughMoney();
				}

				ply thread cooldown();
	  		}
		} else {
			ply ClearLowerMessage("activate", 1);
		}

		wait .1;
	}
}

randomCrateAllowCrateUsage(){
	wait level.config["CRATE_COOLDOWN_TIME"];
	level.randomCrateInUse = false;
}

randomCrateAutoRemove(){
	level endon("boxend");

	wait level.config["RAND_RMVTIME"];

	level.wep delete();

	self ClearLowerMessage("trade", 1);

	self thread randomCrateAllowCrateUsage();

	level notify("boxend");
}

randomCrateGiveWeapon(pos)
{
	level endon("boxend");

	wait level.config["RAND_WAITTIME"];

	level notify("endrandom");

	boxWeapon = level.weapons[RandomInt( level.weapons.size )];
	level.wep setModel(GetWeaponModel(boxWeapon));
	wait 0.1;

	self thread randomCrateAutoRemove();

	while(1) 
	{
		if( Distance(pos, self.origin) <= level.config["CRATE_DISTANCE"] )
		{
	  		self setLowerMessage("trade", "Hold ^3[{+activate}]^7 to trade weapons");

	  		if( self useButtonPressed() ){
				self ClearLowerMessage("trade", 1);
				self notify("newWeapon");

				self takeWeapon(self getCurrentWeapon());
				wait 0.1;

				self _giveWeapon(boxWeapon);
				self switchToWeapon(boxWeapon);
				self giveMaxAmmo(boxWeapon);

				self playLocalSound( "ammo_crate_use" );

				level.wep delete();

				self thread randomCrateAllowCrateUsage();

				level notify("boxend");
	  		}

		} else {
			self ClearLowerMessage("trade", 1);
		}

		wait .05;
   	}
}

randomCrateGunEffect(){
	level endon("endrandom");

	while(1)
	{
		boxWeapon = level.weapons[ RandomInt(level.weapons.size) ];
		level.wep setModel( GetWeaponModel(boxWeapon) );
		wait 0.13;
	}
}

randomCrate(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );

	invisblock = spawn("script_model", pos+(0,0,60));
	invisblock Solid();
	invisblock.angles = angle;
	invisblock CloneBrushmodelToScriptmodel( level.airDropCrateCollision );

	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( level.config["RAND_ICON"], 10, 10);
	block.headIcon setWaypoint( true, true, false );

	trigger = spawn("trigger_radius", pos, 0, level.config["CRATE_DISTANCE"] + 10, level.config["CRATE_DISTANCE"] + 10);
	trigger.angles = angle;
	trigger thread randomCrateThink(pos, angle);
	wait 0.01;
}

randomCrateThink(pos, angle) 
{ 
	self endon("disconnect");

	while(1) 
	{ 
		self waittill("trigger", ply);

		if( Distance(pos, ply.origin) <= level.config["CRATE_DISTANCE"] && !ply.onCooldown && !level.randomCrateInUse )
		{
	  		ply setLowerMessage("activate", "^7[^1" + level.config["RAND_NAME"] + "^7][^3" + level.config["RAND_PRICE"] + "^7]\n" + "Hold ^3[{+activate}]^7 for a random weapon");

	  		if( ply useButtonPressed() ){
	  			if( ply.money >= level.config["RAND_PRICE"] ){

					ply ClearLowerMessage("activate", 1);
					ply.money -= level.config["RAND_PRICE"];
					ply thread Millonario();
					ply playLocalSound("ui_mp_timer_countdown");
					ply thread randomCrateGiveWeapon(pos);

					level.randomCrateInUse = true;

					level.wep = spawn("script_model", pos + (0, 5, 0) );
					level.wep.angles = angle;
					level.wep MoveTo(level.wep.origin + (0, 0, 50), level.config["RAND_WAITTIME"] / 2);

					self thread randomCrateGunEffect( ply );

					wait .1;
					ply playLocalSound("mp_defeat");
				} else {
					ply notEnoughMoney();
				}

				ply thread cooldown();
	  		}
		} else {
			ply ClearLowerMessage("activate", 1);
		}

		wait .1;
	}
}  