//============================================================================
float EASEUNDERCURRENT = 16;

.float fakewatertype;
.float water_movflag;
void() CheckFuncWaterDeath = {};

void() func_water_use = { if (self.water_movflag == 1)
	{
		SUB_CalcMove(self.pos1, self.speed, SUB_Null);
		self.water_movflag = 0;
	}
	else
	{
		SUB_CalcMove(self.pos2, self.speed, SUB_Null);
		self.water_movflag = 1;
	}
};

//============================================================================
.float deep;
void() liquid_touch = { local float test;
	local float c;
	if (other.classname == "decal")
		remove(other);

	if (other.health <= 0)
		return;

	if (!(other.flags &FL_CLIENT))
	{
		// Handle some special cases (always set think1 as death function!)
		if (other.classname == "drip")
		{
			setorigin(other, other.origin + '0 0 6');
			self = other;
			self.think1();
			return;
		}

		if (other.movetype == MOVETYPE_NONE ||
			other.movetype == MOVETYPE_PUSH ||
			other.movetype == MOVETYPE_NOCLIP)	// MOVETYPE_WALK is always FL_CLIENT so don't worry about it
			return;

		if (other.fwatershifttime < time && other.watertype)
		{
			other.watertype = self.fakewatertype;
			other.waterlevel = 1;
		}

		// C code will go nuts with the splash sound if we don't time out while in func_water
		other.fwatershifttime = time + 0.1;
		return;
	}

	other.watertype_time = time + 0.05;

	test = other.origin_z + other.mins_z + 1;
	if ((test <= self.absmax_z && test >= self.absmin_z) || (other.zerogtime > time))
	{
		other.fakewatertype = self.fakewatertype;
		other.waterlevel = 1;

		// Test Torso
		test = other.origin_z + (other.mins_z + other.maxs_z) *0.5;
		if (test <= self.absmax_z)
		{
			other.waterlevel = 2;
			other.zerogtime = time + 0.05;	// remove gravity in PreThink
		}

		// Test Eyes
		test = other.origin_z + other.view_ofs_z;
		if ((test <= self.absmax_z) || (self.deep == 1))
		{
			other.waterlevel = 3;

			// Do the color shift
			stuffcmd(other, "v_cshift ");
			stuffcmd(other, self.cshift);
			stuffcmd(other, "\n");

			// Tell PreThink to clear the cshift when the player is out
			other.fwatershifttime = time + frametime;
			other.fwatershift = TRUE;
		}

		// Add drag and/or current
		if (self.spawnflags &EASEUNDERCURRENT) c = 4 - other.waterlevel;
		else c = other.waterlevel;
		if (self.drag) other.velocity = other.velocity + self.velocity *(self.drag *frametime) *c;
		if (self.mangle != '0 0 0') other.velocity = other.velocity + self.mangle *frametime *(c / 3);
	}
};

void() func_water = { if (self.noise != string_null)
		precache_sound(self.noise);
	if (self.noise1 != string_null)
		precache_sound(self.noise1);
	if (self.noise2 != string_null)
		precache_sound(self.noise2);

	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_NOCLIP;
	setmodel(self, self.model);
	setsize(self, self.mins, self.maxs);
	setorigin(self, self.origin);
	self.rel_origin = self.origin;

	self.classname = "fliquid";
	self.dphitcontentsmask = self.watertype;
	self.touch = liquid_touch;
	self.fakewatertype = self.watertype;

	if (self.fakewatertype < -5 || self.fakewatertype > -3)
		self.fakewatertype = CONTENT_WATER;

	if (self.cshift == string_null)
	{
		if (self.fakewatertype == CONTENT_WATER)
		{
			self.cshift = "130 80 50 128";
		}
		else if (self.fakewatertype == CONTENT_SLIME)
			self.cshift = "0 25 5 150";
		else if (self.fakewatertype == CONTENT_LAVA)
			self.cshift = "255 80 0 150";
	}

	if (self.targetname)
		self.movetype = MOVETYPE_PUSH;

	SetMovedir();
	if (!self.lip)
		self.lip = 8;
	if (!self.speed)
		self.speed = 100;

	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir *(fabs(self.movedir *self.size) - self.lip);

	if (self.spawnflags &1)
	{
		// start moved
		setorigin(self, self.pos2);
		self.water_movflag = 1;
	}

	self.use = func_water_use;

	// Cap drag force
	if (self.drag > 100) self.drag = 100;
	if (self.drag < 0) self.drag = 0;

	if (self.mangle != '0 0 0')
		self.mangle = self.mangle * 50;

};
///////////////////////////