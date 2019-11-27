.float explodcount;
.float gwmd;
void() wfire_cannon;

void() idle_cannon = { if (self.playerdeadtime > time)
	{
		self.think = PlayerDeathThink;
		self.nextthink = time;
	}

	self.realoding = 0;
	self.vweaponframe = 0;
	if (self.pick_up_time < time)
		self.vweaponstate = 0;
	self.vweaponglowmod = '1 1 1';
	self.vweaponskin = 0;
};

void() prelease_cannon = { self.vweaponframe += 1;
	if (self.vweaponframe >= 20)
		self.think = idle_cannon;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() slag2_explode10 = { self.skin += 1;self.think = SUB_Remove;self.nextthink = time + 0.05;
};
void() slag2_explode9 = { self.skin += 1;self.think = slag2_explode10;self.nextthink = time + 0.05;
};
void() slag2_explode8 = { self.skin += 1;self.think = slag2_explode9;self.nextthink = time + 0.05;
};
void() slag2_explode7 = { self.skin += 1;self.think = slag2_explode8;self.nextthink = time + 0.05;
};
void() slag2_explode6 = { self.skin += 1;self.think = slag2_explode7;self.nextthink = time + 0.05;
};
void() slag2_explode5 = { self.skin += 1;self.think = slag2_explode6;self.nextthink = time + 0.05;
};
void() slag2_explode4 = { self.skin += 1;self.think = slag2_explode5;self.nextthink = time + 0.05;
};
void() slag2_explode3 = { self.skin += 1;self.think = slag2_explode4;self.nextthink = time + 0.05;
};
void() slag2_explode2 = { self.skin += 1;self.think = slag2_explode3;self.nextthink = time + 0.05;
};
void() slag2_explode1 = { self.skin += 0;self.think = slag2_explode2;self.nextthink = time + 0.05;
};
void() slag_explode5 = { self.skin += 1;self.think = SUB_Remove;self.nextthink = time + 0.05;
};
void() slag_explode4 = { self.skin += 1;self.think = slag_explode5;self.nextthink = time + 0.05;
};
void() slag_explode3 = { self.skin += 1;self.think = slag_explode4;self.nextthink = time + 0.05;
};
void() slag_explode2 = { self.skin += 1;self.think = slag_explode3;self.nextthink = time + 0.05;
};
void() slag_explode1 = { self.skin += 0;self.think = slag_explode2;self.nextthink = time + 0.05;
};

void() slagdrunk = { self.explodcount += 1;
	self.velocity = ((self.velocity + ((v_right *20.000) *crandom())) + ((v_up *20.000) *crandom()));
	self.nextthink = time + 0.1;	// screw up fast
	if (self.explodcount < 50)
		self.think = slagdrunk;
	else
		self.think = SUB_Remove;
};

void() srelease_cannon2 = { self.vweaponframe += 1;
	if (self.vweaponframe >= 40)
		self.think = idle_cannon;
	else
		self.think = srelease_cannon2;
	self.nextthink = time + 0.05;
};

void() srelease_cannon = { self.vweaponframe = 31;
	self.think = srelease_cannon2;
	self.nextthink = time + 0.05;
};

void(float m) BecomeExplosion = { self.movetype = MOVETYPE_NONE;

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	local float skinn;
	skinn = ceil(random() *4);
	if (skinn == 4)
		skinn = 0;
	self.solid = SOLID_NOT;
	makevectors(self.angles);
	self.origin = self.origin + v_forward *-12 + v_up *-5;
	if (m == 1)
	{
		self.skin = skinn * 5;
		setmodel(self, "particles/explo/explo_slag1.md3");
		slag_explode1();
	}
	else
	{
		self.skin = skinn * 10;
		//	te_customflash (self.origin, 120, 0.25, '1 0.8 0');
		setmodel(self, "particles/explo/explo_slag2.md3");
		slag2_explode1();
	}
};

void() ore_touch = { local vector org;
	org = self.origin;
	local string snd;
	self.classname = "explosionn";
	if (self.cnt == 1)
	{
		T_SplashDamage(self, self.owner, slagsplashdamage, world, slagsplashradius);
		T_Damage(other, self, self.owner, self.owner.slagcannon_damage1);
		BecomeExplosion(1);
		snd = strcat("impact/projectiles/slag1_explo", ftos(floor(random() *5) + 1), ".ogg");
		pointparticles(particleeffectnum("slag"), org, v_forward *(-550), 1);
		sound(self, CHAN_AUTO, snd, 1, 0.25);
	}
	else
	{
		T_SplashDamage(self, self.owner, slagsplashdamage2, world, slagsplashradius2);
		T_Damage(other, self, self.owner, self.owner.slagcannon_damage2);
		BecomeExplosion(2);
		snd = strcat("impact/projectiles/slag2_explo", ftos(floor(random() *3) + 1), ".ogg");
		pointparticles(particleeffectnum("slag2"), org, v_forward *(-550), 1);
		sound(self, CHAN_AUTO, snd, 1, 0.125);
	}
};
void(float type, float forg) W_FireCannon = { local vector dir, rorg, tagorg;
	local float sv, tagindex;

	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.classname = "ore";
	dir = aim(self, 1000);
	rorg = self.view_ofs - '0 0 19';

	if (type == 1)
	{
		local string tagname;
		tagname = strcat("muzzle_", ftos(forg));
		tagindex = gettagindex(self.vweapon, tagname);
		tagorg = gettaginfo(self.vweapon, tagindex);
		sv += 0.0075 *self.slagcannonspread;
		setorigin(newmis, tagorg);
		setmodel(newmis, "models/projectiles/proj_slag1.md3");
		newmis.cnt = 1;
		newmis.think = slagdrunk;
		newmis.nextthink = time + 0.08;
		newmis.traileffectnum = particleeffectnum("slagtrail");
		newmis.velocity = normalize(self.cursor_trace_endpos - newmis.origin) *slagspeed;
		self.ammo_cannon -= 1;
	}
	else
	{
		tagindex = gettagindex(self.vweapon, "muzzle_4");
		tagorg = gettaginfo(self.vweapon, tagindex);
		newmis.scale = 1;
		setorigin(newmis, tagorg);
		setmodel(newmis, "models/projectiles/proj_slag2.md3");
		newmis.think = SUB_Remove;
		newmis.nextthink = time + 5;
		newmis.traileffectnum = particleeffectnum("slagtrail2");
		newmis.velocity = normalize(self.cursor_trace_endpos - newmis.origin) *slagspeed2;
		self.ammo_cannon -= 5;
	}

	setsize(newmis, '0 0 0', '0 0 0');
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = ore_touch;
	newmis.effects = EF_NOSHADOW;
	self.punchangle_x = -2;
	self.vweaponframe = 3;
};

void() wfire_cannon14 = { self.vweaponframe = 15;
	if ((self.button0) && (self.ammo_cannon >= 1))
	{
		self.think = wfire_cannon;
		self.attack_finished = time + 0.25;
	}
	else
	{
		self.vweaponframe = 16;
		self.think = prelease_cannon;
	}

	self.nextthink = time + 0.05;
};

void() wfire_cannon13 = { self.vweaponframe = 14;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon14;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon12 = { local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 3);
	self.vweaponframe = 13;
	self.think = wfire_cannon13;
	self.nextthink = time + 0.05;
};

void() wfire_cannon11 = { self.vweaponframe = 12;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon12;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon10 = { local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 2);
	self.vweaponframe = 11;
	self.think = wfire_cannon11;
	self.nextthink = time + 0.05;
};

void() wfire_cannon9 = { self.vweaponframe = 10;
	if ((self.button0) && (self.ammo_cannon >= 1))
	{
		self.think = wfire_cannon10;
		self.attack_finished = time + 0.25;
	}
	else
	{
		self.vweaponframe = 16;
		self.think = prelease_cannon;
	}

	self.nextthink = time + 0.05;
};

void() wfire_cannon8 = { self.vweaponframe = 9;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon9;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon7 = { local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 1);
	self.vweaponframe = 8;
	self.think = wfire_cannon8;
	self.nextthink = time + 0.05;
};

void() wfire_cannon6 = { self.vweaponframe = 7;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon7;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon5 = { local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 3);
	self.vweaponframe = 6;
	self.think = wfire_cannon6;
	self.nextthink = time + 0.05;
};

void() wfire_cannon4 = { self.vweaponframe = 5;
	if ((self.button0) && (self.ammo_cannon >= 1))
	{
		self.think = wfire_cannon5;
		self.attack_finished = time + 0.25;
	}
	else
	{
		self.vweaponframe = 16;
		self.think = prelease_cannon;
	}

	self.nextthink = time + 0.05;
};

void() wfire_cannon3 = { self.vweaponframe = 4;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon4;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon2 = { local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 2);
	self.vweaponframe = 3;
	self.think = wfire_cannon3;
	self.nextthink = time + 0.05;
};

void() wfire_cannon1 = { self.vweaponframe = 2;
	if (self.ammo_cannon >= 1)
		self.think = wfire_cannon2;
	else
		self.think = prelease_cannon;
	self.nextthink = time + 0.05;
};

void() wfire_cannon = { if (self.ammo_cannon < 1)
		return;
	local string snd;
	snd = strcat("weapons/cannon/fire1_", ftos(floor(random() *3) + 1), ".ogg");
	sound(self, CHAN_AUTO, snd, 1, ATTN_NORM);
	//self.ammo_cannon -= 1;
	W_FireCannon(1, 1);
	self.vweaponframe = 1;
	self.think = wfire_cannon1;
	self.attack_finished = time + 0.25;
	self.nextthink = time + 0.05;
};

void() wsfire_cannon1 = { self.vweaponframe += 1;
	if (self.vweaponframe >= 30)
	{
		if ((self.button3) && (self.ammo_cannon >= 50))
			self.think = wsfire_cannon;
		else
			self.think = srelease_cannon;
	}
	else
		self.think = wsfire_cannon1;
	self.nextthink = time + 0.05;
};

void() wsfire_cannon = { if (self.ammo_cannon < 5)
		return;
	local string snd;
	snd = strcat("weapons/cannon/fire2_", ftos(floor(random() *2) + 1), ".ogg");
	sound(self, CHAN_WEAPON, snd, 1, ATTN_NORM);
	W_FireCannon(2, 1);
	//self.ammo_cannon -= 50;
	self.vweaponframe = 21;
	self.think = wsfire_cannon1;
	self.nextthink = time + 0.05;
	self.attack_finished = time + 0.5;
};

void() pick_up_cannon2 = { if (self.vweaponglowmod_x < 1)
	{
		self.vweaponglowmod_x += 0.025;
		self.vweaponglowmod_y += 0.025;
		self.vweaponglowmod_z += 0.025;
	}

	if (time > self.attack_finished)
	{
		self.pick_up_time = time + 0.5;
		self.vweaponstate = 1;
		self.think = idle_cannon;
		self.vweaponglowmod = '1 1 1';
	}
	else
		self.think = pick_up_cannon2;
	self.nextthink = time + 0.05;
};

void() pick_up_cannon = { self.weapon = IT_CANNON;
	self.lastweapon = IT_CANNON;
	W_SetWeapon();

	sound(self, CHAN_WEAPON, "weapons/cannon/inspect.ogg", 1, ATTN_NORM);
	self.draw_w = 0;
	self.vweaponstate = 2;
	self.vweaponframe = 61;
	self.vweaponglowmod = '0.01 0.01 0.01';
	if (self.noltime < time)
		self.lspeedtime = time + 2;
	self.attack_finished = time + 0.05;
	self.think = pick_up_cannon2;
	self.nextthink = time + 0.95;
};

void() raise_cannon2 = { if (self.vweaponframe == 42)
		W_SetWeapon();

	self.vweaponframe += 1;
	if (self.vweaponframe >= 50)
		self.think = idle_cannon;
	else
		self.think = raise_cannon2;
	self.nextthink = time + 0.0125;
};

void() raise_cannon = { self.weapon = IT_CANNON;
	W_SetWeapon();
	sound(self, CHAN_WEAPON, "weapons/cannon/raise.ogg", 1, ATTN_NORM);
	self.vweaponglowmod = '1 1 1';
	sound(self, CHAN_AUTO, "weapons/cannon/raise.ogg", 1, ATTN_NORM);
	self.draw_w = 0;
	self.vweaponframe = 41;
	self.vweaponstate = 1;
	self.nextthink = time + 0.0125;
	self.attack_finished = time + 0.125;
	self.think = raise_cannon2;
};

void() lower_cannon2 = { self.vweaponframe += 1;
	if (self.vweaponframe >= 60)
		self.think = raise_weapon;
	else
		self.think = lower_cannon2;
	self.nextthink = time + 0.0125;
};

void() lower_cannon = { sound(self, CHAN_WEAPON, "weapons/cannon/lower.ogg", 1, ATTN_NORM);
	self.vweaponframe = 51;
	self.attack_finished = time + 0.375;
	self.think = lower_cannon2;
	self.vweaponstate = 2;
	self.nextthink = time + 0.0125;
};

///////////////////////////////////end of qc file