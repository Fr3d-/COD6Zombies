#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");

	level.reaparicion = (38,-1022,-139);
	level.vision = "cobra_sunset2";
	level.pared = 1;
	level.cuerpo = "mp_body_opforce_arab_shotgun_a";	
	level.lugares = []; 
	level.lugares[0] = (1184,-1984,-67); 
	level.lugares[1] = (1127,-3728,-100); 
	level.lugares[2] = (-899,-2820,-21); 
	maps\mp\gametypes\_boxes::AmmoMatic((-161,-1710,-130),(0,90,0));
}