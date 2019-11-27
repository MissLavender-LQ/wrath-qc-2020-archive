/*
==============================================================================

oppressor

==============================================================================
*/

$frame pose0

$frame idle1 idle2 idle3 idle4 idle5 idle6 idle7 idle8 idle9 idle10

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10 walk11 walk12

$frame walkta1 walkta2 walkta3 walkta4 walkta5

$frame attack1 attack2 attack3 attack4 attack5 attack6

$frame pain1 pain2 pain3 pain4 pain5

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10 death11 death12

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8 deathb9 deathb10

///////////////////////////////////////////////////////////////////////////////////////////////
void() oppressor_walk1;
void() oppressor_atk1;
void() oppressor_walktoa6;
void() oppressor_walktoa1;
void() oppressor_run1;
void() oppressor_stand1 =[$idle1, oppressor_stand2]
{
	ai_stand();
	local float r;
	r = random() *15;
	if ((r < 1) && (!(self.spawnflags &1)))
		chattersound("enemies/oppressor/idle", 3, 1);
};
void() oppressor_stand2 =[$idle2, oppressor_stand3]
{
	ai_stand();
};
void() oppressor_stand3 =[$idle3, oppressor_stand4]
{
	ai_stand();
};
void() oppressor_stand4 =[$idle4, oppressor_stand5]
{
	ai_stand();
};
void() oppressor_stand5 =[$idle5, oppressor_stand6]
{
	ai_stand();
};
void() oppressor_stand6 =[$idle6, oppressor_stand7]
{
	ai_stand();
};
void() oppressor_stand7 =[$idle7, oppressor_stand8]
{
	ai_stand();
};
void() oppressor_stand8 =[$idle8, oppressor_stand9]
{
	ai_stand();
};
void() oppressor_stand9 =[$idle9, oppressor_stand10]
{
	ai_stand();
};
void() oppressor_stand10 =[$idle10, oppressor_stand1]
{
	ai_stand();
};
void() oppressor_walk1;
void() oppressor_atk1;
void() oppressor_walktoa6;
void() oppressor_walktoa1 =[$walkta1, oppressor_walktoa2]
{
	ai_runwalk(oppwta1);
	ai_face();
};
void() oppressor_walktoa2 =[$walkta2, oppressor_walktoa3]
{
	ai_runwalk(oppwta2);
	ai_face();
	chattersound("enemies/oppressor/step", 3, 1);
};
void() oppressor_walktoa3 =[$walkta3, oppressor_walktoa4]
{
	ai_runwalk(oppwta3);
	ai_face();
};
void() oppressor_walktoa4 =[$walkta4, oppressor_walktoa5]
{
	ai_runwalk(oppwta4);
	ai_face();
};
void() oppressor_walktoa5 = { self.frame = $walkta5;
	if ((visible2(self.enemy, 4096, 0.15)))
	{
		self.think = oppressor_atk1;
		self.nextthink = time + 0.1;
	}
	else
	{
		self.think = oppressor_walktoa6;
		self.nextthink = time + 0.5;
	}

	ai_runwalk(oppwta5);
	ai_face();
};
void() oppressor_walktoa6 = { self.frame = $walkta5;
	if ((visible2(self.enemy, 4096, 0.3)))
	{
		self.think = oppressor_atk1;
		self.nextthink = time + 0.1;
	}
	else
	{
		self.think = oppressor_walk1;
		self.nextthink = time + 0.1;
	}

	ai_runwalk(oppwta5);
	ai_face();
};

void() oppressor_walk1 =[$walk1, oppressor_walk2]
{
	ai_walk(oppwvel1);
	local float r;
	r = random() *15;
	if (r < 1)
		chattersound("enemies/oppressor/idle", 3, 1);
};
void() oppressor_walk2 =[$walk2, oppressor_walk3]
{
	ai_walk(oppwvel2);
};
void() oppressor_walk3 =[$walk3, oppressor_walk4]
{
	ai_walk(oppwvel3);
};
void() oppressor_walk4 =[$walk4, oppressor_walk5]
{
	ai_walk(oppwvel4);
	chattersound("enemies/oppressor/step", 3, 1);
};
void() oppressor_walk5 =[$walk5, oppressor_walk6]
{
	ai_walk(oppwvel5);
};
void() oppressor_walk6 =[$walk6, oppressor_walk7]
{
	ai_walk(oppwvel6);
};
void() oppressor_walk7 =[$walk7, oppressor_walk8]
{
	ai_walk(oppwvel7);
};
void() oppressor_walk8 =[$walk8, oppressor_walk9]
{
	ai_walk(oppwvel8);
};
void() oppressor_walk9 =[$walk9, oppressor_walk10]
{
	ai_walk(oppwvel9);
};
void() oppressor_walk10 =[$walk10, oppressor_walk11]
{
	ai_walk(oppwvel10);
	chattersound("enemies/oppressor/step", 3, 1);
};
void() oppressor_walk11 =[$walk11, oppressor_walk12]
{
	ai_walk(oppwvel11);
};
void() oppressor_walk12 = { self.frame = $walk12;
	if ((visible2(self.enemy, 4096, 0.3)))
		self.think = oppressor_walktoa1;
	else
		self.think = oppressor_walk1;
	ai_walk(oppwvel12);
	self.nextthink = time + 0.1;
};
//////////////////////////////////////////////////***RUN***////////////////////////////////////////////////////
void() oppressor_run1 =[$walk1, oppressor_run2]
{
	ai_runwalk(oppwvel1);
};
void() oppressor_run2 =[$walk2, oppressor_run3]
{
	ai_runwalk(oppwvel2);
	if (self.enemy.health > 0)
	{
		if ((visible2(self.enemy, 4096, 0.3)))
			self.think = oppressor_walktoa1;
		else
			self.think = oppressor_run3;
	}
};
void() oppressor_run3 =[$walk3, oppressor_run4]
{
	ai_runwalk(oppwvel3);
};
void() oppressor_run4 =[$walk4, oppressor_run5]
{
	ai_runwalk(oppwvel4);
	chattersound("enemies/oppressor/step", 3, 1);
};
void() oppressor_run5 =[$walk5, oppressor_run6]
{
	ai_runwalk(oppwvel5);
};
void() oppressor_run6 =[$walk6, oppressor_run7]
{
	ai_runwalk(oppwvel6);
};
void() oppressor_run7 =[$walk7, oppressor_run8]
{
	ai_runwalk(oppwvel7);
	if (self.enemy.health > 0)
	{
		if ((visible2(self.enemy, 4096, 0.3)))
			self.think = oppressor_walktoa1;
		else
			self.think = oppressor_run8;
	}
};
void() oppressor_run8 =[$walk8, oppressor_run9]
{
	ai_runwalk(oppwvel8);
};
void() oppressor_run9 =[$walk9, oppressor_run10]
{
	ai_runwalk(oppwvel9);
};
void() oppressor_run10 =[$walk10, oppressor_run11]
{
	ai_runwalk(oppwvel10);
	chattersound("enemies/oppressor/step", 3, 1);
};
void() oppressor_run11 =[$walk11, oppressor_run12]
{
	ai_runwalk(oppwvel11);
};
void() oppressor_run12 = { self.frame = $walk12;
	if (self.enemy.health > 0)
	{
		if ((visible2(self.enemy, 4096, 0.3)))
			self.think = oppressor_walktoa1;
		else
			self.think = oppressor_run1;
	}
	else
	{
		ai_run(0);
		self.think = oppressor_stand1;
	}

	self.nextthink = time + 0.1;
	ai_runwalk(oppwvel12);
};
//////////////////////////////////////////////////***END-RUN***////////////////////////////////////////////////////

//////////////////////////////////////////////////***ATTACK***////////////////////////////////////////////////////
void() OppressorGrenadeExplode = { T_RadiusDamage(self, self.owner, 5, world);
	//	msound (self, CHAN_VOICE, "oppressor/hi.wav", 1, ATTN_NORM);
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	setmodel(self, "particles/explo/explo_slag1.md3");
	pointparticles(particleeffectnum("slag"), self.origin, v_forward *(-550), 1);
	self.think = slag_explode1;
};

void() OppressorGrenadeTouch = { local float damg;
	self.effects = 512;
	if (other == self.owner)
		return;	// don't explode on owner
	self.solid = SOLID_NOT;
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = oppressordamage;
	if (other.health)
	{
		if (other.classname == "monster_oppressor")
			damg = damg *0.25;	// mostly immune
		T_Damage(other, self, self.owner, damg);
		//	msound (self, CHAN_AUTO, "oppressor/claw.wav", 1, ATTN_NORM);
	}
	else
	{
		T_RadiusDamage(self, self.owner, damg, world);
		//	msound (self, CHAN_VOICE, "oppressor/hit.wav", 0.7, ATTN_NORM);	// bounce sound
	}

	pointparticles(particleeffectnum("slag"), self.origin, v_forward *(-550), 1);
	//	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel(self, "particles/explo/explo_slag1.md3");
	self.think = slag_explode1;
};

void(entity ownr, float tf) Oppressor_Fire = { local vector org;
	local float tagindex;
	local string tagname;
	chattersound("enemies/oppressor/attack", 3, 1);
	local entity missile;
	missile = spawn();
	missile.owner = ownr;
	missile.classname = "oppresor_projectile";
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_CORPSE;
	missile.traileffectnum = particleeffectnum("slagtrail2");
	// set missile speed
	local vector sre;
	sre = ownr.angles;
	makevectors2(sre);
	if (tf == 1)
	{
		tagname = "muzzle_1";
		ownr.cnt = 0;
	}
	else
	{
		tagname = "muzzle_2";
		ownr.cnt = 1;
	}

	tagindex = gettagindex(ownr, tagname);
	org = gettaginfo(ownr, tagindex);
	missile.velocity = normalize(ownr.enemy.origin - org);
	if (TrinketofRespite_time > time)
		missile.velocity = missile.velocity * 400;
	else
		missile.velocity = missile.velocity * oppressorpvel;
	missile.angles = vectoangles(missile.velocity);
	missile.touch = OppressorGrenadeTouch;
	missile.nextthink = time;
	missile.think = slagdrunk;
	missile.modelflags = EF_NOMODELFLAGS;	// smoke rocket dp-extension
	setmodel(missile, "models/projectiles/proj_slag1.md3");
	//	setsizeitem (missile, oppressorpbbox);
	setsizeitem(missile, '0 0 0');
	local float nparticles;
	nparticles = particleeffectnum("oppressor_fire");
	pointparticles(nparticles, org, '0 0 0', 1);
	setorigin(missile, org);
};
void() oppressor_atk2;
void() oppressor_atk1;
.float opp_wait_attack;
void() oppressor_wtk1 =[$attack1, oppressor_wtk1]
{
	ai_face();
	if (self.opp_wait_attack < time)
	{
		self.think = oppressor_run1;
		self.nextthink = time + 0.05;
		return;
	}

	if ((visible2(self.enemy, 4096, 0.15)))
		self.think = oppressor_atk1;
	else
		self.think = oppressor_wtk1;
	self.nextthink = time + 0.05;
};

void() oppressor_atk1 = { self.frame = $attack1;
	//if ((visible2 (self.enemy, 1024, 0.15)))
	self.think = oppressor_atk2;
	//else
	//self.think = oppressor_run1;
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk2 =[$attack1, oppressor_atk3]
{
	ai_face();
	self.nextthink = time + 0.05;
	Oppressor_Fire(self, 1);
};
void() oppressor_atk3 =[$attack2, oppressor_atk4]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk4 =[$attack2, oppressor_atk5]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk5 =[$attack3, oppressor_atk6]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk6 =[$attack3, oppressor_atk7]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk7 =[$attack4, oppressor_atk8]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk8 =[$attack4, oppressor_atk9]
{
	ai_face();
	self.nextthink = time + 0.05;
	Oppressor_Fire(self, 2);
};
void() oppressor_atk9 =[$attack5, oppressor_atk10]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk10 =[$attack5, oppressor_atk11]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk11 =[$attack6, oppressor_atk12]
{
	ai_face();
	self.nextthink = time + 0.05;
};
void() oppressor_atk12 = { local float r;
	self.frame = $attack6;
	if ((visible2(self.enemy, 4096, 0.15)))
	{
		r = random();
		if (self.turret == 1)
		{
			ai_face();
			self.think = oppressor_atk1;
			self.nextthink = time + 0.05;
			return;
		}

		if (r > opp_dr_attack)
			self.think = oppressor_run1;
		else
			self.think = oppressor_atk1;
	}
	else
	{
		if (self.turret == 1)
		{
			ai_face();
			self.think = oppressor_wtk1;
			self.opp_wait_attack = time + 5;
			self.nextthink = time + 0.05;
			return;
		}

		self.think = oppressor_run1;
		ai_face();
	}

	self.nextthink = time + 0.05;
};

//////////////////////////////////////////////////***END-ATTACK***////////////////////////////////////////////////////

//////////////////////////////////////////////////***PAIN***////////////////////////////////////////////////////

void() oppressor_paina1 =[$pain1, oppressor_paina2]
{
	ai_pain(0);
	self.pain_finished = time + 0.6;
};
void() oppressor_paina2 =[$pain2, oppressor_paina3] {};
void() oppressor_paina3 =[$pain3, oppressor_paina4] {};
void() oppressor_paina4 =[$pain4, oppressor_paina5] {};
void() oppressor_paina5 =[$pain5, oppressor_run1]
{
	local float r;
	if ((visible2(self.enemy, 4096, 0.3)))
	{
		if (self.turret == 1)
		{
			ai_face();
			self.think = oppressor_wtk1;
			self.opp_wait_attack = time + 5;
			self.nextthink = time + 0.05;
			return;
		}

		r = random();
		if (r > opp_dr_paina)
			self.think = oppressor_atk1;
		else
			self.think = oppressor_run1;
	}
	else
		self.think = oppressor_run1;
	self.nextthink = time + 0.1;
};
void() oppressor_painb1 =[$painb1, oppressor_painb2]
{
	ai_pain(3);
	self.pain_finished = time + 1;
};
void() oppressor_painb2 =[$painb2, oppressor_painb3] {};
void() oppressor_painb3 =[$painb3, oppressor_painb4] {};
void() oppressor_painb4 =[$painb4, oppressor_painb5] {};
void() oppressor_painb5 =[$painb5, oppressor_painb6] {};
void() oppressor_painb6 =[$painb6, oppressor_painb7] {};
void() oppressor_painb7 =[$painb7, oppressor_painb8] {};
void() oppressor_painb8 =[$painb8, oppressor_painb9] {};
void() oppressor_painb9 = { local float r;
	self.frame = $painb9;
	if ((visible2(self.enemy, 4096, 0.3)))
	{
		if (self.turret == 1)
		{
			ai_face();
			self.think = oppressor_wtk1;
			self.opp_wait_attack = time + 5;
			self.nextthink = time + 0.05;
			return;
		}

		r = random();
		if (r > opp_dr_painb)
			self.think = oppressor_atk1;
		else
			self.think = oppressor_run1;
	}
	else
		self.think = oppressor_run1;
	self.nextthink = time + 0.1;
};

void() oppressor_painr = { local float r;
	r = random();
	if (r < 0.5)
		oppressor_paina1();
	else
		oppressor_painb1();
	chattersound("enemies/oppressor/pain", 3, 1);
};

void(entity attacker, float damage) oppressor_pain = { if (self.pain_finished > time)
		return;
	local float pp, rp;
	if (damage >= oppph)
	{
		pp = hpdmg;
	}

	if ((damage <= opppm) && (damage > opppl))
	{
		pp = mpdmg;
	}

	if (damage <= opppl)
	{
		pp = lpdmg;
	}

	rp = random();
	if (rp > pp)
		return;
	oppressor_painr();
};

//////////////////////////////////////////////////***END-PAIN***////////////////////////////////////////////////////

void() oppressor_die1 =[$death1, oppressor_die2]
{
	self.glowmod = '0.9 0.9 0.9';
};
void() oppressor_die2 =[$death2, oppressor_die3]
{
	self.solid = 0;
	self.glowmod = '0.8 0.8 0.8';
};
void() oppressor_die3 =[$death3, oppressor_die4]
{
	self.glowmod = '0.7 0.7 0.7';
};
void() oppressor_die4 =[$death4, oppressor_die5]
{
	self.glowmod = '0.6 0.6 0.6';
};
void() oppressor_die5 =[$death5, oppressor_die6]
{
	self.glowmod = '0.5 0.5 0.5';
};
void() oppressor_die6 =[$death6, oppressor_die7]
{
	self.glowmod = '0.4 0.4 0.4';
};
void() oppressor_die7 =[$death7, oppressor_die8]
{
	self.glowmod = '0.3 0.3 0.3';
};
void() oppressor_die8 =[$death8, oppressor_die9]
{
	self.glowmod = '0.2 0.2 0.2';
};
void() oppressor_die9 =[$death9, oppressor_die10]
{
	self.glowmod = '0.1 0.1 0.1';
};
void() oppressor_die10 =[$death10, oppressor_die11]
{
	self.glowmod = '-1 -1 -1';
};
void() oppressor_die11 =[$death11, oppressor_die12] {};
void() oppressor_die12 =[$death12, oppressor_die12] {};

void() oppressor_dieb1 =[$deathb1, oppressor_dieb2]
{
	self.glowmod = '0.9 0.9 0.9';
};
void() oppressor_dieb2 =[$deathb2, oppressor_dieb3]
{
	self.solid = 0;
	self.glowmod = '0.8 0.8 0.8';
};
void() oppressor_dieb3 =[$deathb3, oppressor_dieb4]
{
	self.glowmod = '0.7 0.7 0.7';
};
void() oppressor_dieb4 =[$deathb4, oppressor_dieb5]
{
	self.glowmod = '0.6 0.6 0.6';
};
void() oppressor_dieb5 =[$deathb5, oppressor_dieb6]
{
	self.glowmod = '0.5 0.5 0.5';
};
void() oppressor_dieb6 =[$deathb6, oppressor_dieb7]
{
	self.glowmod = '0.4 0.4 0.4';
};
void() oppressor_dieb7 =[$deathb7, oppressor_dieb8]
{
	self.glowmod = '0.3 0.3 0.3';
};
void() oppressor_dieb8 =[$deathb8, oppressor_dieb9]
{
	self.glowmod = '0.2 0.2 0.2';
};
void() oppressor_dieb9 =[$deathb9, oppressor_dieb10]
{
	self.glowmod = '0.1 0.1 0.1';
};
void() oppressor_dieb10 =[$deathb10, oppressor_dieb10]
{
	self.glowmod = '-1 -1 -1';
};

void() oppressor_death2 = { local float r;
	r = random();
	if (r < 0.5)
		oppressor_die1();	// normal dead animation
	else
		oppressor_dieb1();	// normal dead animation
	chattersound("enemies/oppressor/die", 3, 1);
};

void() oppressor_die = { local string dsound, r;
	drop_item(self.origin + '0 0 48', "ore", 10, self);
	if (self.health < -350)
	{
		r = ftos(floor(random() *2) + 1);
		dsound = strcat("impact/gib", r, ".ogg");
		msound(self, CHAN_VOICE, dsound, 1, ATTN_NORM);
		ThrowGib("progs/gib1.mdl", self.health, 1, 1, 1);
		ThrowGib("progs/gib2.mdl", self.health, 1, 1, 1);
		ThrowGib("progs/gib3.mdl", self.health, 1, 1, 1);
		remove(self);
		return;
	}
	else
	{
		r = ftos(floor(random() *2) + 1);
		dsound = strcat("enemies/oppressor/die", r, ".ogg");
		msound(self, CHAN_VOICE, dsound, 1, ATTN_NORM);
		self.think = oppressor_death2;
		self.nextthink = time;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////***END-DEADS***///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*WRATHED monster_oppressor (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
void() precache_monster_oppressor = { precache_sound("enemies/oppressor/attack1.ogg");
	precache_sound("enemies/oppressor/attack2.ogg");
	precache_sound("enemies/oppressor/attack3.ogg");
	precache_sound("enemies/oppressor/die1.ogg");
	precache_sound("enemies/oppressor/die2.ogg");
	precache_sound("enemies/oppressor/die3.ogg");
	precache_sound("enemies/oppressor/idle1.ogg");
	precache_sound("enemies/oppressor/idle2.ogg");
	precache_sound("enemies/oppressor/idle3.ogg");
	precache_sound("enemies/oppressor/pain1.ogg");
	precache_sound("enemies/oppressor/pain2.ogg");
	precache_sound("enemies/oppressor/pain3.ogg");
	precache_sound("enemies/oppressor/sight1.ogg");
	precache_sound("enemies/oppressor/sight2.ogg");
	precache_sound("enemies/oppressor/sight3.ogg");
	precache_sound("enemies/oppressor/step1.ogg");
	precache_sound("enemies/oppressor/step2.ogg");
	precache_sound("enemies/oppressor/step3.ogg");
	precache_model("models/enemies/oppressor/oppressor.md3");
};
void() monster_oppressor = { precache_sound("enemies/oppressor/attack1.ogg");
	precache_sound("enemies/oppressor/attack2.ogg");
	precache_sound("enemies/oppressor/attack3.ogg");
	precache_sound("enemies/oppressor/die1.ogg");
	precache_sound("enemies/oppressor/die2.ogg");
	precache_sound("enemies/oppressor/die3.ogg");
	precache_sound("enemies/oppressor/idle1.ogg");
	precache_sound("enemies/oppressor/idle2.ogg");
	precache_sound("enemies/oppressor/idle3.ogg");
	precache_sound("enemies/oppressor/pain1.ogg");
	precache_sound("enemies/oppressor/pain2.ogg");
	precache_sound("enemies/oppressor/pain3.ogg");
	precache_sound("enemies/oppressor/sight1.ogg");
	precache_sound("enemies/oppressor/sight2.ogg");
	precache_sound("enemies/oppressor/sight3.ogg");
	precache_sound("enemies/oppressor/step1.ogg");
	precache_sound("enemies/oppressor/step2.ogg");
	precache_sound("enemies/oppressor/step3.ogg");
	precache_model("models/enemies/oppressor/oppressor.md3");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "models/enemies/oppressor/oppressor.md3");
	setsizemonster(self, oppressorbbox);
	local float r;
	r = floor(random() *3);
	if (r < 1)
		self.noise = "enemies/oppressor/sight1.ogg";	
	if (r < 2)
		self.noise = "enemies/oppressor/sight2.ogg";	
	else
		self.noise = "enemies/oppressor/sight3.ogg";	
	self.netname = "oppressor";
	self.classname = "oppressor";
	self.health = oppressorhealth;
	self.max_health = 300;
	self.view_ofs_z = 40;
	self.cnt = 1;
	self.th_stand = oppressor_stand1;
	self.th_walk = oppressor_walk1;
	self.th_run = oppressor_run1;
	self.th_missile = oppressor_atk1;
	self.th_melee = oppressor_atk1;
	self.th_pain = oppressor_pain;
	self.th_die = oppressor_die;
	walkmonster_start();
};

////////////////end of qc file