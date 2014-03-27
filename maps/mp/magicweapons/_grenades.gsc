#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_functions;
#include maps\mp\gametypes\_hud_util;

///////////////////////////////////////////////////////
//////////////////////////////////////////////////////
/////////////Custom Grenades//////////////
/////////////////////////////////////////////////////

GranadasMagicas()
{
	self giveWeapon("concussion_grenade_mp",0,false);
	self DisableGrenadeTouchDamage();
       	while(1)
        	{
        		self waittill("grenade_fire", grenade, weaponName);
		if(weaponName == "frag_grenade_mp") //OMA Grenade
		{
        			grenade hide();
        			granadacool = spawn("script_model", grenade.origin);
        			granadacool SetModel("weapon_oma_pack");
			granadacool linkTo( grenade );
			wait 4.5;
			self thread Boom(granadacool);
		}
		if(weaponName == "smoke_grenade_mp") //Nova Gas
		{
			maquinador = spawn("script_model", grenade.origin);
			maquinador setModel("projectile_us_smoke_grenade");
			maquinador Linkto(grenade);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			RadiusDamage(maquinador.origin,300,100,50,self);
			wait 1;
			maquinador delete();
		}
		if(weaponName == "flash_grenade_mp") //Decoy Grenade by Master131
		{
			loc = GetCursorPos();
			num = 0;
			
			self thread getWeapons();
			wait 1;
			foreach(player in level.players)
				player thread stopFlash();
				
			wait 0.5;
			while(1)
			{
				num++;
				if(num == 196)
					break;
				if(num != 32 || 64 || 96 || 128 || 160)
				{
					MagicBullet( level.primary[self.randprimary] + "_mp", loc+(0,0,1), loc, self );
					wait(RandomFloat(0.1));
				}
				else
					wait 5;
			}
		}
		if(weaponName == "concussion_grenade_mp") //Molotov Coctail
		{
        			grenade hide();
        			molotov = spawn("script_model", grenade.origin);
        			molotov SetModel("projectile_concussion_grenade");
			molotov linkTo( grenade );
			wait 1;
			self thread Fuego(molotov);
		}
	}
}

Boom(granadacool)
{
	RadiusDamage(granadacool.origin,400,150,75,self);
	granadacool delete();
}

Fuego(molotov)
{
           	playfx(level.molotovfx, molotov.origin);
	RadiusDamage(molotov.origin,50,150,75,self);
	molotov delete();
}

stopFlash()
{
	temp = 0;
	self endon("death");
	self endon("disconnect");
	while(1)
	{
		temp++;
		self stopShellShock();
		if(temp == 10)
			break;
		wait 0.1;
	}
}

getWeapons()
{
	level.primary = [];
	level.primary[0] = "ak47";
	level.primary[1] = "m16";
	level.primary[2] = "famas";
	level.primary[3] = "fal";
	level.primary[4] = "aug";
	level.primary[5] = "mp5k";
	level.primary[6] = "uzi";
	
	self.randprimary = randomInt(6);
	
	level.secondary[0] = "model1887";
	level.secondary[1] = "spas12";
	level.secondary[2] = "coltanaconda";
	
	self.randsec = randomInt(2);
	
	level.specsec[0] = "rpd_acog_silencer_mp";
	level.specsec[1] = "ump45_rof_silencer_mp";
	level.specsec[2] = "m79_mp";
	
	self.randspec = randomInt(2);
}
		