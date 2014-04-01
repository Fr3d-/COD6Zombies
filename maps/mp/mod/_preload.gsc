main(){
	precacheMpAnim("pb_hold_run");
	precacheMpAnim("pb_stumble_walk_forward");
	precacheMpAnim("pb_sprint_shield");
	precacheMpAnim("pb_sprint");
	precacheMpAnim("pt_melee_right2right_1");
	precacheMpAnim("pb_sprint_pistol");
	precacheMpAnim("pb_sprint_akimbo");
	precacheMpAnim("pb_walk_forward_akimbo");
	precacheMpAnim("pt_stand_pullout_shield");

	// General HUD
	precacheShader("black");
	precacheShader("cardtitle_hazard_3");
	precacheShader("cardicon_compass");
	precacheShader("cardicon_biohazard");

	// Ammo
	precacheShader("cardicon_bullets_50cal");

	// Perks
	precacheShader("specialty_marathon_upgrade");
	precacheShader("specialty_fastreload_upgrade");
	precacheShader("cardicon_juggernaut_2");

	precacheShader("hudicon_neutral");
	precacheShader("cardicon_fmj");
	precacheShader("ui_cursor");


	level.bloodfx = loadfx("impacts/flesh_hit_body_fatal_exit");
 	level.molotovfx = loadfx ("explosions/helicopter_explosion_secondary_small");
	level.greenlightfx = loadFX( "misc/aircraft_light_wingtip_green" );
	level.redlightfx = loadFX( "misc/aircraft_light_wingtip_red" );

	precacheModel("police_barrier_01_dlc2");
  	precacheModel("foliage_cod5_tallgrass10b");
	precacheModel("weapon_saw_mg_setup");

	level.weapons = [];
	level.weapons[0] = "beretta_mp";
	level.weapons[1] = "usp_mp";
	level.weapons[2] = "deserteagle_mp";
	level.weapons[3] = "deserteaglegold_mp";
	level.weapons[4] = "coltanaconda_mp";
	level.weapons[5] = "riotshield_mp";
	level.weapons[6] = "glock_mp";
	level.weapons[7] = "beretta393_mp";
	level.weapons[8] = "mp5k_mp";
	level.weapons[9] = "pp2000_mp";
	level.weapons[10] = "uzi_mp";
	level.weapons[11] = "p90_mp";
	level.weapons[12] = "kriss_mp";
	level.weapons[13] = "ump45_mp";
	level.weapons[14] = "tmp_mp";
	level.weapons[15] = "ak47_mp";
	level.weapons[16] = "m16_mp";
	level.weapons[17] = "m4_mp";
	level.weapons[18] = "fn2000_mp";
	level.weapons[19] = "masada_mp";
	level.weapons[20] = "famas_mp";
	level.weapons[21] = "fal_mp";
	level.weapons[22] = "scar_mp";
	level.weapons[23] = "tavor_mp";
	level.weapons[24] = "m79_mp";
	level.weapons[25] = "rpg_mp";
	level.weapons[26] = "at4_mp";
	level.weapons[27] = "stinger_mp";
	level.weapons[28] = "javelin_mp";
	level.weapons[29] = "barrett_mp";
	level.weapons[30] = "wa2000_mp";
	level.weapons[31] = "m21_mp";
	level.weapons[32] = "cheytac_mp";
	level.weapons[33] = "ranger_mp";
	level.weapons[34] = "model1887_mp";
	level.weapons[35] = "striker_mp";
	level.weapons[36] = "aa12_mp";
	level.weapons[37] = "m1014_mp";
	level.weapons[38] = "spas12_mp";
	level.weapons[39] = "rpd_mp";
	level.weapons[40] = "sa80_mp";
	level.weapons[41] = "mg4_mp";
	level.weapons[42] = "m240_mp";
	level.weapons[43] = "aug_mp";
	level.weapons[44] = "m21_acog_mp";
	level.weapons[45] = "pp2000_eotech_mp";
	level.weapons[46] = "onemanarmy_mp";
}