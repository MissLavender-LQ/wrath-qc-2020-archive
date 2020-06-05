.float timer_item_cnt;
.float old_cnt;
.float old_item_cnt;
.float secret;
void() hud_message2_think = { if (self.owner.item_cnt)
	{
		self.item_cnt += self.owner.item_cnt;
		self.owner.item_cnt = 0;
		self.cnt = 20;
	}
	self.old_item_cnt = self.item_cnt;
	self.cnt -= 1;
	self.SendFlags |= 0x2;
	if (self.cnt > 0)
		self.think = hud_message2_think;
	else
		self.think = SUB_Remove;
	self.nextthink = time + 0.1;
};
.float alwaystouchable;

void(entity e) flash_screen_item =
{
	float checked_flash = cvar("saved6");
	if(checked_flash != 1)
		return;
	string flash_command_a = strcat ("bf ",ftos(flash_color_x)," ",ftos(flash_color_y)," ");
	string flash_command_b = strcat (ftos(flash_color_z)," ",ftos(flash_alpha)," ",ftos(flash_fade),"\n");
	string flash_command =  strcat (flash_command_a,flash_command_b);
	stuffcmd (e, flash_command);
}


float() Send_Item2 = { WriteByte(MSG_ENTITY, ENT_HUDMSG2);
	WriteShort(MSG_ENTITY, self.msg);
	WriteShort(MSG_ENTITY, self.item_cnt);
	return TRUE;
};

float() Send_Item = { WriteByte(MSG_ENTITY, ENT_HUDMSG);
	WriteShort(MSG_ENTITY, self.msg);
	return TRUE;
};

void(float mtype, vector org, entity ownr, float item_cntr) Hud_message2 = { local entity HudMessage;
	if(!(ownr.flags & FL_CLIENT))return;if (ownr.classname != "player")return;
	HudMessage = spawn();
	HudMessage.owner = ownr;
	HudMessage.drawonlytoclient = ownr;
	setmodel(HudMessage, "models/misc/null.md3");
	HudMessage.origin = org + '0 0 25';
	HudMessage.movetype = MOVETYPE_NOCLIP;
	HudMessage.msg = mtype;
	HudMessage.item_cnt = item_cntr;
	HudMessage.cnt = 20;
	HudMessage.wrathflags += FL_MESSAGE;
	HudMessage.SendEntity = Send_Item2;
	//	HudMessage.SendFlags |= 0x2;
	HudMessage.SendFlags = -1;
	HudMessage.think = hud_message2_think;
	HudMessage.nextthink = time;
};
.float fullitemtime;
void(float mtype, vector org, entity ownr) Hud_message = { 

	if(!(ownr.flags & FL_CLIENT))return;if (ownr.classname != "player")return;
	ownr.stat_time_hudmessage = 1;
	/*if(mtype == 109)
	{
	if(ownr.time_hudmessage > time)
	return;
	}*/
	ownr.time_hudmessage = time + 2;
	local entity HudMessage;
	HudMessage = spawn();
	HudMessage.classname = "hudmessage";
	HudMessage.drawonlytoclient = ownr;
	setmodel(HudMessage, "models/misc/null.md3");
	HudMessage.origin = org + '0 0 25';
	HudMessage.movetype = MOVETYPE_NOCLIP;
	HudMessage.msg = mtype;
	HudMessage.wrathflags += FL_MESSAGE;
	HudMessage.SendEntity = Send_Item;
	//	HudMessage.SendFlags  = self.SendFlags  + 1;
	HudMessage.SendFlags = -1;
	HudMessage.think = SUB_Remove;
	HudMessage.nextthink = time + 2;
	
};

void() Message_delay =
{
	self.classname = "hudmessage";
	self.SendEntity = Send_Item;
	//	HudMessage.SendFlags  = self.SendFlags  + 1;
	self.SendFlags = -1;
	self.think = SUB_Remove;
	self.nextthink = time + 2;
}	

void(float mtype, vector org, entity ownr) Hud_message_delay = { 

	if(!(ownr.flags & FL_CLIENT))return;if (ownr.classname != "player")return;
	ownr.stat_time_hudmessage = 1;
	ownr.time_hudmessage = time + 2;
	local entity HudMessage;
	HudMessage.wrathflags += FL_MESSAGE;
	HudMessage = spawn();
	HudMessage.classname = "hudmessage_delay";
	HudMessage.drawonlytoclient = ownr;
	setmodel(HudMessage, "models/misc/null.md3");
	HudMessage.origin = org + '0 0 25';
	HudMessage.movetype = MOVETYPE_NOCLIP;
	HudMessage.msg = mtype;
	HudMessage.nextthink = time + 0.5;
	HudMessage.think = Message_delay;
	
};


void() respawn_items = 
{ 
	self.pflags =  self.oldpflags;
	self.touch = self.oldtouch; 
	self.solid = self.oldsolid;
	self.colormod = '1 1 1';
	self.alpha = 1;
	self.think = SUB_Null;
	self.nextthink = time; 
};

void() siframes = { /*if (self.frame >= 16)
		self.frame = 0; 
	self.frame += 1;
	*/

	self.nextthink = time + 0.05;	// items start after other solids
	self.think = siframes;
};

void() twframes = { if (self.frame >= 20)
		self.frame = 0;
	self.frame += 1;
	self.nextthink = time + 0.1;	// items start after other solids
	self.think = twframes;
};
.float rwpn;
void() artifact_drop = { 

	if(self.flags & FL_ONGROUND)
	self.flags -= FL_ONGROUND;
	self.movetype = MOVETYPE_TOSS;
	self.velocity_x = crandom() *10;
	self.velocity_y = crandom() *10;
	self.velocity_z = 50 + random() *70;
}


void()check_item_onfloor =
{
	local vector rintvelocity;
	rintvelocity_x = rint(self.velocity_x);
	rintvelocity_y = rint(self.velocity_y);

	if((rintvelocity_x == 0) && (rintvelocity_y == 0) &&(!(self.flags & FL_ONGROUND)))
	{
	self.movetype = MOVETYPE_TOSS;
	self.velocity_x = crandom() *10;
	self.velocity_y = crandom() *10;
	self.velocity_z = random() *10;
	}

	if((self.flags & FL_ONGROUND) && (self.oldgroundentity == world))	
	self.think = SUB_Null;
	else
	self.think = check_item_onfloor;
	
	self.nextthink = time  + 0.05;
};

void() vel_item = 
{
	self.solid = SOLID_TRIGGER;
	
	local vector rintvelocity;
	rintvelocity_x = rint(self.velocity_x);
	rintvelocity_y = rint(self.velocity_y);

	if((rintvelocity_x == 0) && (rintvelocity_y == 0) &&(!(self.flags & FL_ONGROUND)))
	{
	self.movetype = MOVETYPE_TOSS;
	self.velocity_x = crandom() *10;
	self.velocity_y = crandom() *10;
	self.velocity_z = random() *10;
	}
	
	if((self.flags & FL_ONGROUND) && (self.oldgroundentity == world))	
	self.think = SUB_Null;
	else
	self.think = vel_item;

	self.nextthink = time + 0.05;
};
void() PlaceItem = {

	self.origin_z = self.origin_z + 12;
	self.movetype = MOVETYPE_TOSS;
	if (!droptofloor())
	{
		dprint("Bonus item fell out of level at ");
		dprint(vtos(self.origin));
		dprint("\n");
		remove(self);
		return;
	}
	local float oldz;
	self.solid = SOLID_TRIGGER;
	if (self.rwpn == 1)
	{
		self.modelflags = MF_ROTATE;
	}
	self.velocity = '0 0 0';
	oldz = self.origin_z;
};

void(float ie) StartItem = {

	if(self.classname == "bbox_touch")
	return;
	if (ie == 1)
	{
	}
	else if (ie == 2)
	{
	}
	else if (ie == 3)	//life
	{
		self.scale = 0.5;
		self.pflags = 128 | 1;
	}
	else if (ie == 4)	//armor
	{
		self.style = 0;
		self.pflags = 128 | 1;
	}
	else if (ie == 5)	//artifacts
	{
		self.modelflags = 8;
		self.effects = EF_ADDITIVE;
		self.cnt = 1;
		self.solid = SOLID_TRIGGER;
		self.nextthink = time + 0.2;	// items start after other solids
		self.think = siframes;
		return;
	}
	else if (ie == 6)	//sigil
	{
		self.light_lev = 125;
		self.pflags = 128 | 1;
		self.color = '0.3 1 0.3';
		self.style = 6;
		setsize(self, '-12 -12 -16', '12 12 16');
		self.cnt = 1;
	}
	self.use = artifact_drop;
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = PlaceItem;
};

void() start_key = { copy_old_data(self);
		self.use = artifact_drop;
		self.nextthink = time + 0.2;	// items start after other solids
		self.think = PlaceItem;
		self.wrathflags = FL_RESPAWN;
	}
	.float msg2;
.float itemisweapon;
.float time_emptymessage;
////////////////////////////////
///weapons and ammo///
////////////////////////////////
void() wammo_touch = { 
		
	if(!(other.flags & FL_CLIENT))
		return;
	if (other.classname != "player")
		return;
	if ((other.items &self.items))
	{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((other.attack_finished > time) && (self.itemisweapon == 1))
		return;
	
	if (self.msg == 3)
	{
		other.coachgunclip = 3;
		other.timefrik = time + 0.75;
		if (self.spawnflags &1)
			other.timefrik = 0;
		//if ((time > other.attack_finished) && (!other.button0) && (!other.button3))
		other.oldimpulse = 2;
		other.itemtime = time + 0.5;
		Hud_message(35, other.origin, other);
	}
	if (self.msg == 8)
	{
		other.timefrik = time + 0.75;
		if (self.spawnflags &1)
			other.timefrik = 0;
		//if ((time > other.attack_finished) && (!other.button0) && (!other.button3))		
		other.oldimpulse = 4;
		other.itemtime = time + 0.5;
		Hud_message(35, other.origin, other);
	}
	if (self.msg == 25)
	{
		other.timefrik = time + 0.75;
		if (self.spawnflags &1)
			other.timefrik = 0;
		//if ((time > other.attack_finished) && (!other.button0) && (!other.button3))		
		other.oldimpulse = 5;
		other.itemtime = time + 0.5;
		Hud_message(35, other.origin, other);
	}
	if (self.msg == 33)
	{
		other.timefrik = time + 0.75;
		if (self.spawnflags &1)
			other.timefrik = 0;

		other.oldimpulse = 3;
		other.itemtime = time + 0.5;
		Hud_message(35, other.origin, other);
	}
	if (self.msg == 14)
	{
		other.timefrik = time + 0.75;
		if (self.spawnflags &1)
			other.timefrik = 0;

		//if ((time > other.attack_finished) && (!other.button0) && (!other.button3))		
		other.oldimpulse = 6;
		other.itemtime = time + 0.5;
		Hud_message(35, other.origin, other);
	}
	if (self.msg == 18)
	{
		if ((other.ammo_coachgun >= max_ammo_coachgun )&& (self.alwaystouchable != 1))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
		if ((other.ammo_coachgun <= 0))
		{
			other.precoachgunclip = 1;
			if ((other.weapon == IT_COACHGUN) && (other.vweaponframe == 0))
				stuffcmd(other, "impulse 30\n");
		}
	}
	if (self.msg == 19)
	{
		if ((other.ammo_cannon >= max_ammo_cannon )&& (self.alwaystouchable != 1))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	}
	if (self.msg == 20)
	{
		if ((other.ammo_shotgun >= max_ammo_shotgun)&& (self.alwaystouchable != 1))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
		if ((other.weapon == IT_SHOTGUN) && (other.empty_shells == 1))
		{
			stuffcmd(other, "impulse 36\n");
		}
	}

	if (self.msg == 21)
	{
		if ((other.ammo_spitter >= max_ammo_spitter)&& (self.alwaystouchable != 1))
			{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	}
	if (self.msg == 30)
	{
		if ((other.ammo_retcher >= max_ammo_retcher) && (self.alwaystouchable != 1))
			{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
		if ((other.ammo_retcher <= 0))
		{
			other.preloadcyst = 1;
			if ((other.weapon == IT_RETCHER) && (other.vweaponframe == 0))
				stuffcmd(other, "impulse 34\n");
		}
	}
	other.items += self.items;
	other.ammo_coachgun = self.ammo_coachgun + other.ammo_coachgun;
	if (other.ammo_coachgun > max_ammo_coachgun)
		other.ammo_coachgun = max_ammo_coachgun;
	other.ammo_shotgun = self.ammo_shotgun + other.ammo_shotgun;
	if (other.ammo_shotgun > max_ammo_shotgun)
		other.ammo_shotgun = max_ammo_shotgun;
	other.ammo_cannon = self.ammo_cannon + other.ammo_cannon;
	if (other.ammo_cannon > max_ammo_cannon)
		other.ammo_cannon = max_ammo_cannon;
	other.ammo_spitter = self.ammo_spitter + other.ammo_spitter;
	if (other.ammo_spitter > max_ammo_spitter)
		other.ammo_spitter = max_ammo_spitter;
	other.ammo_retcher = self.ammo_retcher + other.ammo_retcher;
	if (other.ammo_retcher > max_ammo_retcher)
		other.ammo_retcher = max_ammo_retcher;
	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
	SUB_UseTargets();

	if (self.ammo_coachgun)	// 4-8
	{
		other.slugspulsetime = time + 0.5;
		if (other.slugspulsetime > time)
		{
			if (!(other.pulseicons &8))
				other.pulseicons += 8;
			other.rslugspulsetime = time + 0.01;
		}
	}
	if (self.ammo_shotgun)	// 16- 32
	{
		other.shellspulsetime = time + 0.5;
		if (other.shellspulsetime > time)
		{
			if (!(other.pulseicons &32))
				other.pulseicons += 32;
			other.rshellspulsetime = time + 0.01;
		}
	}
	if (self.ammo_spitter)	// 32 - 64
	{
		other.spitterpulsetime = time + 0.5;
		if (other.spitterpulsetime > time)
		{
			if (!(other.pulseicons &64))
				other.pulseicons += 64;
			other.rspitterpulsetime = time + 0.01;
		}
	}
	if (self.ammo_retcher)	//128 - 256
	{
		other.retcherpulsetime = time + 0.5;
		if (other.retcherpulsetime > time)
		{
			if (!(other.pulseicons &256))
				other.pulseicons += 256;
			other.rretcherpulsetime = time + 0.01;
		}
	}

	if (self.secret == 1)
	{
		sound(other, CHAN_AUTO, "misc/secret.ogg", 1, ATTN_NONE);
		Hud_message(27, other.origin, other);
		local entity oself;
		oself = self;
		self = other;
		found_secrets = found_secrets + 1;
		self = oself;
		WriteByte(MSG_ALL, SVC_FOUNDSECRET);
	}


	flash_screen_item(other);
	if (deathmatch)
	{
		self.oldsolid = self.solid;
		self.oldtouch = self.touch;
		self.touch = SUB_Null;
		self.oldpflags = self.pflags;
		self.pflags =  0;
		self.alpha = 0.1;
		self.colormod = '0.5 0.5 1';
		self.solid = SOLID_NOT;
		self.think = respawn_items;
		self.nextthink = time + 25;
		if(self.classname == "bbox_touch")
		{
		self.owner.oldpflags = self.pflags;
		self.owner.pflags =  0;
		self.owner.alpha = 0.1;
		self.owner.colormod = '0.5 0.5 1';
		self.owner.solid = SOLID_NOT;
		self.owner.think = respawn_items;
		self.owner.nextthink = time + 25;
		}	
	}
	else
	{
	remove(self);
	if(self.classname == "bbox_touch")
	remove(self.owner);
	}

};

void() weapon_shotgun = { self.items = IT_SHOTGUN;
	self.itemisweapon = 1;
	setmodel(self, "models/weapons/shotgun/w_shotgun.md3");
	self.ammo_shotgun = 2;
	self.scale = 1;
	StartItem(1);
	self.origin_z += 24;
	self.rwpn = 1;
	//self.noise  ="items/shotgun.ogg";
	precache_sound(self.noise);
	self.touch = wammo_touch;
	self.msg = 33;
	setsize(self, '-12 -12 -24' ,'12 12 8');
};

void() weapon_coachgun = { self.items = IT_COACHGUN;
	self.itemisweapon = 1;
	setmodel(self, "models/weapons/coachgun/w_coachgun.md3");
	self.ammo_coachgun = 3;
	self.scale = 1;
	StartItem(1);
	self.origin_z += 24;
	self.rwpn = 1;
	//self.noise  ="misc/null.wav";
	precache_sound(self.noise);
	self.touch = wammo_touch;
	self.msg = 3;
	setsize(self, '-12 -12 -24' ,'12 12 8');
};

void() weapon_retcher = { self.items = IT_RETCHER;
	self.itemisweapon = 1;
	setmodel(self, "models/weapons/retcher/w_retcher.md3");
	setsize(self, '-12 -12 -24' ,'12 12 8');
	self.ammo_retcher = 6;
	self.scale = 1;
	self.rwpn = 1;
	StartItem(1);
	self.origin_z += 24;
	//self.noise  ="misc/null.wav";
	precache_sound(self.noise);
	self.touch = wammo_touch;
	self.msg = 25;
};

void() weapon_spitter = { self.items = IT_SPITTER;
	self.itemisweapon = 1;
	setmodel(self, "models/weapons/spitter/w_spitter.md3");
	setsize(self, '-12 -12 -24' ,'12 12 8');
	self.ammo_spitter = 20;
	self.rwpn = 1;
	self.scale = 1;
	StartItem(1);
	self.origin_z += 24;
	//self.noise  ="misc/null.wav";
	precache_sound(self.noise);
	self.touch = wammo_touch;
	self.msg = 8;
};

void() weapon_slagcannon = { self.items = IT_CANNON;
	self.itemisweapon = 1;
	setmodel(self, "models/weapons/cannon/w_cannon.md3");
	setsize(self, '-12 -12 -24' ,'12 12 8');
	//self.noise  ="misc/null.wav";
	precache_sound(self.noise);
	self.ammo_cannon = 20;
	self.rwpn = 1;
	self.scale = 1;
	StartItem(1);
	self.origin_z += 24;
	self.touch = wammo_touch;
	self.msg = 14;
};
void(entity ownr) spawn_bbox_collider =
{
entity bbox_touch;
bbox_touch = spawn();
copyentity (ownr,bbox_touch);
bbox_touch.owner = ownr;
bbox_touch.classname = "bbox_touch";
bbox_touch.solid = SOLID_TRIGGER;
setmodel(bbox_touch,"models/misc/null.md3");

setsize(bbox_touch,bbox_touch.nsize_bbox,bbox_touch.size_bbox);
//bbox_touch.touch = bbox_touch.owner.oldtouch;
bbox_touch.movetype = MOVETYPE_FOLLOW;
bbox_touch.aiment = ownr;
bbox_touch.think = null;
ownr.solid = SOLID_NOT;
ownr.touch = null;
};
void() spawnfunc_ammo_shells = { self.noise = "items/shells.ogg";
	self.ammo_shotgun = 20;
	setmodel(self, "models/items/shells.md3");
	setsizeitem2(self, shells_size);
	self.msg = 20;
	precache_sound(self.noise);
	StartItem(1);
	self.scale = 1;
	self.touch = wammo_touch;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
};


void() spawnfunc_ammo_slugs = { self.noise = "items/slugs.ogg";
	if (self.spawnflags)
	{
		self.ammo_coachgun = 15;
		setmodel(self, "models/items/slugs.md3");
		setsizeitem2(self, shellsl_size);
		self.msg = 18;
	}
	else
	{
		self.ammo_coachgun = 15;
		setmodel(self, "models/items/slugs.md3");
		setsizeitem2(self, shellsl_size);
		self.msg = 18;
	}
	precache_sound(self.noise);
	StartItem(1);
	self.scale = 1;
	self.touch = wammo_touch;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
};
void() ammo_cysts = { setmodel(self, "models/items/cysts.md3");
	self.noise = "items/cysts.ogg";
	if (self.spawnflags == 1)
	{
		setsizeitem2(self, explosives_size);
		self.ammo_retcher = retcher_ammount;
	}
	else if (self.spawnflags == 2)
	{
		setsizeitem2(self, explosivesl_size);
		self.ammo_retcher = retcher_ammount;
	}
	else
	{
		setsizeitem2(self, explosives_size);
		self.ammo_retcher = 9;
	}
	precache_sound(self.noise);
	StartItem(2);
	self.scale = 1;
	self.msg = 30;
	self.touch = wammo_touch;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
};

void() spawnfunc_ammo_ore = { if (self.spawnflags == 1)
	{
		setmodel(self, "models/items/ore.md3");
		setsizeitem2(self, orel_size);
		self.ammo_cannon = cannon_ammount;
		self.noise = "items/ore.ogg";
		self.msg = 19;
	}
	else
	{
		setmodel(self, "models/items/ore.md3");
		setsizeitem2(self, ore_size);
		self.ammo_cannon = cannon_ammount;
		self.noise = "items/ore.ogg";
		self.msg = 19;
	}
	precache_sound(self.noise);
	StartItem(2);
	self.scale = 1;
	self.touch = wammo_touch;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	};

void()wammo_special_touch =
{
return;
};



void() ammo_fangs = { self.noise = "items/fangs.ogg";

	if (self.spawnflags == 1)
	{
		setmodel(self, "models/items/fangs.md3");
		setsizeitem2(self, resinl_size);
		self.ammo_spitter = fang_ammount;
		self.msg = 21;
	}
	else
	{
		setmodel(self, "models/items/fangs.md3");
		setsizeitem2(self, resin_size);
		self.ammo_spitter = fang_ammount;
		self.msg = 21;
	}
	precache_sound(self.noise);
	StartItem(2);
	self.scale = 1;
	self.touch = wammo_touch;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

/////////////////////////
///armor &health///
/////////////////////////
void() larmor_touch = { if (other.classname != "player")
	if(!(other.flags & FL_CLIENT))		return;


	if ((other.health == 100) && (self.health))
	{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	other.health += self.health;
	if (other.health > 100)
		other.health = 100;
	if (self.health)
	{
		sound(other, CHAN_AUTO, "player/gain_health.ogg", 1, ATTN_NORM);
		other.healthpulsetime = time + 0.5;

		if (other.healthpulsetime > time)
		{
			if (!(other.pulseicons &2))
				other.pulseicons += 2;
			other.rhealthpulsetime = time + 0.01;
		}
	}

	if (self.rarmorvalue)	//1024 - 2048
	{
		if ((other.rarmorvalue == 100))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
		other.rarmorvalue += self.rarmorvalue;
		if (other.rarmorvalue > 100)
			other.rarmorvalue = 100;
		other.armorpulsetime = time + 0.5;
		if (other.armorpulsetime > time)
		{
			if (!(other.pulseicons &2048))
				other.pulseicons += 2048;
			other.rarmorpulsetime = time + 0.01;
		}
	}
	if (self.darmorvalue)	//4096 -8192
	{
		if ((other.darmorvalue == 100))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
		other.darmorvalue += self.darmorvalue;
		if (other.darmorvalue > 100)
			other.darmorvalue = 100;
		other.darmorpulsetime = time + 0.5;
		if (other.darmorpulsetime > time)
		{
			if (!(other.pulseicons &4096))
				other.pulseicons += 4096;
			other.rdarmorpulsetime = time + 0.01;
		}
	}
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	SUB_UseTargets();
	if (self.secret == 1)
	{
		sound(other, CHAN_AUTO, "misc/secret.ogg", 1, ATTN_NONE);
		Hud_message(27, other.origin, other);
		local entity oself;
		oself = self;
		self = other;
		found_secrets = found_secrets + 1;
		self = oself;
		WriteByte(MSG_ALL, SVC_FOUNDSECRET);
	}
	flash_screen_item(other);
	if (deathmatch)
	{
		self.oldsolid = self.solid;
		self.oldtouch = self.touch;
		self.touch = SUB_Null;
		self.alpha = 0.1;
		self.oldpflags = self.pflags;
		self.pflags =  0;
		self.colormod = '0.5 0.5 1';
		self.solid = SOLID_NOT;
		self.think = respawn_items;
		self.nextthink = time + 25;
		if(self.classname == "bbox_touch")
		{
		self.owner.oldpflags = self.pflags;
		self.owner.pflags =  0;
		self.owner.alpha = 0.1;
		self.owner.colormod = '0.5 0.5 1';
		self.owner.solid = SOLID_NOT;
		self.owner.think = respawn_items;
		self.owner.nextthink = time + 25;
		}	
	}
	else
	{
	remove(self);
	if(self.classname == "bbox_touch")
	remove(self.owner);
	}


};

void() health_life_vial = { self.noise = "items/lifeblood_vial1.ogg";
	self.pflags = 129;
	self.health = 10;
	self.light_lev = 15;
	self.color = '3 0 0';
	self.colormod = '1 1 1';
	setmodel(self, "models/items/lifeblood_vial.md3");
	self.movetype = MOVETYPE_TOSS;
	self.solid = SOLID_TRIGGER;
	setsizeitem2(self, vial_size);
	self.touch = larmor_touch;
//	self.nextthink = time + 0.2;	// items start after other solids
//	self.think = PlaceItem;
	self.msg = 11;

	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() health_life_beaker = { local float r;
	r = random() *3;
	if (r < 3)
		self.noise = ("items/lifeblood_beaker3.ogg");
	if (r < 2)
		self.noise = ("items/lifeblood_beaker2.ogg");
	if (r < 1)
		self.noise = ("items/lifeblood_beaker1.ogg");

	self.pflags = 129;
	self.health = 30;
	self.light_lev = 25;
	self.color = '3 0 0';
	self.colormod = '1 1 1';
	setmodel(self, "models/items/lifeblood_beaker.md3");
	self.touch = larmor_touch;
	self.movetype = MOVETYPE_TOSS;
	self.solid = SOLID_TRIGGER;
	setsizeitem2(self, beaker_size);
	self.msg = 10;
//	self.nextthink = time + 0.2;	// items start after other solids
//	self.think = PlaceItem;
	spawn_bbox_collider(self);
	self.oldtouch = self.touch;
	
};

void() health_life_chalice = { self.noise = "items/lifeblood_vial3.ogg";
	self.pflags = 129;
	self.health = 50;
	self.light_lev = 32;
	self.color = '1 2 1';
	self.colormod = '1 5 1';
	setmodel(self, "models/items/lifeblood_vial.md3");
	self.movetype = MOVETYPE_TOSS;
	self.solid = SOLID_TRIGGER;
	setsizeitem2(self, chalice_size);
	self.touch = larmor_touch;
//	self.nextthink = time + 0.2;	// items start after other solids
//	self.think = PlaceItem;
	self.msg = 11;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() health_life_heart = { self.noise = "items/lifeblood_beaker1.ogg";
	StartItem(3);
	self.health = 100;
	self.light_lev = 64;
	self.color = '0 1 3';
	self.colormod = '1 1 5';
	setmodel(self, "models/items/life_heart.spr");
	self.movetype = MOVETYPE_TOSS;
	self.solid = SOLID_TRIGGER;
	setsizeitem2(self, heart_size);
	self.touch = larmor_touch;
//	self.nextthink = time + 0.2;	// items start after other solids
//	self.think = PlaceItem;
	self.msg = 11;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_shard = { local float r;
	r = floor(random() *3);
	if (r < 1)
		self.noise = "items/armor_shard1.ogg";
	if (r < 2)
		self.noise = "items/armor_shard2.ogg";
	else
		self.noise = "items/armor_shard3.ogg";
	precache_sound(self.noise);
	self.rarmorvalue = 10;
	setmodel(self, "models/items/armor_shard.md3");
	setsize2(self, shard_nsize, shard_size);
	self.touch = larmor_touch;
	self.color = shard_light_col;
	self.light_lev = shard_lightlev;
	StartItem(4);
	self.msg = 13;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_helm = { self.noise = "items/helm1.ogg";
	precache_sound(self.noise);
	self.rarmorvalue = 30;
	setmodel(self, "models/items/helm.md3");
	setsize2(self, helm_nsize, helm_size);
	self.touch = larmor_touch;
	self.color = helm_light_col;
	self.light_lev = helm_lightlev;
	StartItem(4);
	self.msg = 9;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_armor = { self.noise = "items/armor1.ogg";
	precache_sound(self.noise);
	self.rarmorvalue = 50;
	setmodel(self, "models/items/armor.md3");
	setsize2(self, armor_nsize, armor_size);
	self.touch = larmor_touch;
	self.color = armor_light_col;
	self.light_lev = armor_lightlev;
	StartItem(4);
	self.msg = 2;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_shard_dark = { local float r;
	r = floor(random() *3);
	if (r < 1)
		self.noise = "items/armor_shard_dark1.ogg";
	if (r < 2)
		self.noise = "items/armor_shard_dark2.ogg";
	else
		self.noise = "items/armor_shard_dark3.ogg";
	precache_sound(self.noise);
	self.darmorvalue = 10;
	setmodel(self, "models/items/armor_shard_dark.md3");
	setsize2(self, dark_shard_nsize, dark_shard_size);
	self.touch = larmor_touch;
	self.color = dark_shard_light_col;
	self.light_lev = dark_shard_lightlev;
	StartItem(4);
	self.msg = 6;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_armor_dark = { self.noise = "items/armor_dark1.ogg";
	precache_sound(self.noise);
	self.darmorvalue = 50;
	setmodel(self, "models/items/armor_dark.md3");
	setsize2(self, dark_armor_nsize, dark_armor_size);
	self.touch = larmor_touch;
	self.color = dark_armor_light_col;
	//	self.skin = 1;
	self.light_lev = dark_armor_lightlev;
	StartItem(4);
	self.msg = 4;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() armor_helm_dark = { self.noise = "items/helm_dark1.ogg";
	precache_sound(self.noise);
	self.darmorvalue = 30;
	setmodel(self, "models/items/helm_dark.md3");
	setsize2(self, dark_helm_nsize, dark_helm_size);
	self.touch = larmor_touch;
	self.color = dark_helm_light_col;
	self.light_lev = dark_helm_lightlev;
	StartItem(4);
	self.msg = 5;
	self.oldtouch = self.touch;
	spawn_bbox_collider(self);
	
};

void() guardian_shield = {};
/////////////////
///artifacts///
/////////////////

	
void() artifact_touch = { if (other.classname != "player")
		return;
	if(!(other.flags & FL_CLIENT))		return;


	if ((other.Attar >= 9) && (self.Attar))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((other.LifeSiphon >= 9) && (self.LifeSiphon))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((other.TrinketofRespite >= 9) && (self.TrinketofRespite))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((other.Aegis >= 9) && (self.Aegis))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((other.DrownerApp >= 9) && (self.DrownerApp))
		{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	if ((!(other.centerprint_messages &1)) && (!self.SoulTether))
	{
		Hud_message(256, other.origin, other);
		other.centerprint_messages += 1;
	}
	else
	{
		if (!(other.centerprint_messages &4)) 
		{	
		Hud_message(260, other.origin, other);
		other.centerprint_messages += 4;
		}
	}

	other.LifeSiphon += self.LifeSiphon;
	other.SoulTether += self.SoulTether;
	other.Attar += self.Attar;
	
	
	other.TrinketofRespite += self.TrinketofRespite;
	other.DrownerApp += self.DrownerApp;
	other.Aegis += self.Aegis;
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);

	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	SUB_UseTargets();
	if (self.secret == 1)
	{
		sound(other, CHAN_AUTO, "misc/secret.ogg", 1, ATTN_NONE);
		Hud_message(27, other.origin, other);
		local entity oself;
		oself = self;
		self = other;
		found_secrets = found_secrets + 1;
		self = oself;
		WriteByte(MSG_ALL, SVC_FOUNDSECRET);
	}
	flash_screen_item(other);
	if (deathmatch)
	{
		self.oldsolid = self.solid;
		self.oldtouch = self.touch;
		self.touch = SUB_Null;
		self.alpha = 0.1;
		self.colormod = '0.5 0.5 1';
		self.solid = SOLID_NOT;
		self.oldpflags = self.pflags;
		self.pflags =  0;
		self.think = respawn_items;
		self.nextthink = time + 25;
		if(self.classname == "bbox_touch")
		{
		self.owner.oldpflags = self.pflags;
		self.owner.pflags =  0;
		self.owner.alpha = 0.1;
		self.owner.colormod = '0.5 0.5 1';
		self.owner.solid = SOLID_NOT;
		self.owner.think = respawn_items;
		self.owner.nextthink = time + 25;
		}	
	}
	else
	{
	remove(self);
	if(self.classname == "bbox_touch")
	remove(self.owner);
	}

};

void() radial = { self.scale = 1;
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_TRIGGER;
	self.cnt = 1;
	self.origin_z += 12;
	self.use = artifact_drop;
};

void() artifact_soul_tether = { radial();
	self.modelflags = 8;
	self.noise = "items/artifacts/artifactE_pickup.ogg";
	self.noise1 = "items/artifacts/artifactE_use.ogg";
	precache_sound(self.noise);precache_sound(self.noise1);precache_sound(self.noise2);
	self.SoulTether = 1;
	if (self.secret)
		total_secrets++;
	setmodel(self, "models/artifacts/soul_tether.md3");
	setsize(self, artifact_nsize, artifact_size);
	//setsize (self, '-8 -8 -8', ' 9 9 9');

	self.msg = 110;
	self.touch = artifact_touch;
	self.oldtouch = self.touch;

	
};

void() artifact_life_siphon = { radial();
	self.modelflags = 8;
	self.noise = "items/artifacts/artifactF_pickup.ogg";
	self.noise1 = "items/artifacts/artifactF_use.ogg";
	self.noise2 = "items/artifacts/artifactF_end.ogg";
	precache_sound(self.noise);precache_sound(self.noise1);precache_sound(self.noise2);
	self.LifeSiphon = 1;
	if (self.secret)
		total_secrets++;
	setmodel(self, "models/artifacts/life_siphon.md3");
	setsize(self, artifact_nsize, artifact_size);
	self.traileffectnum = particleeffectnum("life_siphon");
	self.msg = 106;
	self.touch = artifact_touch;
	self.oldtouch = self.touch;

	
};

void() artifact_drowners_apparatus = { radial();
	self.noise = "items/artifacts/artifactB_pickup.ogg";
	self.noise1 = "items/artifacts/artifactB_use.ogg";
	self.noise2 = "items/artifacts/artifactB_end.ogg";
	self.modelflags = 8;
	precache_sound(self.noise);precache_sound(self.noise1);precache_sound(self.noise2);
	self.DrownerApp = 1;
	if (self.secret)
		total_secrets++;
	setmodel(self, "models/artifacts/drowners_apparatus.md3");
	setsize(self, artifact_nsize, artifact_size);
	self.msg = 102;
	self.touch = artifact_touch;
	self.oldtouch = self.touch;

}

void() artifact_TrinketofRespite = {};

void() artifact_cruel_aegis = { radial();
	self.noise = "items/artifacts/artifactH_pickup.ogg";
	self.noise1 = "items/artifacts/artifactH_use.ogg";
	self.noise2 = "items/artifacts/artifactH_end.ogg";
	precache_sound(self.noise);precache_sound(self.noise1);precache_sound(self.noise2);
	self.modelflags = 8;
	self.Aegis = 1;
	if (self.secret)
		total_secrets++;
	setmodel(self, "models/artifacts/cruel_aegis.md3");
	setsize(self, artifact_nsize, artifact_size);
	self.msg = 108;
	self.touch = artifact_touch;
	self.oldtouch = self.touch;

	
};

void() artifact_confounding_attar = { radial();
	self.noise = "items/artifacts/artifactD_pickup.ogg";
	self.noise1 = "items/artifacts/artifactD_use.ogg";
	self.noise2 = "items/artifacts/artifactD_end.ogg";
	precache_sound(self.noise);precache_sound(self.noise1);precache_sound(self.noise2);
	self.modelflags = 8;
	self.Attar = 1;
	if (self.secret)
		total_secrets++;
	setmodel(self, "models/artifacts/confounding_attar.md3");
	setsize(self, artifact_nsize, artifact_size);
	self.msg = 104;
	self.touch = artifact_touch;
	self.oldtouch = self.touch;

	
};

void(vector org, string class, float ammount, entity ownr) drop_item;
.float item_ammount;
.float classweapon1;
.float classweapon2;
.float classweapon3;
.float classweapon4;
.float classweapon5;
void(vector origin, string classt, float item_amm, entity slf) convert_to_item;
void() weapon_spawner_use = { local entity pl;
	pl = find(world, classname, "player");
	if (pl.oldrelics)
	{
		if (pl.oldrelics == 1)
			self.cnt = self.classweapon2;
		if (pl.oldrelics == 2)
			self.cnt = self.classweapon3;
		if (pl.oldrelics == 3)
			self.cnt = self.classweapon4;
		if (pl.oldrelics == 4)
			self.cnt = self.classweapon5;
	}
	if (self.cnt == 1) 
	{
		if (!(pl.items &IT_COACHGUN))
			self.classtype = "coachgun";
		else
		{	self.classtype = "slugs";
			self.item_ammount = coachgun_ammount;
			self.alwaystouchable = 1;}
	}
	if (self.cnt == 2) 
	{
		if (!(pl.items &IT_SHOTGUN))
			self.classtype = "shotgun";
		else
		{	self.classtype = "shells";	
			self.item_ammount = shotgun_ammount;
			self.alwaystouchable = 1;}
	}
	if (self.cnt == 3) 
	{
		if (!(pl.items &IT_SPITTER))
			self.classtype = "spitter";
		else
		{	self.classtype = "fangs";
			self.item_ammount = fang_ammount;
			self.alwaystouchable = 1;}
	}
	
	if (self.cnt == 4)
	{
		if (!(pl.items &IT_RETCHER))
			self.classtype = "retcher";
		else
		{	self.classtype = "fangs";
			self.item_ammount = retcher_ammount;
			self.alwaystouchable = 1;}
	}
	if (self.cnt == 5)
	{
		if (!(pl.items &IT_CANNON))
			self.classtype = "slagcannon";
		else
		{	self.classtype = "ore";
			self.item_ammount = cannon_ammount;
			self.alwaystouchable = 1;}
	}
	if ((self.classtype) && (self.cnt))
	{
		self.use =SUB_Null;
		convert_to_item(self.origin, self.classtype, self.item_ammount, self);
	}

	//	drop_item(self.origin, self.classtype, self.item_ammount, self);
	//	remove(self);
	else
		remove(self);
};

void() weapon_spawner = { if (self.targetname)
		self.use = weapon_spawner_use;
	if (!self.targetname)
	{				
		self.think = wrath_objerror;
		self.nextthink = time + random();
	}
	self.cnt = self.classweapon1;
};
.float classitem1;
.float classitem0;
.float classitem2;
.float classitem3;
.float classitem4;
.float classitem5;

.float checkweapon;
void() item_spawner_use = { local entity pl;
	pl = find(world, classname, "player");


	if (pl.oldrelics)
	{
		if (pl.oldrelics == 1)
			self.classitem1 = self.classitem2;
		if (pl.oldrelics == 2)
			self.classitem1 = self.classitem3;
		if (pl.oldrelics == 3)
			self.classitem1 = self.classitem4;
		if (pl.oldrelics == 4)
			self.classitem1 = self.classitem5;
		if (pl.oldrelics == 5)
			self.classitem1 = self.classitem1;
	}


	
	if(self.checkweapon == 1)
	{
		if((!(pl.items & IT_COACHGUN)) && (self.classitem1 ==  1))
			remove(self);
		if((!(pl.items & IT_SHOTGUN)) && (self.classitem1 ==  2))
			remove(self);
		if((!(pl.items & IT_SPITTER)) && (self.classitem1 ==  3))
			remove(self);
		if((!(pl.items & IT_RETCHER)) && (self.classitem1 ==  4))
			remove(self);
		if((!(pl.items & IT_CANNON)) && (self.classitem1 ==  25))
			remove(self);
	}


	if (self.classitem1 == 1)
	{
		if (!self.item_ammount)
			self.item_ammount = 12;	//coachgun_ammount;
		self.classtype = "slugs";
	}
	if (self.classitem1 == 2)
	{
		if (!self.item_ammount)
			self.item_ammount = retcher_ammount;
		self.classtype = "cyst";
	}
	if (self.classitem1 == 3)
	{
		if (!self.item_ammount)
			self.item_ammount = shotgun_ammount;
		self.classtype = "shells";
	}
	if (self.classitem1 == 4)
	{
		if (!self.item_ammount)
			self.item_ammount = fang_ammount;
		self.classtype = "fangs";
	}

	if(self.classitem1 ==  25)
	{
		if (!self.item_ammount)
		self.item_ammount  = cannon_ammount;
		self.classtype = "ore";
	}
	if (self.classitem1 == 5)
		(self.classtype = "shard");
	if (self.classitem1 == 6)
		(self.classtype = "armor");
	if (self.classitem1 == 7)
		(self.classtype = "helm");
	if (self.classitem1 == 8)
		(self.classtype = "shard_dark");
	if (self.classitem1 == 9)
		(self.classtype = "armor_dark");
	if (self.classitem1 == 10)
		(self.classtype = "helm_dark");
	if (self.classitem1 == 11)
		(self.classtype = "vial");
	if (self.classitem1 == 12)
		(self.classtype = "beaker");
	if (self.classitem1 == 20)
		(self.classtype = "apparatus");
	if (self.classitem1 == 21)
		(self.classtype = "theter");
	if (self.classitem1 == 22)
		(self.classtype = "siphon");
	if (self.classitem1 == 23)
		(self.classtype = "aegis");
	if(self.classitem1 ==  24)
		(self.classtype = "attar");
	if (self.classitem1)
	{
		self.use = SUB_Null;
		convert_to_item(self.origin, self.classtype, self.item_ammount, self);
	}
	//drop_item(self.origin, self.classtype, self.item_ammount, self);
	//remove(self);
};

.float classitem1;
.float classitem2;
.float classitem3;
.float classitem4;
.float classitem5;

void() item_spawner = { /*	if (!self.classitem0)
			self.classitem0 = 1;

		if (!self.classitem1)
			self.classitem1 = self.classitem0;
		if (!self.classitem2)
			self.classitem2 = self.classitem0;
		if (!self.classitem3)
			self.classitem3 = self.classitem0;
		if (!self.classitem4)
			self.classitem4 = self.classitem0;
		if (!self.classitem5)
			self.classitem5 = self.classitem0;
	*/
	if (!self.targetname)
	{				
		self.think = wrath_objerror;
		self.nextthink = time + random();
	}
	if (self.targetname)
		self.use = item_spawner_use;
};

.float PreStartItemvalue;

void() PreStartItem = { StartItem(self.PreStartItemvalue);
};
.float counter_coffer_use;
.float counter_coffer_ammount;

void(vector org, string class, float ammount, entity ownr) drop_item = { local entity dropped;
	dropped = spawn();
	dropped.origin = org;
	dropped.movetype = MOVETYPE_TOSS;
	dropped.owner = ownr;
	dropped.angles = ownr.angles;
	
	
	local vector revel;
	
	if ((dropped.owner.flags &FL_MONSTER))
	{
		makevectors(ownr.angles);
			revel = v_forward *(120 + random() *50);
		revel_z += (150 + random() *50);
	}
	else
	{
		if (self.owner.target)
			dropped.target = self.owner.target;
	}
	if(ownr.classname == "coffer")
	{
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.gravity = coffer_item_gravity;
		dropped.bouncefactor = coffer_item_bounce;
		makevectors(ownr.angles);
		local float right_vel;
		
		if(ownr.counter_coffer_ammount == 4)
		{
			if(ownr.counter_coffer_use == 4)
				right_vel = -67.5;
			if(ownr.counter_coffer_use == 3)
				right_vel = -22.5;
			if(ownr.counter_coffer_use == 2)
				right_vel = 22.5;
			if(ownr.counter_coffer_use == 1)
				right_vel = 67.5;			
		}
		if(ownr.counter_coffer_ammount == 3)
		{
			if(ownr.counter_coffer_use == 3)
				right_vel = -45;
			if(ownr.counter_coffer_use == 1)
				right_vel = 45;			
		}
		if(ownr.counter_coffer_ammount == 2)
		{
			if(ownr.counter_coffer_use == 2)
				right_vel = -22.5;
			if(ownr.counter_coffer_use == 1)
				right_vel = 22.5;			
		}
		revel = (v_forward * coffer_item_vel) + v_right * (right_vel) * 2;
		revel_z += (coffer_item_vel);
	}


	if (class == "slugs")
	{
		setmodel(dropped, "models/items/slugs.md3");
		dropped.ammo_cannon = ammount;
		dropped.noise = "items/slugs.ogg";
		dropped.msg = 18;
		setsizeitem2(dropped, shellsl_size);
		dropped.ammo_coachgun = 15;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "cyst")
	{
		setmodel(dropped, "models/items/cysts.md3");
		setsizeitem2(dropped, explosives_size);
		dropped.noise = "items/cysts.ogg";
		dropped.msg = 30;
		dropped.scale = 1;
		dropped.ammo_retcher = ammount;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "shells")
	{
		setmodel(dropped, "models/items/shells.md3");
		dropped.noise = "items/shells.ogg";
		dropped.msg = 20;
		setsizeitem2(dropped, shells_size);
		dropped.ammo_shotgun = ammount;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "shells_inv")
	{
		setmodel(dropped, "models/items/shells_drop.md3");
		dropped.avelocity_y = (random() *120 + 120) *crandom();
		dropped.noise = "items/shells.ogg";
		dropped.msg = 20;
		setsizeitem2(dropped, shells_size_invader);
		dropped.ammo_shotgun = ammount;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "fangs")
	{
		setmodel(dropped, "models/items/fangs.md3");
		dropped.noise = "items/fangs.ogg";
		dropped.msg = 21;
		setsizeitem2(dropped, resin_size);
		dropped.ammo_spitter = fang_ammount;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "ore")
	{
		setmodel(dropped,"models/items/ore.md3");
		dropped.noise = "items/ore.ogg";
		dropped.msg = 19;
		setsizeitem2(dropped, shellsl_size);
		dropped.ammo_cannon = ammount;
		dropped.touch = wammo_touch;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
	}	

	if (class == "shard")
	{
		dropped.noise = "items/armor_shard3.ogg";
		dropped.rarmorvalue = 10;
		setmodel(dropped, "models/items/armor_shard.md3");
		setsize2(dropped, shard_nsize, shard_size);
		dropped.touch = larmor_touch;
		dropped.color = shard_light_col;
		dropped.light_lev = shard_lightlev;
		dropped.msg = 13;
		dropped.pflags = 128 | 1;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "armor")
	{
		dropped.noise = "items/armor1.ogg";
		dropped.rarmorvalue = 50;
		setmodel(dropped, "models/items/armor.md3");
		setsize2(dropped, armor_nsize, armor_size);
		dropped.touch = larmor_touch;
		dropped.color = armor_light_col;
		dropped.light_lev = armor_lightlev;
		dropped.msg = 2;
		dropped.pflags = 128 | 1;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "helm")
	{
		dropped.noise = "items/armor1.ogg";
		dropped.rarmorvalue = 30;
		setmodel(dropped, "models/items/helm.md3");
		setsize2(dropped, helm_nsize, helm_size);
		dropped.touch = larmor_touch;
		dropped.color = helm_light_col;
		dropped.light_lev = helm_lightlev;
		dropped.msg = 9;
		dropped.pflags = 128 | 1;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "shard_dark")
	{
		local float r;
		r = floor(random() *3);
		if (r < 1)
			dropped.noise = "items/armor_shard_dark1.ogg";
		if (r < 2)
			dropped.noise = "items/armor_shard_dark2.ogg";
		else
			dropped.noise = "items/armor_shard_dark3.ogg";

		dropped.darmorvalue = 10;
		setmodel(dropped, "models/items/armor_shard_dark.md3");
		setsize2(dropped, dark_shard_nsize, dark_shard_size);
		dropped.touch = larmor_touch;
		dropped.color = dark_shard_light_col;
		dropped.light_lev = dark_shard_lightlev;
		dropped.pflags = 128 | 1;
		dropped.msg = 6;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "armor_dark")
	{
		dropped.noise = "items/armor_dark1.ogg";
		dropped.darmorvalue = 50;
		setmodel(dropped, "models/items/armor_dark.md3");
		setsize2(dropped, dark_armor_nsize, dark_armor_size);
		dropped.touch = larmor_touch;
		dropped.color = dark_armor_light_col;
		dropped.light_lev = dark_armor_lightlev;
		dropped.pflags = 128 | 1;
		dropped.msg = 4;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "helm_dark")
	{
		dropped.noise = "items/armor_dark1.ogg";
		dropped.darmorvalue = 30;
		setmodel(dropped, "models/items/helm_dark.md3");
		setsize2(dropped, dark_helm_nsize, dark_helm_size);
		dropped.touch = larmor_touch;
		dropped.color = dark_helm_light_col;
		dropped.light_lev = dark_helm_lightlev;
		dropped.pflags = 128 | 1;
		dropped.msg = 5;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "vial")
	{
		dropped.noise = "items/lifeblood_vial1.ogg";
		dropped.pflags = 129;
		dropped.health = 10;
		dropped.light_lev = 15;
		dropped.color = '3 0 0';
		dropped.colormod = '1 1 1';
		setmodel(dropped, "models/items/lifeblood_vial.md3");
		dropped.touch = larmor_touch;
		setsizeitem2(dropped, vial_size);
		/*if(ownr.classname != "coffer")
		{
		dropped.nextthink = time + 0.2;	// items start after other solids
		dropped.think = PlaceItem;
		}*/
		dropped.msg = 11;
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "beaker")
	{
		dropped.noise = ("items/lifeblood_beaker1.ogg");
		dropped.pflags = 129;
		dropped.health = 30;
		dropped.light_lev = 25;
		dropped.color = '3 0 0';
		dropped.colormod = '1 1 1';
		setmodel(dropped, "models/items/lifeblood_beaker.md3");
		dropped.touch = larmor_touch;
		setsizeitem2(dropped, beaker_size);
		dropped.msg = 10;
		/*if(ownr.classname != "coffer")
		{
		dropped.nextthink = time + 0.2;	// items start after other solids
		dropped.think = PlaceItem;
		}*/
		spawn_bbox_collider(dropped);
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "siphon")
	{
		dropped.scale = 1;
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.solid = SOLID_TRIGGER;
		dropped.cnt = 1;
		dropped.origin_z += 12;
		dropped.modelflags = 8;
		dropped.noise = "items/artifacts/artifactF_pickup.ogg";
		dropped.LifeSiphon = 1;
		setmodel(dropped, "models/artifacts/life_siphon.md3");
		setsize(dropped, artifact_nsize, artifact_size);
		dropped.traileffectnum = particleeffectnum("life_siphon");
		dropped.msg = 106;
		dropped.touch = artifact_touch;
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "apparatus")
	{
		dropped.scale = 1;
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.solid = SOLID_TRIGGER;
		dropped.cnt = 1;
		dropped.origin_z += 12;
		dropped.noise = "items/artifacts/artifactB_pickup.ogg";
		dropped.modelflags = 8;
		dropped.DrownerApp = 1;
		setmodel(dropped, "models/artifacts/drowners_apparatus.md3");
		setsize(dropped, artifact_nsize, artifact_size);
		dropped.msg = 102;
		dropped.touch = artifact_touch;
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "theter")
	{
		dropped.scale = 1;
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.solid = SOLID_TRIGGER;
		dropped.cnt = 1;
		dropped.origin_z += 12;
		dropped.modelflags = 8;
		dropped.noise = "items/artifacts/artifactE_pickup.ogg";
		dropped.SoulTether = 1;
		precache_model("models/artifacts/soul_tether.md3");
		setmodel(dropped, "models/artifacts/soul_tether.md3");
		setsize(dropped, artifact_nsize, artifact_size);
		dropped.msg = 110;
		dropped.touch = artifact_touch;
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "aegis")
	{
		dropped.scale = 1;
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.solid = SOLID_TRIGGER;
		dropped.cnt = 1;
		dropped.origin_z += 12;
		dropped.noise = "items/artifacts/artifactH_pickup.ogg";
		dropped.modelflags = 8;
		dropped.Aegis = 1;
		setmodel(dropped, "models/artifacts/cruel_aegis.md3");
		setsize(dropped, artifact_nsize, artifact_size);
		dropped.msg = 108;
		dropped.touch = artifact_touch;
		dropped.oldtouch = dropped.touch;
		
	}
	if (class == "attar")
	{
		dropped.scale = 1;
		dropped.movetype = MOVETYPE_BOUNCE;
		dropped.solid = SOLID_TRIGGER;
		dropped.classname = "artifact_confounding_attar";
		dropped.cnt = 1;
		dropped.origin_z += 12;
		dropped.noise = "items/artifacts/artifactD_pickup.ogg";
		dropped.modelflags = 8;
		dropped.Attar = 1;
		setmodel(dropped, "models/artifacts/confounding_attar.md3");
		setsize(dropped, artifact_nsize, artifact_size);
		dropped.msg = 104;
		dropped.touch = artifact_touch;
		dropped.oldtouch = dropped.touch;
	}
	
	dropped.nextthink = time + 0.1;	// items start after other solids
	dropped.think = check_item_onfloor;
	
	if (class == "shotgun")
	{
		dropped.items = IT_SHOTGUN;
		dropped.spawnflags = ownr.spawnflags;
		dropped.itemisweapon = 1;
		setmodel(dropped, "models/weapons/shotgun/w_shotgun.md3");
		dropped.ammo_shotgun = 2;
		StartItem(1);
		dropped.modelflags = 8;
		dropped.origin_z += 24;
		dropped.rwpn = 1;
		precache_sound(dropped.noise);
		dropped.touch = wammo_touch;
		dropped.msg = 33;
		setsize(dropped, coach_nsize, coach_size);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "coachgun")
	{
		dropped.items = IT_COACHGUN;
		dropped.spawnflags = ownr.spawnflags;
		dropped.itemisweapon = 1;
		setmodel(dropped, "models/weapons/coachgun/w_coachgun.md3");
		dropped.ammo_coachgun = 3;
		StartItem(1);
		dropped.modelflags = 8;
		dropped.origin_z += 24;
		dropped.rwpn = 1;
		precache_sound(dropped.noise);
		dropped.touch = wammo_touch;
		dropped.msg = 3;
		setsize(dropped, coach_nsize, coach_size);
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "retcher")
	{
		dropped.items = IT_RETCHER;
		dropped.spawnflags = ownr.spawnflags;
		dropped.itemisweapon = 1;
		setmodel(dropped, "models/weapons/retcher/w_retcher.md3");
		setsize(dropped, retcher_nsize, retcher_size);
		dropped.ammo_retcher = 6;
		dropped.rwpn = 1;
		StartItem(1);
		dropped.modelflags = 8;
		dropped.origin_z += 24;
		precache_sound(dropped.noise);
		dropped.touch = wammo_touch;
		dropped.msg = 25;
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "spitter")
	{
		dropped.items = IT_SPITTER;
		dropped.spawnflags = ownr.spawnflags;
		dropped.itemisweapon = 1;
		setmodel(dropped, "models/weapons/spitter/w_spitter.md3");
		setsize(dropped, spitter_nsize, spitter_size);
		dropped.ammo_spitter = 20;
		dropped.rwpn = 1;
		StartItem(1);
		dropped.modelflags = 8;
		dropped.origin_z += 24;
		precache_sound(dropped.noise);
		dropped.touch = wammo_touch;
		dropped.msg = 8;
		dropped.oldtouch = dropped.touch;
		
	}

	if (class == "slagcannon")
	{
		dropped.items = IT_CANNON;
		dropped.spawnflags = ownr.spawnflags;
		dropped.itemisweapon = 1;
		setmodel(dropped, "models/weapons/cannon/w_cannon.md3");
		setsize(dropped, slag_nsize, slag_size);
		precache_sound(dropped.noise);
		dropped.ammo_cannon = 20;
		dropped.rwpn = 1;
		StartItem(1);
		dropped.modelflags = 8;
		dropped.origin_z += 24;
		dropped.touch = wammo_touch;
		dropped.msg = 14;
		dropped.oldtouch = dropped.touch;
		
	}

	dropped.velocity = revel;
	dropped.solid = SOLID_TRIGGER;
	
	
 	if(dropped.owner.classname == "coffer")
	{
	dropped.solid = SOLID_NOT;
	dropped.nextthink = time + 0.1;	// items start after other solids
	dropped.think = vel_item;
//	dropped.think = 
	}

};

void(vector org, string class, float ammount, entity slf) convert_to_item = { self.origin = org;
	self.movetype = MOVETYPE_TOSS;
	self.angles = self.angles;
	//	if(!(self.flags &FL_ITEM))
	//	self.flags += FL_ITEM;		// make extra wide
	//self.targetname = string_null;
	self.use = artifact_drop;
	self.classtype = string_null;
	self.classitem1 = 0;
	self.classitem2 = 0;
	self.classitem3 = 0;
	self.classitem4 = 0;
	self.classitem5 = 0;
	vector revel;
	if (class == "ore")
	{
		setmodel(self, "models/items/ore.md3");
		self.noise = "items/ore.ogg";
		self.classname = "ammo_cannon";
		self.msg = 19;
		setsizeitem2(self, shellsl_size);
		self.ammo_cannon = ammount;
			self.alwaystouchable = slf.alwaystouchable;
		self.touch = wammo_touch;
	}	
	if (class == "slugs")
	{
		setmodel(self, "models/items/slugs.md3");
		self.noise = "items/slugs.ogg";
		self.classname = "ammo_slugs";
		self.msg = 18;
		setsizeitem2(self, shellsl_size);
		self.ammo_coachgun = 15;
			self.alwaystouchable = slf.alwaystouchable;
		self.touch = wammo_touch;
	}
	if (class == "cyst")
	{
		setmodel(self, "models/items/cysts.md3");
		setsizeitem2(self, explosives_size);
		self.noise = "items/cysts.ogg";
		self.classname = "ammo_cysts";
		self.msg = 30;
		self.scale = 1;
		self.ammo_retcher = ammount;
			self.alwaystouchable = slf.alwaystouchable;
		self.touch = wammo_touch;
	}
	if (class == "shells")
	{
		setmodel(self, "models/items/shells.md3");
		self.noise = "items/shells.ogg";
		self.classname = "ammo_shells";
		self.msg = 20;
		setsizeitem2(self, shells_size);
		self.ammo_shotgun = ammount;
			self.alwaystouchable = slf.alwaystouchable;
		self.touch = wammo_touch;
	}
	if (class == "shells_inv")
	{
		setmodel(self, "models/items/shells_drop.md3");
		self.avelocity_y = (random() *120 + 120) *crandom();
		self.noise = "items/shells.ogg";
		self.classname = "ammo_shells";
		self.msg = 20;
		setsizeitem2(self, shells_size_invader);
		self.ammo_shotgun = ammount;
		self.touch = wammo_touch;
	}
	if (class == "fangs")
	{
		setmodel(self, "models/items/fangs.md3");
		self.classname = "ammo_fangs";
		self.noise = "items/fangs.ogg";
		self.msg = 21;
		setsizeitem2(self, resin_size);
		self.ammo_spitter = fang_ammount;
		self.touch = wammo_touch;
	}

	if (class == "shard")
	{
		self.noise = "items/armor_shard3.ogg";
		self.rarmorvalue = 10;
		setmodel(self, "models/items/armor_shard.md3");
		self.classname = "armor_shard";
		setsize2(self, shard_nsize, shard_size);
		self.touch = larmor_touch;
		self.color = shard_light_col;
		self.light_lev = shard_lightlev;
		self.msg = 13;
		self.pflags = 128 | 1;
	}
	if (class == "armor")
	{
		self.noise = "items/armor1.ogg";
		self.rarmorvalue = 50;
		setmodel(self, "models/items/armor.md3");
		setsize2(self, armor_nsize, armor_size);
		self.touch = larmor_touch;
		self.classname = "armor_armor";
		self.color = armor_light_col;
		self.light_lev = armor_lightlev;
		self.msg = 2;
		self.pflags = 128 | 1;
	}

	if (class == "helm")
	{
		self.noise = "items/armor1.ogg";
		self.rarmorvalue = 30;
		setmodel(self, "models/items/helm.md3");
		setsize2(self, helm_nsize, helm_size);
		self.classname = "armor_helm";
		self.touch = larmor_touch;
		self.color = helm_light_col;
		self.light_lev = helm_lightlev;
		self.msg = 9;
		self.pflags = 128 | 1;
	}
	if (class == "shard_dark")
	{
		local float r;
		r = floor(random() *3);
		if (r < 1)
			self.noise = "items/armor_shard_dark1.ogg";
		if (r < 2)
			self.noise = "items/armor_shard_dark2.ogg";
		else
			self.noise = "items/armor_shard_dark3.ogg";

		self.classname = "armor_shard_dark";
		self.darmorvalue = 10;
		setmodel(self, "models/items/armor_shard_dark.md3");
		setsize2(self, dark_shard_nsize, dark_shard_size);
		self.touch = larmor_touch;
		self.color = dark_shard_light_col;
		self.light_lev = dark_shard_lightlev;
		self.pflags = 128 | 1;
		self.msg = 6;
	}
	if (class == "armor_dark")
	{
		self.noise = "items/armor_dark1.ogg";
		self.darmorvalue = 50;
		setmodel(self, "models/items/armor_dark.md3");
		setsize2(self, dark_armor_nsize, dark_armor_size);
		self.classname = "armor_armor_dark";
		self.touch = larmor_touch;
		self.color = dark_armor_light_col;
		self.light_lev = dark_armor_lightlev;
		self.pflags = 128 | 1;
		self.msg = 4;
	}

	if (class == "helm_dark")
	{
		self.noise = "items/armor_dark1.ogg";
		self.darmorvalue = 30;
		setmodel(self, "models/items/helm_dark.md3");
		setsize2(self, dark_helm_nsize, dark_helm_size);
		self.touch = larmor_touch;
		self.classname = "armor_helm_dark";
		self.color = dark_helm_light_col;
		self.light_lev = dark_helm_lightlev;
		self.pflags = 128 | 1;
		self.msg = 5;
	}

	if (class == "vial")
	{
		self.noise = "items/lifeblood_vial1.ogg";
		self.pflags = 129;
		self.health = 10;
		self.light_lev = 15;
		self.color = '3 0 0';
		self.colormod = '1 1 1';
		self.classname = "health_life_vial";
		setmodel(self, "models/items/lifeblood_vial.md3");
		setsizeitem2(self, vial_size);
		self.touch = larmor_touch;
		self.oldtouch = self.touch;
		self.msg = 11;
	}

	if (class == "beaker")
	{
		self.noise = ("items/lifeblood_beaker1.ogg");
		self.pflags = 129;
		self.health = 30;
		self.light_lev = 25;
		self.color = '3 0 0';
		self.colormod = '1 1 1';
		self.classname = "health_life_beaker";
		setmodel(self, "models/items/lifeblood_beaker.md3");
		self.touch = larmor_touch;
		setsizeitem2(self, beaker_size);
		self.msg = 10;
//		self.nextthink = time + 0.2;	// items start after other solids
//		self.think = PlaceItem;
//		return;
	}
	if (class == "siphon")
	{
		self.scale = 1;
		self.movetype = MOVETYPE_BOUNCE;
		self.solid = SOLID_TRIGGER;
		self.cnt = 1;
		self.origin_z += 12;
		self.classname = "artifact_life_siphon";
		self.modelflags = 8;
		self.noise = "items/artifacts/artifactF_pickup.ogg";
		self.LifeSiphon = 1;
		setmodel(self, "models/artifacts/life_siphon.md3");
		setsize(self, artifact_nsize, artifact_size);
		self.traileffectnum = particleeffectnum("life_siphon");
		self.msg = 106;
		self.touch = artifact_touch;
	}
	self.velocity = revel;
	self.solid = SOLID_TRIGGER;
	spawn_bbox_collider(self);
	
	if (class == "apparatus")
	{
		self.scale = 1;
		self.movetype = MOVETYPE_BOUNCE;
		self.solid = SOLID_TRIGGER;
		self.cnt = 1;
		self.origin_z += 12;
		self.classname = "artifact_drowners_apparatus";
		self.noise = "items/artifacts/artifactB_pickup.ogg";
		self.modelflags = 8;
		self.DrownerApp = 1;
		setmodel(self, "models/artifacts/drowners_apparatus.md3");
		setsize(self, artifact_nsize, artifact_size);
		self.msg = 102;
		self.touch = artifact_touch;
	}
	if (class == "theter")
	{
		self.scale = 1;
		self.movetype = MOVETYPE_BOUNCE;
		self.solid = SOLID_TRIGGER;
		self.cnt = 1;
		self.origin_z += 12;
		self.classname = "artifact_soul_tether";
		self.modelflags = 8;
		self.noise = "items/artifacts/artifactE_pickup.ogg";
		self.SoulTether = 1;
		precache_model("models/artifacts/soul_tether.md3");
		setmodel(self, "models/artifacts/soul_tether.md3");
		setsize(self, artifact_nsize, artifact_size);
		self.msg = 110;
		self.touch = artifact_touch;
	}

	if (class == "aegis")
	{
		self.scale = 1;
		self.movetype = MOVETYPE_BOUNCE;
		self.solid = SOLID_TRIGGER;
		self.classname = "artifact_cruel_aegis";
		self.cnt = 1;
		self.origin_z += 12;
		self.noise = "items/artifacts/artifactH_pickup.ogg";
		self.modelflags = 8;
		self.Aegis = 1;
		setmodel(self, "models/artifacts/cruel_aegis.md3");
		setsize(self, artifact_nsize, artifact_size);
		self.msg = 108;
		self.touch = artifact_touch;
	}
	if (class == "attar")
	{
		self.scale = 1;
		self.movetype = MOVETYPE_BOUNCE;
		self.solid = SOLID_TRIGGER;
		self.classname = "artifact_confounding_attar";
		self.cnt = 1;
		self.origin_z += 12;
		self.noise = "items/artifacts/artifactD_pickup.ogg";
		self.modelflags = 8;
		self.Attar = 1;
		setmodel(self, "models/artifacts/confounding_attar.md3");
		setsize(self, artifact_nsize, artifact_size);
		self.msg = 104;
		self.touch = artifact_touch;
	}
	if (class == "shotgun")
	{
		self.items = IT_SHOTGUN;
		self.spawnflags = self.spawnflags;
		self.classname = "weapon_shotgun";
		self.itemisweapon = 1;
		setmodel(self, "models/weapons/shotgun/w_shotgun.md3");
		self.ammo_shotgun = 2;
		StartItem(1);
		self.modelflags = 8;
		self.origin_z += 24;
		self.rwpn = 1;
		precache_sound(self.noise);
		self.touch = wammo_touch;
		self.msg = 33;
		setsize(self, coach_nsize, coach_size);
	}

	if (class == "coachgun")
	{
		self.items = IT_COACHGUN;
		self.spawnflags = self.spawnflags;
		self.classname = "weapon_coachgun";
		self.itemisweapon = 1;
		setmodel(self, "models/weapons/coachgun/w_coachgun.md3");
		self.ammo_coachgun = 3;
		StartItem(1);
		self.modelflags = 8;
		self.origin_z += 24;
		self.rwpn = 1;
		precache_sound(self.noise);
		self.touch = wammo_touch;
		self.msg = 3;
		setsize(self, coach_nsize, coach_size);
	}

	if (class == "retcher")
	{
		self.items = IT_RETCHER;
		self.spawnflags = self.spawnflags;
		self.classname = "weapon_retcher";
		self.itemisweapon = 1;
		setmodel(self, "models/weapons/retcher/w_retcher.md3");
		setsize(self, retcher_nsize, retcher_size);
		self.ammo_retcher = 6;
		self.rwpn = 1;
		StartItem(1);
		self.modelflags = 8;
		self.origin_z += 24;
		precache_sound(self.noise);
		self.touch = wammo_touch;
		self.msg = 25;
	}

	if (class == "spitter")
	{
		self.items = IT_SPITTER;
		self.spawnflags = self.spawnflags;
		self.classname = "weapon_spitter";
		self.itemisweapon = 1;
		setmodel(self, "models/weapons/spitter/w_spitter.md3");
		setsize(self, spitter_nsize, spitter_size);
		self.ammo_spitter = 20;
		self.rwpn = 1;
		StartItem(1);
		self.modelflags = 8;
		self.origin_z += 24;
		precache_sound(self.noise);
		self.touch = wammo_touch;
		self.msg = 8;
	}

	if (class == "slagcannon")
	{
		self.items = IT_CANNON;
		self.spawnflags = self.spawnflags;
		self.classname = "weapon_slaggcannon";
		self.itemisweapon = 1;
		setmodel(self, "models/weapons/cannon/w_cannon.md3");
		setsize(self, slag_nsize, slag_size);
		precache_sound(self.noise);
		self.ammo_cannon = 20;
		self.rwpn = 1;
		StartItem(1);
		self.modelflags = 8;
		self.origin_z += 24;
		self.touch = wammo_touch;
		self.msg = 14;
	}
	self.velocity = revel;
	self.solid = SOLID_TRIGGER;


	self.oldtouch = self.touch;
	
};

void() item_Sigil = { StartItem(6);
	self.touch = artifact_touch;
	setsize(self, '-14 -14 -14', '14 14 14');
};

void() key_touch = { if (other.classname != "player")
		return;
	if ((other.items &self.items))
	{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}

	if (self.slot_keys)
	{
		if (!other.slot_keys)
			other.slot_keys = self.slot_keys * 100;
		else
		{
			local string slotdigits, slotdigitsdozen;
			local float slotdozens;
			slotdigits = ftos(other.slot_keys);
			slotdigitsdozen = substring(slotdigits, 1, 2);
			slotdozens = stof(slotdigitsdozen);
			if (slotdozens)
				other.slot_keys += self.slot_keys;
			else
				other.slot_keys += self.slot_keys * 10;
		}
	}
	other.items += self.items;
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	SUB_UseTargets();
	flash_screen_item(other);
	if (self.secret == 1)
	{
		sound(other, CHAN_AUTO, "misc/secret.ogg", 1, ATTN_NONE);
		Hud_message(27, other.origin, other);
		local entity oself;
		oself = self;
		self = other;
		found_secrets = found_secrets + 1;
		self = oself;
		WriteByte(MSG_ALL, SVC_FOUNDSECRET);
	}
	if (deathmatch)
	{
		self.alpha = 0.1;
		self.colormod = '0.5 0.5 1';
		self.solid = SOLID_NOT;
		self.think = respawn_items;
		self.nextthink = time + 25;
	}
	else
	{
		self.effects = EF_NODRAW;
		self.touch = SUB_Null;
		self.solid = SOLID_NOT;

		if (self.msg == 31)
			other.rkeyson = self;
		if (self.msg == 28)
			other.bkeyson = self;
		if (self.msg == 32)
			other.ykeyson = self;
	}
};

void() coffer_key_touch = { if (other.classname != "player")
		return;
	if ((other.items &IT_COFFERKEY3))
	{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}

	
	
	if (!(other.items & IT_COFFERKEY1))
		{other.items += self.items;other.keyson1 = self;}
	else
	{
	if ((other.items & IT_COFFERKEY1) && (other.items & IT_COFFERKEY2) )
		{other.items +=  IT_COFFERKEY3;other.keyson3 = self;}

	else
		{other.items +=  IT_COFFERKEY2;other.keyson2 = self;}

	}
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	SUB_UseTargets();
	flash_screen_item(other);
	if (self.secret == 1)
	{
		sound(other, CHAN_AUTO, "misc/secret.ogg", 1, ATTN_NONE);
		Hud_message(27, other.origin, other);
		local entity oself;
		oself = self;
		self = other;
		found_secrets = found_secrets + 1;
		self = oself;
		WriteByte(MSG_ALL, SVC_FOUNDSECRET);
	}
	if (deathmatch)
	{
		self.alpha = 0.1;
		self.colormod = '0.5 0.5 1';
		self.solid = SOLID_NOT;
		self.think = respawn_items;
		self.nextthink = time + 25;
	}
	else
	{
		self.effects = EF_NODRAW;
		self.touch = SUB_Null;
		self.solid = SOLID_NOT;

	}
};
void() key_coffer = { self.modelflags = 8;
	self.rwpn = 1;
	self.noise = "items/coffer_key.ogg";
	precache_sound(self.noise);
	self.items = IT_COFFERKEY1;
	setmodel(self, "models/items/coffer_key1.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.light_lev = cofferkey_lightlev;
	self.color = cofferkey_light_col;
	StartItem(4);
	self.scale = 1;
	self.classname = "coffer_key";
	self.touch = coffer_key_touch;
	self.msg = 23;
	self.wrathflags += FL_RESPAWN;
	copy_old_data(self);
};

/*Plays sound when unlocked by glyph (objects/door_unlocked.ogg)
ITEM_GLYPH_BLUE
-4 -4 -4, 4 4 4 bbox
items/glyph.ogg (played when picked up)
models/items/glyph_blue.md3
Hud element (icon in upper right hand corner where coffer key icon goes) gfx/hud/glyph_blue.tga
Show message on pick up (gfx/hud/msg_glyph_blue.tga)
*/

void() key_red = { self.noise = "items/glyph.ogg";
	precache_sound(self.noise);
	self.items = IT_KEY1;
	setmodel(self, "models/items/glyph_red.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	StartItem(1);
	self.scale = 1;
	self.touch = key_touch;
	self.msg = 31;
	self.slot_keys = 1;
	self.wrathflags += FL_RESPAWN;
	copy_old_data(self);
};

void() key_blue = { self.noise = "items/glyph.ogg";
	precache_sound(self.noise);
	self.items = IT_KEY2;
	setmodel(self, "models/items/glyph_blue.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	StartItem(1);
	self.scale = 1;
	self.touch = key_touch;
	self.msg = 28;
	self.slot_keys = 2;
	self.wrathflags += FL_RESPAWN;
	copy_old_data(self);
};

void() key_yellow = { self.noise = "items/glyph.ogg";
	precache_sound(self.noise);
	self.items = IT_KEY3;
	setmodel(self, "models/items/glyph_yellow.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	StartItem(1);
	self.scale = 1;
	self.touch = key_touch;
	self.msg = 32;
	self.slot_keys = 3;
	self.wrathflags += FL_RESPAWN;
	copy_old_data(self);
};

.float relic_dthou;
.float relic_thou;
.float relic_cent;
.float relic_doze;
.float relic_unit;

void() relic_touch = { if (other.classname != "player")
		return;
	if ((other.relics &self.relics))
	{if(other.time_emptymessage < time)Hud_message(109, other.origin, other);other.time_emptymessage = time + 2.1;return;}
	other.relics += self.relics;
	other.foundedrelics += self.relics;
	other.oldrelics++;
	if (self.slot_relics)
	{
		if (!other.slot_relics)
			other.slot_relics = self.slot_relics * 10000;
		else
		{
			local string slotdigits, slotdigitsdozen, slotdigitscent, slotdigitsthou;
			local float slotdozens, slotcents, slotthou;
			slotdigits = ftos(other.slot_relics);
			slotdigitsthou = substring(slotdigits, 1, 2);

			slotthou = stof(slotdigitsthou);
			if (!slotthou)
				other.slot_relics += self.slot_relics * 1000;
			else
			{
				slotdigitscent = substring(slotdigits, 2, 3);
				slotcents = stof(slotdigitscent);
				if (!slotcents)
					other.slot_relics += self.slot_relics * 100;
				else
				{
					slotdigitsdozen = substring(slotdigits, 3, 4);
					slotdozens = stof(slotdigitsdozen);
					if (!slotdozens)
						other.slot_relics += self.slot_relics * 10;
					else
						other.slot_relics += self.slot_relics;
				}
			}
		}
	}
	sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
	if (self.msg)
		Hud_message(self.msg, other.origin, other);
	SUB_UseTargets();
	flash_screen_item(other);
	slotdigits = ftos(other.slot_relics);
	other.relic_dthou = stof(substring(slotdigits, 0, 1));
	other.relic_thou = stof(substring(slotdigits, 1, 1));
	other.relic_cent = stof(substring(slotdigits, 2, 1));
	other.relic_doze = stof(substring(slotdigits, 3, 1));
	other.relic_unit = stof(substring(slotdigits, 4, 1));

	remove(self);
};

void() relic_e1m1 = { self.noise = "items/relic.ogg";
	precache_sound(self.noise);
	self.relics = RL_E1M1;
	setmodel(self, "models/items/relic.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.skin = 1;
	StartItem(1);
	self.touch = relic_touch;
	self.msg = 50;
	self.slot_relics = 1;
};
void() relic_e1m2 = { self.noise = "items/relic.ogg";
	precache_sound(self.noise);
	self.relics = RL_E1M2;
	setmodel(self, "models/items/relic.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.skin = 2;
	StartItem(1);
	self.touch = relic_touch;
	self.msg = 51;
	self.slot_relics = 2;

};
void() relic_e1m3 = { self.noise = "items/relic.ogg";
	precache_sound(self.noise);
	self.relics = RL_E1M3;
	setmodel(self, "models/items/relic.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.skin = 3;
	StartItem(1);
	self.touch = relic_touch;
	self.msg = 52;
	self.slot_relics = 3;

};
void() relic_e1m4 = { self.noise = "items/relic.ogg";
	precache_sound(self.noise);
	self.relics = RL_E1M4;
	setmodel(self, "models/items/relic.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.skin = 4;
	StartItem(1);
	self.touch = relic_touch;
	self.msg = 53;
	self.slot_relics = 4;

};

void() relic_e1m5 = { self.noise = "items/relic.ogg";
	precache_sound(self.noise);
	self.relics = RL_E1M5;
	setmodel(self, "models/items/relic.md3");
	setsize(self, coffer_key_nsize, coffer_key_size);
	self.skin = 5;
	StartItem(1);
	self.touch = relic_touch;
	self.msg = 54;
	self.slot_relics = 5;

};


void() coffer_item_think = { local entity pl;
	pl = find(world, classname, "player");
	setorigin(self, pl.origin);
	self.think = SUB_Remove;
	self.nextthink = time + 2.5;
};


.float coffer_random_order;

.float coffer_step;


void() trigger_coffer_use = 
{ 	local entity ca, ch;
	self.classname = "coffer";


	if((self.counter_coffer_use == self.counter_coffer_ammount))
	self.think = SUB_Null;
	else
	self.think = trigger_coffer_use ;
	self.nextthink = time + 0.25;

	if (self.coffer_artifacts)
	{
		self.counter_coffer_use ++;
		ca = spawn();
		if (self.coffer_artifacts == 2)
			drop_item(self.origin + '0 0 32', "apparatus", 1, self);
		if (self.coffer_artifacts == 4)
			drop_item(self.origin + '0 0 32', "attar", 1, self);
		else if (self.coffer_artifacts == 5)			
			drop_item(self.origin + '0 0 32', "theter", 1, self);
		else if (self.coffer_artifacts == 6)
			drop_item(self.origin + '0 0 32', "siphon", 1, self);
		else if (self.coffer_artifacts == 8)
			drop_item(self.origin + '0 0 32', "aegis", 1, self);
			self.coffer_artifacts = 0;
		return;		
	}		
	if (self.coffer_ammo)
	{
		self.counter_coffer_use ++;
		if (self.coffer_ammo == 1)
			drop_item(self.origin + '0 0 32', "slugs", 15, self);
		else if (self.coffer_ammo == 2)
			drop_item(self.origin + '0 0 32', "shells", 10, self);
		else if (self.coffer_ammo == 3)
			drop_item(self.origin + '0 0 32', "fangs", 20, self);
		else if (self.coffer_ammo == 4)
			drop_item(self.origin + '0 0 32', "cysts", 10, self);
		self.coffer_ammo = 0;
		return;		
	}
	if (self.coffer_armor)
	{
		self.counter_coffer_use ++;
		if (self.coffer_armor == 1)
			drop_item(self.origin + '0 0 32', "shard", 1, self);
		if (self.coffer_armor == 2)
			drop_item(self.origin + '0 0 32', "armor", 1, self);
		if (self.coffer_armor == 3)
			drop_item(self.origin + '0 0 32', "helm", 1, self);
		if (self.coffer_armor == 4)
			drop_item(self.origin + '0 0 32', "shard_dark", 1, self);
		if (self.coffer_armor == 5)
			drop_item(self.origin + '0 0 32', "armor_dark", 1, self);
		if (self.coffer_armor == 6)
			drop_item(self.origin + '0 0 32', "helm_dark", 1, self);
		self.coffer_armor = 0;
		return;		
	}
	if (self.coffer_health)
	{
		self.counter_coffer_use ++;
		ch = spawn();
		if (self.coffer_health == 1)
			drop_item(self.origin + '0 0 32', "vial", 1, self);
		if (self.coffer_health == 2)
			drop_item(self.origin + '0 0 32', "beaker", 1, self);
		self.coffer_health = 0;
		return;		
	}

};

void() trigger_coffer = { self.use = trigger_coffer_use;
};

void() manuscript_touch = { if (other.classname != "player")
		return;
	if (!(other.journal_jmessages &self.journal_jmessages))
	{
		other.journal_jmessages += self.journal_jmessages;
		sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
		remove(self);
	}
	if (!(other.journal_jmessagesm &self.journal_jmessagesm))
	{
		other.journal_jmessagesm += self.journal_jmessagesm;
		sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
		remove(self);
	}
};
.float bestiary;
.float jmessage;
.float jmessagem;
void() item_manuscript = { setmodel(self, "models/items/manuscript.md3");
	setsizeitem(self, '4 4 24');
	self.noise = "misc/null.wav";
	precache_sound(self.noise);
	if (!(self.bestiary))
	{
		if (!self.jmessage)
			self.jmessage = 1;
		self.journal_jmessages = pow(2, (self.jmessage - 1));
		if (self.jmessage == 1)
			self.journal_jmessages = 1;
	}
	else
	{
		if (!self.jmessagem)
			self.jmessagem = 1;
		self.journal_jmessagesm = pow(2, (self.jmessagem - 1));
		if (self.jmessagem == 1)
			self.journal_jmessagesm = 1;
	}
	self.origin_z += 24;
	self.light_lev = 64;
	self.pflags = 129;
	self.color = '1 1 0.5';
	self.effects = 512;
	StartItem(1);
	self.scale = 0.5;
	self.touch = manuscript_touch;

};

void() coffer_model_think = { self.frame = self.owner.frame;
	self.glowmod = self.owner.glowmod;
	self.think = coffer_model_think;
	self.nextthink = time + 0.01;
	if (self.frame == 1)
		self.usable = 0;
	if (self.owner.frame >= 19)
	{
		self.nextthink = time + 1;
		self.think = null;
	}
};

void() use_coffer = { local float ft;
	//	if(self.frame == -5)
	//		sound (self, CHAN_AUTO, "objects/coffers/coffer1_locked_activate.ogg", 1, ATTN_NORM);
	self.frame += 1;
	if (self.frame <= 10)
	{
		self.glowmod_x -= 0.11;
		self.glowmod_y -= 0.11;
		self.glowmod_z -= 0.11;
	}
	if (self.frame < 1)
		ft = 0.1;
	if (self.frame == 1)
	{
		//	if(self.frame == 17)
		sound(self, CHAN_AUTO, "objects/coffers/coffer1_unlocked.ogg", 1, ATTN_NORM);

		//	sound (self, CHAN_AUTO, "objects/coffers/coffer1_locked_rotate.ogg", 1, ATTN_NORM);
		self.use = null;
		self.classname = "coffer_open";
	}
	if ((self.frame >= 1) && (self.frame <= 15))
	{
		ft = 0.1;
	}
	if (self.frame == 16)
	{
		ft = 0.4;
	}
	if (self.frame > 16)
		ft = 0.1;
	if (self.frame == 18)
	{		
		SUB_UseTargets();
	}
	self.nextthink = time + ft;
	self.think = use_coffer;
	if (self.frame >= 19)
	{
		//self.counter_coffer_use ++;
	if (self.coffer_artifacts)
	self.counter_coffer_ammount ++;
	if (self.coffer_ammo)
	self.counter_coffer_ammount ++;
	if (self.coffer_armor)
	self.counter_coffer_ammount ++;
	if (self.coffer_health)
	self.counter_coffer_ammount ++;
		self.nextthink = time + ft;
		self.think = trigger_coffer_use;
	}
};

void() object_coffer = { self.glowmod = '1 1 1';
	//self.noise = 
	self.noise2 = "objects/coffers/coffer1_locked.ogg";
	self.classname = "coffer";
	self.frame = 0;
	self.usable = 1;
	self.keyrequired = 1;
	self.alpha = -1;
	local entity coffer_model;
	coffer_model = spawn();
	coffer_model.usable = 1;
	coffer_model.owner = self;
	setmodel(coffer_model, "models/objects/coffers/coffer1_locked.md3");
	setattachment(coffer_model, self, "");
	coffer_model.think = coffer_model_think;
	coffer_model.nextthink = time + 0.05;
	precache_model("models/objects/coffers/coffer1_collision.md3");
	self.solid = SOLID_BSP;
	setmodel(self, "models/objects/coffers/coffer1_collision.md3");
	self.use = use_coffer;
};
void() cannon_item_think = {	//void(float effectnum, vector org, vector vel, float howmany) pointparticles 

	if (self.cnt != 1)
	{
		self.glowmod_x += 0.05;
		self.glowmod_y += 0.05;
		self.glowmod_z += 0.05;
		self.light_lev += 0.5;
		self.color_x += 0.05;
		self.color_y += 0.1;
		self.color_z += 0.05;
		self.count += 1;

		if (self.glowmod_x >= 2.2)
			self.cnt = 1;
	}
	else
	{
		self.color_x -= 0.05;
		self.color_y -= 0.1;
		self.color_z -= 0.05;
		self.glowmod_x -= 0.05;
		self.glowmod_y -= 0.05;
		self.glowmod_z -= 0.05;
		self.light_lev -= 0.5;
		self.count -= 1;
		if (self.glowmod_x <= 0.2)
			self.cnt = 0;
	}

	if (self.glowmod_x > 1.9)
		pointparticles(particleeffectnum("cystsnow4"), self.origin, '0 0 0', 1);
	if ((self.glowmod_x < 1.9) && (self.glowmod_x > 1.6))
		pointparticles(particleeffectnum("cystsnow3"), self.origin, '0 0 0', 1);
	if ((self.glowmod_x < 1.6) && (self.glowmod_x > 1.2))
		pointparticles(particleeffectnum("cystsnow2"), self.origin, '0 0 0', 1);
	if ((self.glowmod_x < 1.2) && (self.glowmod_x > 0.8))
		pointparticles(particleeffectnum("cystsnow1"), self.origin, '0 0 0', 1);
	if (self.glowmod_x < 0.8)
		pointparticles(particleeffectnum("cystsnow"), self.origin, '0 0 0', 1);

	self.think = cannon_item_think;
	self.nextthink = time + 0.1;
};
void() cannon_item = { setmodel(self, "models/projectiles/proj_cyst.md3");
	self.glowmod = '0.2 0.2 0.2';
	self.color = '0.5 1 0.5';
	self.scale = 1;
	self.cnt = 0;
	self.light_lev = 32;
	self.pflags = 131;
	self.think = cannon_item_think;
	self.nextthink = time + 0.05;
};

///////////////end of qc file