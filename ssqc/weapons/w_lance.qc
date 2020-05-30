
.float randomattack;
.float oldrandomattack;

void() idle_lance = 
{ 
	if (self.pick_up_time < time)
		self.vweaponstate = 0;
	self.vweaponstate = 0;
	self.vweaponframe = 0;

};
.float spawnedlance;
.float beam_lenght;

.entity lastbeam;
.float beam_counter;

.entity lastbeam_view;
.float beam_counter_view;

void(entity e)sub_beam;
void() beam_update;

void(entity e)sub_beam =
{

};

void() beam_update_view =
{
	if(self == self.owner.lastbeam_view)
	{
		if(self.owner.beam_counter_view > ((self.owner.beam_lenght / 2) + 1))
		{
			self.owner.beam_counter_view --;
			self.owner.lastbeam_view = self.lastbeam_view;
			remove(self);
			return;
		}
		if(self.owner.beam_counter_view < (self.owner.beam_lenght / 2))
		{
			self.owner.beam_counter_view ++;
			local entity beam;
			beam = spawn();
			beam.classname = "lancebeam_view";
			beam.owner = self.owner;
			setmodel (beam,"models/projectiles/proj_beam.md3");
			beam.lastbeam_view = self.owner.lastbeam_view;
			self.owner.lastbeam_view = beam;
			setattachment (beam,self,"tag_nextbeam");
			beam.nextthink = time; 
			beam.alpha = 1;
			beam.think = beam_update_view;
		}
		
	}		
	if(!self.owner.spawnedlance)
		self.think = alphafade3;
	else
		self.think = beam_update_view;	
	self.nextthink = time + 0.0125; 
};


//self.cursor_trace_endpos

void(entity e) te_lance2 =
{
	local entity beam;
	beam = spawn();
	beam.owner = e;
	e.lastbeam_view = beam;
	//self.beam_counter = -1;
	setmodel (beam,"models/weapons/lance/v_beam.md3");
	setattachment (beam,e.vweapon,"tag_muzzle");
	beam.nextthink = time;
	beam.alpha = 1;
	beam.think = beam_update_view;

};
void() beam_update =
{
	if(self == self.owner.lastbeam)
	{
		if(self.owner.beam_counter > (self.owner.beam_lenght + 1))
		{
			self.owner.beam_counter --;
			self.owner.lastbeam = self.lastbeam;
			remove(self);
			return;
		}
		if(self.owner.beam_counter < self.owner.beam_lenght)
		{
			self.owner.beam_counter ++;
			local entity beam;
			beam = spawn();
			beam.classname = "lancebeam";
			beam.exteriormodeltoclient = self.owner;
			beam.owner = self.owner;
			setmodel (beam,"models/projectiles/proj_beam.md3");
			beam.lastbeam = self.owner.lastbeam;
			self.owner.lastbeam = beam;
			setattachment (beam,self,"tag_nextbeam");
			beam.nextthink = time; 
			beam.alpha = 1;
			beam.think = beam_update;
		}
		
	}		
	if(!self.owner.spawnedlance)
		self.think = alphafade3;
	else
		self.think = beam_update;	
	self.nextthink = time + 0.0125; 
};


//self.cursor_trace_endpos

void(entity e) te_lance =
{
	local entity beam;
	beam = spawn();
	beam.owner = e;
	e.lastbeam = beam;
	//self.beam_counter = -1;
	setmodel (beam,"models/projectiles/proj_beam.md3");
	setattachment (beam,e,"tag_muzzle");
	beam.nextthink = time;
	beam.exteriormodeltoclient = beam.owner;
	beam.alpha = 1;
	beam.think = beam_update;

};

.float beamtime;
.float lance_secondary;
void() wsfire_lance =
{
	if((self.button3))
	{
		if(self.beamtime < time)
		{
			vector tagorg = tag_origin("tag_muzzle",self.vweapon);
			makevectors(self.v_angle);
			vector t_dest = self.origin + self.view_ofs + v_forward *2048;
			wtraceline(tagorg, t_dest, FALSE, self);
			vector direction = aim(self, 100000);
			self.lance_secondary = 1;
			if (trace_fraction != 1.0)
			TraceAttack(self.lance_damage2, direction);
				ApplyMultiDamage();
			traceline(tagorg, t_dest, MOVE_WORLDONLY, self);	
			self.beam_lenght = vlen (tagorg - trace_endpos) / 64;
			if(self.beam_lenght > 64)
				self.beam_lenght = 64;					
			self.beamtime = time +self.lance_time2;
			if(!self.spawnedlance)
			{	
				self.beam_counter = 0;
				self.beam_counter_view = 0;
				te_lance(self);
				te_lance2(self);
				self.spawnedlance = 1;
			}
			
		}
		self.think = wsfire_lance;
	}
	else
	{	
		self.spawnedlance = 0;	
		self.think = idle_lance;
	}
	self.nextthink = time + 0.01;
};

/*
void(entity e) railgun_spawner =
{
	local entity beam;
	beam = spawn();
	beam.classname = "lancebeam_view";
	beam.owner = e;
	setmodel (beam,"models/weapons/lance/railb.md3");
	setattachment (beam,e.lastbeam,"tag_nextbeam");
	e.lastbeam = beam;
	beam.alpha = 1;
	beam.think = alphafade3;
	beam.nextthink = time + 1; 
}
void(entity e) te_railgun =
{
	local entity beam;
	beam = spawn();
	beam.owner = e;
	e.lastbeam = beam;
	if(self.owner.beam_lenght <= 1)
		setmodel (beam,"models/weapons/lance/raila.md3");
	else
		setmodel (beam,"models/weapons/lance/railb.md3");
	setattachment (beam,e.vweapon,"tag_muzzle");
	beam.alpha = 1;
	beam.think = alphafade3;
	beam.nextthink = time + 1;
	float loop_lenght;
	loop_lenght = self.owner.beam_lenght;
	while(loop_lenght > 1)
	{
		railgun_spawner(e);
		loop_lenght --;
	}
};
*/

void(entity e, float beamlenght) sub_railgun =
{
	local entity beam;

	beam = spawn();
	//if( beamlenght > 0)
		setmodel(beam, "models/projectiles/proj_railb.md3");
	//else
	//	setmodel(beam, "models/projectiles/proj_raila.md3");
	setattachment(beam, e.lastbeam, "tag_nextbeam");
	beam.nextthink = (time + 0.05);
	beam.alpha = 1;
	beam.alphatime = e.lance_alpha_time;
	e.lastbeam = beam;
	beam.think = alphafade;
};

void(entity e, vector tagorg, vector tangles) te_railgun =
{
	local entity beam;
	local float beamlenght;

	beam = spawn();
	self.owner = e;
	e.lastbeam = beam;
	//if(self.owner.beam_lenght <= 1)
		setmodel (beam,"models/projectiles/proj_raila.md3");
	//else
	//	setmodel (models/projectiles/proj_railb.md3");
	beam.origin = tagorg;
	beam.angles = tangles;
	//beam.effects = EF_NODEPTHTEST;
	//setattachment(beam, e.vweapon, "tag_muzzle");
	beam.beam_lenght = (e.beam_lenght - TRUE);
	beam.nextthink = (time + 0.05);
	beam.alpha = 1;
	beam.alphatime = e.lance_alpha_time;
	beam.think = alphafade;
	beamlenght = beam.beam_lenght;
	while ((beamlenght > 0))
	{
		beamlenght --;
		sub_railgun(e, beamlenght);
	}
};
void()trail_remove =
{
	if(other != world)
		return;
	else 
		remove(self);
}
void() wfire_lance =
{
	vector tagorg = tag_origin("tag_muzzle",self.vweapon);
	makevectors(self.v_angle);
	vector t_dest = self.origin + self.view_ofs + v_forward *4096;
	wtraceline(tagorg, t_dest, FALSE, self);
	vector direction = aim(self, 100000);
	self.lance_secondary = 0;
	if (trace_fraction != 1.0)
		TraceAttack(self.lance_damage, direction);
	ApplyMultiDamage();
	self.beam_lenght = vlen (tagorg - trace_endpos) / 64;
	if(self.beam_lenght > 64)
		self.beam_lenght = 64;		
	
	self.beam_counter = 0;
	self.beam_counter_view = 0;

	traceline(tagorg, t_dest, MOVE_WORLDONLY, self);
	sound(self,CHAN_WEAPON,"weapons/lance/fire1.ogg",1,0.25);
	vector dir = normalize(trace_endpos - tagorg);
	vector teangles = vectoangles(dir);	
	te_railgun(self, tagorg, teangles);
	//te_railgun2(self);
	self.think = idle_lance;
	self.nextthink = time + 0.05;
	self.attack_finished = time + self.lance_time;
	
	entity trail = spawn();
	trail.movetype = MOVETYPE_FLY;
	setorigin(trail, tagorg);
	setmodel(trail, "models/misc/null.md3");
	trail.velocity = dir *12000;
	trail.solid = SOLID_CORPSE;
	trail.traileffectnum = particleeffectnum("rail_trail");
	trail.touch = trail_remove;
	trail.think = SUB_Remove;
	trail.nextthink = time + 1;
	
};


void() lower_lance2 = { self.vweaponframe += 1;
	if (self.vweaponframe >= 50)
		self.think = raise_weapon;
	else
		self.think = lower_lance2;
	self.nextthink = time + 0.05;
};

void() lower_lance = { self.vweaponframe = 41;
	self.attack_finished = time + 0.25;
	self.think = lower_lance2;
	self.nextthink = time + 0.05;
};

void() raise_lance2 = { self.vweaponframe += 1;
	if (self.vweaponframe == 45)
		W_SetWeapon();

	if (self.vweaponframe >= 47)
	{
		self.think = idle_lance;
	}
	else
		self.think = raise_lance2;
	self.nextthink = time + 0.025;
};

void() raise_lance = { self.weapon = IT_LANCE;
	W_SetWeapon();
	sound(self, CHAN_AUTO, "weapons/lance/raise.ogg", 1, ATTN_NORM);
	self.vweaponglowmod = '1 1 1';
	self.draw_w = 0;
	self.vweaponframe = 43;
	self.vweaponstate = 1;
	self.attack_finished = time + 0.125;
	self.think = raise_lance2;
	self.nextthink = time;
};
void() pick_up_lance2 = { self.think = idle_lance;
	self.pick_up_time = time + 0.5;
	self.vweaponstate = 1;
	self.nextthink = time + 0.05;
};

void() pick_up_lance = { self.lastweapon = IT_LANCE;
	self.weapon = IT_LANCE;
	sound(self, CHAN_WEAPON, "weapons/lance/inspect.ogg", 1, ATTN_NORM);
	W_SetWeapon();
	self.draw_w = 0;
	self.vweaponglowmod = '1 1 1';
	self.vweaponstate = 2; // hud state
	if (self.noltime < time)
		self.lspeedtime = time + 5;
	self.vweaponframe = 0;
	self.attack_finished = time + 0.05;
	self.think = pick_up_lance2;
	self.nextthink = time + 5.95;
}

///////////////////////////////////end of qc file