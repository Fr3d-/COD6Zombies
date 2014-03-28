#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;
#include common_scripts\utility;
#using_animtree( "multiplayer" );

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
////////////////////Bot AI////////////////////////
/////////////////////////////////////////////////////

main()
{
	level thread init();
	level thread onPlayerConnect();
}

init()
{
	level.contador = createServerFontString( "objective", 1.7, "allies" );
	level.contador setPoint("","",0,-190);
	level.contador.color = (1,0,0.4);
	level.contadort = 3;
	for(i = level.contadort; i > 0; i --)
	{
		level.contador setText("Zombies coming in:" + i);
		wait 1;
	}
	level thread NukeQuake();
	level.contador destroy();
	iPrintlnBold("^1Zombies Incoming");
	level notify("nuevaola");
	level.ola = 1;
	level thread Oleadas();
	level thread PrepararNuevaOleada();
}

Oleadas()
{
	switch(level.ola)
	{
		case 1:
			level.ztotal[level.ola] = 10;
			level thread createZombies(level.ztotal[level.ola],100);
		break;

		case 2:
			level.ztotal[level.ola] = 15;
			level thread createZombies(level.ztotal[level.ola],150);
		break;

		case 3:
			level.ztotal[level.ola] = 25;
			level thread createZombies(level.ztotal[level.ola],200);
		break;

		case 4:
			level.ztotal[level.ola] = 35;
			level thread createZombies(level.ztotal[level.ola],250);
		break;

		case 5:
			level.ztotal[level.ola] = 45;
			level thread createZombies(level.ztotal[level.ola],300);
		break;

		case 6:
			level.ztotal[level.ola] = 55;
			level thread createZombies(level.ztotal[level.ola],300);
		break;

		case 7:
			level.ztotal[level.ola] = 60;
			level thread createZombies(level.ztotal[level.ola],400);
		break;

		case 8:
			level.ztotal[level.ola] = 65;
			level thread createZombies(level.ztotal[level.ola],450);
		break;

		case 9:
			level.ztotal[level.ola] = 75;
			level thread createZombies(level.ztotal[level.ola],500);
		break;

		case 10:
			level.ztotal[level.ola] = 75;
			level thread createZombies(level.ztotal[level.ola],550);
		break;

		case 11:
			level.ztotal[level.ola] = 60;
			level thread createZombies(level.ztotal[level.ola],600);
		break;

		case 12:
			level.ztotal[level.ola] = 70;
			level thread createZombies(level.ztotal[level.ola],650);
		break;

		case 13:
			level.ztotal[level.ola] = 75;
			level thread createZombies(level.ztotal[level.ola],800);
		break;

		case 14:
			level.ztotal[level.ola] = 1;
			level thread createZombies(level.ztotal[level.ola],50000);
		break;

		case 15:
		break;
	}
}

createZombies(numero,vidaola)
{
	for(i=0;i<numero;i++)
	{
		level.zombis[i] = spawn("script_model", level.lugares[RandomInt(level.lugares.size)] + (randomInt(100),randomInt(100),0));
		level.zombis[i] setModel(level.cuerpo);
      	level.zombis[i] EnableLinkTo();
		level.zombis[i] physicsLaunchServer((0,0,0),(0,0,0));
		level.zombis[i].vida = spawn("script_model", level.zombis[i].origin + (0,0,30) ); 
		level.zombis[i].vida setModel("com_plasticcase_enemy");
		level.zombis[i].vida Solid();
		level.zombis[i].vida CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.zombis[i].vida.angles = (90,0,0);
		level.zombis[i].vida hide();
		level.zombis[i].vida.lifeId = 1;
		level.zombis[i].vida.targetname = "zombi"; 
                	level.zombis[i].vida setcandamage(true);
		level.zombis[i].vida physicsLaunchServer((0,0,0), (0,0,0));
		level.zombis[i].vida.health = vidaola;
		level.zombis[i].vida linkto( level.zombis[i] );
		level.zombis[i].team = "axis";
		level.zombis[i] Solid();
		level.zombis[i] thread Velocidades(i);
		if(level.pared == 1)
		{
			level.zombis[i] thread AtacarJugador(i);
		}
		if(level.pared == 0)
		{
			level.zombis[i] thread AtacarJugadorParedes(i);
		}
		level.zombis[i] thread VidadeZombies(i);
		level.zombis[i] thread Matar(i);
		level.zombis[i] thread NoBajoMapa(i);
	}
}

AtacarJugador(i)
{
	while(1)
	{
		distancia = undefined;
		objetivo = undefined;
		self physicsLaunchServer((0,0,0), (0,0,0));
		foreach( jugador in level.players )
		{
			if(!isAlive(jugador) && !bulletTracePassed(self getTagOrigin("j_head"),jugador getEye(),true,self) && jugador.sessionstate != "playing" && jugador.pers["team"] != "allies")
                		continue;
			if(distancesquared(self.origin, jugador.origin) < 9999999999)
			{
				distancia = distance(self.origin, jugador.origin);
				objetivo = jugador;
			}
		}
		Angulos = VectorToAngles( objetivo getEye() - self getTagOrigin( "j_head" ) );
		self.angles = (0, Angulos[1], 0);
		delante = self.origin + (0, 0, 25) + maps\mp\mod\_functions::vector_scal(anglestoforward(angulos), 25);
		final = bullettrace(delante, delante + (0, 0, -200), false, self);
		self moveto(final["position"],self.velocidad);
	wait 0.08;
	}
}

AtacarJugadorParedes(i) //Thanks to Nukem
{
	for(;;)
	{
		TmpDist = 999999999;
		pTarget = undefined;
		foreach( player in level.players )
		{	
			if(!isAlive(player))
                			continue;
			if(level.teamBased && self.team == player.pers["team"])
                			continue;
			if( !bulletTracePassed( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), false, self ) )
                			continue;
			if(player.sessionstate != "playing")
				continue;
			if(distancesquared(self.origin, player.origin) < TmpDist)
			{
				TmpDist = distancesquared(self.origin, player.origin);
				pTarget = player;
			}
			movetoLoc = VectorToAngles( pTarget getTagOrigin("j_head") - self getTagOrigin( "j_head" ) );
			self.angles = (0, movetoLoc[1], 0);
			delante = self.origin + (0, 0, 25) + maps\mp\mod\_functions::vector_scal(anglestoforward(self.angles), 25);
			final = bullettrace(delante, delante + (0, 0, -200), false, self);
			self moveto(final["position"],self.velocidad);
		}
	wait 0.08;
	}

}

Velocidades(i)
{
	switch( randomInt(9) )
	{
		case 0:
		self.velocidad = 0.5;
		self.sonido = "generic_death_russian_1";
		self scriptModelPlayAnim("pb_stumble_walk_forward");
		break;
		case 1:
		self.velocidad = 0.4;
		self.sonido = "melee_knife_hit_watermelon";
		self scriptModelPlayAnim("pb_sprint_shield"); 
		break;
		case 2:
		self.velocidad = 0.3;
		self.sonido = "melee_knife_hit_watermelon";
		self scriptModelPlayAnim("pb_hold_run"); 
		break;
		case 3:
		self.velocidad = 0.2;
		self.sonido = "generic_death_russian_2";
		self scriptModelPlayAnim("pb_sprint_pistol"); 
		break;
		case 4:
		self.velocidad = 0.15;
		self.sonido = "generic_death_russian_1";
		self scriptModelPlayAnim("pb_sprint_akimbo");
		break;
		case 5:
		self.velocidad = 0.25;
		self.sonido = "generic_death_russian_2";
		self scriptModelPlayAnim("pb_sprint_pistol"); 
		break;
		case 6:
		self.velocidad = 0.35;
		self.sonido = "melee_knife_hit_watermelon";
		self scriptModelPlayAnim("pb_hold_run"); 
		break;
		case 7:
		self.velocidad = 0.27;
		self.sonido = "melee_knife_hit_watermelon";
		self scriptModelPlayAnim("pb_sprint");
		break;
		case 8:
		self.velocidad = 0.45;
		self.sonido = "generic_death_russian_1";
		self scriptModelPlayAnim("pb_walk_forward_akimbo");
		break;
	}
}

VidadeZombies(i)
{
	while(1)
	{
		self.vida waittill("damage", eInflictor, attacker, victim, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(sHitLoc);
		self.vida.health -= iDamage;
              	playFx(level.bloodfx,self.origin);
              	playFx(level.bloodfx,self.origin+(0,0,50));
		if(self.vida.health <= 0)
		{
			self notify("death");
			self.vida delete();
			wait .1;
            self startRagDoll(0);

			attacker thread maps\mp\gametypes\_rank::scorePopup( 100, 0, (1,0,0), 1 );
			self playSound( self.sonido );

			attacker.kills++;
			attacker.dinero += 100;
			attacker.pers["kills"] = attacker.kills;
			attacker.score += 100;
			attacker.pers["score"] = attacker.score;

			wait 5;
			self delete();
			break;
		}
	wait 0.05;
	}
}

Matar(i)
{
	self endon("death");
	for(;;)
	{
		foreach( jugador in level.players )
		{
			if(distancesquared(jugador.origin, self.origin) <= 1500)
			{
				switch( randomInt(2) ){
					case 0:
						self ScriptModelPlayAnim("pt_melee_right2right_1");
					case 1:
						self ScriptModelPlayAnim("pt_stand_pullout_shield");
				}

				earthquake(0.7,1, self.origin + (0,0,40), 60);
				jugador.health--;
				if(jugador.health <= 0)
				{
					jugador thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 999999, 0, "MOD_MELEE", "none", jugador.origin, jugador.origin, "none", 0, 0 );
				}
			}
		}

	wait 0.07;
	}
}

NoBajoMapa(i)
{
	self endon("death");
	for(;;)
	{
		if((self.origin[2] < -2000) && (getDvar("mapname") == "mp_afghan") && level.edicion == 0)
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < -3500) && (getDvar("mapname") == "mp_afghan") && level.edicion == 1)
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < -50) && (getDvar("mapname") == "mp_derail"))
		{
			self delete();
			self.vida delete();
			break;
		}	
		if((self.origin[2] < -130) && (getDvar("mapname") == "mp_estate"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < 6000) && (getDvar("mapname") == "mp_fuel2"))
		{
			self delete();
			self.vida delete();
			break;
		}	
		if((self.origin[2] < -20) && (getDvar("mapname") == "mp_trailerpark"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < 3198) && (getDvar("mapname") == "mp_highrise"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < 63) && (getDvar("mapname") == "mp_invasion"))
		{
			self delete();
			self.vida delete();
			break;
		}	
		if((self.origin[2] < -100) && (getDvar("mapname") == "mp_brecourt"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < -120) && (getDvar("mapname") == "mp_rundown"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < 200) && (getDvar("mapname") == "mp_underpass"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < 30) && (getDvar("mapname") == "mp_compact"))
		{
			self delete();
			self.vida delete();
			break;
		}	
		if((self.origin[2] < -250) && (getDvar("mapname") == "mp_overgrown"))
		{
			self delete();
			self.vida delete();
			break;
		}	
		if((self.origin[2] < -20) && (getDvar("mapname") == "mp_abandon"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < -800) && (getDvar("mapname") == "mp_rust"))
		{
			self delete();
			self.vida delete();
			break;
		}
		if((self.origin[2] < -200) && (getDvar("mapname") == "mp_boneyard"))
		{
			self delete();
			self.vida delete();
			break;
		}
	wait 0.05;
	}
}

PrepararNuevaOleada()
{
	while(1)
	{
		if(maps\mp\mod\_functions::Zombiesconvida() <= 0)
		{
			iprintlnbold("^1Humans Have survived the Wave");
			foreach(jugador in level.players)
			{
				jugador maps\mp\perks\_perks::givePerk( "frag_grenade_mp" );
				if(jugador.tieneque == 1)
				{
					jugador notify("menuresponse", game["menu_team"], "allies");
					jugador allowSpectateTeam( "freelook", false );
					jugador.tieneque = 0;
				}
				wait 0.05;
			}
			wait 30;
			iprintlnbold("^1New Wave");
			level.ola ++;
			level thread Oleadas();
			if(level.ola == 15)
			{
			       	maps\mp\gametypes\_gamelogic::endGame( "allies", "^5The Humans Survived" );
			}
		}
	wait 0.08;
	}
}
			
onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player thread onPlayerSpawned();
		player thread UnirseaAliados();
		player thread Marcadores(player);
		level thread Configuracion();
		level thread HumanosDevorados();
	}
}

UnirseaAliados()
{
	self notify("menuresponse", game["menu_team"], "allies");
	if(level.gameState == "intermission" || level.gameState == "starting")
	{
		self notify("menuresponse", game["menu_team"], "allies");
	}
}

HumanosDevorados()
{
       	winner = "axis";
	wait 5;
	while( 1 )
	{
		players = maps\mp\gametypes\_teams::CountPlayers();
		if(players["allies"] == 0) 
		{
       			maps\mp\gametypes\_gamelogic::endGame( winner, "^1The zombies devorated the Humans" );
		}
	wait 0.05;
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "spawned_player" );
		self setOrigin(level.reaparicion+(randomInt(50),randomInt(50),0));
		self.health = 100;
		self.maxhealth = 100;
		self thread Vision();
		//self thread Coordinates();
	}
}

Vision()
{
	while(1)
	{
		self VisionSetNakedForPlayer(level.vision, 0);
		wait 0.05;
	}
}

Configuracion()
{
	////////////Allow Dvars/////////
	setDvar("ui_allow_teamchange", "0");
	setDvar("ui_allow_classchange",0);
	setDvar("ui_allow_controlschange",0);

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
	setDvar("didyouknow","^2OMA Zombie Mod by Yamato");
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
	setDvar("cg_ScoresPing_MaxBars", 10);
	setDvar("g_ScoresColor_Allies", "0 1 0.6 1");
	setDvar("g_ScoresColor_Axis", "1 0.1 0 1");
	setDvar("g_TeamColor_Allies", "0 1 0.6 1");
	setDvar("g_TeamColor_Axis", "1 0.1 0 1");

	/////////Lobby////////
	setDvar("g_hardcore", 1);
	setDvar("sv_hostname", "OMA Zombie Mod by Yamato");
	setDvar("party_maxPrivatePartyPlayers",4);
	setDvar("party_maxplayers",4);
	setDvar("sv_maxclients",4);
	setDvar("ui_maxclients",4);

	/////////No Fall////////
	setDvar( "bg_fallDamageMinHeight", 9998);
	setDvar( "bg_fallDamageMaxHeight", 9999);

	////////Turrets///////
	setDvar("turret_fov", 57);
	setDvar("turret_adsFov", 50);

	////////Rockets////////
	setDvar("missileRemoteFOV", 35);
	setDvar("missileRemoteSpeedTargetRange", "1700 2300");
	setDvar("missileRemoteSteerPitchRange", "-180 180");
	setDvar("missileRemoteSteerPitchRate", 140);
	setDvar("missileRemoteSteerYawRate", 140);
	setDvar("missileRemoteSpeedUp", 900);
}

Marcadores(player)
{
	self endon("disconnect");
	player notifyOnPlayerCommand("showHost", "+scores");
	player notifyOnPlayerCommand("hideHost", "-scores");
	if (isDefined(player.hostname)) player.hostname destroy();
	for(;;)
	{
		player waittill("showHost");
		player thread maps\mp\mod\_survivors::DestruirTodoelHUD();
	        	player.scorebartop = self createRectangle("", "", 0, -190, 800, 22, "minimap_scanlines", (0,1,0.6), 1, 1);
		player.hostname = player createFontString("hudmedium", 1.4);
		player.hostname setPoint("BOTTOMLEFT", "BOTTOMLEFT", 85, -25);
		player.hostname setText( level.hostname );
		player waittill("hideHost");
		player.hostname destroy();
		player.scorebartop destroy();
		player thread maps\mp\mod\_survivors::Pantalla();
	}
}
