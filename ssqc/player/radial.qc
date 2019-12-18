float tether;

vector tether_org;
string tether_map;
void(float n, vector a, entity ownr) Hud_message;
.float savedlist;

float SAVED_TETHER = 1;
float SAVED_SIGIL = 2;

void() Remove_Tether = { self.alpha -= 0.025;
	if (self.alpha <= 0)
		self.think = SUB_Remove;
	self.nextthink = time + 0.01;

};

void() tether_mark_think = { local float bparticle;
	bparticle = particleeffectnum("tetherparticle");
	if (tether > 1)
	{
		self.alpha = 1;
		tether = 1;
		pointparticles(bparticle, self.origin, '0 0 0', 1);
		self.think = Remove_Tether;
		self.nextthink = time + 0.01;
	}
	else
		self.think = tether_mark_think;
	self.nextthink = time + 0.1;
};

void() check_tether = { read_currentprofileslot();
	local string campaignloc;
	campaignloc = strcat("profiles/", profilename, "/tether.txt");

	local float readparms;
	local string readtext;
	readparms = fopen(campaignloc, FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
	readtext = fgets(readparms);	//read the text
	tether = stof(readtext);
	readtext = fgets(readparms);
	tether_org_x = stof(readtext);
	readtext = fgets(readparms);
	tether_org_y = stof(readtext);
	readtext = fgets(readparms);
	tether_org_z = stof(readtext);
	readtext = fgets(readparms);
	tether_map = readtext;
	fclose(readparms);
	if (world.model != tether_map)
	{
		tether = 0;
		return;
	}

	local entity tether_mark;
	tether_mark = spawn();
	tether_mark.color = '1 1 1';
	tether_mark.light_lev = 75;
	tether_mark.pflags = 129;
	tether_mark.style = 6;
	tether_mark.classname = "tether_mark";
	tether_mark.scale = 1;
	tether_mark.effects = EF_ADDITIVE;
	setmodel(tether_mark, "models/artifacts/soul_marker.md3");
	setorigin(tether_mark, tether_org);
	tether_mark.think = tether_mark_think;
	tether_mark.nextthink = time + 0.1;
	if (profilename)
		strunzone(profilename);
};
void() check_tether_inmap = { local entity tm;
	tm = find(world, classname, "tether_mark");
	if (tm)
		remove(tm);

	read_currentprofileslot();
	local string campaignloc;
	campaignloc = strcat("profiles/", profilename, "/tether.txt");
	local float readparms;
	local string readtext;
	readparms = fopen(campaignloc, FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
	readtext = fgets(readparms);	//read the text
	tether = stof(readtext);
	readtext = fgets(readparms);
	tether_org_x = stof(readtext);
	readtext = fgets(readparms);
	tether_org_y = stof(readtext);
	readtext = fgets(readparms);
	tether_org_z = stof(readtext);
	readtext = fgets(readparms);
	tether_map = readtext;
	fclose(readparms);
	if (world.model != tether_map)
	{
		tether = 0;
		return;
	}

	local entity tether_mark;
	tether_mark = spawn();
	tether_mark.color = '1 1 1';
	tether_mark.light_lev = 75;
	tether_mark.pflags = 129;
	tether_mark.style = 6;
	tether_mark.classname = "tether_mark";
	tether_mark.scale = 1;
	tether_mark.effects = EF_ADDITIVE;
	setmodel(tether_mark, "models/artifacts/soul_marker.md3");
	setorigin(tether_mark, tether_org);
	tether_mark.think = tether_mark_think;
	tether_mark.nextthink = time + 0.1;
	if (profilename)
		strunzone(profilename);
};
.float tether_global;
.float lifetime;

.float tether_model_client;
void() artifact_client_remove3;
void() write_tether = { 

	Kill_Tether();
	write_tether2(0);
	Hud_message(24, self.origin, self);
	read_currentprofileslot();
	local string campaignloc;
	campaignloc = strcat("profiles/", profilename, "/tether.txt");

	local float writeparms;
	local string writethis;
	writeparms = fopen(campaignloc, FILE_WRITE);	//open what file to use in write mode
	tether += 1;
	writethis = ftos(1);	//prepare the next thing to write
	fputs(writeparms, writethis);	//line 1
	fputs(writeparms, "\n");	//and again
	writethis = ftos(tether_org_x);
	fputs(writeparms, writethis);
	fputs(writeparms, "\n");
	writethis = ftos(tether_org_y);
	fputs(writeparms, writethis);
	fputs(writeparms, "\n");
	writethis = ftos(tether_org_z);
	fputs(writeparms, writethis);
	fputs(writeparms, "\n");
	writethis = world.model;
	fputs(writeparms, writethis);
	fputs(writeparms, "\n");
	fclose(writeparms);

			local entity artifact_client3;
			artifact_client3 = spawn();
			artifact_client3.lifetime = time + 2;
			artifact_client3.owner = self;
			artifact_client3.effects = 256;
			artifact_client3.viewmodelforclient = self;
			setorigin(artifact_client3, '0 0 0');
			artifact_client3.oldangles = self.angles;
			artifact_client3.frame = 0;
			self.tether_model_client = 1;
			artifact_client3.alpha = 1;
			setmodel(artifact_client3, "models/artifacts/active/soul_tether_active.md3");
			artifact_client3.think = artifact_client_remove3;
			artifact_client3.nextthink = time;
	local entity tether_mark;
	tether_mark = spawn();
	sound(self, CHAN_AUTO, "items/artifacts/artifactE_use.ogg", 1, ATTN_NORM);
	setmodel(tether_mark, "models/artifacts/soul_marker.md3");
	tether_mark.scale = 1;
	setorigin(tether_mark, tether_org);
	local float bparticle;
	bparticle = particleeffectnum("tetherparticle");
	pointparticles(bparticle, tether_org, '0 0 0', 1);
	tether_mark.color = '1 1 1';
	tether_mark.light_lev = 75;
	tether_mark.pflags = 129;
	tether_mark.style = 6;
	tether_mark.classname = "tether_mark";
	tether_mark.effects = EF_ADDITIVE;
	self.tether_global = time + 1;
	self.radialruning = 1;
	self.SoulTether -= 1;
	self.tetherhasmodel = 1;
	tether_mark.think = tether_mark_think;
	tether_mark.nextthink = time + 2.2;
	//	read_currentprofileslot();
	local string saveloc;
	copy_save_maps(1);
	saveloc = strcat("save data/profiles/", profilename, "/tether\n");

	stuffcmd(self, "scratch1 1\n");
	stuffcmd(self, saveloc);
	stuffcmd(self, "scratch1 0\n");

	if (!(self.savedlist &SAVED_TETHER))
		self.savedlist += SAVED_TETHER;
	local float savestotalnumber;
	savestotalnumber = self.savedlist;
	writeprofilesavedlist(savestotalnumber);

	if (profilename)
		strunzone(profilename);

};

void() LifeSiphon_selected = { self.radialruning = 1;
	sound(self, CHAN_AUTO, "items/artifacts/artifactF_use.ogg", 1, 0.25);
	self.LifeSiphon_time = time + 20.8;
	self.radial_time = time + 21;
	self.LifeSiphon -= 1;
	//	self.radialactive = 0;
	sprint(self, "Life Siphon selected\n");
};

void() Aegis_selected = { self.radialruning = 1;
	sound(self, CHAN_AUTO, "items/artifacts/artifactH_use.ogg", 1, 0.25);
	self.Aegis_time = time + 15.1;
	self.radial_time = time + 15.2;
	self.Aegis -= 1;
	self.health = 10;
	//	self.radialactive = 0;
	sprint(self, "Aegis selected\n");
};

void() Drowner_selected = { self.radialruning = 1;
	sound(self, CHAN_AUTO, "items/artifacts/artifactB_use.ogg", 1, 0.25);
	self.DrownerApp_time = time + 20.8;
	self.radial_time = time + 21;
	self.DrownerApp -= 1;
	//	self.radialactive = 0;
	sprint(self, "Drowner Apparatus selected\n");
};
void() TrinketofRespite_selected = { self.radialruning = 1;
	//	sound (self,CHAN_AUTO,"items/artifacts/artifactB_use.ogg",1,0.25);
	TrinketofRespite_time = time + 20.8;
	self.TrinketofRespite -= 1;
	//	self.radialactive = 0;
	self.radial_time = time + 21;
	sprint(self, "Trinket of Respite selected\n");
};

///////////////////////////////////end of qc file