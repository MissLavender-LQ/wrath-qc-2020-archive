float(float v) anglemod;

void() ai_face;

.float waypointed;
float enemy_vis, enemy_infront, enemy_range;
float enemy_yaw;

//float	current_yaw;

float() CheckAttack = { local vector spot1, spot2;
	local entity targ;
	local float chance;

	targ = self.enemy;

	// see if any entities are in the way of the shot
	spot1 = rorigin(self) + self.view_ofs;
	spot2 = rorigin(targ) + targ.view_ofs;

	wtraceline(spot1, spot2, FALSE, self);

	if (trace_ent != targ)
		return FALSE;	// don't have a clear shot

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	if (enemy_range == RANGE_MELEE)
	{
		// melee attack
		if (self.th_melee)
		{
			self.th_melee();

			return TRUE;
		}
	}

	// missile attack
	if (!self.th_missile)
		return FALSE;

	if (time < self.attack_finished)
		return FALSE;

	if (enemy_range == RANGE_FAR)
		return FALSE;

	if (enemy_range == RANGE_MELEE)
	{
		chance = 0.9;
		self.attack_finished = 0;
	}
	else if (enemy_range == RANGE_NEAR)
	{
		if (self.th_melee)
			chance = 0.2;

		else
			chance = 0.4;
	}
	else if (enemy_range == RANGE_MID)
	{
		if (self.th_melee)
			chance = 0.05;

		else
			chance = 0.1;
	}
	else
		chance = 0;

	if (random() < chance)
	{
		self.th_missile();
		SUB_AttackFinished(2* random());

		return TRUE;
	}

	return FALSE;
};

/*=============
ai_face

Stay facing the enemy
=============*/
void() ai_face = { self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
	ChangeYaw();
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};

float(entity targ) oldvisible;
float(entity targ) visible;
float(entity targ) infront;
float(entity targ) range;

void(float d) ai_charge = { ai_face();
	movetogoal(d);	// done in C code...
};

void() ai_charge_side = { local vector dtemp;
	local float heading;

	// aim to the left of the enemy for a flyby
	self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
	ChangeYaw();

	makevectors2(self.angles);
	dtemp = rorigin(self.enemy) - 30 * v_right;
	heading = vectoyaw(dtemp - rorigin(self));

	walkmove(heading, 20);

};

/*=============
ai_melee

=============*/
void() ai_melee = { local vector delta;
	local float ldmg;

	if (!self.enemy)
		return;	// removed before stroke

	delta = rorigin(self.enemy) - rorigin(self);

	if (vlen(delta) > 60)
		return;

	ldmg = (random() + random() + random()) *3;
	T_Damage(self.enemy, self, self, ldmg);
};

void() ai_melee_side = { local vector delta;
	local float ldmg;

	if (!self.enemy)
		return;	// removed before stroke

	ai_charge_side();

	delta = rorigin(self.enemy) - rorigin(self);

	if (vlen(delta) > 60)
		return;

	if (!CanDamage(self.enemy, self))
		return;
	ldmg = (random() + random() + random()) *3;
	T_Damage(self.enemy, self, self, ldmg);
};

void() movetarget_f;
void() t_movetarget;

void(entity etemp, entity stemp, entity stemp, float dmg) T_Damage;

entity sight_entity;
float sight_entity_time;

void makevectors2(vector ang) = { ang_x *= -1;
	makevectors(ang);
};

float(float v) anglemod = { while (v >= 360)
		v = v - 360;
	while (v < 0)
		v = v + 360;
	return v;
};



void() movetarget_f = { if ((!self.targetname) && (self.classname != "path_corner_start"))
		objerror("monster_movetarget: no targetname");

	self.solid = SOLID_TRIGGER;
	self.touch = t_movetarget;
	setsize(self, '-8 -8 -8', '8 8 8');

};

void() path_corner = { movetarget_f();
};

void() path_corner_start = { movetarget_f();
};

.entity lastpathed;
.entity lastpathed2;
.entity lastpathed3;

void() t_movetarget = { local entity temp;

	if (other.movetarget != self)
		return;

	if (other.enemy)
		return;	// fighting, not following a path

	other.lastpathed3 = other.lastpathed2;
	other.lastpathed2 = other.lastpathed;
	other.lastpathed = self;

	temp = self;
	self = other;
	other = temp;

	//	if (self.classname == "monster_ogre")
	//		sound (self, CHAN_VOICE, "ogre/ogdrag.wav", 1, ATTN_IDLE);// play chainsaw drag sound

	//dprint ("t_movetarget\n");
	self.goalentity = self.movetarget = find(world, targetname, other.target);
	if (other.classname == "place_model")
	{
		if (self.speed)
			other.speed = self.speed;
	}

	self.ideal_yaw = vectoyaw(self.goalentity.origin - rorigin(self));
	float r = random();
	if ((self.pathed == 1) && (self.pathtime < time) && (r > 0.8))
		self.pathtime = time + 0.5;

	if (visible(self.oldenemy))
	{
		if (self.th_missile)
		{
			self.ideal_yaw = vectoyaw(self.oldenemy.origin - self.origin);
			self.enemy = self.oldenemy;
			self.goalentity = self.enemy;
			self.th_missile();
		}
	}

	if (!self.movetarget)
	{
		self.pausetime = time + 999999;
		self.th_stand();
		return;
	}
};


float(entity targ) hear_range = { local vector spot1, spot2;
	local float r;
	spot1 = rorigin(self) + self.view_ofs;
	spot2 = rorigin(targ) + targ.view_ofs;

	r = vlen(spot1 - spot2);

	if (r < 128)
		return RANGE_MELEE;
	if (r < 512)
		return RANGE_NEAR;
	if (r < 4096)
		return RANGE_MID;

	return RANGE_FAR;
};
.float movingz;
float(entity targ) range = { local vector spot1, spot2;
	local float r;
	spot1 = rorigin(self) + self.view_ofs;
	spot2 = rorigin(targ) + targ.view_ofs;

	r = vlen(spot1 - spot2);

	if (!targ.health)
		return RANGE_FAR;

	if (self.classname == "oppressor")
	{
		if (r < 250)
			return RANGE_MELEE;
		if (r < 1000)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}
	else if (self.classname == "heretic")
	{
		if (r < 60)
			return RANGE_MELEE;

		if (r < 1000)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}
	else if (self.classname == "afflicted")
	{
		if (r < 75)
			return RANGE_MELEE;
		if (r < 2048)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}
	else if (self.classname == "monster_incisor")
	{
		if (r < incisor_near)
			return RANGE_MELEE;
		if (r < incisor_mid)
			return RANGE_NEAR;
		if (r < incisor_far)
			return RANGE_MID;
	}
	else if (self.classname == "monster_wretch")
	{
		if (r < wretch_near)
			return RANGE_MELEE;
		if (r < wretch_mid)
			return RANGE_NEAR;
		if (r < wretch_far)
			return RANGE_MID;
	}
	else if (self.classname == "monster_stricken")
	{
		if (r < stricken_near)
			return RANGE_MELEE;
		if (r < stricken_mid)
			return RANGE_NEAR;
		if (r < stricken_far)
			return RANGE_MID;
	}
	else if (self.classname == "monster_invader")
	{
		if (r < invader_near)
			return RANGE_MELEE;
		if (r < invader_mid)
			return RANGE_NEAR;
		if (r < invader_far)
			return RANGE_MID;
	}

	/*
	else if (self.classname == "monster_fallen")
	{
		if (r < fallen_near)
			return RANGE_MELEE;
		if (r < fallen_mid)
			return RANGE_NEAR;
		if (r < fallen_far)
			return RANGE_MID;
	}*/
	else if (self.classname == "monster_heretic")
	{
	
		if(self.movingz == 1)
		{
			if (r < heretic_near + 16)
				return RANGE_MELEE;
		}
		else
		{
			if (r < heretic_near)
				return RANGE_MELEE;
		}
		if (r < heretic_mid)
			return RANGE_NEAR;
		if (r < heretic_far)
			return RANGE_MID;
	}
	else if (self.classname == "monster_widow")
	{
		if (r < widow_near)
			return RANGE_MELEE;
		if (r < widow_mid)
			return RANGE_NEAR;
		if (r < widow_far)
			return RANGE_MID;
	}
	else if (self.classname == "wraith")
	{
		if (r < 128)
			return RANGE_MELEE;
		if (r < 1024)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}
	else if (self.classname == "fallen")
	{
		if (self.enemy.crouch == 1)
		{
			if (r < 256)
				return RANGE_MELEE;
		}
		else
		{
			if (r < 256)
				return RANGE_MELEE;
		}

		if (r < 1024)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}
	else
	{
		if (r < 120)
			return RANGE_MELEE;
		if (r < 500)
			return RANGE_NEAR;
		if (r < 4096)
			return RANGE_MID;
	}

	return RANGE_FAR;
};



float(entity targ) rvisible = { local vector spot1, spot2;

	spot1 = rorigin(self);
	spot2 = rorigin(targ);
	traceline(spot1, spot2, TRUE, self);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

float(entity targ) oldvisible = { local vector spot1, spot2;

	spot1 = self.origin + '0 0 16';
	spot2 = targ.origin + '0 0 16';
	traceline(spot1, spot2, TRUE, self);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

float(entity targ) reachable = { if (oldvisible(targ))
		return TRUE;
	return FALSE;
}

float(entity targ, entity e) reachable2 = 
{ 
	self = e;
	if (oldvisible(targ))
		return TRUE;
	return FALSE;
}

float(entity targ) visible = { local vector spot1, spot2;

	spot1 = self.origin + '0 0 16';
	spot2 = targ.origin + '0 0 16';
	wtraceline(spot1, spot2, TRUE, world);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

float(vector spot1, vector spot2, entity e) visibleb = { traceline(spot1, spot2, TRUE, e);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};



float(entity targ) visible_complex = { local vector spot1, org; // fisible
	local float thruwater, pc1, pc2;

	org = rorigin(targ);
	spot1 = rorigin(self) + self.view_ofs;

	if (targ.solid == SOLID_BSP)
	{
		wtraceline(spot1, org, TRUE, self);
		if (trace_ent == targ)
			return TRUE;
		else if (trace_fraction == 1)
			return TRUE;
		return FALSE;
	}
	else
	{
		pc1 = pointcontents(org);
		pc2 = pointcontents(spot1);
		if (targ.classname == "player")
			thruwater = FALSE;
		else if (pc1 == CONTENT_LAVA)
			return FALSE;
		else
			thruwater = TRUE;
	}

	if (pc1 < -1)	// targ's origin is in water or other liquid
	{
		if (pc2 != pc1)
		{
			// look for their head
			wtraceline(spot1, org + targ.mins, TRUE, self);
			// cross the water check
			if (trace_inopen)
				if (trace_inwater)
					if (!thruwater)
						return FALSE;
			if (trace_ent == targ)
				return TRUE;
			else if (trace_fraction == 1)
				return TRUE;
			return FALSE;
		}
	}
	else
	{
		if (pc2 != pc1)
		{
			wtraceline(spot1, org + targ.maxs, TRUE, self);
			if (trace_inopen)
				if (trace_inwater)
					if (!thruwater)
						return FALSE;
			if (trace_ent == targ)
				return TRUE;
			else if (trace_fraction == 1)
				return TRUE;
			return FALSE;
		}
	}

	wtraceline(spot1, org, TRUE, self);
	if (trace_ent == targ)
		return TRUE;
	else if (trace_fraction == 1)
		return TRUE;

	wtraceline(spot1, org + targ.maxs, TRUE, self);
	if (trace_ent == targ)
		return TRUE;
	else if (trace_fraction == 1)
		return TRUE;

	wtraceline(spot1, org + targ.mins, TRUE, self);
	if (trace_ent == targ)
		return TRUE;
	else if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};

float(entity targ, float dist, float drange) visible2 = { local vector spot1, spot2;
	local float d;

	if (!drange)
		drange = 0.3;
	if (targ.health <= 0)
		return FALSE;
	spot1 = rorigin(self) + self.view_ofs;
	spot2 = rorigin(targ) + targ.view_ofs;

	local vector vec;
	local float dot;

	d = vlen(spot1 - spot2);
	if (d > dist)
		return FALSE;

	wtraceline(spot1, spot2, TRUE, self);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	makevectors2(self.angles);
	vec = normalize(spot2 - spot1);
	dot = vec * v_forward;

	if (dot < drange)
		return FALSE;

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

float(entity targ, float dist) visibleinfront = { local vector vec, spot1, spot2;
	local float dot, d;

	//	spot1 = rorigin(self) + self.view_ofs;
	//	spot2 = targ.origin + targ.view_ofs;
	spot1 = rorigin(self) + self.view_ofs;
	spot2 = rorigin(targ) + targ.view_ofs;
	d = vlen(spot1 - spot2);
	if (d > dist)
		return FALSE;

	wtraceline(spot1, spot2, TRUE, self);	// see through other monsters

	if (trace_inopen && trace_inwater)
		return FALSE;	// sight line crossed contents

	makevectors2(self.angles);
	//	vec = normalize (targ.origin - rorigin(self));
	vec = normalize(rorigin(targ) - rorigin(self));
	dot = vec * v_forward;

	if (dot < 0.3)
	{
		return FALSE;
	}

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;

};


float(entity targ) infront = { local vector vec;
	local float dot;

	makevectors2(self.angles);
	vec = normalize(rorigin(targ) - rorigin(self));
	dot = vec * v_forward;

	if (dot > 0.3)
	{
		return TRUE;
	}

	return FALSE;
};

//============================================================================
.float turret;
.float likecharge;
void() executioner_chrgrandom;
void() executioner_chargesh2;

void() HuntTarget = { self.goalentity = self.enemy;
	float r;
	r = random();

	if (self.classname == "monster_oppressor")
	{
		if ((r > opp_dr_idle) && (!self.turret))
			self.think = self.th_run;
		else
			self.think = self.th_missile;
	}

	if (self.classname == "executioner")
	{
		if (self.likecharge == 1)
			self.think = self.th_charge;
		else
		{
			if ((visible2(self.enemy, 512, 0.5)))
				self.think = self.th_charge;
			else
				self.think = self.th_run;
		}
	}
	else
		self.think = self.th_run;
	self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
	SUB_AttackFinished(1);	// wait a while before first attack
	self.nextthink = time + 0.05;
};
.float widowsight;
.float widowscreamingtime;
void() FoundTarget = { if (self.enemy.classname == "player")
	{
		// let other monsters see this monster for a while
		sight_entity = self;
		sight_entity_time = time;
	}

	self.show_hostile = time + 1;	// wake up other monsters
	self.sight_time = time + 1;
	
	if (self.classname == "widow")
	{
		sound(self, CHAN_ITEM, self.noise, 1, 0.25);
		self.widowscreamingtime = soundlength(self.noise) + time;
	}
	else
		sound(self, CHAN_AUTO, self.noise, 1, 0.25);
	//void(vector org, float radius, float lifetime, vector color) te_customflash = #417;
	HuntTarget();
	/*if((self.classname == "executioner")||(self.classname == "monster_invader") ||(self.classname == "monster_stricken")||(self.classname == "fallen"))
	return;
	else
	self.colormod = '0 1 0'; */
};

.float grosstime;

void() FindNearestPath = { local entity head, near;
	local float dist, low;
	low = 99999999;	
	head = find(world, classname, "path_corner_start");
	if (!head)
	{
		self.pathed = 0;
		self.th_run();
		return;
	}

	while (head)
	{
		//	if((reachable(head)) && (head !=  self.lastpathed) && (head !=  self.lastpathed2)&& (head !=  self.lastpathed3)) 
		if (reachable(head))
		{
			dist = vlen(head.origin - self.origin);
			if (dist < low)
			{
				low = dist;
				near = head;
			}
		}

		head = find(head, classname, "path_corner");
	}

	if (near)
	{
		if (!(self.pathtime < time))
			self.pathtime = time + 0.5;
		self.target = near.targetname;
		self.goalentity = self.movetarget = near;
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		self.th_walk();
	}
};

void() FindNearestEnemy = { local entity head, near;
	local float dist, low;

	if (self.enemy)
		return;

	low = 99999999;	

	head = find(world, classentity, "monsters");
	if (!head)
	{
		local entity client;
		client = checkclient();
		self.enemy = world;
		self.goalentity = client;
		self.th_walk();
		return;
	}

	while (head)
	{
		if ((head != self) && (visible(head)) && (head.friendly_monster != 1))
			if (head.health > 0)
			{
				dist = vlen(head.origin - self.origin);
				if (dist < low)
				{
					low = dist;
					near = head;
				}
			}

		head = find(head, classentity, "monsters");
	}

	if (near)
		self.enemy = near;

};

float() FindTarget = { local entity client;
	local float r;

	// if the first spawnflag bit is set, the monster will only wake up on
	// really seeing the player, not another monster getting angry

	// spawnflags &3 is a big hack, because zombie crucified used the first
	// spawn flag prior to the ambush flag, and I forgot about it, so the second
	// spawn flag works as well

	if (sight_entity_time >= time - 0.1 && !(self.spawnflags &3))
	{
		client = sight_entity;
		if (client.enemy == self.enemy)
			return TRUE;
	}
	else
	{
		client = checkclient();
		if (!client)
			return FALSE;	// current check entity isn't in PVS
	}

	if (self.friendly_monster == 1)
	{
		if (self.enemy)
		{
			return FALSE;
		}

		FindNearestEnemy();

		if (!self.enemy)
		{
			return FALSE;
		}

		FoundTarget();
		return TRUE;
	}

	if (client == self.enemy)
		return FALSE;

	if (client.flags &FL_NOTARGET)
		return FALSE;

	//	if (client.items &IT_INVISIBILITY)
	//		return FALSE;

	if (self.classname == "afflicted")
	{
		r = hear_range(client);
		if (r == RANGE_FAR)
			return FALSE;

		if (!visible(client))
			return FALSE;

		if (r == RANGE_NEAR)
		{
			if (client.show_hostile < time && !infront(client))
				return FALSE;
		}
		else if (r == RANGE_MID)
		{
			if (/*client.show_hostile < time || */ !infront(client))
				return FALSE;
		}
	}
	else
	{
		r = range(client);
		if (r == RANGE_FAR)
			return FALSE;

		if (!visible(client))
			return FALSE;

		if (r == RANGE_NEAR)
		{
			if (client.show_hostile < time && !infront(client))
				return FALSE;
		}
		else if (r == RANGE_MID)
		{
			if (/*client.show_hostile < time || */ !infront(client))
				return FALSE;
		}
	}

	self.enemy = client;
	if (self.enemy.classname != "player")
	{
		self.enemy = self.enemy.enemy;
		if (self.enemy.classname != "player")
		{
			self.enemy = world;
			return FALSE;
		}
	}

	FoundTarget();

	return TRUE;
};

//=============================================================================

void(float dist) ai_forward = { walkmove(self.angles_y, dist);
};

void(float dist) ai_back = { walkmove((self.angles_y + 180), dist);
};


void(float dist) ai_pain = { ai_back(dist);
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};


void(float dist) ai_painforward = { walkmove(self.ideal_yaw, dist);
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};


.float rollwalktoattack;
.float findtargettime;
.float painframe;
void(float dist) ai_walk = { 

		if (self.watertype == CONTENT_LAVA)	// do lava damage
		{
		T_Damage(self, world, world, 10 *self.waterlevel);
		return;
		}
	movedist = dist;

	// check for noticing a player

	if (self.rollwalktoattack)
	{
		local float r;
		r = random() *100;
		if ((self.rollwalktoattack >= r) && (self.findtargettime > time))
		{
			if (FindTarget())
				return;
		}
	}

	if (self.pathed != 1)
	{
		if (FindTarget())
			return;
	}
	else
	{
		if (self.pathtime < time)
		{
			if (FindTarget())
				return;
		}
	}

	movetogoal(dist);
	//	movetogoal (dist);
	if (self.friendly_monster == 1 && vlen(self.origin - self.goalentity.origin) < 80)
	{
		self.pausetime = time + 1.5;
		self.th_stand();
	}
};

.float rise;

void() ai_stand = { 
		if (self.watertype == CONTENT_LAVA)	// do lava damage
		{
		T_Damage(self, world, world, 10 *self.waterlevel);
		return;
		}

	if (self.oldenemy)
	{
		self.enemy = self.oldenemy;
		if (self.enemy.health > 0)
		{
			self.th_run();
			return;
		}
	}

	if (self.grosstime > time)
	{
		FoundTarget();
		local entity pl;
		pl = find(world, classname, "player");
		self.enemy = pl;
		return;
	}

	if (FindTarget())
		return;

	if (time > self.pausetime)
	{
		self.th_walk();
		return;
	}

	// change angle slightly
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};


void() ai_turn = { if (FindTarget())
		return;

	ChangeYaw();
};


void(vector dest3) ChooseTurn = { local vector dir, newdir;

	dir = rorigin(self) - dest3;

	newdir_x = trace_plane_normal_y;
	newdir_y = 0 - trace_plane_normal_x;
	newdir_z = 0;

	if (dir * newdir > 0)
	{
		dir_x = 0 - trace_plane_normal_y;
		dir_y = trace_plane_normal_x;
	}
	else
	{
		dir_x = trace_plane_normal_y;
		dir_y = 0 - trace_plane_normal_x;
	}

	dir_z = 0;
	self.ideal_yaw = vectoyaw(dir);
};


float() FacingIdeal = { local float delta;

	delta = anglemod(self.angles_y - self.ideal_yaw);
	if (delta > 45 && delta < 315)
		return FALSE;
	return TRUE;
};

float() wraithCheckAttack;

float() CheckAnyAttack = { if (!enemy_vis)
		return FALSE;
	if (self.classname == "wraith")
		return wraithCheckAttack();
	//	if (self.classname == "monster_wizard")
	//		return WizardCheckAttack ();
	return CheckAttack();
};


void() ai_run_melee = { self.ideal_yaw = enemy_yaw;
	ChangeYaw();

	if (FacingIdeal())
	{
		self.th_melee();
		self.attack_state = AS_STRAIGHT;
	}

	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};


void() ai_run_missile = { self.ideal_yaw = enemy_yaw;
	ChangeYaw();
	if (FacingIdeal())
	{
		self.th_missile();
		self.attack_state = AS_STRAIGHT;
	}

	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};



float(float righty) test_side_wall = { local vector source;
	local float dist;

	if (righty == 1)
		dist = 64;
	else
		dist = -64;
	makevectors(self.v_angle);
	source = self.origin;
	tracebox(source, '-1 -1 -1', '1 1 1', source + v_right *dist, FALSE, self);
	if (trace_fraction == 1)
		return FALSE;
	else
		return TRUE;
};

void() ai_run_slide = { local float ofs;

	self.ideal_yaw = enemy_yaw;
	ChangeYaw();
	if (self.lefty)
		ofs = 90;
	else
		ofs = -90;
	if (walkmove(self.ideal_yaw + ofs, movedist))
	{
		return;
	}

	walkmove(self.ideal_yaw + ofs, movedist);
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};
void() mercenary_walktoattack;



void(float dist) ai_runwalkb = { movedist = dist;
	// see if the enemy is dead
	if (self.enemy.health <= 0)
	{
		self.enemy = world;
		// FIXME: look all around for other targets
		if (self.oldenemy.health > 0)
		{
			self.enemy = self.oldenemy;
			HuntTarget();
		}
		else
		{
			if (self.movetarget)
				self.th_walk();
			else
				self.th_stand();
			return;
		}
	}

	self.show_hostile = time + 1;	// wake up other monsters
	// check knowledge of enemy
	enemy_vis = visible(self.enemy);

	if (visible(self.enemy))
		self.search_time = time + 5;
	// look for other coop players
	if (coop && self.search_time < time)
	{
		if (FindTarget())
			return;
	}

	enemy_infront = infront(self.enemy);
	enemy_range = range(self.enemy);
	enemy_yaw = vectoyaw((rorigin(self.enemy)) - rorigin(self));
	if (self.attack_state == AS_MISSILE)
	{
		ai_run_missile();
		return;
	}

	if (self.attack_state == AS_MELEE)
	{
		ai_run_melee();
		return;
	}

	if (CheckAnyAttack())
		return;	// beginning an attack		
	if (self.attack_state == AS_SLIDING)
	{
		ai_run_slide();
		return;
	}

	// head straight in
	self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
	ChangeYaw();
	if (!walkmove(self.angles_y, dist))
		movetogoal(dist);
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};

void(float dist) ai_run = { movedist = dist;
	// see if the enemy is dead
	if (self.enemy.health <= 0)
	{
		self.enemy = world;
		// FIXME: look all around for other targets
		if (self.oldenemy.health > 0)
		{
			self.enemy = self.oldenemy;
			HuntTarget();
		}
		else
		{
			if (self.movetarget)
				self.th_walk();
			else
				self.th_stand();
			return;
		}
	}

	self.show_hostile = time + 1;	// wake up other monsters
	// check knowledge of enemy
	enemy_vis = visible(self.enemy);
	if (enemy_vis)
		self.search_time = time + 5;
	// look for other coop players
	if (coop && self.search_time < time)
	{
		if (FindTarget())
			return;
	}

	enemy_infront = infront(self.enemy);
	enemy_range = range(self.enemy);
	enemy_yaw = vectoyaw((rorigin(self.enemy)) - rorigin(self));
	if (self.attack_state == AS_MISSILE)
	{
		ai_run_missile();
		return;
	}

	if (self.attack_state == AS_MELEE)
	{
		ai_run_melee();
		return;
	}

	if (CheckAnyAttack())
		return;	// beginning an attack		
	if (self.attack_state == AS_SLIDING)
	{
		ai_run_slide();
		return;
	}

	// head straight in
	movetogoal(dist);
	/*	
	if(self.flags &FL_WALKEDOFF)	
	{
		self.effects = 512;
		self.origin_z = self.origin_z + 3;
		self.velocity += v_forward *300 + '0 0 120';
	self.flags -= FL_WALKEDOFF;
	}

	*/

	// done in C code...
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};

void(float dist) ai_runwalk2 = { if (dist <= 0)
	{
		self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
		ChangeYaw();
		return;
	}

	movedist = dist;
	movetogoal(dist);	// done in C code...
	//if (TrinketofRespite_time > time)
	//self.nextthink = time + 0.2;	
};

.float pathtomonstertime;
void(entity e, entity excep) changegoalentity = { local entity head, near;
	local float dist, low;
	low = 99999999;	

	head = find(world, classname, "path_waypoint");
	while (head)
	{
		dist = vlen(head.origin - e.origin);
		if (dist < low)
		{
			low = dist;

			if (head != excep)
			{
				self = e;
				if (visible(head) && oldvisible(head))
					near = head;
				e = self;
			}
		}

		head = find(head, classname, "path_waypoint");
	}

	if (near)
	{
		e.enemy = near;
		e.goalentity = near;
	}

	if (e.classname == "widow")
		e.pathtomonstertime = time + 2.5;

};
.string classname2;

void(entity e, entity excep) changegoalentity2 = { local entity head, near;
	local float dist, low;
	low = 99999999;	

	head = find(world, classname2, "path_waypoint");
	while (head)
	{
		dist = vlen(head.origin - e.origin);
		if (dist < low)
		{
			low = dist;

			if (head != excep)
			{
				self = e;
				if (visible(head) && oldvisible(head))
					near = head;
				e = self;
			}
		}

		head = find(head, classname2, "path_waypoint");
	}

	if (near)
	{
		e.enemy = near;
		e.goalentity = near;
	}

	if (e.classname == "widow")
		e.pathtomonstertime = time + 2.5;
};
void() path_waypointthink = { self.classname = "path_waypoint";
};

void() path_waypoint_touch = { if (!(other.flags &FL_MONSTER))
		return;
	if (other.enemy.classname == "player")
		return;
	changegoalentity(self, self);
	self.classname = "path_waypoint_waiting";
	other.enemy = self.enemy;
	self.think = path_waypointthink;
	self.nextthink = time + 2.5;
};

void() path_waypoint = { self.solid = SOLID_TRIGGER;
	setsize(self, '-12 -12 -12', '12 12 12');
	self.touch = path_waypoint_touch;
	self.classname2 = self.classname;
};

.float rotating_time;

.float lasttimespotted;
.vector vlasttimespotted;

void(vector org, entity e) dropwaypoint = { local entity head, near;
		local float dist, low;
		low = 99999999;	

		head = find(world, classname2, "path_waypoint");
		while (head)
		{
			dist = vlen(head.origin - org);
			if (dist < low)
			{
				low = dist;

				self = e;
				if (visible(head) && oldvisible(head))
					near = head;
				e = self;
			}

			head = find(head, classname2, "path_waypoint");
		}

		if (near)
		{
			e.enemy = near;
			e.goalentity = near;
		}
	}

	.vector oldmonsterorigin;
.float distoplayer;
.float origincounter;
.float timeroaming;
.float timestrafing;
.float heavy;
.float timeangles;
.float movetogoal_time;



void(float dist) ai_runwalk = { 

		if (self.watertype == CONTENT_LAVA)	// do lava damage
		{
		T_Damage(self, world, world, 10 *self.waterlevel);
		return;
		}
	if (self.movetype == MOVETYPE_FLYMISSILE)
	{
		ai_face();
		return;
	}

	if (self.movetype == MOVETYPE_BOUNCE)
		self.movetype = self.oldmovetype;
	if (!self.enemy)
	{
		if (FindTarget())
			return;

		ai_run(dist);
		return;
	}

	if (self.timeroaming > time)
	{
		if (self.enemy.classname != "player")
			self.enemy = self.oldenemy;

		//ai_run(dist);	
	}
	else
	{
		if (self.waypointed)
		{
			//self.effects = 8192;
			if (visible(self.enemy) && oldvisible(self.oldenemy))
			{
				self.lasttimespotted = 1;
				self.vlasttimespotted = rorigin(self.enemy);
			}

			if ((!visible(self.enemy)) && (!oldvisible(self.oldenemy)) && (self.enemy.classname == "player"))
			{
				self.oldenemy = self.enemy;
				local float dropablesame_z;

				self.distoplayer = (max(self.enemy.origin_z, self.origin_z + 32) - min(self.enemy.origin_z, self.origin_z + 32));

				if ((self.classname == "widow") && (self.distoplayer > 12))
					dropablesame_z = 1;

				if (self.lasttimespotted == 1)
				{
					dropwaypoint(self.vlasttimespotted, self);
					self.lasttimespotted = 0;
				}
				else
					changegoalentity(self, self.enemy);
			}

			if ((!visible(self.enemy)) && (!oldvisible(self.oldenemy)) && (self.enemy.classname2 == "path_waypoint"))
				changegoalentity2(self, self.enemy);

			if (visible(self.oldenemy) && oldvisible(self.oldenemy))
			{
				if (self.enemy.classname == "path_waypoint")
					self.enemy = self.oldenemy;
			}
		}

		if ((self.timestrafing < time) && (self.heavymonster < 1) && (self.timeangles < time)) 
		{
			local float visl, visr;
			local vector spot1, spot2, spot3;
			makevectors(self.angles);
			spot2 = rorigin(self.enemy);
			spot1 = rorigin(self) + v_right * 16;
			wtraceline(spot1, spot2, TRUE, self);
			if (trace_fraction == 1)
				visr = 1;
			spot3 = rorigin(self) + v_right *-16;
			wtraceline(spot3, spot2, TRUE, self);
			if (trace_fraction == 1)
				visl = 1;

			if ((visr == 1) && (visl != 1))
			{
				self.timeroaming = time + 0.5;
				self.flags -= FL_ONGROUND;
				//	self.colormod = '0 0 1';
				self.velocity += v_right *32 + v_up * 32;
			}

			if ((visr != 1) && (visl == 1))
			{
				self.timeroaming = time + 0.5;
				self.flags -= FL_ONGROUND;
				//	self.colormod = '1 0 0';
				self.velocity += v_right *-32 + v_up * 32;
			}

			self.timestrafing = time + 2.5;
		}

		if ((!self.heavymonster))
			self.origincounter++;


		if(self.timeangles < time)
		{
			if (self.zigzaging == 1)
			{
				local float zzpo;
				zzpo = self.zigzagdeviance;
				self.ideal_yaw = vectoyaw((rorigin(self.enemy)) - rorigin(self)) + zzpo;
			}
			else
			{
				self.ideal_yaw = vectoyaw((rorigin(self.enemy)) - rorigin(self));
			}

			ChangeYaw();
		}
		//self.flags = self.flags | FL_PARTIALGROUND; 
		//self.effects = EF_NODEPTHTEST;
		if (self.heavymonster == 1)
			self.velocity = '0 0 0';



		vector oldorigin = self.origin;
		//movetogoal(dist);

		if (!walkmove(self.angles_y, dist))
		{
		if(self.timeangles)
		self.timeangles = 0;
		//ChangeYaw();
		
		movetogoal(dist);
		}
		if ((self.origincounter == 3) && (!self.heavymonster))
		{
			if (vlen(self.origin - self.oldmonsterorigin) <= 1)
				self.timeroaming = time + 2.5;

			self.origincounter = 0;
			self.oldmonsterorigin = self.origin;
		}
	}
};

void(float dist) ai_runattack = { movedist = dist;
	if (self.enemy.health <= 0)
	{
		self.enemy = world;
		if (self.oldenemy.health > 0)
		{
			self.enemy = self.oldenemy;
			HuntTarget();
		}
		else
		{
			if (self.movetarget)
				self.th_walk();
			else
				self.th_stand();
			return;
		}
	}

	self.show_hostile = time + 1;	// wake up other monsters
	enemy_vis = visible(self.enemy);
	if (enemy_vis)
		self.search_time = time + 5;
	if (coop && self.search_time < time)
	{
		if (FindTarget())
			return;
	}

	enemy_infront = infront(self.enemy);
	enemy_range = range(self.enemy);
	enemy_yaw = vectoyaw((rorigin(self.enemy)) - rorigin(self));
	if (self.attack_state == AS_MISSILE)
	{
		ai_run_missile();
		return;
	}

	if (self.attack_state == AS_MELEE)
	{
		ai_run_melee();
		return;
	}

	if (CheckAnyAttack())
		return;	// beginning an attack
	if (self.attack_state == AS_SLIDING)
	{
		ai_run_slide();
		return;
	}

	self.ideal_yaw = vectoyaw(rorigin(self.enemy) - rorigin(self));
	ChangeYaw();
	if (!walkmove(self.angles_y, dist))
		movetogoal(dist);
	if (TrinketofRespite_time > time)
		self.nextthink = time + 0.2;
};

///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////   Monsters sounds   	/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
void(entity e, float chan, string samp, float vol, float attenn) msound = { if (TrinketofRespite_time < time)
		sound(e, chan, samp, vol, attenn);
	else
		sound7(e, chan, samp, vol, attenn, 50, 0.5);

};

void(string locsound) painsound = { local float r;
	local string monstersound, rsound;

	r = floor(random() *2) + 1;

	if (r == self.painsnd)
		r += 1;

	if (r > 3)
		r = 1;

	self.painsnd = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, CHAN_VOICE, monstersound, 1, 0.25);
};

.float attacksoundtime;
void(string locsound) attacksound = { if (self.attacksoundtime > time)
	{
		//self.attacksoundtime = 0;
		return;
	}

	local float r;
	local string monstersound, rsound;

	r = floor(random() *2) + 1;

	if (r == self.attacksnd)
		r += 1;

	if (r > 3)
		r = 1;

	self.attacksnd = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, CHAN_WEAPON, monstersound, 1, 0.25);
};

.float attacksnd2;

void(string locsound) attacksound2 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *2) + 1;

	if (r == self.attacksnd2)
		r += 1;

	if (r > 3)
		r = 1;

	self.attacksnd2 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, CHAN_VOICE, monstersound, 1, 0.25);
};

void(string locsound, float rnd) walksound = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;

	if (r == self.chattersnd)
		r += 1;

	if (r > rnd)
		r = 1;

	self.chattersnd = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	if (self.classname == "widow")
		msound(self, CHAN_BODY, monstersound, 0.5, 0.5);
	else
		msound(self, CHAN_BODY, monstersound, 1, 0.25);
};

.float chatter_time;
.float chattersnd2;

void(string locsound, float rnd, float vol) chattersound2 =	//chatter with timer
	{
		if (self.chatter_time > time)
			return;

		if (!vol)
			vol = 1;

		local float r;
		local string monstersound, rsound;

		r = floor(random() *rnd) + 1;

		if (r == self.chattersnd2)
			r += 1;

		if (r > rnd)
			r = 1;

		self.chattersnd2 = r;
		rsound = ftos(r);
		monstersound = strcat(locsound, rsound, ".ogg");

		self.chatter_time = time + soundlength(monstersound);
		if (self.classname == "fallen")
			self.chatter_time = time + soundlength(monstersound) + 5 + random() *5;
		if (self.classname == "widow")
			self.chatter_time = time + soundlength(monstersound) + 5 + random() *5;

		if (vol == 0.5)
			msound(self, CHAN_VOICE, monstersound, vol, 0.5);
		else
			msound(self, CHAN_VOICE, monstersound, vol, 0.25);
	};

void(string locsound, float rnd, float vol) chattersound = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;

	if (r == self.chattersnd)
		r += 1;

	if (r > rnd)
		r = 1;

	self.chattersnd = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");

	if (vol == 0.5)
		msound(self, CHAN_AUTO, monstersound, 1, 0.5);
	else
		msound(self, CHAN_AUTO, monstersound, 1, 0.25);
};

.float msound_cnt1;
.float msound_cnt2;
.float msound_cnt3;
.float msound_cnt4;
.float msound_cnt5;
.float msound_cnt6;

void(string locsound, float rnd, float vol) randomsound = { local float r;
	local string monstersound, rsound;
	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt1)
		r += 1;
	if (r > rnd)
		r = 1;
	self.msound_cnt1 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, CHAN_AUTO, monstersound, vol, 0.5);
};

.float rdmsound_cnt1;
void(vector org, string locsound, float rnd, float vol) randompointsound = { local float r;
	local string samplesound, rsound;
	r = floor(random() *rnd) + 1;
	if (r == self.rdmsound_cnt1)
		r += 1;
	if (r > rnd)
		r = 1;
	self.rdmsound_cnt1 = r;
	rsound = ftos(r);
	samplesound = strcat(locsound, rsound, ".ogg");
	pointsound(org, samplesound, vol, 0.5);
};


void(string locsound, float rnd, float vol, float nchannel, float iswav, float atten) randomsound2 = { local float r;
	local string soundend, lsound, rsound;
	if (iswav)
		soundend = ".wav";
	else
		soundend = ".ogg";
	r = floor(random() *rnd) + 1;
	if (r == self.rsound_cntr)
		r += 1;
	if (r > rnd)
		r = 1;
	self.rsound_cntr = r;
	rsound = ftos(r);
	lsound = strcat(locsound, rsound, soundend);
	sound(self, nchannel, lsound, vol, atten);
};

void(string locsound, float vol, float nchannel, float iswav, float atten) alreadyrandomsound2 = {
	local string soundend, lsound, rsound;
	if (iswav)
		soundend = ".wav";
	else
		soundend = ".ogg";
	rsound = ftos(self.rsound_cntr);
	lsound = strcat(locsound, rsound, soundend);
	sound(self, nchannel, lsound, vol, atten);
};
void(string locsound, float rnd, float nchannel) monstersound1 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt1)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt1 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");

	if (self.classname == "fallen")
		msound(self, nchannel, monstersound, 0.3, 0.25);
	else
		msound(self, nchannel, monstersound, 1, 0.25);
};

void(string locsound, float rnd, float nchannel) monstersound2 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt2)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt2 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, nchannel, monstersound, 1, 0.25);
};

void(string locsound, float rnd, float nchannel) monstersound3 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt3)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt3 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, nchannel, monstersound, 1, 0.25);
};

void(string locsound, float rnd, float nchannel) monstersound4 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt4)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt4 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, nchannel, monstersound, 1, 0.25);
};

void(string locsound, float rnd, float nchannel) monstersound5 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt5)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt5 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, nchannel, monstersound, 1, 0.25);
};

void(string locsound, float rnd, float nchannel) monstersound6 = { local float r;
	local string monstersound, rsound;

	r = floor(random() *rnd) + 1;
	if (r == self.msound_cnt6)
		r += 1;
	if (r > rnd)
		r = 1;

	self.msound_cnt6 = r;
	rsound = ftos(r);
	monstersound = strcat(locsound, rsound, ".ogg");
	msound(self, nchannel, monstersound, 1, 0.25);
};

////// proto ai code

.string oldmodel;
.float lifetime;
void(entity e, entity excep) changegoalentity3 = { local entity head, near;
	local float dist, low;
	low = 99999999;	

	head = find(world, classname, "path_waypoint");
	while (head)
	{
		dist = vlen(head.origin - e.origin);
		if (dist < low)
		{
			low = dist;

			if (head != excep)
			{
				self = e;
				if (visible(head) && oldvisible(head))
					near = head;
				e = self;
			}
		}

		head = find(head, classname, "path_waypoint");
	}

	if (near)
	{
		e.enemy = near;
		//(entity own, vector start, vector end) te_beam
	}
};
.entity friend;

.entity path1;
.entity path2;
.entity path3;
.entity path4;
.entity path5;
.entity path6;
.entity path7;
.entity path8;
.entity path9;
.entity path10;
.entity path11;
.entity path12;
.float numslotpath;
void(entity plyr) waypointnextslot = { if (self.numslotpath == 1)
		self.enemy = plyr.path2;
	if (self.numslotpath == 2)
		self.enemy = plyr.path3;
	if (self.numslotpath == 3)
		self.enemy = plyr.path4;
	if (self.numslotpath == 4)
		self.enemy = plyr.path5;
	if (self.numslotpath == 5)
		self.enemy = plyr.path6;
	if (self.numslotpath == 6)
		self.enemy = plyr.path7;
	if (self.numslotpath == 7)
		self.enemy = plyr.path8;
	if (self.numslotpath == 8)
		self.enemy = plyr.path9;
	if (self.numslotpath == 9)
		self.enemy = plyr.path10;
	if (self.numslotpath == 10)
		self.enemy = plyr.path11;
	if (self.numslotpath == 11)
		self.enemy = plyr.path12;
	if (self.numslotpath == 12)
		self.enemy = plyr.path12;
};

void(entity path, entity plyr) check_player_slots_paths = { if (!plyr.path1)
	{
		path.numslotpath = 1;
		plyr.path1 = path;
		return;
	}

	if (!plyr.path2)
	{
		path.numslotpath = 2;
		plyr.path2 = path;
		return;
	}

	if (!plyr.path3)
	{
		path.numslotpath = 3;
		plyr.path3 = path;
		return;
	}

	if (!plyr.path4)
	{
		path.numslotpath = 4;
		plyr.path4 = path;
		return;
	}

	if (!plyr.path5)
	{
		path.numslotpath = 5;
		plyr.path5 = path;
		return;
	}

	if (!plyr.path6)
	{
		path.numslotpath = 6;
		plyr.path6 = path;
		return;
	}

	if (!plyr.path7)
	{
		path.numslotpath = 7;
		plyr.path7 = path;
		return;
	}

	if (!plyr.path8)
	{
		path.numslotpath = 8;
		plyr.path8 = path;
		return;
	}

	if (!plyr.path9)
	{
		path.numslotpath = 9;
		plyr.path9 = path;
		return;
	}

	if (!plyr.path10)
	{
		path.numslotpath = 10;
		plyr.path10 = path;
		return;
	}

	if (!plyr.path11)
	{
		path.numslotpath = 11;
		plyr.path11 = path;
		return;
	}

	if (!plyr.path12)
	{
		path.numslotpath = 12;
		plyr.path12 = path;
		return;
	}
}

void() path_waypoint_enemies = { local entity head;
	head = findradius(self.origin, 90);	// finds all entitys within 250 (2.5 meters?)
	while (head)
	{
		if ((head.flags &FL_MONSTER) && (visible(head)))
		{
			head.enemy = self.enemy;
			self.friend = head;
			te_lightning1(self, self.origin, head.origin);
		}

		head = head.chain;	// cycle to next head (entity)
	}
};

void() path_waypoint_think = { if (self.lifetime < time)
	{
		remove(self);
		return;
	}

	if (visible(self.oldenemy))
		self.enemy = self.oldenemy;
	else
		waypointnextslot(self.oldenemy);

	path_waypoint_enemies();

	te_lightning1(self, self.origin, self.enemy.origin);
	te_lightning3(self, self.origin, self.friend.origin);

	self.think = path_waypoint_think;
	self.nextthink = time + 0.1;
};

void() trigger_waypoint_touch = { if ((other.classname != "player"))
		return;
	if (self.lifetime > time)
		return;
	self.lifetime = time + 30;
	local entity pathw;
	pathw = spawn();
	setmodel(pathw, "soere");
	pathw.origin = self.origin + '0 0 0';
	setsize(pathw, '-24 -24 -12', '24 24 12');
	pathw.classname = "path_waypoint";
	pathw.solid = SOLID_TRIGGER;
	check_player_slots_paths(pathw, other);
	pathw.owner = other;
	pathw.classname2 = pathw.classname;
	pathw.think = path_waypoint_think;
	pathw.oldenemy = other;
	pathw.nextthink = time + 2;
	pathw.lifetime = time + 60;
	//remove(self);
};

void() trigger_waypoint = { self.touch = trigger_waypoint_touch;
	self.solid = SOLID_TRIGGER;
	setmodel(self, self.model);
	self.origin = (self.absmin + self.absmax) *0.5;
	self.oldorigin = (self.absmin + self.absmax) *0.5;
	self.oldmodel = self.model;
	self.alpha = -1;
	//self.modelindex = 0;
	//self.model = string_null;
};

void() trigger_waypointed_touch = { if (!(other.flags &FL_MONSTER))
		return;
	other.waypointed = 1;
};
void() trigger_nowaypointed_touch = { if (!(other.flags &FL_MONSTER))
		return;
	other.waypointed = 0;
};
void() trigger_waypointed = { self.touch = trigger_waypointed_touch;
	self.solid = SOLID_TRIGGER;
	setmodel(self, self.model);
	self.modelindex = 0;
	self.model = string_null;
};
void() trigger_nowaypointed = { self.touch = trigger_nowaypointed_touch;
	self.solid = SOLID_TRIGGER;
	setmodel(self, self.model);
	self.modelindex = 0;
	self.model = string_null;
};
.float subangle;
.entity lasttrigger;

float(entity targ, entity eself) backtouch; 

.float minorangle;
void() info_angle=
{
//setmodel (self,"serser");
};

void()determine_subangle =
{
local entity t;
t = find(world, targetname, self.target);
self.enemy = t;
}
.float always_active;

void() trigger_angle_touch =
{
	local entity oself;

	if (!(other.flags & FL_MONSTER))
	{
		return;
	}
	if (((other.lasttrigger == self) && (other.timeangles > time)))
	{
		return;
	}
/*
	if ((test_ia == FALSE))
	{
		return;
	}
*/

	
	self.subangle = self.enemy.angles_y;

	makevectors2(other.angles);
	if (((v_forward * self.movedir) < self.minorangle))
	{
		return;
	}
	other.lasttrigger = self;
	other.timeangles = (time + TRUE);

	oself = self;
	self = other;
	if((oself.always_active != 1) && (reachable(self.enemy)))
	return;
	self.angles_y = oself.subangle;
	self.ideal_yaw = oself.subangle;
	ChangeYaw();
	self = oself;
};

void() trigger_angle =
{
	InitTrigger();
	self.touch = trigger_angle_touch;
	self.think = determine_subangle;
	self.nextthink = self.ltime + 0.1;
};

/////////////