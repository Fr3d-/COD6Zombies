#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_estate_precache::main();
	maps\createart\mp_estate_art::main();
	// maps\mp\mp_estate_fx::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_estate" );

	// ambientPlay( "ambient_mp_estate" );
	
	setdvar( "r_specularcolorscale", "1.17" );
	setdvar( "compassmaxrange", "3500" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.3 );
	setdvar( "r_lightGridContrast", 0 );

	if ( level.ps3 )
		setdvar( "sm_sunShadowScale", "0.5" ); // ps3 optimization
	else
		setdvar( "sm_sunShadowScale", "0.7" ); // optimization

	level waittill("createMap");
	
	level.cuerpo = "mp_body_airborne_shotgun_c";
	level.vision = "icbm_sunrise4";
	level.reaparicion = (1729,3675,28);
	level.pared = 1;
	level.lugares = []; 
	level.lugares[0] = (2027,5098,-65);
	level.lugares[1] = (1446,5128,-106);
	level.lugares[2] = (2204,5021,-50);
	CreateMinigun((1907,3878,73),"pavelow_minigun_mp",(0,71,0));
	CreateMinigun((937,4208,146),"pavelow_minigun_mp",(0,49,0));

	maps\mp\mod\_crates::AmmoMatic((1161,3844,86),(0,0,0));
	maps\mp\mod\_crates::randomCrate((1362,3719,65),(0,0,0));
}