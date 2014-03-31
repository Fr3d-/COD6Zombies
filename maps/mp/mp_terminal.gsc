#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_terminal_precache::main();
	maps\createart\mp_terminal_art::main();
	// maps\mp\mp_terminal_fx::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_terminal" );
	setdvar( "compassmaxrange", "2000" );

	// ambientPlay( "ambient_mp_airport" );

	VisionSetNaked( "mp_terminal" );

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.22 );
	setdvar( "r_lightGridContrast", .6 );

	game["attackers"] = "allies";
	game["defenders"] = "axis";

	level waittill("createMap");

	maps\mp\mod\_crates::randomCrate((-595,324,40),(0,0,0));
}