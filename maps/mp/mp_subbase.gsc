#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_subbase_precache::main();
	maps\createart\mp_subbase_art::main();
	// maps\mp\mp_subbase_fx::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_subbase" );

	// ambientPlay( "ambient_mp_snow" );
	
	setdvar( "r_specularcolorscale", "2.9" );
	setdvar( "compassmaxrange", "2500" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 2 );
	//setdvar( "r_lightGridContrast", 0 );

	level waittill("createMap");
	
	level.reaparicion = (-337,-5850,0);
	level.vision = "icbm";
	level.pared = 1;
	level.cuerpo = "mp_body_opforce_arctic_shotgun_c";	
	level.lugares = []; 
	level.lugares[0] = (-265,-3920,0); 
	level.lugares[1] = (-402,-3978,0);

	maps\mp\mod\_crates::AmmoMatic((-305,-6440,0),(0,0,0));
	maps\mp\mod\_crates::randomCrate((-412,-6440,0),(0,0,0));
}