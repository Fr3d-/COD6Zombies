#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	thread createMap();
	maps\mp\mp_boneyard_precache::main();

	// maps\mp\mp_boneyard_fx::main();
	maps\createart\mp_boneyard_art::main();
	maps\mp\mp_boneyard_precache::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap( "compass_map_mp_boneyard" );
	setdvar( "compassmaxrange", "1700" );

	// ambientPlay( "ambient_mp_desert" );
	
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.19 );
	setdvar( "r_lightGridContrast", .4 );
}

createMap(){
	level waittill("createMap");

	level.reaparicion = (38,-1022,-139);
	level.vision = "cobra_sunset2";
	level.pared = 1;
	level.cuerpo = "mp_body_opforce_arab_shotgun_a";	
	level.lugares = []; 
	level.lugares[0] = (1184,-1984,-67); 
	level.lugares[1] = (1127,-3728,-100); 
	level.lugares[2] = (-899,-2820,-21);
	
	maps\mp\mod\_crates::AmmoMatic((-161,-1710,-130),(0,90,0));
	maps\mp\mod\_crates::randomCrate((571,-2561,-131),(0,0,0));
}