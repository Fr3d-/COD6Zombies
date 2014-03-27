#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_functions;

CONST_CRATE_DISTANCE = 100;
CONST_CRATE_COOLDOWN_TIME = 1;

CONST_AMMO_NAME		= "AmmoMatic";
CONST_AMMO_PRICE	= 700;
CONST_AMMO_ICON		= "waypoint_ammo_friendly";

CONST_RAND_NAME		= "    ?    ";
CONST_RAND_PRICE	= 1000;
CONST_RAND_ICON		= "hudicon_neutral";
CONST_RAND_WAITTIME	= 12;
CONST_RAND_RMVTIME	= 5;


init(){
	level.weapons = [];
	level.weapons[0] = "beretta_mp";
	level.weapons[1] = "usp_mp";
	level.weapons[2] = "deserteagle_mp";
	level.weapons[3] = "deserteaglegold_mp";
	level.weapons[4] = "coltanaconda_mp";
	level.weapons[5] = "riotshield_mp";
	level.weapons[6] = "glock_mp";
	level.weapons[7] = "beretta393_mp";
	level.weapons[8] = "mp5k_mp";
	level.weapons[9] = "pp2000_mp";
	level.weapons[10] = "uzi_mp";
	level.weapons[11] = "p90_mp";
	level.weapons[12] = "kriss_mp";
	level.weapons[13] = "ump45_mp";
	level.weapons[14] = "tmp_mp";
	level.weapons[15] = "ak47_mp";
	level.weapons[16] = "m16_mp";
	level.weapons[17] = "m4_mp";
	level.weapons[18] = "fn2000_mp";
	level.weapons[19] = "masada_mp";
	level.weapons[20] = "famas_mp";
	level.weapons[21] = "fal_mp";
	level.weapons[22] = "scar_mp";
	level.weapons[23] = "tavor_mp";
	level.weapons[24] = "m79_mp";
	level.weapons[25] = "rpg_mp";
	level.weapons[26] = "at4_mp";
	level.weapons[27] = "stinger_mp";
	level.weapons[28] = "javelin_mp";
	level.weapons[29] = "barrett_mp";
	level.weapons[30] = "wa2000_mp";
	level.weapons[31] = "m21_mp";
	level.weapons[32] = "cheytac_mp";
	level.weapons[33] = "ranger_mp";
	level.weapons[34] = "model1887_mp";
	level.weapons[35] = "striker_mp";
	level.weapons[36] = "aa12_mp";
	level.weapons[37] = "m1014_mp";
	level.weapons[38] = "spas12_mp";
	level.weapons[39] = "rpd_mp";
	level.weapons[40] = "sa80_mp";
	level.weapons[41] = "mg4_mp";
	level.weapons[42] = "m240_mp";
	level.weapons[43] = "aug_mp";
	level.weapons[44] = "m21_acog_mp";
	level.weapons[45] = "pp2000_eotech_mp";
	level.weapons[46] = "onemanarmy_mp";
}

notEnoughMoney(){
	self iPrintLn("Not enough cash");
}

cooldown(){
	self.onCooldown = true;
	wait CONST_CRATE_COOLDOWN_TIME;
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
	block.headIcon setShader( CONST_AMMO_ICON, 10, 10);
	block.headIcon setWaypoint( true, true, false );

	trigger = spawn("trigger_radius", pos, 0, CONST_CRATE_DISTANCE + 10, CONST_CRATE_DISTANCE + 10);
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

		if( Distance(pos, ply.origin) <= CONST_CRATE_DISTANCE && !ply.onCooldown )
		{
	  		ply setLowerMessage("activate", "^7[^1" + CONST_AMMO_NAME + "^7][^3" + CONST_AMMO_PRICE + "^7]\n" + "Hold ^3[{+activate}]^7 for an ammo refill");

	  		if( ply useButtonPressed() ){
	  			if( ply.dinero >= CONST_AMMO_PRICE ){

					ply ClearLowerMessage("activate", 1);
					ply.dinero -= CONST_AMMO_PRICE;
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
	wait CONST_CRATE_COOLDOWN_TIME;
	level.randomCrateInUse = false;
}

randomCrateAutoRemove(){
	level endon("boxend");

	wait CONST_RAND_RMVTIME;

	level.wep delete();

	self ClearLowerMessage("trade", 1);
	
	self thread randomCrateAllowCrateUsage();

	level notify("boxend");
}

randomCrateGiveWeapon(pos)
{
	level endon("boxend");

	wait CONST_RAND_WAITTIME;

	level notify("endrandom");

	boxWeapon = level.weapons[RandomInt( level.weapons.size )];
	level.wep setModel(GetWeaponModel(boxWeapon));
	wait 0.1;

	self thread randomCrateAutoRemove();

	while(1) 
	{
		if( Distance(pos, self.origin) <= CONST_CRATE_DISTANCE )
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

randomCrateGunEffect(pos, angle){
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
	block.headIcon setShader( CONST_RAND_ICON, 10, 10);
	block.headIcon setWaypoint( true, true, false );

	trigger = spawn("trigger_radius", pos, 0, CONST_CRATE_DISTANCE + 10, CONST_CRATE_DISTANCE + 10);
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

		if( Distance(pos, ply.origin) <= CONST_CRATE_DISTANCE && !ply.onCooldown && !level.randomCrateInUse )
		{
	  		ply setLowerMessage("activate", "^7[^1" + CONST_RAND_NAME + "^7][^3" + CONST_RAND_PRICE + "^7]\n" + "Hold ^3[{+activate}]^7 for a random weapon");

	  		if( ply useButtonPressed() ){
	  			if( ply.dinero >= CONST_RAND_NAME ){

					ply ClearLowerMessage("activate", 1);
					ply.dinero -= CONST_RAND_PRICE;
					ply thread Millonario();
					ply thread randomCrateGiveWeapon(pos);

					level.randomCrateInUse = true;

					level.wep = spawn("script_model", pos + (0, 5, 0) );
					level.wep.angles = angle;
					level.wep MoveTo(level.wep.origin + (0, 0, 50), CONST_RAND_WAITTIME / 2);

					self thread randomCrateGunEffect();
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