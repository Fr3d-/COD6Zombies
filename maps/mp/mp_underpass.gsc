#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	level waittill("createMap");
	
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 1;
	level thread Relampagos();
	level.reaparicion = (-3158,547,389);
	level.lugares = [];
	level.lugares[0] = (-1472,812,416);
	level.lugares[1] = (-1533,517,416);

	maps\mp\mod\_crates::AmmoMatic((-2396,505,384),(0,90,0));
	maps\mp\mod\_crates::randomCrate((-2539,498,384),(0,90,0));
}