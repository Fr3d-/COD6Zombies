#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	thread createMap();

	maps\mp\mp_afghan_precache::main();
	maps\createart\mp_afghan_art::main();
	//maps\mp\mp_afghan_fx::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_afghan" );

	setdvar( "compassmaxrange", "3000" );

	ambientPlay( "ambient_mp_desert" );

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.2 );
	setdvar( "r_lightGridContrast", 0 ); 
}

createMap(){
	level waittill("createMap");

	switch( 0 )
	{
		case 0:
			level.cuerpo = "mp_body_opforce_arab_shotgun_a";
			level.edicion = 0;
	  			ents = getEntArray();
	  			for ( index = 0; index < ents.size; index++ )
	  			{
	      				if(isSubStr(ents[index].classname, "trigger_hurt"))
	      					ents[index].origin = (0, 0, 9999999);
	  			}	
			level.reaparicion = (-1962,11034,-1794);
			level.pared = 0;
			level.lugares = []; 
			level.lugares[0] = (1028,12326,-1955); 
			level.lugares[1] = (1101,12428,-1949); 
			level.lugares[2] = (-4092,9770,-1693); 
			level.lugares[3] = (-4110,9868,-1692);
			level.vision = "icbm_launch";
			//CreateMinigun((-1165,11408,-1870),"pavelow_minigun_mp",(0,22,0)); 
			CreateBlock((-1165,11408,-1900),(0,102,0));
			//CreateMinigun((-2617,10639,-1682),"pavelow_minigun_mp",(0,-151,0)); 
			CreateBlock((-2617,10639,-1720),(0,-241,0));
			maps\mp\mod\_crates::AmmoMatic((-1882,10951,-1799),(5,30,0));
			//SpeedCola((-1658,11052,-1826),(2,30,0));

			maps\mp\mod\_crates::randomCrate((-1224,11249,-1888),(10,20,0));
		break;

		case 1:
			level.reaparicion = (3798,8017,-2013);
			level.cuerpo = "mp_body_opforce_arab_shotgun_a";
			level.pared = 0;
			level.edicion = 1;
			level.vision = "icbm_launch";
	  			ents = getEntArray();
	  			for ( index = 0; index < ents.size; index++ )
	  			{
	      				if(isSubStr(ents[index].classname, "trigger_hurt"))
	      					ents[index].origin = (0, 0, 9999999);
	  			}
			level.lugares = []; 
			level.lugares[0] = (4443,9310,-2135); 
			level.lugares[1] = (5116,9553,-1928); 
			level.lugares[2] = (5918,9997,-2039); 
			maps\mp\mod\_crates::AmmoMatic((3921,8543,-2265),(0,0,0));
			maps\mp\mod\_crates::randomCrate((6581,10005,-1841),(0,0,0));
		break;
	}
}