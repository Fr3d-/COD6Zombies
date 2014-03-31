main(){
	level.config["ZOMBIE_ATTACK_RANGE"] = 5000;
	level.config["ZOMBIE_ATTACK_DAMAGE"] = 20;

	level.config["CRATE_DISTANCE"] 		= 100;
	level.config["CRATE_COOLDOWN_TIME"] = 1;

	level.config["AMMO_NAME"]		= "AmmoMatic";
	level.config["AMMO_PRICE"]		= 700;
	level.config["AMMO_ICON"]		= "waypoint_ammo_friendly";

	level.config["RAND_NAME"]		= "    ?    ";
	level.config["RAND_PRICE"]		= 1000;
	level.config["RAND_ICON"]		= "hudicon_neutral";
	level.config["RAND_WAITTIME"]	= 12;
	level.config["RAND_RMVTIME"]	= 5;

	level.dvars = [];
	level.dvarValues = [];
	level.numDvar = 0;

	dvar("ui_allow_teamchange", 0);
	dvar("ui_allow_classchange", 0);
	dvar("ui_allow_controlschange", 0);
	dvar("ui_scorelimit", 0);
	dvar("g_deadChat", 1);
	dvar("cg_everyoneHearsEveryone", 1);
	dvar("cg_chatWithOtherTeams", 1);

	////////////Crosshairs////////
	dvar("cg_crosshairEnemyColor", "0" );
	dvar("cg_drawcrosshairnames", "0" );

	// Disable Nametags
	dvar("cg_drawFriendlyNames", 0);
	dvar("cg_enemyNameFadeIn", 2147483647)

	///////////Graphics////////////
	dvar("r_desaturation", "0" );
	dvar("r_specularcolorscale", "0" );
	dvar("r_normalmap", "0" );
	dvar("r_smc_enable", "0" );
	dvar("cg_fovScale", "1.125" );
	dvar("r_multigpu", "1" );
	dvar("r_distortion", "0" );
 	dvar("r_blur", 0.5);
  	dvar("r_brightness", -0.1);
	dvar("cg_fov", 70);
	dvar("fx_drawclouds", 0);
	dvar("r_contrast", 1);
	dvar("r_fog", 0);
	dvar("r_specular", 0);
	dvar("r_zfeather", 0);

	//////////Game Balance////////
	dvar("sc_enable", "0" );
	dvar("sm_enable", "0" );
	dvar("r_dlight_limit", "0" );
	dvar("player_burstFireCooldown",0.01); 

	///////////Physics///////////
	dvar("dynent_active", "0" );

	///////////Connection/////////
	dvar("didyouknow","^2You're playing ^1COD6Zombies");
	dvar("snaps", "30" );
	dvar("cl_maxpackets", "100" );
	dvar("rate", "25000" );
	dvar("cg_nopredict", "0" );

	/////////Bob///////////
	dvar("bg_bobMax", "0" );
	dvar("bg_bobAmplitudeStanding", "0" );
	dvar("bg_bobAmplitudeSprinting", "0" );
	dvar("bg_bobAmplitudeDucked", "0 0" );
	dvar("bg_bobAmplitudeProned", "0 0" );

	//////////ScoreBoard//////
	dvar("cg_ScoresPing_MaxBars", 10);

	/////////Lobby////////
	dvar("g_hardcore", 1);
	dvar("sv_hostname", "COD6Zombies hosted by Fr3d");
	dvar("party_maxPrivatePartyPlayers", 18);
	dvar("party_maxplayers", 18);
	dvar("sv_maxclients", 18);
	dvar("ui_maxclients", 18);

	/////////No Fall////////
	dvar("bg_fallDamageMinHeight", 9998);
	dvar("bg_fallDamageMaxHeight", 9999);
}

dvar( var, value ){
	level.dvars[level.numDvar] = var;
	level.dvarValues[level.numDvar] = value; 

	setDvar(var, value);

	level.numDvar++;
}