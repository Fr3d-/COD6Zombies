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

	setDvar("ui_allow_teamchange", 0);
	setDvar("ui_allow_classchange", 0);
	setDvar("ui_allow_controlschange", 0);
	setDvar("ui_scorelimit", 0 );
	setdvar("g_deadChat", 1 );

	////////////Crosshairs////////
	setDvar( "cg_crosshairEnemyColor", "0" );
	setDvar( "cg_drawcrosshairnames", "0" );

	///////////Graphics////////////
	setDvar( "r_desaturation", "0" );
	setDvar( "r_specularcolorscale", "0" );
	setDvar( "r_normalmap", "0" );
	setDvar( "r_smc_enable", "0" );
	setDvar( "cg_fovScale", "1.125" );
	setDvar( "r_multigpu", "1" );
	setDvar( "r_distortion", "0" );
 	setDvar("r_blur", 0.5);
  	setDvar("r_brightness", -0.1);
	setDvar( "cg_fov", 70);
	setDvar( "fx_drawclouds", 0);
	setDvar( "r_contrast", 1);
	setDvar( "r_fog", 0);
	setDvar( "r_specular", 0);
	setDvar( "r_zfeather", 0);

	//////////Game Balance////////
	setDvar( "sc_enable", "0" );
	setDvar( "sm_enable", "0" );
	setDvar( "r_dlight_limit", "0" );
	setDvar("player_burstFireCooldown",0.01); 

	///////////Physics///////////
	setDvar( "dynent_active", "0" );

	///////////Connection/////////
	setDvar("didyouknow","^2You're playing ^1COD6Zombies");
	setDvar( "snaps", "30" );
	setDvar( "cl_maxpackets", "100" );
	setDvar( "rate", "25000" );
	setDvar( "cg_nopredict", "0" );

	/////////Bob///////////
	setDvar( "bg_bobMax", "0" );
	setDvar( "bg_bobAmplitudeStanding", "0" );
	setDvar( "bg_bobAmplitudeSprinting", "0" );
	setDvar( "bg_bobAmplitudeDucked", "0 0" );
	setDvar( "bg_bobAmplitudeProned", "0 0" );

	//////////ScoreBoard//////
	setDvar("cg_ScoresPing_MaxBars", 10);/*
	setDvar("g_ScoresColor_Allies", "0 1 0.6 1");
	setDvar("g_ScoresColor_Axis", "1 0.1 0 1");
	setDvar("g_TeamColor_Allies", "0 1 0.6 1");
	setDvar("g_TeamColor_Axis", "1 0.1 0 1");*/

	/////////Lobby////////
	setDvar("g_hardcore", 1);
	setDvar("sv_hostname", "COD6Zombies hosted by Fr3d");
	setDvar("party_maxPrivatePartyPlayers", 18);
	setDvar("party_maxplayers", 18);
	setDvar("sv_maxclients", 18);
	setDvar("ui_maxclients", 18);

	/////////No Fall////////
	setDvar( "bg_fallDamageMinHeight", 9998);
	setDvar( "bg_fallDamageMaxHeight", 9999);
}