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
.float waittime;
void(string locsound, float rnd, float vol, float nchannel, float iswav, float atten) randomsound2;
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
		//void(vector org, string locsound, float rnd, float vol)
		self.count -= 1;
	}
	
	if(time > self.waittime)
	randomsound2  ("impact/projectiles/rico",15,0.5, CHAN_AUTO, 0, 0.25);
//(string locsound, float rnd, float vol, float nchannel, float iswav, float atten) 
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
	shotgun_proj.waittime =  time + 0.05;
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
	rvec_x += ownerproj.shotgun_spread1;
	rvec_y += ownerproj.shotgun_spread1;
	rvec = crandom() *(rvec_x) *v_right + crandom() *(rvec_y) *v_up;
	dir += rvec;
	shotgun_proj.velocity = dir *(1000 + (2.5 *order));
	shotgun_proj.oldvelocity = shotgun_proj.velocity;
};
.float rsound_cntr;
void()launch_projectiles_explosion =
{
	local vector dir;
	local float pcount;
	pcount = 20;
	makevectors(self.angles);

	
	while(pcount > 0)
	{
		if(!self.count)
		{
			local float surfnum;
			local vector s;
			surfnum = getsurfacenearpoint(world, self.origin);
			if (surfnum >= 0)
			{
				s = getsurfacenormal(world, surfnum);
				dir = normalize (((dir + (v_up * 360 * crandom ())) + (v_right *360 * crandom ())));
				dir = (dir + (2 * s));
			}
		}
		else
		dir = normalize (((dir + (v_up * 360 *  crandom ())) + (v_right * 360* crandom ())));
		launch_projectile (self.origin, dir, pcount,self.owner);
		pcount -= 1;
	}
	remove(self);
}

void()proj_heretic_explo;
void(string locsound, float vol, float nchannel, float iswav, float atten) alreadyrandomsound2;
void()shotgun_projectile_touch = 
{
	local vector org;
	org = self.origin;
	if (other == self.owner)
		return;
	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	self.classname = "shotgun_projectile_explosion";
	if ((other.takedamage) && (other.solid != SOLID_BSP))
	{
			if (other.flags &FL_MONSTER)
		{
			if (other.classname == "afflicted")
				spawn_touchblood2(9, 2);
			else if (other.classname == "wraith")
				spawn_touchblood2(9, 4);
			else
				spawn_touchblood2(9, 1);

			local float r;
			r = random();
			if (r < 1)
			{
				if (other.classname == "afflicted")
					explo_blood_sprite(3, org);
				else if (other.classname == "wraith")
					explo_blood_sprite(4, org);
				else
				{
					if (r < 0.5)
						explo_blood_sprite(1, org);
					else
						explo_blood_sprite(2, org);
				}
			}
		}
		
	T_Damage(other, self, self.owner, self.owner.shotgun_proj_dmg);
	self.count = 1;
	}
	alreadyrandomsound2  ("impact/projectiles/shotgun_explo",1, CHAN_AUTO, 0, 0.25);

	self.movetype = 0;
	self.velocity = '0 0 0';	
	self.touch = SUB_Null;
	self.solid = 0;
	self.effects = EF_NODRAW;


	self.think = launch_projectiles_explosion;
	self.nextthink = time;
	
	
	local entity explosion_sprite;
	explosion_sprite = spawn();
	explosion_sprite.origin = self.origin;
	setmodel(explosion_sprite, "models/projectiles/proj_shotgun_explo.md3");
	pointparticles(particleeffectnum("shotgun_explo"), self.origin, '0 0 0', 1);
	explosion_sprite.alpha = 1;
	explosion_sprite.nextthink = time;
	explosion_sprite.think = proj_heretic_explo;
	
	
	//BecomeExplosion(1);
	//snd = strcat("impact/projectiles/slag1_explo", ftos(floor(random() *5) + 1), ".ogg");
	//pointparticles(particleeffectnum("slag"), org, v_forward *(-550), 1);
	//sound(self, CHAN_AUTO, snd, 1, 0.25);
};


void() shotgun_projectile_drunk = { self.explodcount += 1;
	self.velocity = ((self.velocity + ((v_right *proj_shotgun_drunkfactorh) *crandom())) + ((v_up *proj_shotgun_drunkfactorv) *crandom()));
	self.nextthink = time + proj_shotgun_timing;	// screw up fast
	if (self.explodcount < 50)
		self.think = shotgun_projectile_drunk;
	else
		self.think = SUB_Remove;
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
		local float tagindex;
		sound(self, CHAN_AUTO, "weapons/shotgun/firetoempty.ogg", 1, ATTN_NORM);
		
		tagindex = gettagindex(self.vweapon, "tag_barrela");
		tagorg = gettaginfo(self.vweapon, tagindex);
		local entity sotgun_projectile;
		sotgun_projectile=  spawn();
		sotgun_projectile.movetype = MOVETYPE_FLYMISSILE;
		sotgun_projectile.solid = SOLID_TRIGGER;
		sotgun_projectile.owner =  self;
		
		dir = aim(self, 1000);
		setorigin(sotgun_projectile, tagorg);
		setmodel(sotgun_projectile, "models/projectiles/proj_shotgun1.md3");
		sotgun_projectile.cnt = 1;
		sotgun_projectile.traileffectnum = particleeffectnum("shotgun_trail");
		sotgun_projectile.velocity = normalize(self.cursor_trace_endpos - sotgun_projectile.origin) *self.shotgun_proj_speed ;
		//setsize(sotgun_projectile, '0 0 0', '0 0 0');
		setsizeitem(sotgun_projectile,  proj_shotgun_bbox);

		sotgun_projectile.angles = vectoangles(sotgun_projectile.velocity);
		sotgun_projectile.touch = shotgun_projectile_touch;
		sotgun_projectile.effects = EF_NOSHADOW;


	
	
		tagindex = gettagindex(self.vweapon, "tag_barrelb");
		tagorg = gettaginfo(self.vweapon, tagindex);
		dir = aim(self, 1000);
		local entity sotgun_projectileb;
		sotgun_projectileb=  spawn();
		sotgun_projectileb.movetype = MOVETYPE_FLYMISSILE;
		sotgun_projectileb.solid = SOLID_TRIGGER;
		sotgun_projectileb.owner =  self;
		setorigin(sotgun_projectileb, tagorg);
		setmodel(sotgun_projectileb, "models/projectiles/proj_shotgun2.md3");
		sotgun_projectileb.cnt = 1;
		sotgun_projectileb.traileffectnum = particleeffectnum("shotgun_trail");
		sotgun_projectileb.velocity = normalize(self.cursor_trace_endpos - sotgun_projectile.origin) *self.shotgun_proj_speed ;
		//setsize(sotgun_projectileb, '0 0 0', '0 0 0');
		setsizeitem(sotgun_projectileb,  proj_shotgun_bbox);
		sotgun_projectileb.angles = vectoangles(sotgun_projectileb.velocity);
		sotgun_projectileb.touch = shotgun_projectile_touch;
		sotgun_projectileb.effects = EF_NOSHADOW;

		sotgun_projectileb.think  = shotgun_projectile_drunk;
		sotgun_projectile.think  = shotgun_projectile_drunk;
		sotgun_projectileb.nextthink =  time + 0.05;
		sotgun_projectile.nextthink =  time + 0.05;
		
		local float r, r1;
		r = floor(random() *5) + 1;
		sotgun_projectile.rsound_cntr = r;
		r1 = floor(random() *5) + 1;
		if (r1 == sotgun_projectile.rsound_cntr)
			r1 += 1;
		sotgun_projectileb.rsound_cntr = r1;
		
		
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
		local float tagindex;
		playersound2("weapons/shotgun/fire2_", 2, CHAN_WEAPON);


		tagindex = gettagindex(self.vweapon, "tag_barrela");
		tagorg = gettaginfo(self.vweapon, tagindex);
		local entity sotgun_projectile;
		sotgun_projectile=  spawn();
		sotgun_projectile.movetype = MOVETYPE_FLYMISSILE;
		sotgun_projectile.solid = SOLID_TRIGGER;
		sotgun_projectile.owner =  self;
		
		dir = aim(self, 1000);
		setorigin(sotgun_projectile, tagorg);
		setmodel(sotgun_projectile, "models/projectiles/proj_shotgun1.md3");
		sotgun_projectile.cnt = 1;
		sotgun_projectile.traileffectnum = particleeffectnum("shotgun_trail");
		sotgun_projectile.velocity = normalize(self.cursor_trace_endpos - sotgun_projectile.origin) *self.shotgun_proj_speed ;
		//setsize(sotgun_projectile, '0 0 0', '0 0 0');
		setsizeitem(sotgun_projectile,  proj_shotgun_bbox);
		sotgun_projectile.angles = vectoangles(sotgun_projectile.velocity);
		sotgun_projectile.touch = shotgun_projectile_touch;
		sotgun_projectile.effects = EF_NOSHADOW;


		tagindex = gettagindex(self.vweapon, "tag_barrelb");
		tagorg = gettaginfo(self.vweapon, tagindex);
		dir = aim(self, 1000);
		local entity sotgun_projectileb;
		sotgun_projectileb=  spawn();
		sotgun_projectileb.movetype = MOVETYPE_FLYMISSILE;
		sotgun_projectileb.solid = SOLID_TRIGGER;
		sotgun_projectileb.owner =  self;
		setorigin(sotgun_projectileb, tagorg);
		setmodel(sotgun_projectileb, "models/projectiles/proj_shotgun2.md3");
		sotgun_projectileb.cnt = 1;
		sotgun_projectileb.traileffectnum = particleeffectnum("shotgun_trail");
		sotgun_projectileb.velocity = normalize(self.cursor_trace_endpos - sotgun_projectile.origin) *self.shotgun_proj_speed ;
		setsizeitem(sotgun_projectileb,  proj_shotgun_bbox);
		//setsize(sotgun_projectileb, '0 0 0', '0 0 0');
		sotgun_projectileb.angles = vectoangles(sotgun_projectileb.velocity);
		sotgun_projectileb.touch = shotgun_projectile_touch;
		sotgun_projectileb.effects = EF_NOSHADOW;

		local float r, r1;
		r = floor(random() *5) + 1;
		sotgun_projectile.rsound_cntr = r;
		r1 = floor(random() *5) + 1;
		if (r1 == sotgun_projectile.rsound_cntr)
			r1 += 1;
		sotgun_projectileb.rsound_cntr = r1;
		
		
		sotgun_projectileb.think  = shotgun_projectile_drunk;
		sotgun_projectile.think  = shotgun_projectile_drunk;
		sotgun_projectileb.nextthink =  time + 0.05;
		sotgun_projectile.nextthink =  time + 0.05;
		
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