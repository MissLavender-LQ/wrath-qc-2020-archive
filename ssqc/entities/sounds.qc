.float atten;
.float maxpitch;
.float minpitch;
.float pitch;
void() soundbox_think;
void() soundbox_stop = { if (self.count)
		sound7(self, CHAN_VOICE, "misc/null.wav", 1, 1, 100, 0);
	else
	{
		sound(self, CHAN_VOICE, "misc/null.wav", 1, 1);
		remove(self);
	}

	self.use = soundbox_think;
};

void() soundbox_think = { local float spitch;
	self.cnt = soundlength(self.noise);
	if ((self.pitch) || (self.minpitch && self.maxpitch))
	{
		spitch = self.pitch * 100;
		if (self.minpitch && self.maxpitch)
		{
			spitch = (self.minpitch + self.maxpitch* random()) *100;
			self.cnt = self.cnt *(100 / spitch);
		}

		self.count = 1;
		sound7(self, CHAN_VOICE, self.noise, self.volume, self.atten, spitch, 0);
	}
	else
		sound(self, CHAN_VOICE, self.noise, self.volume, self.atten);
	if (self.delay > 0)
	{
		self.think = soundbox_think;
		self.nextthink = time + self.cnt + self.wait + (random() *self.delay);
		self.use = soundbox_stop;
	}
	else
		remove(self);
};

void() soundbox = { if (self.noise)
		precache_sound(self.noise);

	if (!self.delay)
	{
		self.delay = -1;
	}

	local float attn;
	if (!self.volume)
		self.volume = 1;
	if (!self.rad_sound)
		self.rad_sound = 512;
	attn = 256 / self.rad_sound;	// 200 for snd_soundradius default cvar!
	if (self.rad_sound <= 0)
		attn = 0;
	if (self.spawnflags &1)
		attn = 0;
	if (self.minpitch <= 0)
		self.minpitch = 0.1;
	self.atten = attn;
	if ((self.targetname) && (!self.using))
		self.use = soundbox_think;
	else
	{
		if (self.delay >= 0)
		{
			if (!self.wait)
				self.wait = 1;
			self.think = soundbox_think;
			self.nextthink = time + self.wait;
		}
		else
			ambientsound(self.origin, self.noise, self.volume, attn);
	}
};

/////////////////end of qc file