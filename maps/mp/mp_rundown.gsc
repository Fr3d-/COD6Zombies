#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_rundown_precache::main();
	// maps\mp\mp_rundown_fx::main();
	maps\createart\mp_rundown_art::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_rundown" );

	//setExpFog( 1695, 5200, 0.8, 0.8, 0.8, 0.2, 0 );
	// ambientPlay( "ambient_mp_rural" );
	VisionSetNaked( "mp_rundown" );

	setdvar( "r_specularcolorscale", "1.67" );
	setdvar( "compassmaxrange", "3000" );
	setdvar( "sm_sunShadowScale", "0.5" ); // optimization

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.16 );
	setdvar( "r_lightGridContrast", 1 );

	level waittill("createMap");
	
	level.vision = "cobra_sunset";
	level.reaparicion = (841,2635,64);
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 0;
	level.lugares = []; 
	level.lugares[0] = (505,4089,5); 
	level.lugares[1] = (498,1906,121); 
	
	Bog((671,2093,100),(0,0,0));
	Bog((615,2094,99),(0,0,0));
	Bog((515,2107,98),(0,0,0));
	Bog((565,2107,98),(0,0,0));
	Bog((598,3844,28),(0,0,0));
	Bog((542,3836,30),(0,0,0));
	Bog((484,3827,30),(0,0,0));

	maps\mp\mod\_crates::AmmoMatic((959,2872,64),(0,90,0));
	maps\mp\mod\_crates::randomCrate((1278,2669,66),(0,0,0));
}