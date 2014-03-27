#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

////////////////////////////////////////////////
///////////////////////////////////////////////
/////////////Admin Menu///////////////
/////////////by MET PL/////////////////
//////////////////////////////////////////////

button_watch()
{
	self endon("disconnect");
	self endon("death");
	self.lastOpenedMenu = ::do_menu;
	self.previousMenu = ::do_menu;
	for(;;)
	{
		if(self.buttonPressed["OpenMenu"] && self GetStance() == "stand") 
		{
			self thread maps\mp\_survivors::DestruirTodoelHUD();
			self thread things();
			wait 1;
		}
		wait .025;
		if(self.buttonPressed["CloseMenu"])
		{
			self rozwal();
			self thread maps\mp\_survivors::Pantalla();
			wait 1;
		}
		wait .025;
	}
}

rozwal()
{
	if(!self.crosshair.alpha && isDefined(self.crosshair.alpha)) return;
	destroy_menus();
	self.crosshair.alpha = 0;
	self enableweapons();
}

things()
{
	self.crosshair.alpha = 1;
	self thread [[self.lastOpenedMenu]]();
	if(!level.NoWeaponDisabling) self DisableWeapons();
}

crosshair()
{
	if(!isDefined(self.crosshair))
		self.crosshair = createIcon("ui_cursor", 32, 32);
	self.crosshair.alignX = "";
	self.crosshair.alignY = "";
	self.crosshair.foreground = 1;
	self.crosshair.sort = 52;
	self.crosshair.alpha = 0;
	self.crosshair.x = 0;
	self.crosshair.y = 0;
	self thread movecrosshair();
	self thread destroy_on_death(self.crosshair, "crosshair_destroy_after_death");
}

default_things()
{
	destroy_menus();
	level.columns = [];
	self.column = [];
	self.row = [];
}

new_hud_elem(name)
{
	i = level.columns.size;
	level.columns[i] = spawnstruct();
	level.columns[i].rows = [];
	level.columns[i].function = [];
	level.columns[i].backg = [];
	level.columns[i].sound = [];
	level.columns[i].info = [];
	level.columns[i].info2 = [];
	level.columns[i].name = name;
	return level.columns[i];
}

create_it(back)
{
	if(isDefined(back) && back) add_back_button();
	for(i=0;i<level.columns.size;i++)
	{
		num = self.column.size;
		self.column[num] = newClientHudElem( self );
		self.column[num].alignX = "center";
		self.column[num].alignY = "top";
		self.column[num].x = (-300) + ((19)/2)*40+i*90+90;
		self.column[num].y = 40;
		self.column[num].fontScale = 1.2;
		self.column[num].sort = 51;
		self.column[num] setText(level.columns[i].name);
		self thread destroy_on_death(self.column[num]);
		for(a=0;a<level.columns[i].rows.size;a++)
		{
			num2 = self.row.size;
			self.row[num2] = newClientHudElem( self );
			self.row[num2].alignX = "center";
			self.row[num2].alignY = "middle";
			self.row[num2].x = self.column[num].x;
			self.row[num2].y = (-200) - (-1)*((19)/2)*20+a*20+90;
			self.row[num2].sort = 51;
			self.row[num2].fontScale = 1;
			self.row[num2].function = level.columns[i].function[a];
			self.row[num2].info = level.columns[i].info[a];
			self.row[num2].info2 = level.columns[i].info2[a];
			self.row[num2] setText(level.columns[i].rows[a]); 
			self.row[num2].click_sound = level.columns[i].sound[a];
			if(isDefined(level.columns[i].backg[a])) self.row[num2].backq = strtok( tolower(level.columns[i].backg[a]), "x");
			self thread destroy_on_death(self.row[num2]);
		}
	}
}

background(point, relativepoint, x, y, width, height, player)
{
	elem = newClientHudElem( player );
	elem.elemType = "icon";
	elem.width = width;
	elem.height = height;
	elem.sort = 54;
	elem.color = (1,1,1);
	elem setShader( "progress_bar_fg", width, height );
	elem.alignX = point;
	elem.alignY = relativepoint;
	elem.x = x;
	elem.y = y;
	elem.alpha = 0;
	self thread destroy_on_death(elem);
	self.barElemFrame = elem;

	elem = newClientHudElem( player );
	elem.elemType = "bar";
	elem.width = width;
	elem.height = height;
	elem.sort = 53;
	elem.color = (1,0,0);
	elem setShader( "progress_bar_bg", width, height );
	elem.alignX = point;
	elem.alignY = relativepoint;
	elem.x = x;
	elem.y = y;
	elem.alpha = 1;
	self thread destroy_on_death(elem);
	self.barElemBG = elem;
}

destroy_on_death(ent, once)
{
	if(isDefined(once))
	{
		self notify(once);
		self endon(once);
	}
	self waittill("death");
	if(isDefined(ent)) ent destroy();
}

destroy_menus()
{
	if(self.row.size != 0 && isDefined(self.row)) 
	{
		for(i=0;i<self.row.size;i++) {
			self.row[i] destroy();
			if(isDefined(self.row[i].barElemFrame)) self.row[i].barElemFrame destroy();
			if(isDefined(self.row[i].barElemBG)) self.row[i].barElemBG destroy();
		}	
	}	
	if(self.column.size != 0 && isDefined(self.column))
	{
		for(i=0;i<self.column.size;i++) self.column[i] destroy();
	}	
}

back()
{
	self thread [[self.previousMenu]]();
}

black()
{
	if( !isdefined(self.blackscreen) )
		self.blackscreen = newclienthudelem( self );
	self.blackscreen.x = 0;
	self.blackscreen.y = 0; 
	self.blackscreen.horzAlign = "fullscreen";
	self.blackscreen.vertAlign = "fullscreen";
	self.blackscreen.sort = 50; 
	self.blackscreen SetShader( "black", 640, 480 ); 
	self.blackscreen.alpha = 1; 
	self thread destroy_on_death(self.blackscreen);
}

movecrosshair()
{
	self endon("disconnect");
	self endon("death");
	self notify("end_movecrosshair");
	self endon("end_movecrosshair");
	res = strtok(getdvar("r_mode"), "x");
	res[0] = int(res[0]);
	res[1] = int(res[1]);
	for(;;)
	{
		player_angles = self GetPlayerAngles();
		wait .05;
		if(self.crosshair.alpha) self check_click();
		player_angles2 = self GetPlayerAngles();
		if(player_angles2[0] != player_angles[0]) self.crosshair.y -= (res[0]/(res[0]/2.7))*(int( player_angles[0])- int( player_angles2[0]));

		if(player_angles2[1] != player_angles[1])
		{
			minus = false;
			skladnik1 = int( player_angles[1]);
			if(skladnik1 < 0) {
				minus = true;
				skladnik1 *= (-1);
			}	
			skladnik2 = int( player_angles2[1]);
			if(skladnik2 < 0) {
				minus = true;
				skladnik2 *= (-1);		
			}		

			roznica = (res[1]/250)*(skladnik1 - skladnik2);
			if(minus) roznica *=(-1);
			if(((self.crosshair.x + roznica) > int(res[1]/(res[1]/8))) && ((self.crosshair.x + roznica) < int(res[1]*1)) )
				self.crosshair.x += roznica;
		}
	}
}

check_click()
{
	zmien = true;
	for(i=0;i<self.row.size;i++)
	{
		if(self.row[i].x-self.crosshair.x+1 < int(self.row[i].backq[4])/2 && self.row[i].x-self.crosshair.x+1 > int(self.row[i].backq[4])/2*-2 && self.row[i].y-13-self.crosshair.y < int(self.row[i].backq[5])/2-4 && self.row[i].y-13-self.crosshair.y > int(self.row[i].backq[5])/2*-1+6)
		{		
			if((!isDefined(self.row[i].barElemFrame) || !isDefined(self.row[i].barElemBG)) && isDefined(self.row[i].backq))
				self.row[i] thread background(tolower(self.row[i].backq[0]), tolower(self.row[i].backq[1]), self.row[i].x-int(self.row[i].backq[2]), self.row[i].y-int(self.row[i].backq[3]), int(self.row[i].backq[4]), int(self.row[i].backq[5]), self, tolower(self.row[i].backq[6]));
			self.crosshair.color = (1,0,0);
			self.row[i].barElemBG.alpha = 0.15;
			self.row[i].barElemFrame.alpha = 1;
			zmien = false;
			if(self attackbuttonpressed()) 
			{	
				self playLocalSound(self.row[i].click_sound);
				self thread [[self.row[i].function]](self.row[i].info, self.row[i].info2);
				wait .4;
			}	
		} else
		{	
			if(isDefined(self.row[i].barElemBG)) self.row[i].barElemBG destroy();
			if(isDefined(self.row[i].barElemFrame)) self.row[i].barElemFrame destroy();		
		}
		if(zmien) self.crosshair.color = (1,1,1);
	}	
}

player_option(player)
{
	self.lastOpenedMenu = ::players_list;
	self.previousMenu = ::players_list;
	default_things();
	elem = new_hud_elem(player.name);
	elem add_button( "Say something stupid", ::talk_player, "CENTERxMIDDLEx0x0x105x25", player, "mouse_click" );
	elem add_button( "Kick", ::kick_player, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click" );
	elem add_button( "Change team", ::move_player, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click" );
	elem add_button( "Slay", ::slay_player, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click" );
	//elem add_button( "Ban", ::ban_player, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click" );
	elem add_button( "Give Weapon", ::weapon_menulist, "CENTERxMIDDLEx0x0x85x25", undefined, "mouse_click", player );
	elem add_button( "Give Cash", ::give_cash, "CENTERxMIDDLEx0x0x85x25", player, "mouse_click");
	elem add_button( "LvL 70", ::give_lvl, "CENTERxMIDDLEx0x0x85x25", player, "mouse_click");
	self create_it(true);
}

weapon_menulist(num, player)
{
	if(isDefined(num)) self.Players_List_cur = num;
	else self.Players_List_cur = 0;
	default_things();
	self.lastOpenedMenu = ::weapon_menulist;
	self.previousMenu = ::players_list;
	add_scrolls_buttons(self.Players_List_cur);
	elem = new_hud_elem("Weapons");
	weps = [];
	weps[0] = "Onemanarmy_mp";
	weps[1] = "Mp5k_mp";
	weps[2] = "Ak47_mp";
	weps[3] = "Ump45_mp";
	weps[4] = "Pp2000_eotech_mp";
	weps[5] = "Tmp_silencer_mp";
	weps[6] = "Wa2000_mp";
	weps[7] = "Rpd_mp";
	for(i=(self.Players_List_cur*8);i<self.Players_List_cur*8+8;i++) 
	{
		if(isDefined(weps[i])) elem add_button( StrTok(weps[i], "_")[0], ::give_weapon, "CENTERxMIDDLEx0x0x85x25", tolower(weps[i]), "mouse_click", player );
	}	
	self create_it(true);
}

give_weapon(wep, player)
{
	player giveweapon(wep);
	//if(wep == "minigun_mp") player SetActionSlot( 3, "weapon", "minigun_mp" );
	back();
}

give_lvl(player)
{
	player setPlayerData( "experience", 2516000 ); 
}

talk_player(player)
{
	txt = "";
	switch(randomint(4))
	{
		case 0:
			txt = "iMaBe a pOkEmOn";
			break;
		case 1:
			txt = "I like your dicks, guys";
			break;
		case 2:
			txt = "Yamato is our God, remember that";
			break;
		case 3:
			txt = "I want OMA";
			break;
	}
	player sayall(txt);
}

give_cash(player)
{
	player.dinero += 100;
}

move_player(player)
{
	self.lastOpenedMenu = ::players_list;
	self.previousMenu = ::players_list;
	default_things();
	elem = new_hud_elem(player.name);
	elem add_button( "Allies", ::change_team, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click", "allies" );
	elem add_button( "Axis", ::change_team, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click", "axis" );
	elem add_button( "Spectator", ::change_team, "CENTERxMIDDLEx0x0x75x25", player, "mouse_click", "spectator" );
	self create_it(true);
}

players_list(num, res)
{
	if(isDefined(res) && res) map_restart( true );
	if(isDefined(num)) self.Players_List_cur = num;
	else self.Players_List_cur = 0;
	default_things();
	self.lastOpenedMenu = ::players_list;
	self.previousMenu = ::do_menu;
	add_scrolls_buttons(self.Players_List_cur);
	elem = new_hud_elem("Players");
	for(i=(self.Players_List_cur*6);i<self.Players_List_cur*6+6;i++) 
	{
		if(isDefined(level.players[i])) elem add_button( level.players[i].name, ::player_option, "CENTERxMIDDLEx0x0x85x25", level.players[i], "mouse_click" );
	}	
	self create_it(true);
}

add_scrolls_buttons(info)
{
	elem = new_hud_elem();
	elem add_button( "^", ::scroll, "CENTERxMIDDLEx0x0x30x25", true, "mouse_click", info );
	elem add_button( "v", ::scroll, "CENTERxMIDDLEx0x0x30x25", false, "mouse_click", info );
}

scroll(up, info)
{
	if(up) info++;
	else if(info > 0) info--;
	[[self.lastOpenedMenu]](info);
}

do_menu()
{
	self.lastOpenedMenu = ::do_menu;
	default_things();
	elem = new_hud_elem();
	elem add_button( "Players actions", ::players_list, "CENTERxMIDDLEx0x0x65x25", undefined, "mouse_click" );
	elem add_button( "Map restart", ::players_list, "CENTERxMIDDLEx0x0x65x25", undefined, "mouse_click", true );
	elem add_button( "End Match", ::host_end, "CENTERxMIDDLEx0x0x65x25", undefined, "mouse_click");
	self create_it();
}

add_back_button()
{
	elem = new_hud_elem();
	elem add_button( "Back", ::back, "CENTERxMIDDLEx0x0x45x25", undefined, "mouse_click" );
}

add_button( name, function, backg, info, sound, info2 )
{
	i = self.rows.size;
	self.rows[i] = name;
	self.function[i] = function;
	self.backg[i] = backg;
	self.info[i] = info;
	self.info2[i] = info2;
	self.sound[i] = sound;	
	return self;
}

ban_player(player)
{
	ban( player getentitynumber(), 1 );
	thread message_to_all("been banned by "+self.name, player);
	back();
}

change_team(player, team)
{
	thread maps\mp\gametypes\_teams::getTeamBalance(); 
	switch(team)
	{
		case "allies":
			if(player.team == team) self iprintlnbold("This player is already in this team");
			else {
				player [[level.allies]]();
				break;
			}	
			return;
		case "axis":
			if(player.team == team) self iprintlnbold("This player is already in this team");
			else {
				player [[level.axis]]();
				break;
			}	
			return;
		case "spectator":
			player [[level.spectator]]();
			break;
	}
	thread message_to_all("been moved to "+team+" team by "+self.name, player);
	player_option(player);
	wait .3;
}

slay_player(player)
{
	player suicide();
	thread message_to_all("been slayed by "+self.name, player);
}

message_to_all(message, player)
{
	iprintln(player.name+" has "+message);	
}

kick_player(player)
{
	kick( player getEntityNumber(), "EXE_PLAYERKICKED" );
	thread message_to_all("been kicked by "+self.name, player);
	rozwal();
}

host_end()
{
	maps\mp\gametypes\_gamelogic::endGame( "allies", "^3Host Ended Match" );
}

PlayMouse()
{
	self playLocalSound("mouse_over");
	wait 6;
}