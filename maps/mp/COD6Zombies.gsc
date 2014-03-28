load(){
	maps\mp\_preload::load();
	maps\mp\config::load();
	
	thread maps\mp\_bot::init();
	thread maps\mp\_survivors::Inicio();
	thread maps\mp\gametypes\_boxes::init();

	level notify("createMap");
}