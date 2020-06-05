void(string filefrom, string fileto)fcopy_wrath2 =
{

if(fexists(strcat ("data/",filefrom)))
fcopy (filefrom, fileto);
};


void(float istether) load_save_maps =
{
	read_currentprofileslot();
	local string hub1map, e1m1map, e1m2map, e1m3map, e1m4map, e1m5map;
	hub1map = strcat("data/profiles/", profilename, "/maps/hub1.sav");
	e1m1map = strcat("data/profiles/", profilename, "/maps/e1m1.sav");
	e1m2map = strcat("data/profiles/", profilename, "/maps/e1m2.sav");
	e1m3map = strcat("data/profiles/", profilename, "/maps/e1m3.sav");
	e1m4map = strcat("data/profiles/", profilename, "/maps/e1m4.sav");
	e1m5map = strcat("data/profiles/", profilename, "/maps/e1m5.sav");
	if(fexists(hub1map)) fremove (hub1map);
	if(fexists(e1m1map)) fremove (e1m1map);
	if(fexists(e1m2map)) fremove (e1m2map);
	if(fexists(e1m3map)) fremove (e1m3map);
	if(fexists(e1m4map)) fremove (e1m4map);
	if(fexists(e1m5map)) fremove (e1m5map);

	string tohub1map, toe1m1map, toe1m2map, toe1m3map, toe1m4map, toe1m5map;
	string fromhub1map, frome1m1map, frome1m2map, frome1m3map, frome1m4map, frome1m5map;
	tohub1map = strcat("profiles/", profilename, "/maps/hub1.sav");
	toe1m1map = strcat("profiles/", profilename, "/maps/e1m1.sav");
	toe1m2map = strcat("profiles/", profilename, "/maps/e1m2.sav");
	toe1m3map = strcat("profiles/", profilename, "/maps/e1m3.sav");
	toe1m4map = strcat("profiles/", profilename, "/maps/e1m4.sav");
	toe1m5map = strcat("profiles/", profilename, "/maps/e1m5.sav");

	if(istether == 1)
	{
		fromhub1map = strcat("profiles/", profilename, "/tether/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/tether/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/tether/maps/e1m2.sav");	
		frome1m3map = strcat("profiles/", profilename, "/tether/maps/e1m3.sav");	
		frome1m4map = strcat("profiles/", profilename, "/tether/maps/e1m4.sav");	
		frome1m5map = strcat("profiles/", profilename, "/tether/maps/e1m5.sav");	
	}
	if(istether == 2)
	{
		fromhub1map = strcat("profiles/", profilename, "/shrine/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/shrine/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/shrine/maps/e1m2.sav");	
		frome1m3map = strcat("profiles/", profilename, "/shrine/maps/e1m3.sav");	
		frome1m4map = strcat("profiles/", profilename, "/shrine/maps/e1m4.sav");	
		frome1m5map = strcat("profiles/", profilename, "/shrine/maps/e1m5.sav");	
	}	
	if(istether == 3)
	{
		fromhub1map = strcat("profiles/", profilename, "/autosave/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/autosave/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/autosave/maps/e1m2.sav");	
		frome1m3map = strcat("profiles/", profilename, "/autosave/maps/e1m3.sav");	
		frome1m4map = strcat("profiles/", profilename, "/autosave/maps/e1m4.sav");	
		frome1m5map = strcat("profiles/", profilename, "/autosave/maps/e1m5.sav");	
	}	

	fcopy(fromhub1map, tohub1map);
	fcopy(frome1m1map, toe1m1map);
	fcopy(frome1m2map, toe1m2map);
	fcopy(frome1m3map, toe1m3map);
	fcopy(frome1m4map, toe1m4map);
	fcopy(frome1m5map, toe1m5map);


	local string hub1stat, e1m1stat, e1m2stat, e1m3stat, e1m4stat, e1m5stat;
	hub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	e1m3stat = strcat("profiles/", profilename, "/maps/e1m3.stats");
	e1m4stat = strcat("profiles/", profilename, "/maps/e1m4.stats");
	e1m5stat = strcat("profiles/", profilename, "/maps/e1m5.stats");
	if(fexists(hub1stat)) fremove (hub1stat);
	if(fexists(e1m1stat)) fremove (e1m1stat);
	if(fexists(e1m2stat)) fremove (e1m2stat);
	if(fexists(e1m3stat)) fremove (e1m3stat);
	if(fexists(e1m4stat)) fremove (e1m4stat);
	if(fexists(e1m5stat)) fremove (e1m5stat);

	string tohub1stat, toe1m1stat, toe1m2stat, toe1m3stat, toe1m4stat, toe1m5stat;
	string fromhub1stat, frome1m1stat, frome1m2stat, frome1m3stat, frome1m4stat, frome1m5stat;
	tohub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	toe1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	toe1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	toe1m3stat = strcat("profiles/", profilename, "/maps/e1m3.stats");
	toe1m4stat = strcat("profiles/", profilename, "/maps/e1m4.stats");
	toe1m5stat = strcat("profiles/", profilename, "/maps/e1m5.stats");

	if (istether == 1)
	{
		fromhub1stat = strcat("profiles/", profilename, "/tether/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/tether/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/tether/maps/e1m2.stats");
		frome1m3stat = strcat("profiles/", profilename, "/tether/maps/e1m3.stats");
		frome1m4stat = strcat("profiles/", profilename, "/tether/maps/e1m4.stats");
		frome1m5stat = strcat("profiles/", profilename, "/tether/maps/e1m5.stats");
	}

	if (istether == 2)
	{
		fromhub1stat = strcat("profiles/", profilename, "/shrine/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/shrine/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/shrine/maps/e1m2.stats");
		frome1m3stat = strcat("profiles/", profilename, "/shrine/maps/e1m3.stats");
		frome1m4stat = strcat("profiles/", profilename, "/shrine/maps/e1m4.stats");
		frome1m5stat = strcat("profiles/", profilename, "/shrine/maps/e1m5.stats");
	}

	if (istether == 3)
	{
		fromhub1stat = strcat("profiles/", profilename, "/autosave/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/autosave/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/autosave/maps/e1m2.stats");
		frome1m3stat = strcat("profiles/", profilename, "/autosave/maps/e1m3.stats");
		frome1m4stat = strcat("profiles/", profilename, "/autosave/maps/e1m4.stats");
		frome1m5stat = strcat("profiles/", profilename, "/autosave/maps/e1m5.stats");
	}

	fcopy_wrath(fromhub1stat, tohub1stat);
	fcopy_wrath(frome1m1stat, toe1m1stat);
	fcopy_wrath(frome1m2stat, toe1m2stat);
	fcopy_wrath(frome1m3stat, toe1m3stat);
	fcopy_wrath(frome1m4stat, toe1m4stat);
	fcopy_wrath(frome1m5stat, toe1m5stat);

};
void() load_tether = { cmd("set cvar_restoregame 2\n");
	cmd("slowmo 1\n");cmd("r_glsl_saturation 1\n");
	read_currentprofileslot();
	load_save_maps(1);
	string cname;
	cname = strcat("load data/profiles/", profilename, "/tether.sav\n");
	//	bprint(cname);
	cmd("scratch3 0 \n");
	cmd(cname);
};
void() load_shrine = { cmd("set cvar_restoregame 3\n");
	cmd("slowmo 1\n");cmd("r_glsl_saturation 1\n");
	read_currentprofileslot();
	load_save_maps(2);
	string cname;
	cname = strcat("load data/profiles/", profilename, "/shrine.sav\n");
	cmd("scratch3 0 \n");
	//	bprint(cname);
	cmd(cname);
};
void() load_autosave = { cmd("set cvar_restoregame 0\n");
	cmd("slowmo 1\n");cmd("r_glsl_saturation 1\n");
	read_currentprofileslot();
	load_save_maps(3);
	string cname;
	cname = strcat("load data/profiles/", profilename, "/autosave.sav\n");
	cmd("scratch3 0 \n");
	//	bprint(cname);
	cmd(cname);
};