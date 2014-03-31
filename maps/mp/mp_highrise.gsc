#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	maps\mp\mp_highrise_precache::main();
	maps\createart\mp_highrise_art::main();
	//maps\mp\mp_highrise_fx::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap( "compass_map_mp_highrise" );

	setdvar( "r_lightGridEnableTweaks", 1 );
	setdvar( "r_lightGridIntensity", 1.11 );
	setdvar( "r_lightGridContrast", .9 );

	//VisionSetNaked( "mp_highrise" );
	//ambientPlay( "embient_mp_highrise" );

	// raise up planes to avoid them flying through buildings
	level.airstrikeHeightScale = 3;

	setdvar( "compassmaxrange", "2100" );
	level waittill("createMap");
	
	level.cuerpo = "mp_body_airborne_shotgun_c";
	level.vision = "mp_highrise";
	level.pared = 0;
	level.reaparicion = (-6253,-9927,3230);
	level.lugares = []; 
	level.lugares[0] = (-4564,-11731,3200); 
	level.lugares[1] = (-5111,-12297,3200); 
	level.lugares[2] = (-3758,-10999,3200); 
	level.lugares[3] = (-5861,-12190,3200); 
	level.lugares[4] = (-4033,-10430,3200); 
	
	maps\mp\mod\_crates::AmmoMatic((-7492,-10755,3200),(0,225,0));
	maps\mp\mod\_crates::randomCrate((-5529,-8791,3200), (0, 225, 0));
}