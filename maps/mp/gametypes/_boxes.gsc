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