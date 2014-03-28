#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_airborne_shotgun_c";
	level.vision = "mp_highrise";
	level.pared = 1;
	level.reaparicion = (-6253,-9927,3230);
	level.lugares = []; 
	level.lugares[0] = (-4564,-11731,3200); 
	level.lugares[1] = (-5111,-12297,3200); 
	level.lugares[2] = (-3758,-10999,3200); 
	level.lugares[3] = (-5861,-12190,3200); 
	level.lugares[4] = (-4033,-10430,3200); 
	
	maps\mp\gametypes\_boxes::AmmoMatic((-7492,-10755,3200),(0,225,0));
	maps\mp\gametypes\_boxes::randomCrate((-5529,-8791,3200), (0, 225, 0));
}