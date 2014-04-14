#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include common_scripts\utility;


Meteoros()
{

}

Niebla()
{
	level.blizzardpoint = (-1136,-2469,100);
	level._effect[ "FOW" ] = loadfx( "dust/nuke_aftermath_mp" );
	PlayFX(level._effect[ "FOW" ], level.blizzardpoint + ( 0 , 0 , 200 ));
}

LuzdeArbol(pos)
{
	switch(randomInt(2))
	{
		case 0: 
		level.treelight = level.greenlightfx; 
		break;
		case 1: 
		level.treelight = level.redlightfx; 
		break;
	}
	PlayFX(level.treelight,pos);
	wait 1;
}

Relampagos()
{
    	while(1)
	{
	    	playFX(level._effect[ "lightning" ], (-323,-834,2733));
		wait 1;
	}
}

removeAllObjects(){
	models = GetEntArray("script_model","classname");
	for(i=0;i<models.size;i++)
	    models[i] delete();

	/*
	This is used for the crate collisions so nono removal
	smodels = GetEntArray("script_brushmodel","classname");
	for(i=0;i<smodels.size;i++)
	    smodels[i] delete();*/

	destructibles = GetEntArray("destructible","targetname");
	for(i=0;i<destructibles.size;i++)
	    destructibles[i] delete();

	animated_models = getentarray( "animated_model", "targetname" );
	for(i=0;i<animated_models.size;i++)
	    animated_models[i] delete();

	ents = getentarray("destructable", "targetname");
	for(i=0;i<ents.size;i++)
	    ents[i] delete();

	barrels = getentarray ("explodable_barrel","targetname");
	for(i=0;i<barrels.size;i++)
	    barrels[i] delete();

	radiationFields = getentarray("radiation", "targetname");
	for(i=0;i<radiationFields.size;i++)
	    radiationFields[i] delete();

	killzones = getentarray("trigger_hurt", "targetname");
	for(i=0;i<killzones.size;i++)
	    killzones[i] delete();

	level deletePlacedEntity("misc_turret");
}

CreateMinigun(pos,weapon,angles)
{
 	mgTurret = spawnTurret( "misc_turret", pos, weapon );
 	mgTurret.angles = angles; 
 	mgTurret setModel( "weapon_minigun" );
	wait 0.01;
}

CreateBlocks(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.01;
}

CreateModel(pos, angle, model)
{
	block = spawn("script_model", pos );
	block setModel( model );
	block.angles = angle;
	block Solid();
	wait 0.01;
}

CreateRamps(top, bottom)
{
	D = Distance(top, bottom);
	blocks = roundUp(D/30);
	CX = top[0] - bottom[0];
	CY = top[1] - bottom[1];
	CZ = top[2] - bottom[2];
	XA = CX/blocks;
	YA = CY/blocks;
	ZA = CZ/blocks;
	CXY = Distance((top[0], top[1], 0), (bottom[0], bottom[1], 0));
	Temp = VectorToAngles(top - bottom);
	BA = (Temp[2], Temp[1] + 90, Temp[0]);
	for(b = 0; b < blocks; b++){
		block = spawn("script_model", (bottom + ((XA, YA, ZA) * b)));
		block setModel("com_plasticcase_friendly");
		block.angles = BA;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.01;
	}
	block = spawn("script_model", (bottom + ((XA, YA, ZA) * blocks) - (0, 0, 5)));
	block setModel("com_plasticcase_friendly");
	block.angles = (BA[0], BA[1], 0);
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.01;
}

CreateGrids(corner1, corner2 )
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
	center.angles = ( 0, 0, 0 );
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

CreateInvisibleWalls(start, end)
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

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}