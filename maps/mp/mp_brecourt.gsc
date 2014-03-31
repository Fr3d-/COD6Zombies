#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_brecourt_precache::main();
	// maps\mp\mp_brecourt_fx::main();
	maps\createart\mp_brecourt_art::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_brecourt" );

	//ambientPlay( "ambient_mp_rural" );

	setdvar( "r_specularcolorscale", "1" );

	setdvar( "compassmaxrange", "4000" );

	setdvar( "sm_sunShadowScale", 0.5 );

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.11 );
	setdvar( "r_lightGridContrast", .29 );

	level waittill("createMap");

	maps\mp\mod\_crates::randomCrate((-2139,-3929,83),(0,0,0));
}