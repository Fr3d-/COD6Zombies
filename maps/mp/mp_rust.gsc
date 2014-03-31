#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_rust_precache::main();
	maps\createart\mp_rust_art::main();
	// maps\mp\mp_rust_fx::main();

	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_rust" );

	setdvar( "compassmaxrange", "1400" );

	ambientPlay( "ambient_mp_duststorm" );

	level waittill("createMap");

	level.cuerpo = "mp_body_opforce_arab_shotgun_a";
	level.vision = "icbm";
	level.reaparicion = (163,-2573,-160);
	level.pared = 1;
	level.lugares = []; 
	level.lugares[0] = (574,-6770,-344); 
	level.lugares[1] = (78,-5980,-330); 
	level.lugares[2] = (-2030,-3078,-80); 
	level.lugares[3] = (-1102,52,-236); 
	level.lugares[4] = (2556,-1781,-172);
	
	maps\mp\mod\_crates::AmmoMatic((-1276,-1336,-210),(0,0,0));
	maps\mp\mod\_crates::randomCrate((251,-399,-229),(0,0,0));
}