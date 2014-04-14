#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	thread createMap();

	maps\mp\mp_underpass_precache::main();
	maps\createart\mp_underpass_art::main();
	maps\mp\mp_underpass_fx::main();
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
}

createMap(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 1;
	level thread Relampagos();
	level.reaparicion = (1179, 2194, 234);

	level.lugares = [];

	maps\mp\mod\_crates::AmmoMatic((-47, 1920, 40),(0,0,0));
	maps\mp\mod\_crates::randomCrate((3314, 2000, 282),(0,90,0));
	maps\mp\mod\_crates::speedCola( (790, 2075, 190), (0, 0, 0) );
	maps\mp\mod\_crates::staminUp( (95, 2343, 0), (0, 0, 0) );

	CreateInvisibleWalls( (2648.36, 2600.37, 384.827), (2576.13, 2599.46, 457.819) );
	CreateInvisibleWalls( (-87.8709, 2536.2, 136.125), (23.8611, 2533.1, 191.578) );
	CreateInvisibleWalls( (-164.35, 1424.55, 106.863), (-321.854, 1471.87, 165.641) );
	CreateInvisibleWalls( (2850.95, 1665.58, 354.896), (2440.18, 1665.46, 378.46) );

	// Path 1
	CreateModel( (2617.03, 2566.48, 378.912), (0, -91.2689, 0), "foliage_pacific_bushtree01_animated" );
 	CreateModel( (2648.87, 2506.49, 385.997), (0, 98.6737, 0), "foliage_pacific_bushtree01_animated" );
 	level.lugares[0] = (2652, 2775, 436);

 	// Path 2
	CreateModel( (2549.18, 1662.17, 320.125), (0, 1.50513, 0), "foliage_tree_oak_1_animated2" );
	CreateModel( (2466.68, 1664.13, 320.125), (0, 6.68518, 0), "foliage_pacific_bushtree01_animated" );
	CreateModel( (2621.38, 1657.86, 320.125), (0, 176.082, 0), "foliage_pacific_bushtree01_animated" );
	CreateModel( (2675.96, 1652.01, 320.125), (0, 173.038, 0), "foliage_pacific_bushtree01_animated" );
	level.lugares[1] = (2704, 1293, 344);

	// Path 3
	CreateModel( (-32.0162, 2511.36, 128.125), (0, 177.885, 0), "foliage_pacific_bushtree01_animated" );
	level.lugares[2] = (-237, 2503, 296);

	// Path 4
	CreateModel( (-245.968, 1494.1, 91.6368), (0, 84.8804, 0), "foliage_cod5_tree_jungle_03_animated" );
	CreateModel( (-185.048, 1465.42, 96.8284), (0, 86.0394, 0), "foliage_cod5_tree_jungle_03_animated" );
	CreateModel( (-305.268, 1505.96, 93.1027), (0, 78.5028, 0), "foliage_cod5_tree_jungle_02_animated" );
	level.lugares[3] = (-246, 1274, 157);

	setDvar("mantle_enable", 0);
}