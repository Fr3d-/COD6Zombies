#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.reaparicion = (-337,-5850,0);
	level.vision = "icbm";
	level.pared = 1;
	level.cuerpo = "mp_body_opforce_arctic_shotgun_c";	
	level.lugares = []; 
	level.lugares[0] = (-265,-3920,0); 
	level.lugares[1] = (-402,-3978,0);

	maps\mp\gametypes\_boxes::AmmoMatic((-305,-6440,0),(0,0,0));
	maps\mp\gametypes\_boxes::randomCrate((-412,-6440,0),(0,0,0));
}