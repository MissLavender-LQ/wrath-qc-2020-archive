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
void() nowater_type; 
.float tether_model_client;
void() artifact_client_remove3;
void()message_garbage_collector;
void() write_tether = { 

	nowater_type();
	Kill_Tether();
	write_tether2(0);

	message_garbage_collector ();

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
.float attar_timem;

.entity exenemy;
void ()ai_face;
void()fmck_maker_touch;
.float turret;
void() stricken_preattack1;

void()deactivate_turret2;
void()deactivate_turret;
void() FindNearestEnemy;
void() remove_attar_enemy =
{
	self.owner.enemy = self.exenemy;
	self.owner.friendly_monster = 0;	
	if(self.owner.classname == "monster_stricken")
	{
		self.owner.turret = self.owner.oldturret;
		if(self.owner.turret == 1)
		self.owner.th_run = stricken_preattack1;
		else
		self.owner.th_run = stricken_run1;
	}

	if(self.owner.health > 0)
	{
		local entity oself = self;
		self = self.owner;
		FoundTarget();
		local entity pl;
		pl = find(world, classname, "player");
		self.enemy = pl;
		ai_face();
		self.think = self.th_run;
		self.nextthink = time;	
		self.goalentity = self.enemy;
		self = oself;
	}
	
	self.think = alphafade;	
	self.nextthink = time;	
};
void() spawn_attar_enemy_think =
{
	if(self.owner.health <= 0)
	{
	self.think = alphafade;	
	self.nextthink = time;
	return;
	}
	if(self.frame < 4)
		self.frame ++;

	if(self.lifetime < time)
	{
		self.alphatime = 1;		
		self.think = remove_attar_enemy;
	}
	else
	self.think = spawn_attar_enemy_think;
	self.nextthink = time + 0.05;
};


void() find_next_enemy =
{
next_enemy();
self.nextthink = time;
self.think = self.th_run;
}
void(entity ownr)spawn_attar_enemy =
{
local entity mark;
mark = spawn();
mark.owner = ownr;
ownr.attached_cloud = mark;
setmodel(mark,"models/artifacts/effects/confounding_attar_enemy.md3");
mark.nextthink = time + 0.01;
mark.lifetime = time + attar_effect_time;
mark.think = spawn_attar_enemy_think;
setattachment (mark,ownr,"");		
}


void(entity friend) Create_friendly_monster = 
{
	friend.friendly_monster = 1;
	if(friend.enemy)
	friend.exenemy = friend.enemy; 

	friend.enemy = 0;
	friend.attar_timem = time  + 1;
	if(friend.classname == "monster_heretic")
	{
	if(friend.movetype != MOVETYPE_STEP)
	friend.movetype = MOVETYPE_STEP;
	}
	friend.think = find_next_enemy;
	friend.nextthink = time;
	spawn_attar_enemy(friend);
	local entity oself;
	oself = self;
	self = friend;
	ai_face();
	self = oself;
};
void() search_monster =
{
	local vector source;
	local entity head;
	source = self.origin;
	head = findradius(source, attar_bbox_x);
	while (head)
	{
		if ((head.classentity ==  "monsters") && (head.friendly_monster != 1) && (	head.warped_time < time))
		{
		Create_friendly_monster(head);
		}
		head = head.chain;
	}
};
void()fmck_maker_touch;
void() AttarExplode =
{
	if(self.frame < 4)
		self.frame ++;
	search_monster();
	if(time > self.lifetime)
	{
		self.think = alphafade;	
		self.alphatime = 1.5;		
	}
	else
		self.think = AttarExplode;
	self.nextthink = time + 0.1;
};
.float alreadytouched1;
void() attar_touch =
{
//pointparticles(particleeffectnum("retcherdecal"), self.origin, '0 0 0', 1);
if ((other == self.owner))
	return;	// don't explode on owner
if((other == world) || (other.flags & FL_MONSTER) || (other.solid == SOLID_BSP))
	{	
	sound(self, CHAN_AUTO, "items/artifacts/artifactD_end.ogg", 1, 0.25);
	setmodel(self, "models/artifacts/effects/confounding_attar_cloud.md3");	
	self.movetype = 0;
	self.solid = SOLID_TRIGGER;
	setsize (self, attar_bboxn, attar_bbox);
	self.angles_x = 0;
	self.angles_z = 0;
	self.lifetime = time + attar_time;
	self.touch = fmck_maker_touch ;
	self.nextthink =time + 0.1;
	self.think =  AttarExplode;		
	}
};

void() attar_think_fly =
{
	local vector source;
	local entity head;
	source = self.origin;
	head = findradius(source, 16);
	local float fm;
	while (head)
	{
		if ((head.classentity ==  "monsters") && (head.friendly_monster != 1))
		{
		fm = 1;		
		}
		head = head.chain;	
	}
	if(fm == 1)
		self.think = attar_touch;
	else
		self.think = attar_think_fly; 
	self.nextthink = time + 0.05;	
}
void() Attar_selected =
{
	if(!self.Attar)
	return;
	local entity missile;
	missile = spawn ();
	self.Attar --;
	self.radial_time = time + 1;
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_TRIGGER;
	missile.classname = "grenade";
	sound(self, CHAN_AUTO, "items/artifacts/artifactD_use.ogg", 1, 0.25);
	makevectors (self.v_angle);
	if (self.v_angle_x)
		missile.velocity = v_forward*attar_vel + v_up * attar_velz + crandom()*v_right*1 + crandom()*v_up*1;
	else
	{
		//missile.velocity = aim(self, 10000);
		missile.velocity = normalize(self.cursor_trace_endpos - missile.origin) *attar_vel;
		//missile.velocity = missile.velocity * attar_vel;
		missile.velocity_z += attar_velz;
	}
	missile.angles = vectoangles(missile.velocity);
	missile.gravity = attar_grav;
	missile.touch = attar_touch;
	missile.think = attar_think_fly; 
	missile.nextthink = time + 0.05;
	setmodel (missile, "models/artifacts/effects/confounding_attar_proj.md3");
	setsize(missile, attar_pbboxn,attar_pbbox);
	setorigin (missile, self.origin);
};
///////////////////////////////////end of qc file