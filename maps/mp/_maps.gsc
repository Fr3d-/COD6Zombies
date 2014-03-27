#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_functions;
#include maps\mp\_mapeffects;

init(){
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
		maps\mp\gametypes\_boxes::AmmoMatic((-1276,-1336,-210),(0,0,0));
	}
	if(getDvar("mapname") == "mp_afghan")
	{
		switch( 0 )
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
			maps\mp\gametypes\_boxes::AmmoMatic((-1882,10951,-1799),(5,30,0));
			//SpeedCola((-1658,11052,-1826),(2,30,0));

			maps\mp\gametypes\_boxes::randomCrate((-1224,11249,-1888),(10,20,0));
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
			maps\mp\gametypes\_boxes::AmmoMatic((3921,8543,-2265),(0,0,0));
			maps\mp\gametypes\_boxes::randomCrate((6581,10005,-1841),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-2493,395,87),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((1161,3844,86),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((16195,28908,7212),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((1943,-2922,8),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-7492,-10755,3200),(0,225,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-6359,-3457,512),(0,135,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-3345,-2576,32),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((959,2872,64),(0,90,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-305,-6440,0),(0,0,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-2396,505,384),(0,90,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-3205,-312,146),(0,90,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-316,3039,-43),(0,90,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-1897,3746,-7),(0,90,0));
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
		maps\mp\gametypes\_boxes::AmmoMatic((-161,-1710,-130),(0,90,0));
	}
}