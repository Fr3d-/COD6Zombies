load(){
	precacheMpAnim("pb_hold_run");
	precacheMpAnim("pb_stumble_walk_forward");
	precacheMpAnim("pb_sprint_shield");
	precacheMpAnim("pb_sprint");
	precacheMpAnim("pt_melee_right2right_1");
	precacheMpAnim("pb_sprint_pistol");
	precacheMpAnim("pb_sprint_akimbo");
	precacheMpAnim("pb_walk_forward_akimbo");
	precacheMpAnim("pt_stand_pullout_shield");

	precacheShader("specialty_fastreload_upgrade");
	precacheShader("cardicon_juggernaut_2");
	precacheShader("hudicon_neutral");
	precacheShader("cardicon_fmj");
	precacheShader("cardtitle_bloodsplat");
	precacheShader("cardtitle_zombie_3");
	precacheShader("minimap_scanlines");
	precacheShader("ui_cursor");

	level.bloodfx = loadfx("impacts/flesh_hit_body_fatal_exit");
 	level.molotovfx = loadfx ("explosions/helicopter_explosion_secondary_small");
	level.greenlightfx = loadFX( "misc/aircraft_light_wingtip_green" );
	level.redlightfx = loadFX( "misc/aircraft_light_wingtip_red" );

	precacheModel("police_barrier_01_dlc2");
  	precacheModel("foliage_cod5_tallgrass10b");
	precacheModel("weapon_saw_mg_setup");
}