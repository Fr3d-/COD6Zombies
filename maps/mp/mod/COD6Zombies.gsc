main(){
	maps\mp\mod\_preload::main();
	maps\mp\mod\config::main();
	
	thread maps\mp\mod\_zombies::main();
	thread maps\mp\mod\_survivors::main();

	level notify("createMap");
}