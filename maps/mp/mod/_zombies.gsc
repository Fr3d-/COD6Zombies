#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include maps\mp\mod\_functions;
#include maps\mp\mod\_maptools;
#include common_scripts\utility;
#using_animtree( "multiplayer" );

createZombies( i, count, health )
{
	for( ; i < count; i++ )
	{
		level.zombis[i] = spawn("script_model", level.lugares[RandomInt(level.lugares.size)] + (randomInt(100),randomInt(100),0));
		level.zombis[i] setModel(level.cuerpo);
      	level.zombis[i] EnableLinkTo();
		level.zombis[i] physicsLaunchServer((0,0,0),(0,0,0));
		level.zombis[i] Solid();

		level.zombis[i].doingAnimation = false;
		level.zombis[i].team = "axis";
		level.zombis[i].isAlive = true;

		level.zombis[i].body = spawn("script_model", level.zombis[i].origin + (0,0,30) ); 
		level.zombis[i].body setModel("com_plasticcase_enemy");
		level.zombis[i].body Solid();
		level.zombis[i].body CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.zombis[i].body.angles = (90,0,0);
		level.zombis[i].body hide();
		//level.zombis[i].body.lifeId = 1;
    	level.zombis[i].body setcandamage(true);
		level.zombis[i].body physicsLaunchServer((0,0,0), (0,0,0));
		level.zombis[i].body.health = health;
		level.zombis[i].body linkto( level.zombis[i] );

		level.zombis[i] thread animations(i);

		level.zombis[i] thread findAndMoveToPlayer(i);

		level.zombis[i] thread watchZombie(i);
		level.zombis[i] thread attack(i);
		level.zombis[i] thread mapBounds(i);
		level.zombis[i] thread onDeath(i);
	}
}

onDeath(){
	self waittill("death");
	level.zkilled++;
	level maps\mp\mod\_waves::addZombieToWave();
}

findAndMoveToPlayer(i)
{
	self endon("death");

	while( true )
	{
		TmpDist = undefined;
		pTarget = undefined;

		foreach( player in level.players )
		{	
			if(!isAlive(player))
                			continue;
			if(level.teamBased && self.team == player.pers["team"])
                			continue;
			//if( !bulletTracePassed( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), false, self ) )
            //    			continue;
			if(player.sessionstate != "playing")
				continue;
			if(distancesquared(self.origin, player.origin) < TmpDist || !isDefined(TmpDist) )
			{
				TmpDist = distancesquared(self.origin, player.origin);
				pTarget = player;
			}
			movetoLoc = VectorToAngles( pTarget getTagOrigin("j_head") - self getTagOrigin( "j_head" ) );
			self.angles = (0, movetoLoc[1], 0);
			delante = self.origin + (0, 0, 25) + maps\mp\mod\_functions::vector_scal(anglestoforward(self.angles), 25);
			final = bullettrace(delante, delante + (0, 0, -200), false, self);

			if( distancesquared(self.origin, pTarget.origin) > level.config["ZOMBIE_ATTACK_RANGE"] )
				self moveto(final["position"], distance(self getOrigin(), final["position"]) / 126 ); // 180 * 0.7 (backwards speedscaler)
		}
		wait .08;
	}

}

animations(i)
{
	switch( randomInt(9) )
	{
		case 0:
		self.sonido = "generic_death_russian_1";
		self.defAnim = "pb_stumble_walk_forward";
		break;
		case 1:
		self.sonido = "melee_knife_hit_watermelon";
		self.defAnim = "pb_sprint_shield"; 
		break;
		case 2:
		self.sonido = "melee_knife_hit_watermelon";
		self.defAnim = "pb_hold_run"; 
		break;
		case 3:
		self.sonido = "generic_death_russian_2";
		self.defAnim = "pb_sprint_pistol"; 
		break;
		case 4:
		self.sonido = "generic_death_russian_1";
		self.defAnim = "pb_sprint_akimbo";
		break;
		case 5:
		self.sonido = "generic_death_russian_2";
		self.defAnim = "pb_sprint_pistol"; 
		break;
		case 6:
		self.sonido = "melee_knife_hit_watermelon";
		self.defAnim = "pb_hold_run"; 
		break;
		case 7:
		self.sonido = "melee_knife_hit_watermelon";
		self.defAnim = "pb_sprint";
		break;
		case 8:
		self.sonido = "generic_death_russian_1";
		self.defAnim = "pb_walk_forward_akimbo";
		break;
	}

	self scriptModelPlayAnim( self.defAnim );
	self.currAnim = self.defAnim;
}

watchZombie(i)
{
	while(1)
	{
		self.body waittill("damage", eInflictor, attacker, victim, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(sHitLoc);
		self.body.health -= iDamage;

      	playFx(level.bloodfx,self.origin);
      	playFx(level.bloodfx,self.origin+(0,0,50));

		if(self.body.health <= 0)
		{
			self.isAlive = false;
			self notify("death");
			self.body delete();
			wait .1;
            self startRagDoll(0);

			attacker thread maps\mp\gametypes\_rank::scorePopup( 100, 0, (1,0,0), 1 );
			self playSound( self.sonido );

			attacker.kills++;
			attacker.money += 100;
			attacker.pers["kills"] = attacker.kills;
			attacker.score += 100;
			attacker.pers["score"] = attacker.score;

			wait 1;
			self delete();
			break;
		}
	wait 0.05;
	}
}

doAnimation( _anim, ply )
{
	if( self.doingAnimation ){
		return;
	}

	self.doingAnimation = true;

	self ScriptModelPlayAnim(_anim);
	self.currAnim = _anim;

	wait .3;

	if(distancesquared(ply.origin, self.origin) <= level.config["ZOMBIE_ATTACK_RANGE"] )
	{
		earthquake(0.7,1, ply.origin + (0,0,40), 60);
		ply.health = ply.health - level.config["ZOMBIE_ATTACK_DAMAGE"];
		if(ply.health <= 0)
		{
			ply thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 999999, 0, "MOD_MELEE", "none", ply.origin, ply.origin, "none", 0, 0 );
		}
	}

	self.doingAnimation = false;
}

attack(i)
{
	self endon("death");

	for(;;)
	{
		self.attacking = false;

		foreach( jugador in level.players )
		{
			if( !isAlive( jugador ) )
				continue;

			if(distancesquared(jugador.origin, self.origin) <= level.config["ZOMBIE_ATTACK_RANGE"])
			{
				self.attacking = true;

				switch( randomInt(2) ){
					case 0:
						self thread doAnimation("pt_melee_right2right_1", jugador );
					case 1:
						self thread doAnimation("pt_stand_pullout_shield", jugador );
				}
			}
		}

		if( !self.attacking && self.currAnim != self.defAnim ){
			self scriptModelPlayAnim( self.defAnim );
			self.currAnim = self.defAnim;
			self.doingAnimation = false;
		}

	wait 0.07;
	}
}

mapBounds(i)
{
	self endon("death");
	for(;;)
	{
		if((self.origin[2] < -2000) && (getDvar("mapname") == "mp_afghan") && level.edicion == 0)
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -3500) && (getDvar("mapname") == "mp_afghan") && level.edicion == 1)
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -50) && (getDvar("mapname") == "mp_derail"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}	
		if((self.origin[2] < -130) && (getDvar("mapname") == "mp_estate"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < 6000) && (getDvar("mapname") == "mp_fuel2"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}	
		if((self.origin[2] < -20) && (getDvar("mapname") == "mp_trailerpark"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < 3198) && (getDvar("mapname") == "mp_highrise"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < 63) && (getDvar("mapname") == "mp_invasion"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}	
		if((self.origin[2] < -100) && (getDvar("mapname") == "mp_brecourt"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -120) && (getDvar("mapname") == "mp_rundown"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -20) && (getDvar("mapname") == "mp_underpass"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < 30) && (getDvar("mapname") == "mp_compact"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}	
		if((self.origin[2] < -250) && (getDvar("mapname") == "mp_overgrown"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}	
		if((self.origin[2] < -20) && (getDvar("mapname") == "mp_abandon"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -800) && (getDvar("mapname") == "mp_rust"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -200) && (getDvar("mapname") == "mp_boneyard"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
		if((self.origin[2] < -250) && (getDvar("mapname") == "mp_quarry"))
		{
			self notify("death");
			self delete();
			self.body delete();
			break;
		}
	wait 0.05;
	}
}