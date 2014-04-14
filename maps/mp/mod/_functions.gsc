#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
////////////////////Mod Functions////////////////////////
//////////////////////////////////////////////////////////////////
testBind()
{
    self endon ( "disconnect" );

    i = 0;

    self notifyOnPlayerCommand("F1", "+test");
    for(;;)
    {
            self waittill("F1");
            self setModel( level.models[i] );
            iPrintLn( level.models[i] );
            i++;
       
    }
}

test(){
	iPrintLn(self getPlayerAngles() );
	//exitLevel( false );
}

GetSpawnModel( )
{
rModel = "";

	switch( getDvar("mapname") )
	{
		case "mp_underpass":
		rModel = "mp_body_militia_smg_aa_wht";
		break;
		
		case "mp_quarry":
		rModel = "mp_body_militia_smg_aa_blk";
		break;
		
		case "mp_afghan":
		rModel = "mp_body_opforce_arab_shotgun_a";
		break;
		
		case "mp_rust":
		rModel = "mp_body_opforce_arab_shotgun_a";
		break;
		
		case "mp_boneyard":
		rModel = "mp_body_opforce_arab_shotgun_a";
		break;
		
		case "mp_derail":
		rModel = "mp_body_opforce_arctic_shotgun_c";
		break;
		
		case "mp_highrise":
		rModel = "mp_body_airborne_shotgun";
		break;
		
		case "mp_terminal":
		rModel = "mp_body_airborne_shotgun";
		break;
		
		case "mp_brecourt":
		rModel = "mp_body_airborne_shotgun_b";
		break;
		
		case "mp_nightshift":
		rModel = "mp_body_airborne_shotgun_c";
		break;
		
		case "mp_estate":
		rModel = "mp_body_airborne_shotgun_c";
		break;
		
		case "mp_favela":
		rModel = "mp_body_militia_smg_aa_blk";
		break;
		
		case "mp_invasion":
		rModel = "mp_body_opforce_arab_shotgun_a";
		break;
		
		case "mp_checkpoint":
		rModel = "mp_body_opforce_arab_shotgun_a";
		break;
		
		case "mp_subbase":
		rModel = "mp_body_opforce_arctic_shotgun_c";
		break;
		
		case "mp_rundown":
		rModel = "mp_body_militia_smg_aa_blk";
		break;
	}

return rModel;
}


Coordinates()
{
	self endon ( "disconnect" );
        	self endon ( "death" );
	self thread Angles();
	self thread UFO();
     	for(;;)
             	{
		wait 1.0;
		self iPrintLnBold(self getOrigin());
             	}
}

Angles()
{
        	self endon ( "disconnect" );
       	self endon ( "death" );
     	for(;;)
             	{
		wait 1.5;
		self iPrintLnBold("" + self.angles);
	}
}

UFO()
{
        self endon ( "disconnect" );
        self endon ( "death" );

        self notifyOnPlayerCommand("X", "+noclip");
        maps\mp\gametypes\_spectating::setSpectatePermissions();
        for(;;)
        {
                self waittill("X");          
                self allowSpectateTeam( "freelook", true );
                self.sessionstate = "spectator";
                self setContents( 0 );
                self thread maps\mp\gametypes\_hud_message::hintMessage( "" );
                self waittill("X");
                self.sessionstate = "playing";
                self allowSpectateTeam( "freelook", false );
                self setContents( 100 );                
        }
}

Models()
{
             	self endon("death");
             	self endon("disconnect");
	entities = getentarray( "script_model", "classname" );
	for ( i = 0; i < entities.size; i++ )
	{
		self iPrintLnBold( entities[ i ].model );
                            self setModel(entities[ i ].model);
              wait 1.5;
	}
}

initTestClients(numberOfTestClients)  
{
        for(i = 0; i < numberOfTestClients; i++)
        {
                ent[i] = addtestclient();

                if (!isdefined(ent[i]))
                {
                        wait 1;
                        continue;
                }

                ent[i].pers["isBot"] = true;
                ent[i] thread initIndividualBot();
                wait 0.1;
        }
}

initIndividualBot()
{
        self endon( "disconnect" );
        while(!isdefined(self.pers["team"]))
                wait .05;
        self notify("menuresponse", game["menu_team"], "axis");
        wait 0.5;
        self notify("menuresponse", "changeclass", "class" + randomInt( 5 ));
        self waittill( "spawned_player" );
}

GetCursorPos()
{
	forward = self getTagOrigin("tag_eye");
	end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
	location = BulletTrace( forward, end, 0, self)[ "position" ];
	return location;
}

vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

Zombiesconvida()
{
	if( !isDefined(level.ztotal) && !isDefined(level.wave) ){
		return 0;
	}

	return level.ztotal - level.zkilled;
}

DesegundosaTiempo(sec)
{
        	seconds = sec;
        	minutes = 0;
        	hours = 0;
        	if(seconds >= 60)
        	{
                	minutes = int(seconds/60);
                	seconds -= int(minutes*60);
                	if(minutes>=60)
                	{
                       		hours = int(minutes/60);
                        		minutes -= int(hours*60);
                	}
        	}
        	return hours + ":" + minutes + ":" + seconds;
}

EscalerasNo()
{
	while(1)
	{
		if(self isonladder()) 
		{
			self suicide();
			self iprintlnbold("No ladders bitch");
		}
	wait 0.05;
	}
}

Flashear(tiempo)
{
 	self shellshock( "flashbang_mp", tiempo );
}

NukeQuake()
{
           	self thread maps\mp\killstreaks\_nuke::nukeSoundExplosion();
           	earthquake(0.6,10,self.origin,100000);
           	self thread maps\mp\killstreaks\_nuke::nukeEffects();
}

DefaultAngles()
{
	self setPlayerAngles(self.angles+(0,0,0));
}

TextoFlash( period )
{
        	x = self createFontString( "default", 2.3 );
        	x setPoint("CENTER","TOP",0,10); 
        	x setText("=)"); 
        	x.sort = -10;
        	x.color = (randomFloat(1),randomFloat(1),randomFloat(1));
       	t = 0;
        	for (;;) 
	{
                	if ( x.alpha<.01 ) 
		{
                        		x.color = (randomFloat(1),randomFloat(1),randomFloat(1));
                	}
                	x.alpha = (cos(360*t/period)+1)/2;
                	t += .05;
                	wait .05;
        	}
}

DetectGround( origin )
{
	return BulletTrace( origin, ( origin + ( 0, 0, -100000 ) ), 0, self )[ "position" ];
}

NoShellShock()
{
	for(;;)
	{
		self StopShellShock();
		wait 0.05;
	}
}

PlayRandomShellshocks()
{
	while(1)
	{
		switch(randomInt(3))
		{
			case 0:
			self ShellShock( "damage_mp", 60 );
			break;
			case 1:
			self ShellShock( "pain", 60 );
			break;
			case 2:
			self ShellShock( "death", 60 );
			break;
		}
	wait 10;
	}
}

CreateFXonPos(pos,fx)
{
        	playFX(fx, pos);
        	angles = (90, 90, 0);
	wait 0.01;
}

Millonario()
{
	level._effect["money"] = loadfx ("props/cash_player_drop");
	PlayFx(level._effect["money"],self.origin);
}
