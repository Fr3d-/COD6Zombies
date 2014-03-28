#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	level waittill("createMap");
	
	level.vision = "cobra_sunset";
	level.reaparicion = (841,2635,64);
	level.cuerpo = "mp_body_militia_smg_aa_blk";
	level.pared = 0;
	level.lugares = []; 
	level.lugares[0] = (505,4089,5); 
	level.lugares[1] = (498,1906,121); 
	
	Bog((671,2093,100),(0,0,0));
	Bog((615,2094,99),(0,0,0));
	Bog((515,2107,98),(0,0,0));
	Bog((565,2107,98),(0,0,0));
	Bog((598,3844,28),(0,0,0));
	Bog((542,3836,30),(0,0,0));
	Bog((484,3827,30),(0,0,0));

	maps\mp\mod\_crates::AmmoMatic((959,2872,64),(0,90,0));
	maps\mp\mod\_crates::randomCrate((1278,2669,66),(0,0,0));
}