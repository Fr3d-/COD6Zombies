#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_opforce_arab_shotgun_a";
	level.vision = "mp_rundown";
	level.reaparicion = (-6096,-2970,512);
	level.pared = 1;
	level.lugares = [];
	level.lugares[0] = (-4313,-1520,301);
	level.lugares[1] = (-4557,-766,269);
	level.lugares[2] = (-4957,602,214);

	maps\mp\gametypes\_boxes::AmmoMatic((-6359,-3457,512),(0,135,0));
	maps\mp\gametypes\_boxes::randomCrate((-6553,-3289,512), (0, 135, 0));
}