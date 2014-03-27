#include maps\mp\_utility;
#include common_scripts\utility;

////////////////////////////////////////////////
////////////////////////////////////////////////
//////////////AGM Missile///////////////
/////////////by 4FunPlayin//////////////
///////////////////////////////////////////////

init()
{
	mapname = getDvar( "mapname" );
	if ( mapname == "mp_suburbia" )
	{
		level.missileRemoteLaunchVert = 7000;
		level.missileRemoteLaunchHorz = 10000;
		level.missileRemoteLaunchTargetDist = 2000;
	}
	else if ( mapname == "mp_mainstreet" )
	{
		level.missileRemoteLaunchVert = 7000;
		level.missileRemoteLaunchHorz = 10000;
		level.missileRemoteLaunchTargetDist = 2000;
	}
	else
	{
		level.missileRemoteLaunchVert = 14000;
		level.missileRemoteLaunchHorz = 7000;
		level.missileRemoteLaunchTargetDist = 1500;

	}	
	precacheItem( "remotemissile_projectile_mp" );
	precacheShader( "ac130_overlay_grain" );
	
	level.rockets = [];
	
	level.killstreakFuncs["predator_missile"] = ::tryUsePredatorMissile;
	
	level.missilesForSightTraces = [];
}


tryUsePredatorMissile( lifeId )
{
	self thread spawnUAVForAGM();
	return true;
}

drawLine( start, end, timeSlice, color )
{
	drawTime = int(timeSlice * 20);
	for( time = 0; time < drawTime; time++ )
	{
		line( start, end, color,false, 1 );
		wait ( 0.05 );
	}
}

/#
_fire_noplayer( lifeId, player )
{
	upVector = (0, 0, level.missileRemoteLaunchVert );
	backDist = level.missileRemoteLaunchHorz;
	targetDist = level.missileRemoteLaunchTargetDist;

	forward = AnglesToForward( player.angles );
	startpos = player.origin + upVector + forward * backDist * -1;
	targetPos = player.origin + forward * targetDist;
	
	rocket = MagicBullet( "remotemissile_projectile_mp", startpos, targetPos, player );

	if ( !IsDefined( rocket ) )
		return;

	rocket thread handleDamage();
	
	rocket.lifeId = lifeId;
	rocket.type = "remote";
	
	player CameraLinkTo( rocket, "tag_origin" );
	player ControlsLinkTo( rocket );

	rocket thread Rocket_CleanupOnDeath();

	wait ( 2.0 );

	player ControlsUnlink();
	player CameraUnlink();	
}
#/

handleDamage()
{
	self endon ( "death" );
	self endon ( "deleted" );

	self setCanDamage( true );

	for ( ;; )
	{
	  self waittill( "damage" );
	  
	  println ( "projectile damaged!" );
	}
}	


MissileEyes( player, rocket )
{
	//level endon ( "game_ended" );
	player endon ( "joined_team" );
	player endon ( "joined_spectators" );

	rocket thread Rocket_CleanupOnDeath();
	player thread Player_CleanupOnGameEnded( rocket );
	player thread Player_CleanupOnTeamChange( rocket );
	
	player VisionSetMissilecamForPlayer( "black_bw", 0 );

	player endon ( "disconnect" );

	if ( isDefined( rocket ) )
	{
		player VisionSetMissilecamForPlayer( game["thermal_vision"], 1.0 );
		player thread delayedFOFOverlay();
		player CameraLinkTo( rocket, "tag_origin" );
		player ControlsLinkTo( rocket );

		if ( getDvarInt( "camera_thirdPerson" ) )
			player setThirdPersonDOF( false );
	
		rocket waittill( "death" );

		// is defined check required because remote missile doesnt handle lifetime explosion gracefully
		// instantly deletes its self after an explode and death notify
		if ( isDefined(rocket) )
			player maps\mp\_matchdata::logKillstreakEvent( "predator_missile", rocket.origin );
		
		player ControlsUnlink();
		player freezeControlsWrapper( true );
	
		// If a player gets the final kill with a hellfire, level.gameEnded will already be true at this point
		if ( !level.gameEnded || isDefined( player.finalKill ) )
			player thread staticEffect( 0.5 );

		wait ( 0.5 );
		
		player ThermalVisionFOFOverlayOff();
		
		player CameraUnlink();
		
		if ( getDvarInt( "camera_thirdPerson" ) )
			player setThirdPersonDOF( true );
		
	}
	
	player clearUsingRemote();
}


delayedFOFOverlay()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	level endon ( "game_ended" );
	
	wait ( 0.15 );
	
	self ThermalVisionFOFOverlayOn();
}

staticEffect( duration )
{
	self endon ( "disconnect" );
	
	staticBG = newClientHudElem( self );
	staticBG.horzAlign = "fullscreen";
	staticBG.vertAlign = "fullscreen";
	staticBG setShader( "white", 640, 480 );
	staticBG.archive = true;
	staticBG.sort = 10;

	static = newClientHudElem( self );
	static.horzAlign = "fullscreen";
	static.vertAlign = "fullscreen";
	static setShader( "ac130_overlay_grain", 640, 480 );
	static.archive = true;
	static.sort = 20;
	
	wait ( duration );
	
	static destroy();
	staticBG destroy();
}


Player_CleanupOnTeamChange( rocket )
{
	rocket endon ( "death" );
	self endon ( "disconnect" );

	self waittill_any( "joined_team" , "joined_spectators" );

	if ( self.team != "spectator" )
	{
		self ThermalVisionFOFOverlayOff();
		self ControlsUnlink();
		self CameraUnlink();	

		if ( getDvarInt( "camera_thirdPerson" ) )
			self setThirdPersonDOF( true );
	}
	self clearUsingRemote();
	
	level.remoteMissileInProgress = undefined;
}


Rocket_CleanupOnDeath()
{
	entityNumber = self getEntityNumber();
	level.rockets[ entityNumber ] = self;
	self waittill( "death" );	
	
	level.rockets[ entityNumber ] = undefined;
}


Player_CleanupOnGameEnded( rocket )
{
	rocket endon ( "death" );
	self endon ( "death" );
	
	level waittill ( "game_ended" );
	
	self ThermalVisionFOFOverlayOff();
	self ControlsUnlink();
	self CameraUnlink();	

	if ( getDvarInt( "camera_thirdPerson" ) )
		self setThirdPersonDOF( true );
}

dudemovealready()
{
    while(1)
	{
                            self moveTo(self.origin+(0, 80000, 0), 230);
		wait 20;
		self rotateyaw( 90, 10 );
		self moveTo(self.origin-(80000, 0, 0), 230);
		wait 20;
		self rotateyaw( 90, 10 );
		self moveTo(self.origin-(0, 80000, 0), 230);
		wait 20;
		self rotateyaw( 90, 10 );
		self moveTo(self.origin+(80000, 0, 0), 230);
		wait 20;
		self rotateyaw( 90, 10 );
	}
}

returnToNormal()
{
              self unlink();
              self show();
	self setOrigin(self.oldOrigin);
	self ThermalVisionFOFOverlayOff();
	self ThermalVisionOff();
	self setClientDvar("cg_gun_x", 0); //invisible gun
	self setOrigin(self.oldOrigin);
	self freezeControls(false);
}

spawnUAVForAGM()
{
               self endon("agm_hit");
	self endon("disconnect");
              self notifyOnPlayerCommand( "fiy", "+attack" );
	
	self giveweapon("killstreak_ac130_mp");
	wait 0.2;
              self switchToWeapon("killstreak_ac130_mp");
	
	wait 2;
	
	uavwithagm = spawn("script_model", self.origin+(7000, -3000, 5500) );
	uavwithagm setModel( "vehicle_uav_static_mp" );
	uavwithagm Solid();
	uavwithagm.angles = (0, 90, 315);
	uavwithagm thread dudemovealready();
	uavwithagm.health = 600; //in case of miss xP
	
	self.OldOrigin = self.origin;
	
	wait 0.3; //let it rest.. lols
	
	self PlayerLinkTo( uavwithagm, "tag_origin", 0.5, 0, 180, 0, 45);
	wait 0.1; //0.1 isn't really useful..
	self hide();//hides the shit ass you 
	self ThermalVisionFOFOverlayOn();
	self ThermalVisionOn();
	self setClientDvar("cg_gun_x", -50); //invisible gun
	wait 0.3;
	
	self waittill("fiy");
	firing = GetCursorPos();
	missile = MagicBullet("remotemissile_projectile_mp", uavwithagm.origin, firing, self);
	missile.angles = self getPlayerAngles();
	
	maps\mp\killstreaks\_remotemissile::MissileEyes( self, missile );
	
	wait 1;
	self ThermalVisionFOFOverlayOn();
	self giveweapon("killstreak_ac130_mp");
	wait 0.2;
              self switchToWeapon("killstreak_ac130_mp");
	
	self waittill("fiy");
	firing = GetCursorPos();
	missile = MagicBullet("remotemissile_projectile_mp", uavwithagm.origin, firing, self);
	missile.angles = self getPlayerAngles();
	
	maps\mp\killstreaks\_remotemissile::MissileEyes( self, missile );
	wait 1;
	self ThermalVisionFOFOverlayOn();
	self giveweapon("killstreak_ac130_mp");
	wait 0.2;
              self switchToWeapon("killstreak_ac130_mp");
	
	self waittill("fiy");
	firing = GetCursorPos();
	missile = MagicBullet("remotemissile_projectile_mp", uavwithagm.origin, firing, self);
	missile.angles = self getPlayerAngles();
	
	maps\mp\killstreaks\_remotemissile::MissileEyes( self, missile );
	
	self returnToNormal();
	
	uavwithagm delete();
}


GetCursorPos()
{
	forward = self getTagOrigin("tag_eye");
	end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
	location = BulletTrace( forward, end, 0, self)[ "position" ];
	return location;
}

vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}
