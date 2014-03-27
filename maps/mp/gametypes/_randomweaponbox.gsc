#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_functions;
#include maps\mp\gametypes\_hud_util;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////Random Weapon Box////////////////////////
///////////////////////////////////////////////////////////////////////////

Iniciodecaja()
{
	level thread Conexion();
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

Conexion()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread Algoquenoimporta();
	}
}

Algoquenoimporta()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "spawned_player" );
	}
}

RandomWeapon(pos, angle)
{
              level.block = spawn("script_model", pos);
              level.block setModel("com_plasticcase_beige_big");
	level.block.angles = angle;
	level.block Solid();
	level.block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              invisblock = spawn("script_model", pos+(0,0,60));
	invisblock Solid();
              invisblock.angles = angle;
	invisblock CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.block.headIcon = newHudElem();
	level.block.headIcon.x = level.block.origin[0];
	level.block.headIcon.y = level.block.origin[1];
	level.block.headIcon.z = level.block.origin[2] + 50;
	level.block.headIcon.alpha = 0.85;
	level.block.headIcon setShader( "hudicon_neutral", 10,10 );
	level.block.headIcon setWaypoint( true, true, false );
	level.block thread RandomWeaponThink(pos, angle);
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread RandomWeaponThink(pos, angle);
      	wait 0.01;
}

RandomWeaponThink(pos, angle) 
{ 
	self endon("disconnect"); 
	level endon("endrandom"); 
       	while(1) 
        	{ 
                	self waittill( "trigger", player );       
                	if(Distance(pos, Player.origin) <= 75)
		{
                		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for a Random Weapon [^31000^7]" );
		}
                	if(Distance(pos, Player.origin) >50)
		{
                		Player ClearLowerMessage("activate", 1);
		}
                	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 1000 && player.pers["team"] == "allies" && player useButtonPressed())
                	{ 
                        		player ClearLowerMessage("activate", 1);
                        		player.dinero -= 1000;
                        		player notify("CASH");
			player thread Millonario();
                        		player thread giveWeaponFunc(pos);
                        		level.wep = spawn("script_model", pos+(0,5,0));
                        		level.wep.angles = angle;
                        		level.wep MoveTo(level.wep.origin+(0,0,50), 3);
                        		while(1)
                        		{
                                		boxWeapon = level.weapons[RandomInt( level.weapons.size )];
                                		level.wep setModel(GetWeaponModel(boxWeapon));
                                		wait 0.13;
                        		}
                	} 
                	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 1000 && player useButtonPressed())
                	{
                        		player iPrintln("Not enough cash!");
                        		wait 1;
                	}
           	wait .25; 
        	}   
}  

giveWeaponFunc(pos)
{
	level endon("boxend");
	wait 8;
        	level notify("endrandom");
        	boxWeapon = level.weapons[RandomInt( level.weapons.size )];
        	level.wep setModel(GetWeaponModel(boxWeapon));
        	wait 0.1;
	while(1) 
        	{
                	if(Distance(pos, self.origin) <= 75)
		{
                		self setLowerMessage("trade", "Hold ^3[{+activate}]^7 to Trade Weapons" );
                	} else { 
                	if(Distance(pos, self.origin) >50)
                		self ClearLowerMessage("trade", 1);
		}
                	if(Distance(pos, self.origin) <= 75 && self useButtonPressed())
                	{
                        		self ClearLowerMessage("trade", 1);
                        		self notify("newWeapon");
			self takeWeapon(self getCurrentWeapon());
                        		wait 0.1;
                        		self _giveWeapon(boxWeapon);
                        		self switchToWeapon(boxWeapon);
                        		self giveMaxAmmo(boxWeapon);
                        		self.firstweapon = 0;
                        		self thread GunSpecials();
                        		wait 0.01;
                        		level.wep delete();
                        		level notify("boxend");
               	}
          	wait 0.01;
       	}
}

DoBoxSpawner()
{
   	while(1)
   	{
         		level waittill("endrandom"); 
         		wait 9;
         		level.block delete();
         		level.wep delete();
         		level.trigger delete();
         		level notify("boxend");
         		if(getDvar("mapname") == "mp_rust")
		{
         			RandomWeapon((251,-399,-229),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_afghan" && level.edicion == 0)
		{
         			RandomWeapon((-1224,11249,-1888),(10,20,0));
		}
         		if(getDvar("mapname") == "mp_afghan" && level.edicion == 1)
		{
         			RandomWeapon((6581,10005,-1841),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_highrise")
		{
         			RandomWeapon((-5529,-8791,3200), (0, 225, 0));
		}
         		if(getDvar("mapname") == "mp_invasion")
		{
         			RandomWeapon((-6553,-3289,512), (0, 135, 0));
		}
         if(getDvar("mapname") == "mp_favela"){
         RandomWeapon((9881,18431,13635), (0, 90, 0));}
         if(getDvar("mapname") == "mp_checkpoint"){
         RandomWeapon((31, -609, 717), (0, 0, 0));}
         if(getDvar("mapname") == "mp_quarry"){
         RandomWeapon((-3503,63,92), (0, 0, 0));}
         		if(getDvar("mapname") == "mp_subbase")
		{
         			RandomWeapon((-412,-6440,0),(0,0,0));
		}
         if(getDvar("mapname") == "mp_nightshift"){
         RandomWeapon((1243,-252,34),(0,0,0));}
         if(getDvar("mapname") == "mp_strike"){
         RandomWeapon((-1312,113,223),(0,90,0));}
         if(getDvar("mapname") == "mp_vacant"){
         RandomWeapon((1107,768,-47),(0,90,0));}
         		if(getDvar("mapname") == "mp_underpass")
		{
         			RandomWeapon((-2539,498,384),(0,90,0));
		}
         		if(getDvar("mapname") == "mp_rundown")
		{
         			RandomWeapon((1278,2669,66),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_fuel2")
		{
         			RandomWeapon((16183,28529,7212),(0,0,0));
		}
         if(getDvar("mapname") == "mp_storm"){
         RandomWeapon((-25,-22,0),(0,90,0));}
         		if(getDvar("mapname") == "mp_derail")
		{
        	 		RandomWeapon((-2669,-283,12),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_estate")
		{
         			RandomWeapon((1362,3719,65),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_boneyard")
		{
         			RandomWeapon((571,-2561,-131),(0,0,0));
		}
         if(getDvar("mapname") == "mp_terminal"){
         RandomWeapon((-595,324,40),(0,0,0));}
         		if(getDvar("mapname") == "mp_brecourt")
		{
         			RandomWeapon((-2139,-3929,83),(0,0,0));
		}
         		if(getDvar("mapname") == "mp_overgrown")
		{
         			RandomWeapon((1284,2651,-157),(0,90,0));
		}
         		if(getDvar("mapname") == "mp_compact")
		{
         			RandomWeapon((-2128,1765,144),(0,0,0));
		}
         if(getDvar("mapname") == "mp_crash"){
         RandomWeapon((1514,447,140),(0,0,0));}
        		if(getDvar("mapname") == "mp_abandon")
		{
         			RandomWeapon((-2991,2361,-7),(0,90,0));
		}
         if(getDvar("mapname") == "mp_complex"){
         RandomWeapon((2516,-2276,748),(0,90,0));}
         		if(getDvar("mapname") == "mp_trailerpark")
		{
     			RandomWeapon((1412,-2950,1),(0,0,0));
		}
         wait 1;
   }
}

boxSpawner()
{
     	wait 1;
     	iPrintLnBold("^3Random Weapon Box^7 spawned!");
     	level.block delete();
     	level.trigger delete();
     	if(getDvar("mapname") == "mp_rust")
	{
     		RandomWeapon((251,-399,-229),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_afghan" && level.edicion == 0)
	{
     		RandomWeapon((-1224,11249,-1888),(10,20,0));
	}
     	if(getDvar("mapname") == "mp_afghan" && level.edicion == 1)
	{
     		RandomWeapon((6581,10005,-1841),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_highrise")
	{
              	RandomWeapon((-5529,-8791,3200), (0, 225, 0));
	}
     	if(getDvar("mapname") == "mp_invasion")
	{
              	RandomWeapon((-6553,-3289,512), (0, 135, 0));
	}
     if(getDvar("mapname") == "mp_favela"){
     RandomWeapon((9881,18431,13635), (0, 90, 0));}
     if(getDvar("mapname") == "mp_checkpoint"){
     RandomWeapon((31, -609, 717), (0, 0, 0));}
     if(getDvar("mapname") == "mp_quarry"){
     RandomWeapon((-3503,63,92), (0, 0, 0));}
     	if(getDvar("mapname") == "mp_subbase")
	{
     		RandomWeapon((-412,-6440,0),(0,0,0));
	}
     if(getDvar("mapname") == "mp_nightshift"){
     RandomWeapon((1243,-252,34),(0,0,0));}
     if(getDvar("mapname") == "mp_strike"){
     RandomWeapon((-1312,113,223),(0,90,0));}
     if(getDvar("mapname") == "mp_vacant"){
     RandomWeapon((1107,768,-47),(0,90,0));}
     	if(getDvar("mapname") == "mp_underpass")
	{
     		RandomWeapon((-2539,498,384),(0,90,0));
	}
     	if(getDvar("mapname") == "mp_rundown")
	{
     		RandomWeapon((1278,2669,66),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_fuel2")
	{
              	RandomWeapon((16183,28529,7212),(0,0,0));
	}
     if(getDvar("mapname") == "mp_storm"){
     RandomWeapon((-25,-22,0),(0,90,0));}
     	if(getDvar("mapname") == "mp_derail")
	{
     		RandomWeapon((-2669,-283,12),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_estate")
	{
         		RandomWeapon((1362,3719,65),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_boneyard")
	{
		RandomWeapon((571,-2561,-131),(0,0,0));
	}
     if(getDvar("mapname") == "mp_terminal"){
     RandomWeapon((-595,324,40),(0,0,0));}
     	if(getDvar("mapname") == "mp_brecourt")
	{
         		RandomWeapon((-2139,-3929,83),(0,0,0));
	}
     	if(getDvar("mapname") == "mp_overgrown")
	{
     		RandomWeapon((1284,2651,-157),(0,90,0));
	}
     	if(getDvar("mapname") == "mp_compact")
	{
     		RandomWeapon((-2128,1765,144),(0,0,0));
	}
     if(getDvar("mapname") == "mp_crash"){
     RandomWeapon((1514,447,140),(0,0,0));}
     	if(getDvar("mapname") == "mp_abandon")
	{
     		RandomWeapon((-2991,2361,-7),(0,90,0));
	}
     if(getDvar("mapname") == "mp_complex"){
     RandomWeapon((2516,-2276,748),(0,90,0));}
     	if(getDvar("mapname") == "mp_trailerpark")
	{
     		RandomWeapon((1412,-2950,1),(0,0,0));
	}
}

GunSpecials()
{
	self endon ( "death" );
	self endon ( "disconnect" );
      	self thread monitorSpecial("Crossbow");
}

monitorSpecial(Special)
{
	self endon("death");
	switch(Special)
	{
		case "Crossbow":
		self setWeaponAmmoClip("m21_acog_mp", 1);
                            for(;;)
	              {
		      	stock = self getWeaponAmmoStock("m21_acog_mp");	
		      	self waittill("weapon_fired");
		      	if(self getCurrentWeapon() == "m21_acog_mp")
		        	{
				while(self getWeaponAmmoClip("m21_acog_mp") == 0)
				{
				wait .05;
				}
				self setWeaponAmmoClip("m21_acog_mp", 1);
				self setWeaponAmmoStock("m21_acog_mp", stock - 1);
		        	}
                         	}
		break;

                            case "CrossbowTwo":
		for(;;)
		{
	                  	wep = self getCurrentWeapon();
	                  	clip = self getWeaponAmmoClip(wep);
                                	stock = self getWeaponAmmoStock(wep);
                                	if(wep == "m21_acog_fmj_mp")
	                  	if(clip != 0)
	                  	self setWeaponAmmoClip(wep, 1);
	                  	wait 0.05;
		}
            		break;
	}
}
