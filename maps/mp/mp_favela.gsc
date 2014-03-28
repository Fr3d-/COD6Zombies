#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	level waittill("createMap");
	
	level.vision = "cobra_sunset";

	maps\mp\mod\_crates::randomCrate((9881,18431,13635), (0, 90, 0));
}