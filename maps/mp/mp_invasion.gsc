#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_invasion_precache::main();
	maps\createart\mp_invasion_art::main();
	// maps\mp\mp_invasion_fx::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_invasion" );

	// raise up planes to avoid them flying through buildings
	level.airstrikeHeightScale = 1.5;

	// ambientPlay( "ambient_mp_urban" );
	
	setdvar( "r_specularcolorscale", "2.5" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.25 );
	setdvar( "r_lightGridContrast", .5 );
	setdvar( "compassmaxrange", "2500" );

	level waittill("createMap");
	
	level.cuerpo = "mp_body_opforce_arab_shotgun_a";
	level.vision = "mp_rundown";
	level.reaparicion = (-6096,-2970,512);
	level.pared = 1;
	level.lugares = [];
	level.lugares[0] = (-4313,-1520,301);
	level.lugares[1] = (-4557,-766,269);
	level.lugares[2] = (-4957,602,214);

	maps\mp\mod\_crates::AmmoMatic((-6359,-3457,512),(0,135,0));
	maps\mp\mod\_crates::randomCrate((-6553,-3289,512), (0, 135, 0));
}