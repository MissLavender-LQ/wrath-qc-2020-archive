.float doorstate;
.float notouch;
void() door_return;

void() door_wait = { self.state = STATE_TOP;
	activator = self.enemy;
	self.usable = 0;
	self.nextthink = self.ltime + self.wait;
	sound(self, CHAN_VOICE, self.noise2, self.volume, self.atten);

	self.think = door_return;
};
void() door_fire;
void() door_blocked = { if (other.classname == "fallen")
		other.solid = SOLID_CORPSE;
	T_Damage(other, self, self, self.dmg);

	/*
	if (self.state == STATE_UP || self.state == STATE_TOP)
	{
		door_return();
		return;
	}
	else
	door_fire(); */
};

void() door_done = { sound(self, CHAN_VOICE, self.noise2, self.volume, self.atten);
	self.state = STATE_BOTTOM;
	if (!self.notouch)
		self.usable = 1;
	self.solid = SOLID_BSP;

};

void() door_return = { self.state = STATE_DOWN;
	self.usable = 0;
	sound(self, CHAN_VOICE, self.noise, self.volume, self.atten);
	SUB_CalcMove(self.pos1, self.speed, door_done);
};

void() door_fire = { if (self.state == STATE_UP || self.state == STATE_TOP)
	{
		door_return();
		return;
	}

	sound(self, CHAN_VOICE, self.noise, 1, self.atten);
	self.state = STATE_UP;
	self.usable = 0;
	SUB_CalcMove(self.pos2, self.speed, door_wait);
};

void() door_use = { self.enemy = activator;
	door_fire();
};
void() door_puse = { SUB_UseTargets();
	SUB_UseTargets2();	//targetname2 for double doors
	door_fire();
};
.float metaldoor;
void() func_door = { if (self.keyrequired == 4)
	{
		if (!self.noise)
			self.noise = "doors/coffer_open.ogg";
		self.noise2 = "doors/coffer_locked.ogg";
	}

	/*	else
		{
			if(!self.noise)
				self.noise = "misc/Door_Move.wav";
			if(self.metaldoor >= 1)
				self.noise = "misc/Metal_Gate_Open.wav";
			if(!self.noise2)
				self.noise2 = "misc/Door_Stop_Move.wav";
		}

	*/
	local float attn;
	if (!self.volume)
		self.volume = 1;
	if (!self.rad_sound)
		self.rad_sound = 512;
	attn = 256 / self.rad_sound;	// 200 for snd_soundradius default cvar!
	if (self.rad_sound <= 0)
		attn = 0;
	self.atten = attn;

	precache_sound(self.noise);
	precache_sound(self.noise2);
	SetMovedir();
	self.classname = "func_door";
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	setmodel(self, self.model);
	if (!self.speed)
		self.speed = 60;
	self.use = door_use;
	if (!self.wait)
		self.wait = 1;
	if (self.keyrequired)
		self.wait = -1;
	if (!self.lip)
		self.lip = 0;
	if (!self.notouch)
		self.usable = 1;

	self.blocked = door_blocked;
	self.state = STATE_BOTTOM;
	self.doorstate = 0;
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir *(fabs(self.movedir *self.size) - self.lip);
	if (self.spawnflags &1)
	{
		setorigin(self, self.pos2);
		self.pos2 = self.pos1;
		self.pos1 = self.origin;
	}

	if (self.keyrequired)
		self.usable = 1;
};

///////////////////////////////////end of qc file