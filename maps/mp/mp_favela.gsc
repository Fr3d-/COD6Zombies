#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

main(){
	level waittill("createMap");
	
	level.vision = "cobra_sunset";

	maps\mp\gametypes\_boxes::randomCrate((9881,18431,13635), (0, 90, 0));
}