#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_opforce_arctic_shotgun_c";
	level.vision = "cobra_sunset";
	level.reaparicion = (-3347,73,18);
	level.pared = 1;
	level.lugares = []; 
	level.lugares[0] = (-4060,-1681,350); 
	level.lugares[1] = (-5062,-864,396); 
	level.lugares[2] = (-5218,180,581); 
	level.lugares[3] = (-3502,1925,428);
	maps\mp\gametypes\_boxes::AmmoMatic((-2493,395,87),(0,0,0));
}