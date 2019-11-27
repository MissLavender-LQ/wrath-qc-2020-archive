.float fcolor;

.float density;
void() lightning_think;

void() weather_think = { if (self.using == 1)
	{
		if (self.type == 1)
			te_particlesnow(self.absmin, self.absmax, self.dest, self.count, self.fcolor);
		else
			te_particlerain(self.absmin, self.absmax, self.dest, self.count, self.fcolor);
	}

	self.nextthink = time + self.delay;
};

void() func_weather = { if (!self.using)
		self.using = 1;
	if (!self.delay)
		self.delay = 0.1;
	if ((self.type == 1) && (!(self.dest)))
		self.dest = '0 0 -100';
	if ((self.type != 1) && (!(self.dest)))
		self.dest = '0 0 -700';
	if (!self.fcolor)
		self.fcolor = 12;
	if (!self.density)
		self.density = 1;
	setmodel(self, self.model);
	if (!self.count)
		self.count = ((self.absmax_x - self.absmin_x) *(self.absmax_y - self.absmin_y) / 32768) *self.density;
	self.model = "";
	self.use = toggle_use;
	self.think = weather_think;
	self.nextthink = time + 0.1;
};

void() pspawner_think = { if (self.owner.using == 1)
		pointparticles(particleeffectnum(self.owner.particlename), self.origin, '0 0 0', 1);
	self.nextthink = time + (self.owner.delay);
	self.think = pspawner_think;
};

void(entity powner) spawn_particle_emitter = { local entity pspawner;
	pspawner = spawn();
	pspawner.owner = powner;
	pspawner.origin_x = self.absmin_x + (random() *powner.size_x);
	pspawner.origin_y = self.absmin_y + (random() *powner.size_y);
	if (self.spawnflags == 1)
		pspawner.origin_z = self.absmin_z + (powner.size_z);
	else
		pspawner.origin_z = self.absmin_z + (random() *powner.size_z);
	setmodel(pspawner, "");
	pspawner.think = pspawner_think;
	pspawner.nextthink = time + random();
};

void() func_particles_think = { while (self.count > -1)
	{
		spawn_particle_emitter(self);
		self.count -= 1;
	}
};

void() func_particles = { if (!self.using)
		self.using = 1;
	if (!self.delay)
		self.delay = 0.5;
	if (!self.particlename)
		self.particlename = "fakerain";
	setmodel(self, self.model);
	if (!self.density)
		self.density = 1;
	self.count = ((self.absmax_x - self.absmin_x) *(self.absmax_y - self.absmin_y) / 4096) *self.density;
	self.model = "";
	self.use = toggle_use;
	self.think = func_particles_think;
	self.nextthink = time + 0.1;
};

void() lightninwait = { if (self.style == 12)
		lightstyle(12, "a");
	if (self.style == 13)
		lightstyle(12, "a");
	if (self.style == 14)
		lightstyle(12, "a");
	self.think = lightning_think;
	self.nextthink = time + self.delay + self.wait* random();
};

void() lightning_think = { local float rn, rls;
	local string tnoise;
	rls = random();
	if (rls < 0.33333)
		tnoise = self.noise;
	else if (rls < 0.66666)
		tnoise = self.noise1;
	else
		tnoise = self.noise2;
	rn = random();
	if (self.style == 12)
	{
		if (rn < 0.33333)
			lightstyle(12, "zzzzxxyzxktcxvcxjddbbccaaaaaaaaaaa");
		else if (rn < 0.66666)
			lightstyle(12, "zzxzzxaxxafgfgddxvcxjdkilaaaaaaaaaa");
		else
			lightstyle(12, "zzxxcybvbxbzxcyvnbbbccaaaaaaaaaaa");
		pointsound(self.origin, tnoise, 1, 0.001);
	}

	if (self.style == 13)
	{
		if (rn < 0.33333)
			lightstyle(13, "zkcxzvczxcnmncxvcxjddbbccaaaaaaaaa");
		else if (rn < 0.66666)
			lightstyle(13, "zzxzzxmxcxzkillpbbccaaaaaaaa");
		else
			lightstyle(13, "zzxxcgfasdawcnbbjsdddbbccaaaaa");
		pointsound(self.origin, tnoise, 1, 0.001);
	}

	if (self.style == 13)
	{
		if (rn < 0.33333)
			lightstyle(14, "zktcvxzczccxzvvgncxvcxjddbbccaaaaaaaa");
		else if (rn < 0.66666)
			lightstyle(14, "zzxzxxzzmxcxzfgfgddddbbckillpizxelcaaaaaaaaa");
		else
			lightstyle(14, "zzxxcybvbxbzxcyvnbbjsdddbbccaaaaaaaaaa");
		pointsound(self.origin, tnoise, 1, 0.001);
	}

	self.nextthink = time + 2.5;
	self.think = lightninwait;
};

void() misc_lightning = { if (!self.style)
		self.style = 12;
	if (self.style < 12)
		self.style = 12;
	if (self.style > 14)
		self.style = 14;
	if (!self.delay)
		self.delay = 10;
	if (!self.wait)
		self.wait = 10;
	if (!self.noise)
		self.noise = "env/thunder_clap1.ogg";
	if (!self.noise1)
		self.noise1 = "env/thunder_clap2.ogg";
	if (!self.noise2)
		self.noise2 = "env/thunder_clap3.ogg";
	precache_sound(self.noise1);
	precache_sound(self.noise2);
	precache_sound(self.noise3);
	if (!(self.targetname))
	{
		self.think = lightning_think;
		self.nextthink = time + self.delay;
	}
	else
		self.use = lightning_think;
};

/*

.float time_fog;

void() fogmodel_think =
{
	if (!self.cnt)
	{
	self.alpha += 0.001;
	if(self.alpha >= 0.1)
	self.cnt = 1;
	}
	else
	{
	self.alpha -= 0.001;
	if(self.alpha <= 0)
	remove(self);
	}

self.think = fogmodel_think;
self.nextthink = time + 0.025 + self.time_fog;
if(self.origin_x > self.owner.absmax_x)
{remove(self);}

if(self.origin_x < self.owner.absmin_x)
{remove(self);}

if(self.origin_y > self.owner.absmax_y)
{remove(self);}

if(self.origin_y < self.owner.absmin_y)
{remove(self);}
};

void(entity powner) spawn_fog_emitter =
{
	local entity fogmodel;
	fogmodel = spawn ();
	fogmodel.owner = powner;
	fogmodel.origin_x = self.absmin_x + (random() *powner.size_x);
	fogmodel.origin_y = self.absmin_y + (random() *powner.size_y);
	fogmodel.origin_z = self.absmin_z;
	setmodel (fogmodel, "particles/fog.md3");
	fogmodel.movetype = MOVETYPE_NOCLIP;
	fogmodel.velocity_x = 3 + random() *3; 
	fogmodel.effects = EF_ADDITIVE;
	fogmodel.velocity_y = 3 + random() *3;
	fogmodel.scale = 0.25 + random() *0.125;
	fogmodel.alpha = 0.01;
	fogmodel.time_fog = random() *0.025;
	fogmodel.think = fogmodel_think;
	fogmodel.nextthink = time + random(); 
};
void()  func_fog_think;
.float oldcount;
void()  func_fog_reset =
{
self.density = self.oldcount;
self.think = func_fog_think;
self.nextthink = time + (3.5 / self.count);
}

void()  func_fog_think =
{
while (self.density > -1) 
{
spawn_fog_emitter(self);
self.density -= 1;
}

self.think = func_fog_reset; 
self.nextthink = time + ((random() *2.5 + 2.5) / self.count);
};

void() func_fog =
{
	setmodel(self, self.model);
	if (!self.density)
	self.density = 1;
	self.count = ((self.absmax_x - self.absmin_x)*(self.absmax_y - self.absmin_y)/8192) *self.density *0.5;
	self.oldcount = self.density;
	self.model = "";		
	self.think = func_fog_think;
	self.nextthink = time + 0.1;
};
*/
//////////////////////end of qc file