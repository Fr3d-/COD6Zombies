#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
////////////////////Mod Functions////////////////////////
//////////////////////////////////////////////////////////////////

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
        self notifyOnPlayerCommand("N", "+actionslot 1");
        maps\mp\gametypes\_spectating::setSpectatePermissions();
        for(;;)
        {
                self waittill("N");          
                self allowSpectateTeam( "freelook", true );
                self.sessionstate = "spectator";
                self setContents( 0 );
                self thread maps\mp\gametypes\_hud_message::hintMessage( "" );
                self waittill("N");
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
	numeroz = 0;
	for(i = 0; i < level.ztotal[level.ola]; i++)
	{
		if((isDefined(level.zombis[i])) && (level.zombis[i].vida.health > 0))
		numeroz++;
	}
	return numeroz;
}

Destruirhud(algo)
{
	self waittill("death");
	algo destroy();
}

Destruirhudr(algo)
{
	self waittill("spawned_player");
	algo destroy();
}

GraficoCoseno(texto)
{
        h = NewClientHudElem(self);
        h.alignX = "center";h.alignY = "middle";h.horzAlign = "center";h.vertAlign = "middle";
        h.fontscale = 0.75;
        h.font = "hudbig";
        h.x -= (texto.size+870)*1.45;
        h settext(texto);
        for(i=0;i<720;i+=4.5)
        {
                h moveovertime(0.1);
                h.y=cos(i*2)*100;
                h.x += (texto.size+870)*0.01875;
                wait 0.1;
        }
        h destroy();
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

CreateMinigun(pos,weapon,angles)
{
     	mgTurret = spawnTurret( "misc_turret", pos, weapon );
     	mgTurret.angles = angles; 
     	mgTurret setModel( "weapon_minigun" );
	wait 0.01;
}

CreateBlock(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.01;
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

CreateGrids(corner1, corner2, angle)
{
	W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
	L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
	H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
	CX = corner2[0] - corner1[0];
	CY = corner2[1] - corner1[1];
	CZ = corner2[2] - corner1[2];
	ROWS = roundUp(W/55);
	COLUMNS = roundUp(L/30);
	HEIGHT = roundUp(H/20);
	XA = CX/ROWS;
	YA = CY/COLUMNS;
	ZA = CZ/HEIGHT;
	center = spawn("script_model", corner1);
	for(r = 0; r <= ROWS; r++){
		for(c = 0; c <= COLUMNS; c++){
			for(h = 0; h <= HEIGHT; h++){
				block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
				block setModel("com_plasticcase_friendly");
				block.angles = (0, 0, 0);
				block Solid();
				block LinkTo(center);
				block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
				wait 0.01;
			}
		}
	}
	center.angles = angle;
}

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}

PoliceBarrier(pos,angle)
{
	barrier = spawn("script_model",pos);
	barrier setModel("police_barrier_01_dlc2");
	barrier.angles = angle;
	barrier Solid();
	barrier CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.01;
}

CreateWalls(start, end)
{
	D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
	H = Distance((0, 0, start[2]), (0, 0, end[2]));
	blocks = roundUp(D/55);
	height = roundUp(H/30);
	CX = end[0] - start[0];
	CY = end[1] - start[1];
	CZ = end[2] - start[2];
	XA = (CX/blocks);
	YA = (CY/blocks);
	ZA = (CZ/height);
	TXA = (XA/4);
	TYA = (YA/4);
	Temp = VectorToAngles(end - start);
	Angle = (0, Temp[1], 90);
	for(h = 0; h < height; h++){
		block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
		block setModel("com_plasticcase_friendly");
		block.angles = Angle;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.001;
		for(i = 1; i < blocks; i++){
			block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
			block setModel("com_plasticcase_friendly");
			block.angles = Angle;
			block Solid();
			block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
			wait 0.001;
		}
		block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
		block setModel("com_plasticcase_friendly");
		block.angles = Angle;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.001;
	}
}

CreateInvWalls(start, end)
{
	D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
	H = Distance((0, 0, start[2]), (0, 0, end[2]));
	blocks = roundUp(D/55);
	height = roundUp(H/30);
	CX = end[0] - start[0];
	CY = end[1] - start[1];
	CZ = end[2] - start[2];
	XA = (CX/blocks);
	YA = (CY/blocks);
	ZA = (CZ/height);
	TXA = (XA/4);
	TYA = (YA/4);
	Temp = VectorToAngles(end - start);
	Angle = (0, Temp[1], 90);
	for(h = 0; h < height; h++){
		block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
		block.angles = Angle;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.001;
		for(i = 1; i < blocks; i++){
			block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
			block.angles = Angle;
			block Solid();
			block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
			wait 0.001;
		}
		block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
		block.angles = Angle;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.001;
	}
}

createRectangle( align, relative, x, y, width, height, elem, color, alpha, sort )
{
        	barElemBG = newClientHudElem( self );
        	barElemBG.elemType = "bar";
        	if( !level.splitScreen )
        	{
                	barElemBG.x = -2;
                	barElemBG.y = -2;
        	}
        	barElemBG.width = width;
        	barElemBG.height = height;
        	barElemBG.align = align;
        	barElemBG.relative = relative;
        	barElemBG.xOffset = 0;
        	barElemBG.yOffset = 0;
        	barElemBG.children = [];
        	barElemBG.sort = sort;
        	barElemBG.color = color;
        	barElemBG.alpha = alpha;
        	barElemBG setParent( level.uiParent );
        	barElemBG setShader( elem, width , height );
        	barElemBG.hidden = false;
        	barElemBG setPoint( align, relative, x, y );
        	return barElemBG;
}

Bog(pos,angle)
{
	barrier = spawn("script_model",pos);
	barrier setModel("foliage_cod5_tallgrass10b");
	barrier.angles = angle;
	barrier Solid();
	barrier CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	PlayFX(level._effect[ "fog_ground_200_heavy_rundown" ],pos+(0,0,3));
	PlayFX(level._effect[ "fog_ground_200_heavy_rundown" ],pos+(0,0,10));
	wait 0.01;
}

isWallBang( attacker, victim ) //By BraX
{
	start = attacker getEye();
	end = victim getEye();
	if( bulletTracePassed( start, end, false, attacker ) )
		return false;
	return true;
}