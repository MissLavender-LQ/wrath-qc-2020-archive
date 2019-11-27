/*
==============================================================================

wretch

==============================================================================
*/

/*
1. health
2. walk speed
3. walk think % chance to attack, else keep walking
4. run speed
5. run time
8. attack type (melee or projectile)
6. attack damage
7. attack time
9. pre-attack time
10. secondary attack damage
11. secondaryattack time
12. secondary pre-attack time
13. damage needed to pain
14. pain time
15. pain think % chance to attack or walk
16. bbox

secondary attack is always melee
*/

$frame pose0

$frame wre_idle1

$frame wre_run1

$frame wre_walk1

$frame wre_patk1

$frame wre_atk1

$frame wre_spatk1

$frame wre_satk1

$frame wre_paina1

$frame wre_death1

	.float runing_time;

/////////////////////////////////////////////////////////////////////////////////////////////
void() wretch_stand1 =[$wre_idle1, wretch_stand1]
{
	local float r;
	r = random() *100;

	if (wretch_wth <= r)
		ai_stand();
};

/////////////////////////////////////////////////////////////////////////////////////////////
void() wretch_walk1 =[$wre_walk1, wretch_walk1]
{
	ai_walk(wretch_ws);
	self.colormod = ' 1.25 1 1';
};

/////////////////////////////////////////////////////////////////////////////////////////////
void() wretch_preattack;
void() wretch_spreattack;
void() wretch_sattack;
void() wretch_run1 =[$wre_run1, wretch_run1]
{
	if (self.wknd != 1)
	{
		self.wknd = 1;
		local float rp;
		rp = random() *100;
		if (wretch_itadr >= rp)
		{
			enemy_range = range(self.enemy);
			if ((enemy_range == RANGE_NEAR) || (enemy_range == RANGE_MID))
				self.think = wretch_preattack;
			if (enemy_range == RANGE_MELEE)
			{
				ai_face();
				self.think = wretch_spreattack;
			}

			return;
		}
	}

	local float r;
	if (self.gravity <= 0)
	{
		self.movetype = MOVETYPE_STEP;
		self.gravity = 1;
	}

	ai_runwalk(wretch_rs);
	self.colormod = ' 1 1 1';
	if (time > self.runing_time)
	{
		self.runing_time = time + wretch_rt;
		if (self.zigzaging == 0)
		{
			r = random() *100;
			if (wretch_zzc >= r)
			{
				local float zzmultiplier;
				zzmultiplier = ((wretch_zzd* random()) + wretch_zzmd);
				if (zzmultiplier > wretch_zzd)
					zzmultiplier = wretch_zzd;
				local float rr = random();
				if (rr > 0.5)
					self.zigzagdeviance = zzmultiplier;
				else
					self.zigzagdeviance = zzmultiplier *-1;

				self.zigzaging = 1;
			}
		}
		else
			self.zigzaging = 0;

		if ((visible(self.enemy)))
		{
			enemy_range = range(self.enemy);
			if (enemy_range == RANGE_FAR)
				return;
			if ((enemy_range == RANGE_NEAR) || (enemy_range == RANGE_MID))
			{
				r = random() *100;
				if (wretch_rth >= r)
					self.think = wretch_preattack;
				else
					self.runing_time = time + wretch_rt;
			}

			if (enemy_range == RANGE_MELEE)
				self.think = wretch_spreattack;

		}
	}
};

/////////////////////////////////////////////////////////////////////////////////////////////projectile attack
void() projectile_touch_wre = { local float damg;
	if (other == self.owner)
		return;
	self.solid = SOLID_NOT;
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = wretch_ad;
	if (other.health)
	{
		T_Damage(other, self, self.owner, damg);
	}

	self.touch = SUB_Null;
	self.nextthink = time;
	self.think = slag_explode1;
};

void(vector org, vector dir, entity ownerproj) launch_projectile_wre = { local entity shotgun_proj;
	ownerproj.effects = EF_MUZZLEFLASH;
	shotgun_proj = spawn();
	shotgun_proj.owner = ownerproj;
	shotgun_proj.movetype = MOVETYPE_FLYMISSILE;
	shotgun_proj.solid = SOLID_TRIGGER;
	shotgun_proj.scale = 2;
	shotgun_proj.angles = vectoangles(dir);
	shotgun_proj.touch = projectile_touch_wre;
	shotgun_proj.classname = "projectile";
	setmodel(shotgun_proj, "models/projectiles/proj_slag1.md3");
	setsize(shotgun_proj, '0 0 0', '0 0 0');
	makevectors(self.angles);
	//org -=v_forward*order ;
	setorigin(shotgun_proj, org);
	shotgun_proj.velocity = dir *(wretch_projvel);

	shotgun_proj.oldvelocity = shotgun_proj.velocity;
};

void() wretch_attack = {	//		local float dist;
	self.frame = $wre_atk1;
	self.runing_time = time + wretch_rt + wretch_at;
	ai_face();
	local vector dir, tagorg;
	local float tagindex;
	playersound2("weapons/shotgun/fire2empty_", 2, CHAN_AUTO);
	tagindex = gettagindex(self.vweapon, "tag_proj");
	tagorg = self.origin;	// gettaginfo(self.vweapon, tagindex);
	dir = aim(self, 1000);
	local vector sre;
	sre = self.angles;
	makevectors2(sre);
	//			dist = 1+ (vlen (self.enemy.origin - tagorg) / 512);
	dir = normalize(self.enemy.origin - tagorg);
	launch_projectile_wre(tagorg, dir, self);
	self.colormod = ' 1 0 0';
	if (visible(self.enemy))
	{
		enemy_range = range(self.enemy);
		if (enemy_range == RANGE_FAR)
			self.think = wretch_run1;
		if ((enemy_range == RANGE_NEAR) || (enemy_range == RANGE_MID))
		{
			local float r;
			r = random() *100;
			if (wretch_ath >= r)
				self.think = wretch_attack;
			else
				self.think = wretch_run1;
		}

		if (enemy_range == RANGE_MELEE)
			self.think = wretch_spreattack;
		else
			self.think = wretch_run1;

	}

	if (!(visible(self.enemy)))
		self.think = wretch_run1;
	self.nextthink = time + wretch_at;
};

void() wretch_preattack = { self.colormod = ' 0 0 1';
	self.frame = $wre_patk1;
	self.think = wretch_attack;
	ai_face();
	self.nextthink = time + wretch_pat;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////melee attack

void(float wdmg) wretch_melee_attack = { local vector delta;
	local float dist;
	if (!self.enemy)
		return;	// removed before stroke
	delta = self.enemy.origin - self.origin;
	dist = vlen(delta);
	if (dist > wretch_near)
	{
		return;
	}
	else
	{
		T_Damage(self.enemy, self, self, wdmg);
	}
};

void() wretch_sattack = { ai_face();
	self.gravity = 1;
	self.movetype = MOVETYPE_STEP;
	self.frame = $wre_satk1;
	self.runing_time = time + wretch_rt;
	enemy_range = range(self.enemy);
	wretch_melee_attack(wretch_sad);
	self.colormod = ' 1 0 0';
	if (enemy_range == RANGE_MELEE)
		self.think = wretch_spreattack;
	else
		self.think = wretch_run1;
	self.nextthink = time + wretch_sat;
};

void() wretch_spreattack = { self.colormod = ' 0 0 1';
	self.frame = $wre_spatk1;
	self.think = wretch_sattack;
	ai_face();
	self.nextthink = time + wretch_spat;
};

/////////////////////////////////////////////////////////////////////////////////////////////
void(entity enemy, float dmg) wretch_paina1 = { if (dmg < wretch_dtp)
		return;

	local float rp;
	rp = random() *100;
	if (wretch_rtp <= rp)
		return;

	self.runing_time = time + wretch_rt;
	self.frame = $wre_paina1;
	ai_pain(4);
	self.colormod = ' 1 1 0';

	local float r;
	r = random() *100;
	if (wretch_pth >= r)
		self.think = wretch_run1;
	else
		self.think = wretch_preattack;

	self.pain_finished = time + wretch_pt;
	self.nextthink = time + wretch_pt;
};

///////////////////////////////////////////////////////////////////////////////////////////
void() wretch_diea1 = { decal_monster(self.origin + '0 0 12');
	remove(self);
};

///////////////////////////////////////////////////////////////////////////////////////////

/*WRATHED monster_wretch (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
.vector bbvv;
void() precache_monster_wretch = { precache_model("models/enemies/wretch/wretch.md3");
};

void() monster_wretch = { precache_model("models/enemies/wretch/wretch.md3");
	if (deathmatch)
	{
		remove(self);
		return;
	}

	if (self.waypointed != 1)
		self.waypointed = 0;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "models/enemies/wretch/wretch.md3");
	setsize(self, wretch_bbox *-0.5, wretch_bbox *0.5);
	self.health = wretch_health;
	self.classname = "monster_wretch";
	self.th_stand = wretch_stand1;
	self.th_walk = wretch_walk1;
	self.th_run = wretch_run1;
	self.th_missile = wretch_preattack;
	self.th_melee = wretch_spreattack;
	self.th_pain = wretch_paina1;
	self.th_die = wretch_diea1;
	walkmonster_start();
};

////////////////end of qc file