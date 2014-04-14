#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	thread createMap();
	maps\mp\mp_quarry_precache::main();
	// maps\mp\mp_quarry_fx::main();
	maps\createart\mp_quarry_art::main();
	maps\mp\_load::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_compass::setupMiniMap( "compass_map_mp_quarry" );
	setdvar( "compassmaxrange", "2800" );

	setExpFog( 900, 3500, 0.631373, 0.568627, 0.54902, 1, 0 );
	setExpFog( 900, 3500, 0.631373, 0.568627, 0.34902, 1, 0, 1, 0.803922, 0.564706, (0, .5, 1), 0, 15.2331, 0.961894 );

	ambientPlay( "ambient_mp_desert" );
	VisionSetNaked( "mp_quarry" );

	// raise up planes to avoid them flying through buildings
	level.airstrikeHeightScale = 2;

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.22 );
	setdvar( "r_lightGridContrast", .67 );
}

createMap(){
	level waittill("createMap");

	level.reaparicion = (-3170, 3704, 11);
	level.lugares = []; 
	level.lugares[0] = (-3246, 6250, 700); /*
	level.lugares[1] = (-2498, 7580, 724+200); 
	level.lugares[2] = (-5071, 6955, 758+200); 
	level.lugares[3] = (-5785, 6558, 740+200);
	level.lugares[4] = (-6142, 5570, 612+200);
	level.lugares[5] = (-7121, 3835, 268+200);
	level.lugares[6] = (-4334, 5938, 446+200);*/
	level.vision = "missilecam";

	maps\mp\mod\_crates::randomCrate((-3503,63,92), (0, 0, 0));
}