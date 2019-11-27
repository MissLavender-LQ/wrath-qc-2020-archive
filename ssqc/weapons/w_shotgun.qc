.float oldammo_shotgun;
.float noshells;
.float oldshotgunclip;
.float sfcg;
void() check_shotgun;
void() idle_shotgun;

.float empty_shells;

void() idle_shotgun = { if (self.playerdeadtime > time)
	{
		self.think = PlayerDeathThink;
		self.nextthink = time + 0.1;
	}

	if (self.realoding == 1)
		self.realoding = 0;
	if (self.sfcg)
		self.sfcg = 0;
	//if((self.vweaponglowmod_x != -0.1)&& (!self.button3))		
	//self.vweaponglowmod = '-0.1 -0.1 -0.1';
	if (self.timezoom > time)
		self.timezoom = 0;

	self.vweaponframe = 0;
	if (self.pick_up_time < time)
		self.vweaponstate = 0;

	if ((self.empty_shells == 1) && (self.ammo_shotgun > 0))
	{
		self.think = empty_reload_shotgun;
		self.nextthink = time + 0.1;
		return;
	}

	self.think = idle_shotgun;
	self.nextthink = time + 0.1;
};

.float alreadytouched1;
.float alreadytouched2;
.float alreadytouched3;
.float alreadytouched4;
.float alreadytouched5;
.float alreadytouched6;
.float alreadytouched7;
.float alreadytouched8;
.float alreadytouched9;
.float alreadytouched10;
.float alreadytouched11;
.float alreadytouched12;
.float alreadytouched13;
.float alreadytouched14;
.float alreadytouched15;
.float alreadytouched16;
.float alreadytouched17;
.float alreadytouched18;
.float alreadytouched19;
.float alreadytouched20;
.float alreadytoucher;

vector() wall_velocity;
void() shot_projectile_think = { local vector source;
	local entity head;
	source = self.origin;
	head = findradius(source, 8);
	local float dm;
	dm = 1;
	self.cnt += 1;
	if (self.cnt == 2)
		self.traileffectnum = particleeffectnum("shottrail");

	while (head)
	{
		if ((head.takedamage) && (head != self.owner) && (head.health > 0) && ((head.solid == SOLID_SLIDEBOX) || (head.solid == SOLID_BBOX) || (head.solid == SOLID_BSP)))
		{
			if ((self.alreadytoucher == 1) && (head.alreadytouched1 > time)) dm = 0;
			if ((self.alreadytoucher == 2) && (head.alreadytouched2 > time)) dm = 0;
			if ((self.alreadytoucher == 3) && (head.alreadytouched3 > time)) dm = 0;
			if ((self.alreadytoucher == 4) && (head.alreadytouched4 > time)) dm = 0;
			if ((self.alreadytoucher == 5) && (head.alreadytouched5 > time)) dm = 0;
			if ((self.alreadytoucher == 6) && (head.alreadytouched6 > time)) dm = 0;
			if ((self.alreadytoucher == 7) && (head.alreadytouched7 > time)) dm = 0;
			if ((self.alreadytoucher == 8) && (head.alreadytouched8 > time)) dm = 0;
			if ((self.alreadytoucher == 9) && (head.alreadytouched9 > time)) dm = 0;
			if ((self.alreadytoucher == 10) && (head.alreadytouched10 > time)) dm = 0;
			if ((self.alreadytoucher == 11) && (head.alreadytouched11 > time)) dm = 0;
			if ((self.alreadytoucher == 12) && (head.alreadytouched12 > time)) dm = 0;
			if ((self.alreadytoucher == 13) && (head.alreadytouched13 > time)) dm = 0;
			if ((self.alreadytoucher == 14) && (head.alreadytouched14 > time)) dm = 0;
			if ((self.alreadytoucher == 15) && (head.alreadytouched15 > time)) dm = 0;
			if ((self.alreadytoucher == 16) && (head.alreadytouched16 > time)) dm = 0;
			if ((self.alreadytoucher == 17) && (head.alreadytouched17 > time)) dm = 0;
			if ((self.alreadytoucher == 18) && (head.alreadytouched18 > time)) dm = 0;
			if ((self.alreadytoucher == 19) && (head.alreadytouched19 > time)) dm = 0;
			if ((self.alreadytoucher == 20) && (head.alreadytouched20 > time)) dm = 0;
			if (dm == 1)
			{
				if (self.owner.classname == "player")
					T_Damage(head, self, self.owner, 25);
				else
					T_Damage(head, self, self.owner, invader_ad);
				if (head.solid == SOLID_SLIDEBOX)
				{
					local float r;
					r = random();
					if (r < 1)
					{
						if (other.classname == "afflicted")
							explo_blood_sprite(3, source);
						else if (other.classname == "wraith")
							explo_blood_sprite(4, source);
						else
						{
							if (r < 0.5)
								explo_blood_sprite(1, source);
							else
								explo_blood_sprite(2, source);
						}
					}

					local vector vel;
					vel = wall_velocity() *0.2;
					if (head.classname == "afflicted")
						SpawnBlood(source, vel *0.2, 25, 2, 1);
					else if (head.classname == "wraith")
						SpawnBlood(source, vel *0.2, 25, 4, 1);
					else
						SpawnBlood(source, vel *0.2, 25, 1, 0);
				}

				if (self.alreadytoucher == 1)
					head.alreadytouched1 = time + 0.1;
				if (self.alreadytoucher == 2)
					head.alreadytouched2 = time + 0.1;
				if (self.alreadytoucher == 3)
					head.alreadytouched3 = time + 0.1;
				if (self.alreadytoucher == 4)
					head.alreadytouched4 = time + 0.1;
				if (self.alreadytoucher == 5)
					head.alreadytouched5 = time + 0.1;
				if (self.alreadytoucher == 6)
					head.alreadytouched6 = time + 0.1;
				if (self.alreadytoucher == 7)
					head.alreadytouched7 = time + 0.1;
				if (self.alreadytoucher == 8)
					head.alreadytouched8 = time + 0.1;
				if (self.alreadytoucher == 9)
					head.alreadytouched9 = time + 0.1;
				if (self.alreadytoucher == 10)
					head.alreadytouched10 = time + 0.1;
				if (self.alreadytoucher == 11)
					head.alreadytouched11 = time + 0.1;
				if (self.alreadytoucher == 12)
					head.alreadytouched12 = time + 0.1;
				if (self.alreadytoucher == 13)
					head.alreadytouched13 = time + 0.1;
				if (self.alreadytoucher == 14)
					head.alreadytouched14 = time + 0.1;
				if (self.alreadytoucher == 15)
					head.alreadytouched15 = time + 0.1;
				if (self.alreadytoucher == 16)
					head.alreadytouched16 = time + 0.1;
				if (self.alreadytoucher == 17)
					head.alreadytouched17 = time + 0.1;
				if (self.alreadytoucher == 18)
					head.alreadytouched18 = time + 0.1;
				if (self.alreadytoucher == 19)
					head.alreadytouched19 = time + 0.1;
				if (self.alreadytoucher == 20)
					head.alreadytouched20 = time + 0.1;
			}
		}

		head = head.chain;
	}

	if (self.cnt >= 500)
		remove(self);
	self.think = shot_projectile_think;
	self.nextthink = time + 0.01;
};
void() shotgun_proj_touch = { local vector org;
	//self.velocity =	self.oldvelocity;

	if (other == self.owner)
		return;

	//if (other.solid == SOLID_TRIGGER)
	//	return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	if ((other == world) || (other.solid == SOLID_BSP))
	{
		org = self.origin;
		pointparticles(particleeffectnum("TE_GUNSHOT"), org, '0 0 0', 1);
		local vector rvel;
		rvel_x = crandom() *50;
		rvel_y = crandom() *50;
		rvel_z = crandom() *50;
		self.angles = vectoangles(self.velocity);
		self.count -= 1;
	}

	if ((self.owner.classname != "player") && (other.classname != "projectile"))
		remove(self);

	if (self.count <= 0)
		remove(self);
};

void(vector org, vector dir, float order, entity ownerproj) launch_projectile = { local entity shotgun_proj;
	shotgun_proj = spawn();
	shotgun_proj.owner = ownerproj;
	shotgun_proj.movetype = MOVETYPE_BOUNCEMISSILE;
	shotgun_proj.solid = SOLID_TRIGGER;
	shotgun_proj.count = 3;
	shotgun_proj.angles = vectoangles(dir);
	shotgun_proj.alreadytoucher = order;	// counter of touchs
	shotgun_proj.touch = shotgun_proj_touch;
	shotgun_proj.classname = "projectile";
	shotgun_proj.think = shot_projectile_think;
	shotgun_proj.nextthink = time;
	setmodel(shotgun_proj, "models/projectiles/proj_shrapnel.md3");
	setsize(shotgun_proj, '0 0 0', '0 0 0');
	if (ownerproj.classname == "player")
		makevectors(ownerproj.v_angle);
	else
		makevectors(ownerproj.angles);

	//org -=v_forward*order ;
	setorigin(shotgun_proj, org);
	local vector rvec;
	rvec_x += ownerproj.shotgun_spread1 * 0.25;
	rvec_y += ownerproj.shotgun_spread1 * 0.25;
	rvec = crandom() *(rvec_x) *v_right + crandom() *(rvec_y) *v_up;
	dir += rvec;
	shotgun_proj.velocity = dir *(2000 + (25 *order));
	shotgun_proj.oldvelocity = shotgun_proj.velocity;
};

.float time_piston;

void() wfire_shotgunempty1 = { self.empty_shells = 1;
	self.vweaponframe += 1;
	self.shotgun_fire1 = 1;
	if (self.vweaponframe == 113)
	{
		local vector dir;
		self.vweaponglowmod = '0.9 0.9 0.9';
		makevectors(self.v_angle);
		sound(self, CHAN_AUTO, "weapons/shotgun/firetoempty.ogg", 1, ATTN_NORM);
		dir = aim(self, 100000);
		FireBullets(self.buckshot_count, dir, '0.3 0.3 0', self.shotgun_damage1, self.shotgun_spread1);
		self.effects += EF_MUZZLEFLASH;
		self.punchangle_x = -5;
		self.ammo_shotgun -= 2;
		//muzzle_shotgun(self.vweapon, 1);
		local entity muzzle;
		local string muzzlemodel;
		muzzlemodel = "models/weapons/shotgun/flash_small.md3";
		muzzle = spawn();
		muzzle.owner = self;
		muzzle.scale = 2;
		setmodel(muzzle, muzzlemodel);
		muzzle.viewmodelforclient = self;
		setattachment(muzzle, self.vweapon, "tag_muzzle");
		muzzle.angles_z = random() *360;
		muzzle.think = SUB_Remove;
		muzzle.nextthink = time + 0.05;
	}

	if ((self.vweaponframe > 114) && (self.vweaponglowmod_x > 0))
	{
		self.realoding = 1;
		self.timezoomframe = time + 0.05;
		self.vweaponglowmod_x -= 0.1;
		self.vweaponglowmod_y -= 0.1;
		self.vweaponglowmod_z -= 0.1;
	}

	//		if(self.vweaponframe == 123)
	//		sound(self,CHAN_WEAPON,"misc/null.wav",1,1);

	if (self.vweaponframe >= 130)
	{
		self.shotgun_fire1 = 0;
		self.think = idle_shotgun;
	}

	self.nextthink = time + 0.05;
};

void() wsfire_shotgunempty1 = { self.empty_shells = 1;

	self.vweaponframe += 1;

	if (self.vweaponframe == 113)
	{
		local vector dir, tagorg;
		local float pcount, tagindex;
		sound(self, CHAN_AUTO, "weapons/shotgun/firetoempty.ogg", 1, ATTN_NORM);
		pcount = 20;
		while (pcount > 0)
		{
			tagindex = gettagindex(self.vweapon, "tag_proj");
			tagorg = gettaginfo(self.vweapon, tagindex);
			dir = aim(self, 1000);
			launch_projectile(tagorg, dir, pcount, self);
			pcount -= 1;
		}

		self.attack_finished = time + self.shotgun_time2;
		self.punchangle_x = -7;
		makevectors(self.angles);
		local float rf;
		if ((self.flags &FL_ONGROUND))
		{
			rf = 512;
			self.velocity_z += 24;
			self.flags -= FL_ONGROUND;
		}
		else
			rf = 192;
		self.velocity -= v_forward * rf;
		self.effects += EF_MUZZLEFLASH;
		self.ammo_shotgun -= 2;
		self.shotgun_clip = 0;
		local entity muzzle;
		local string muzzlemodel;
		muzzlemodel = "models/weapons/shotgun/flash_small.md3";
		muzzle = spawn();
		muzzle.owner = self;
		muzzle.scale = 2;
		setmodel(muzzle, muzzlemodel);
		muzzle.viewmodelforclient = self;
		setattachment(muzzle, self.vweapon, "tag_muzzle");
		muzzle.angles_z = random() *360;
		muzzle.think = SUB_Remove;
		muzzle.nextthink = time + 0.05;

	}

	if ((self.vweaponframe > 113) && (self.vweaponglowmod_x > 0))
	{
		self.realoding = 1;
		self.timezoomframe = time + 0.05;
		self.vweaponglowmod_x -= 0.1;
		self.vweaponglowmod_y -= 0.1;
		self.vweaponglowmod_z -= 0.1;
	}

	if (self.vweaponframe == 116)
		self.timezoom = time + self.shotgun_time1 / 2;

	//	if(self.vweaponframe == 123)
	//		sound(self,CHAN_WEAPON,"misc/null.wav",1,1);

	if (self.vweaponframe == 130)
	{
		self.time_piston = time + 0.15;
		self.shotgun_fire1 = 0;
		self.timezoomframe = time;
		self.think = idle_shotgun;
	}

	self.nextthink = time + 0.05;
};

void() wsfire_shotgun1 = { self.vweaponframe += 1;

	if (self.vweaponframe == 43)
	{
		local vector dir, tagorg;
		local float pcount, tagindex;
		playersound2("weapons/shotgun/fire2_", 2, CHAN_WEAPON);
		pcount = 20;
		while (pcount > 0)
		{
			tagindex = gettagindex(self.vweapon, "tag_proj");
			tagorg = gettaginfo(self.vweapon, tagindex);
			dir = aim(self, 1000);
			launch_projectile(tagorg, dir, pcount, self);
			pcount -= 1;
		}

		self.attack_finished = time + self.shotgun_time2;
		self.lastweapontime = time + 1.25;
		self.punchangle_x = -5;
		makevectors(self.angles);
		local float rf;
		if ((self.flags &FL_ONGROUND))
		{
			rf = 512;
			self.velocity_z += 24;
			self.flags -= FL_ONGROUND;
		}
		else
			rf = 192;
		self.velocity -= v_forward * rf;
		self.effects += EF_MUZZLEFLASH;
		self.ammo_shotgun -= 2;
		self.shotgun_clip = 0;
		local entity muzzle;
		local string muzzlemodel;
		muzzlemodel = "models/weapons/shotgun/flash_small.md3";
		muzzle = spawn();
		muzzle.owner = self;
		muzzle.scale = 2;
		setmodel(muzzle, muzzlemodel);
		muzzle.viewmodelforclient = self;
		setattachment(muzzle, self.vweapon, "tag_muzzle");
		muzzle.angles_z = random() *360;
		muzzle.think = SUB_Remove;
		muzzle.nextthink = time + 0.05;

	}

	if ((self.vweaponframe > 43) && (self.vweaponglowmod_x > 0))
	{
		self.realoding = 1;
		self.timezoomframe = time + 0.05;
		self.vweaponglowmod_x -= 0.1;
		self.vweaponglowmod_y -= 0.1;
		self.vweaponglowmod_z -= 0.1;
	}

	if (self.vweaponframe == 56)
		self.timezoom = time + self.shotgun_time1 / 2;
	if (self.vweaponframe >= 56)
		self.shotgun_clip = 2;
	if (self.vweaponframe == 81)
	{
		if (!self.button3)
			sound(self, CHAN_WEAPON, "weapons/shotgun/piston_out.ogg", 1, ATTN_NORM);
		else
			self.time_piston = time + 0.15;

	}

	if (self.vweaponframe >= 82)
	{
		self.shotgun_fire1 = 0;
		self.timezoomframe = time;
		self.think = idle_shotgun;
	}
	else
		self.think = wsfire_shotgun1;
	self.nextthink = time + 0.05;

};

void() wfire_shotgun1 = { self.vweaponframe += 1;
	self.shotgun_fire1 = 1;
	if (self.vweaponframe == 3)
	{
		local vector dir;
		self.vweaponglowmod = '0.9 0.9 0.9';
		makevectors(self.v_angle);
		playersound2("weapons/shotgun/fire1_", 2, CHAN_WEAPON);
		dir = aim(self, 100000);
		FireBullets(self.buckshot_count, dir, '0.3 0.3 0', self.shotgun_damage1, self.shotgun_spread1);
		self.effects += EF_MUZZLEFLASH;
		self.punchangle_x = -5;
		self.ammo_shotgun -= 2;
		//muzzle_shotgun(self.vweapon, 1);
		local entity muzzle;
		local string muzzlemodel;
		muzzlemodel = "models/weapons/shotgun/flash_small.md3";
		muzzle = spawn();
		muzzle.owner = self;
		muzzle.scale = 2;
		setmodel(muzzle, muzzlemodel);
		muzzle.viewmodelforclient = self;
		setattachment(muzzle, self.vweapon, "tag_muzzle");
		muzzle.angles_z = random() *360;
		muzzle.think = SUB_Remove;
		muzzle.nextthink = time + 0.05;
	}

	if ((self.vweaponframe > 4) && (self.vweaponglowmod_x > 0))
	{
		self.realoding = 1;
		self.timezoomframe = time + 0.05;
		self.vweaponglowmod_x -= 0.1;
		self.vweaponglowmod_y -= 0.1;
		self.vweaponglowmod_z -= 0.1;
	}

	///	if(self.charge_shotgun == self.charge_shotgun_count)
	//	{
	//		self.timezoom = time + self.shotgun_time1 /2;
	//	}

	if (self.vweaponframe >= 15)
		self.shotgun_clip = 2;
	//	if(self.vweaponframe == 40)
	//	self.timezoomframe = time;
	if (self.vweaponframe >= 41)
	{
		self.shotgun_fire1 = 0;
		self.think = idle_shotgun;
	}
	else
		self.think = wfire_shotgun1;
	self.nextthink = time + 0.05;
};

void() wsfire_shotgunwait = { if (!self.button3)
	{
		self.think = idle_shotgun;
		sound(self, CHAN_WEAPON, "weapons/shotgun/piston_out.ogg", 1, ATTN_NORM);
		self.attack_finished = time + 0.25;
	}
	else
	{
		self.vweaponframe += 1;
		if (self.vweaponframe == 102)
		{
			if (self.ammo_shotgun <= 2)
			{
				self.vweaponframe = 112;
				wsfire_shotgunempty1();
				return;
			}

			if (self.ammo_shotgun > 2)
			{
				self.vweaponframe = 42;
				wsfire_shotgun1();
				return;
			}
		}
		else
			self.think = wsfire_shotgunwait;
	}

	self.nextthink = time + 0.05;
};
void() wsfire_shotgun = { if (time > self.time_piston)
		sound(self, CHAN_AUTO, "weapons/shotgun/piston_in.ogg", 1, ATTN_NORM);
	sound(self, CHAN_WEAPON, "weapons/shotgun/charge.ogg", 1, ATTN_NORM);
	self.vweaponframe = 82;
	self.think = wsfire_shotgunwait;
	self.nextthink = time + 0.05;
};

void() wfire_shotgun = { if ((self.vweaponglowmod_x > 0) && (self.vweaponglowmod_x < 1))
	{
		self.attack_finished = time + 0.05;
		return;
	}

	if (self.vweaponglowmod_x < 1)
	{
		if (self.charge_shotgun != self.charge_shotgun_count)
			self.vweaponglowmod = '0.5 0.5 0.5';
		if (self.ammo_shotgun > 2)
		{
			self.vweaponframe = 2;
			self.think = wfire_shotgun1;
		}
		else
		{
			self.vweaponframe = 112;
			self.think = wfire_shotgunempty1;
		}
	}

	self.lastweapontime = time + self.shotgun_time1;
	self.attack_finished = time + self.shotgun_time1;
	self.nextthink = time + 0.05;
};

void() pick_up_shotgun2 = { self.think = idle_shotgun;
	self.pick_up_time = time + 0.5;
	self.vweaponstate = 1;
	self.nextthink = time + 0.05;
};

void() pick_up_shotgun = { self.lastweapon = IT_SHOTGUN;
	self.weapon = IT_SHOTGUN;
	self.shotgun_fire1 = 0;
	sound(self, CHAN_WEAPON, "weapons/shotgun/inspect.ogg", 1, ATTN_NORM);
	W_SetWeapon();
	self.draw_w = 0;
	self.vweaponskin = self.shotgunclip;
	self.vweaponglowmod = '-0.1 -0.1 -0.1';
	self.vweaponstate = 2;

	if (self.noltime < time)
		self.lspeedtime = time + 4;
	self.vweaponframe = 1;
	self.attack_finished = time + 0.05;
	self.think = pick_up_shotgun2;
	self.nextthink = time + 4.95;
}

void() empty_reload_shotgun = { sound(self, CHAN_AUTO, "weapons/shotgun/emptytoreload.ogg", 1, ATTN_NORM);
	self.realoding = 1;
	self.empty_shells = 0;
	self.shotgun_clip = 2;
	self.vweaponframe = 132;
	self.attack_finished = time + 1.95;
	self.nextthink = time + 1.95;
	self.think = idle_shotgun;
}

void() raise_shotgun2 = { if (self.vweaponframe == 103)
		W_SetWeapon();
	self.vweaponframe += 1;
	if (self.vweaponframe >= 106)
	{
		if ((self.empty_shells == 1) && (self.ammo_shotgun > 0))
			self.think = empty_reload_shotgun;
		else
			self.think = idle_shotgun;
	}
	else
		self.think = raise_shotgun2;
	self.nextthink = time + 0.025;
};

void() raise_shotgun = { self.weapon = IT_SHOTGUN;
	self.shotgun_fire1 = 0;
	sound(self, CHAN_AUTO, "weapons/shotgun/raise.ogg", 1, ATTN_NORM);
	W_SetWeapon();
	self.vweaponglowmod = '-0.1 -0.1 -0.1';
	self.vweapon.origin_z = self.dvweapon_z;
	self.draw_w = 0;
	self.vweaponskin = self.shotgunclip;
	self.vweaponframe = 102;
	self.vweaponstate = 1;
	self.attack_finished = time + 0.125;
	self.think = raise_shotgun2;
	self.nextthink = time;
};

void() lower_shotgun2 = { self.vweaponframe += 1;
	if (self.vweaponframe >= 111)
		self.think = raise_weapon;
	else
		self.think = lower_shotgun2;
	self.nextthink = time + 0.025;
};

void() zoom_shotgun = {};

void() lower_shotgun = { self.shotgun_fire1 = 0;
	sound(self, CHAN_AUTO, "weapons/shotgun/lower.ogg", 1, ATTN_NORM);
	self.vweaponframe = 107;
	self.attack_finished = time + 0.125;
	self.think = lower_shotgun2;
	self.vweaponstate = 2;
	self.nextthink = time + 0.025;
};

///////////////////////////////////end of qc file