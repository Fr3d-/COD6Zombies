#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 1;
	level thread Relampagos();
	level.reaparicion = (-3158,547,389);
	level.lugares = [];
	level.lugares[0] = (-1472,812,416);
	level.lugares[1] = (-1533,517,416);

	maps\mp\gametypes\_boxes::AmmoMatic((-2396,505,384),(0,90,0));
	maps\mp\gametypes\_boxes::randomCrate((-2539,498,384),(0,90,0));
}