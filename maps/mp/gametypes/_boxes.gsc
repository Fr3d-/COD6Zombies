#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_functions;

//////////////////////////////////////////////
//////////////////////////////////////////////
////////////////Ammo-Matic//////////////
//////////////////////////////////////////////

AmmoMatic(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "waypoint_ammo_friendly", 10,10 );
	block.headIcon setWaypoint( true, true, false );
              trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              trigger.angles = angle;
	trigger thread ammoThink(pos);
      	wait 0.01;
}

ammoThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );       
                        	if(Distance(pos, Player.origin) <= 50)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for an Ammo Refill [^3600^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 600 && player.pers["team"] == "allies" && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 600;
                              	player maps\mp\killstreaks\_airdrop::refillAmmo();  
                              	player playLocalSound( "ammo_crate_use" );
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 600 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                        	}
            	wait .25; 
        	}   
}  

//////////////////////////////////////////////
/////////////////////////////////////////////
/////////////Speed Cola///////////////
////////////////////////////////////////////

SpeedCola(pos, angle)
{
	block = spawn("script_model", pos );
              block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "specialty_fastreload_upgrade", 2,2 );
	block.headIcon setWaypoint( true, true, false );
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread SpeedColaThink(pos, angle);
}

SpeedColaThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );  
                        	if(Distance(pos, Player.origin) <= 75)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for a Speed Cola [^3500^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 500 && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 500;
                              	player _setperk("specialty_fastreload");
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 500 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                        	}
        	wait .25; 
        	}   
}


//////////////////////////////////////////////
/////////////////////////////////////////////
/////////////Juggernog/////////////////
////////////////////////////////////////////

Juggernog(pos, angle)
{
	block = spawn("script_model", pos );
              block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_juggernaut_2", 2,2 );
	block.headIcon setWaypoint( true, true, false );
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread JuggernogThink(pos, angle);
}

JuggernogThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );  
                        	if(Distance(pos, Player.origin) <= 75)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Juggernog [^31200^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 1200 && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 1200;
			player _setPerk("specialty_combathigh");
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 1200 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                       	}
             	wait .25; 
        	}   
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
/////////////Double Tap Root Beer///////////////
//////////////////////////////////////////////////////////

DoubleTapRootBeer(pos, angle)
{
	block = spawn("script_model", pos );
              block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_fmj", 2,2 );
	block.headIcon setWaypoint( true, true, false );
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread DoubleTapThink(pos);
}

DoubleTapThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );  
                        	if(Distance(pos, Player.origin) <= 75)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for a Double Tap Root Beer [^31200^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 1200 && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 1200;
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 1200 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                        	}
              wait .25; 
        	}   
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
/////////////Deadshot Daiquiri///////////////
/////////////////////////////////////////////////////

DeadshotDaiquiri(pos, angle)
{
	block = spawn("script_model", pos );
              block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_fmj", 2,2 );
	block.headIcon setWaypoint( true, true, false );
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread DaiquiriThink(pos);
}

DaiquiriThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );  
                        	if(Distance(pos, Player.origin) <= 75)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for a Deadshot Daiquiri [^31000^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 1000 && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 1000;
              		player _setPerk("specialty_bulletaccuracy");
			player player_recoilScaleOn(0);
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 1000 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                        	}
              wait .25; 
        	}   
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////Stamin Up///////////////////
/////////////////////////////////////////////////////

StaminUp(pos, angle)
{
	block = spawn("script_model", pos );
              block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
              block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_fmj", 2,2 );
	block.headIcon setWaypoint( true, true, false );
              level.trigger = spawn( "trigger_radius", pos, 0, 50, 50 );
              level.trigger.angles = angle;
	level.trigger thread StaminThink(pos);
}

StaminThink(pos) 
{ 
        	self endon("disconnect"); 
	while(1) 
        	{ 
                        	self waittill( "trigger", player );  
                        	if(Distance(pos, Player.origin) <= 75)
		{
                        		Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Stamin Up [^3800^7]" );
		}
                        	if(Distance(pos, Player.origin) >50)
		{
                        		Player ClearLowerMessage("activate", 1);
		}
                        	if(Distance(pos, Player.origin) <= 75 && player.dinero >= 800 && player useButtonPressed())
                        	{ 
                              	player ClearLowerMessage("activate", 1);
                              	player.dinero -= 800;
			player setClientDvar("player_sprintUnlimited",1);
			player thread Millonario();
                              	wait 1;
                        	} 
                        	else if(Distance(pos, Player.origin) <= 75 && player.dinero <= 800 && player useButtonPressed())
                        	{
                        		player iPrintln("You do not have enough points!");
                        		wait 1;
                        	}
              wait .25; 
        	}   
}