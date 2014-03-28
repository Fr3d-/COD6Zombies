main(){
	maps\mp\mod\_preload::load();
	maps\mp\mod\config::load();
	
	thread maps\mp\mod\_bot::init();
	thread maps\mp\mod\_survivors::Inicio();
	thread maps\mp\mod\_crates::init();

	level notify("createMap");
}