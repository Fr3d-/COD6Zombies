#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
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