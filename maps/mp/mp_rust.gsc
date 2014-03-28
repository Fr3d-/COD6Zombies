#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
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
	
	maps\mp\gametypes\_boxes::AmmoMatic((-1276,-1336,-210),(0,0,0));
	maps\mp\gametypes\_boxes::randomCrate((251,-399,-229),(0,0,0));
}