#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_underpass_precache::main();
	maps\createart\mp_underpass_art::main();
	//maps\mp\mp_underpass_fx::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_underpass" );
	setdvar( "compassmaxrange", "2800" );

	//setExpFog( 500, 3500, .5, 0.5, 0.45, 1, 0 );
	ambientPlay( "none" );

	setdvar( "r_specularcolorscale", "3.1" );
	setdvar( "r_diffusecolorscale", ".78" );
	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.3 );
	setdvar( "r_lightGridContrast", .5 );

	level waittill("createMap");
	
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 1;
	level thread Relampagos();
	level.reaparicion = (-3158,547,389);
	level.lugares = [];
	level.lugares[0] = (-1472,812,416);
	level.lugares[1] = (-1533,517,416);

	maps\mp\mod\_crates::AmmoMatic((-2396,505,384),(0,90,0));
	maps\mp\mod\_crates::randomCrate((-2539,498,384),(0,90,0));
}