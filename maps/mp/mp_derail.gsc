#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	thread createMap();
	thread maps\mp\mp_derail_precache::main();
	// maps\mp\mp_derail_fx::main();
	thread maps\createart\mp_derail_art::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_derail" );

	// ambientPlay( "ambient_mp_snow" );

	setdvar( "r_specularcolorscale", "2.3" );
	setdvar( "compassmaxrange", "4000" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1 );
	setdvar( "r_lightGridContrast", .4 );
}

createMap(){
	level waittill("createMap");

	maps\mp\mod\_crates::randomCrate((-2669,-283,12),(0,0,0));
}