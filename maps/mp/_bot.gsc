#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_randomweaponbox;
#include maps\mp\gametypes\_boxes;
#include maps\mp\_utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;
#include common_scripts\utility;
#using_animtree( "multiplayer" );

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
////////////////////Bot AI////////////////////////
/////////////////////////////////////////////////////

Inicio()
{
	level thread Empezar();
              level thread DoBoxSpawner();
              level thread boxSpawner();
	level thread onPlayerConnect();
	////////////////////////////Animations///////////////////////////
	precacheMpAnim("pb_hold_run");
	precacheMpAnim("pb_stumble_walk_forward");
	precacheMpAnim("pb_sprint_shield");
	precacheMpAnim("pb_sprint");
	precacheMpAnim("pt_melee_right2right_1");
	precacheMpAnim("pb_sprint_pistol");
	precacheMpAnim("pb_sprint_akimbo");
	precacheMpAnim("pb_walk_forward_akimbo");
	///////////////////////////Shaders////////////////////////////////
	precacheShader("specialty_fastreload_upgrade");
	precacheShader("cardicon_juggernaut_2");
	precacheShader("hudicon_neutral");
	precacheShader("cardicon_fmj");
	precacheShader("cardtitle_bloodsplat");
	precacheShader("cardtitle_zombie_3");
	precacheShader("minimap_scanlines");
	precacheShader("ui_cursor");
	///////////////////////////FXs//////////////////////////////////////
	level.bloodfx = loadfx("impacts/flesh_hit_body_fatal_exit");
         	level.molotovfx = loadfx ("explosions/helicopter_explosion_secondary_small");
	level.greenlightfx = loadFX( "misc/aircraft_light_wingtip_green" );
	level.redlightfx = loadFX( "misc/aircraft_light_wingtip_red" );
	//////////////////////////Model///////////////////////////////////
	precacheModel("police_barrier_01_dlc2");
              precacheModel("foliage_cod5_tallgrass10b");
	precacheModel("weapon_saw_mg_setup");
	/////////////////////////////Maps//////////////////////////////////
	if(getDvar("mapname") == "mp_rust")
	{
		level.cuerpo = "mp_body_opforce_arab_shotgun_a";
		level.vision = "icbm";
		level.reaparicion = (163,-2573,-160);
		level.pared = 1;
		level.lugares = []; 
		level.lugares[0] = (574,-6770,-344); 
		level.lugares[1] = (78,-5980,-330); 
		level.lugares[2] = (-2030,-3078,-80); 
		level.lugares[3] = (-1102,52,-236); 
		level.lugares[4] = (2556,-1781,-172); 
		AmmoMatic((-1276,-1336,-210),(0,0,0));
	}
	if(getDvar("mapname") == "mp_afghan")
	{
		switch(randomInt(2))
		{
		case 0:
			level.cuerpo = "mp_body_opforce_arab_shotgun_a";
			level.edicion = 0;
      			ents = getEntArray();
      			for ( index = 0; index < ents.size; index++ )
      			{
          				if(isSubStr(ents[index].classname, "trigger_hurt"))
          					ents[index].origin = (0, 0, 9999999);
      			}	
			level.reaparicion = (-1962,11034,-1794);
			level.pared = 0;
			level.lugares = []; 
			level.lugares[0] = (1028,12326,-1955); 
			level.lugares[1] = (1101,12428,-1949); 
			level.lugares[2] = (-4092,9770,-1693); 
			level.lugares[3] = (-4110,9868,-1692);
			level.vision = "icbm_launch";
			//CreateMinigun((-1165,11408,-1870),"pavelow_minigun_mp",(0,22,0)); 
			CreateBlock((-1165,11408,-1900),(0,102,0));
			//CreateMinigun((-2617,10639,-1682),"pavelow_minigun_mp",(0,-151,0)); 
			CreateBlock((-2617,10639,-1720),(0,-241,0));
			AmmoMatic((-1882,10951,-1799),(5,30,0));
			//SpeedCola((-1658,11052,-1826),(2,30,0));
		break;

		case 1:
			level.reaparicion = (3798,8017,-2013);
			level.cuerpo = "mp_body_opforce_arab_shotgun_a";
			level.pared = 0;
			level.edicion = 1;
			level.vision = "icbm_launch";
      			ents = getEntArray();
      			for ( index = 0; index < ents.size; index++ )
      			{
          				if(isSubStr(ents[index].classname, "trigger_hurt"))
          					ents[index].origin = (0, 0, 9999999);
      			}
			level.lugares = []; 
			level.lugares[0] = (4443,9310,-2135); 
			level.lugares[1] = (5116,9553,-1928); 
			level.lugares[2] = (5918,9997,-2039); 
			AmmoMatic((3921,8543,-2265),(0,0,0));
		break;
		}
	}
	if(getDvar("mapname") == "mp_derail")
	{
		level.cuerpo = "mp_body_opforce_arctic_shotgun_c";
		level.vision = "cobra_sunset";
		level.reaparicion = (-3347,73,18);
		level.pared = 1;
		level.lugares = []; 
		level.lugares[0] = (-4060,-1681,350); 
		level.lugares[1] = (-5062,-864,396); 
		level.lugares[2] = (-5218,180,581); 
		level.lugares[3] = (-3502,1925,428);
		AmmoMatic((-2493,395,87),(0,0,0));
	}
	if(getDvar("mapname") == "mp_estate")
	{
		level.cuerpo = "mp_body_airborne_shotgun_c";
		level.vision = "icbm_sunrise4";
		level.reaparicion = (1729,3675,28);
		level.pared = 1;
		level.lugares = []; 
		level.lugares[0] = (2027,5098,-65); 
		level.lugares[1] = (1446,5128,-106); 
		level.lugares[2] = (2204,5021,-50); 
		CreateMinigun((1907,3878,73),"pavelow_minigun_mp",(0,71,0)); 
		CreateMinigun((937,4208,146),"pavelow_minigun_mp",(0,49,0)); 
		AmmoMatic((1161,3844,86),(0,0,0));
	}
	if(getDvar("mapname") == "mp_favela")
	{
		level.vision = "cobra_sunset";
	}
	if(getDvar("mapname") == "mp_fuel2")
	{
		level.cuerpo = "mp_body_opforce_arab_shotgun_a";
		level.vision = "cobra_sunset";
		level.reaparicion = (16155,28701,7600);
		level.pared = 1;
		CreateGrids((16288,28905,7202),(16032,28521,7202),(0,0,0));
		level.lugares = []; 
		level.lugares[0] = (10808,28840,9080); 
		level.lugares[1] = (12451,30405,8148); 
		level.lugares[2] = (20410,28816,6913); 
		AmmoMatic((16195,28908,7212),(0,0,0));
	}
	if(getDvar("mapname") == "mp_trailerpark")
	{
		level.cuerpo = "mp_body_opforce_arab_shotgun_a";
		level.vision = "icbm";
		level.reaparicion = (1130,-2105,6);
		level.pared = 0;
		level.lugares = []; 
		level.lugares[0] = (1107,-884,4); 
		level.lugares[1] = (1138,-677,4); 
		level.lugares[2] = (-811,-2080,0); 
		level.lugares[3] = (5731,-2047,24); 
		AmmoMatic((1943,-2922,8),(0,0,0));
		PoliceBarrier((220,-2166,0),(0,90,0));
		PoliceBarrier((220,-2062,0),(0,90,0));
		PoliceBarrier((220,-1946,0),(0,90,0));
		PoliceBarrier((220,-1824,0),(0,90,0));
		PoliceBarrier((2162,-1983,0),(0,90,0));
		PoliceBarrier((2162,-2079,0),(0,90,0));
	}
	if(getDvar("mapname") == "mp_highrise")
	{
		level.cuerpo = "mp_body_airborne_shotgun_c";
		level.vision = "mp_highrise";
		level.pared = 1;
		level.reaparicion = (-6253,-9927,3230);
		level.lugares = []; 
		level.lugares[0] = (-4564,-11731,3200); 
		level.lugares[1] = (-5111,-12297,3200); 
		level.lugares[2] = (-3758,-10999,3200); 
		level.lugares[3] = (-5861,-12190,3200); 
		level.lugares[4] = (-4033,-10430,3200); 
		AmmoMatic((-7492,-10755,3200),(0,225,0));
	}
	if(getDvar("mapname") == "mp_invasion")
	{
		level.cuerpo = "mp_body_opforce_arab_shotgun_a";
		level.vision = "mp_rundown";
		level.reaparicion = (-6096,-2970,512);
		level.pared = 1;
		level.lugares = []; 
		level.lugares[0] = (-4313,-1520,301); 
		level.lugares[1] = (-4557,-766,269); 
		level.lugares[2] = (-4957,602,214); 
		AmmoMatic((-6359,-3457,512),(0,135,0));
	}
	if(getDvar("mapname") == "mp_brecourt")
	{
		level.cuerpo = "mp_body_airborne_shotgun_c";
		level.vision = "mp_brecourt";
		level.pared = 1;
		level.reaparicion = (-3116,-3438,33);
		level.lugares = []; 
		level.lugares[0] = (-1624,-2036,-20); 
		level.lugares[1] = (-561,-3048,32); 
		AmmoMatic((-3345,-2576,32),(0,0,0));
	}
	if(getDvar("mapname") == "mp_rundown")
	{
		level.vision = "cobra_sunset";
		level.reaparicion = (841,2635,64);
		level.cuerpo = "mp_body_militia_smg_aa_blk";
		level.pared = 0;
		level.lugares = []; 
		level.lugares[0] = (505,4089,5); 
		level.lugares[1] = (498,1906,121); 
		Bog((671,2093,100),(0,0,0));
		Bog((615,2094,99),(0,0,0));
		Bog((515,2107,98),(0,0,0));
		Bog((565,2107,98),(0,0,0));
		Bog((598,3844,28),(0,0,0));
		Bog((542,3836,30),(0,0,0));
		Bog((484,3827,30),(0,0,0));
		AmmoMatic((959,2872,64),(0,90,0));
	}
	if(getDvar("mapname") == "mp_subbase")
	{
		level.reaparicion = (-337,-5850,0);
		level.vision = "icbm";
		level.pared = 1;
		level.cuerpo = "mp_body_opforce_arctic_shotgun_c";	
		level.lugares = []; 
		level.lugares[0] = (-265,-3920,0); 
		level.lugares[1] = (-402,-3978,0); 
		AmmoMatic((-305,-6440,0),(0,0,0));
	}
	if(getDvar("mapname") == "mp_underpass")
	{
		level.cuerpo = "mp_body_militia_smg_aa_blk";
		level.pared = 1;
		level thread Relampagos();
		level.reaparicion = (-3158,547,389);
		level.lugares = []; 
		level.lugares[0] = (-1472,812,416); 
		level.lugares[1] = (-1533,517,416); 
		AmmoMatic((-2396,505,384),(0,90,0));
	}
	if(getDvar("mapname") == "mp_compact")
	{
		level.reaparicion = (-3376,305,145);
		level.vision = "icbm";
		level.pared = 1;
		level.cuerpo = "mp_body_opforce_arctic_shotgun_c";	
		level.lugares = []; 
		level.lugares[0] = (-1436,369,114); 
		level.lugares[1] = (-1767,-1141,148); 
		level.lugares[2] = (-739,-2041,275); 
		level.lugares[3] = (-2426,-2202,144); 
		level.lugares[4] = (-1530,3682,406); 
		AmmoMatic((-3205,-312,146),(0,90,0));
	}
	if(getDvar("mapname") == "mp_overgrown")
	{
		level.reaparicion = (17,2553,-93);
		level.vision = "icbm";
		level.pared = 1;
		level.cuerpo = "mp_body_airborne_shotgun_c";	
		level.lugares = []; 
		level.lugares[0] = (200,1000,-153); 
		level.lugares[1] = (-382,948,-113); 
		AmmoMatic((-316,3039,-43),(0,90,0));
	}
	if(getDvar("mapname") == "mp_abandon")
	{
		level.reaparicion = (-2573,3015,-7);
		level.vision = "cobra_sunset2";
		level.pared = 1;
		level.cuerpo = "mp_body_militia_smg_aa_blk";	
		level.lugares = []; 
		level.lugares[0] = (-2159,1543,-7); 
		level.lugares[1] = (-699,1930,-7); 
		AmmoMatic((-1897,3746,-7),(0,90,0));
	}
	if(getDvar("mapname") == "mp_boneyard")
	{
		level.reaparicion = (38,-1022,-139);
		level.vision = "cobra_sunset2";
		level.pared = 1;
		level.cuerpo = "mp_body_opforce_arab_shotgun_a";	
		level.lugares = []; 
		level.lugares[0] = (1184,-1984,-67); 
		level.lugares[1] = (1127,-3728,-100); 
		level.lugares[2] = (-899,-2820,-21); 
		AmmoMatic((-161,-1710,-130),(0,90,0));
	}
}

Empezar()
{
	level.contador = createServerFontString( "objective", 1.7, "allies" );
	level.contador setPoint("","",0,-190);
	level.contador.color = (1,0,0.4);
	level.contadort = 30;
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
			level thread MeterZombies(level.ztotal[level.ola],100);
		break;

		case 2:
			level.ztotal[level.ola] = 15;
			level thread MeterZombies(level.ztotal[level.ola],150);
		break;

		case 3:
			level.ztotal[level.ola] = 25;
			level thread MeterZombies(level.ztotal[level.ola],200);
		break;

		case 4:
			level.ztotal[level.ola] = 35;
			level thread MeterZombies(level.ztotal[level.ola],250);
		break;

		case 5:
			level.ztotal[level.ola] = 45;
			level thread MeterZombies(level.ztotal[level.ola],300);
		break;

		case 6:
			level.ztotal[level.ola] = 55;
			level thread MeterZombies(level.ztotal[level.ola],300);
		break;

		case 7:
			level.ztotal[level.ola] = 60;
			level thread MeterZombies(level.ztotal[level.ola],400);
		break;

		case 8:
			level.ztotal[level.ola] = 65;
			level thread MeterZombies(level.ztotal[level.ola],450);
		break;

		case 9:
			level.ztotal[level.ola] = 75;
			level thread MeterZombies(level.ztotal[level.ola],500);
		break;

		case 10:
			level.ztotal[level.ola] = 75;
			level thread MeterZombies(level.ztotal[level.ola],550);
		break;

		case 11:
			level.ztotal[level.ola] = 60;
			level thread MeterZombies(level.ztotal[level.ola],600);
		break;

		case 12:
			level.ztotal[level.ola] = 70;
			level thread MeterZombies(level.ztotal[level.ola],650);
		break;

		case 13:
			level.ztotal[level.ola] = 75;
			level thread MeterZombies(level.ztotal[level.ola],800);
		break;

		case 14:
			level.ztotal[level.ola] = 1;
			level thread MeterZombies(level.ztotal[level.ola],50000);
		break;

		case 15:
		break;
	}
}

MeterZombies(numero,vidaola)
{
	for(i=0;i<numero;i++)
	{
		level.zombis[i] = spawn("script_model", level.lugares[RandomInt(level.lugares.size)]+(randomInt(100),randomInt(100),0));
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
		delante = self.origin + (0, 0, 25) + maps\mp\_functions::vector_scal(anglestoforward(angulos), 25);
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
			delante = self.origin + (0, 0, 25) + maps\mp\_functions::vector_scal(anglestoforward(self.angles), 25);
			final = bullettrace(delante, delante + (0, 0, -200), false, self);
			self moveto(final["position"],self.velocidad);
		}
	wait 0.08;
	}

}

Velocidades(i)
{
	switch(randomInt(9))
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
              		self startRagDoll(1);
			attacker thread maps\mp\gametypes\_rank::scorePopup( 100, 0, (1,0,0), 1 );
			self playSound( self.sonido );
			wait 0.5;
			self delete();
			self.vida delete();
			attacker.kills++;
			attacker.dinero += 100;
			attacker.pers["kills"] = attacker.kills;
			attacker.score += 100;
			attacker.pers["score"] = attacker.score;
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
			if(distancesquared(jugador.origin, self.origin) <= 860)
			{
				self ScriptModelPlayAnim("pt_melee_right2right_1");
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
		if(maps\mp\_functions::Zombiesconvida() <= 0)
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
		player thread maps\mp\_survivors::DestruirTodoelHUD();
	        	player.scorebartop = self createRectangle("", "", 0, -190, 800, 22, "minimap_scanlines", (0,1,0.6), 1, 1);
		player.hostname = player createFontString("hudmedium", 1.4);
		player.hostname setPoint("BOTTOMLEFT", "BOTTOMLEFT", 85, -25);
		player.hostname setText( level.hostname );
		player waittill("hideHost");
		player.hostname destroy();
		player.scorebartop destroy();
		player thread maps\mp\_survivors::Pantalla();
	}
}
