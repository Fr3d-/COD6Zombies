#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;

main(){
	level waittill("createMap");

	maps\mp\mod\_crates::randomCrate((31, -609, 717), (0, 0, 0));
}