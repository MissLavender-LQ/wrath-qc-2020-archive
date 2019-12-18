void(float istether) load_save_maps = { read_currentprofileslot();
	local string hub1map, e1m1map, e1m2map;
	hub1map = strcat("data/profiles/", profilename, "/maps/hub1.sav");
	e1m1map = strcat("data/profiles/", profilename, "/maps/e1m1.sav");
	e1m2map = strcat("data/profiles/", profilename, "/maps/e1m2.sav");
	if (fexists(hub1map))
		fremove(hub1map);
	if (fexists(e1m1map))
		fremove(e1m1map);
	if (fexists(e1m2map))
		fremove(e1m2map);

	string tohub1map, toe1m1map, toe1m2map;
	string fromhub1map, frome1m1map, frome1m2map;
	tohub1map = strcat("profiles/", profilename, "/maps/hub1.sav");
	toe1m1map = strcat("profiles/", profilename, "/maps/e1m1.sav");
	toe1m2map = strcat("profiles/", profilename, "/maps/e1m2.sav");
	if (istether == 1)
	{
		fromhub1map = strcat("profiles/", profilename, "/tether/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/tether/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/tether/maps/e1m2.sav");
	}

	if (istether == 2)
	{
		fromhub1map = strcat("profiles/", profilename, "/shrine/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/shrine/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/shrine/maps/e1m2.sav");
	}

	if (istether == 3)
	{
		fromhub1map = strcat("profiles/", profilename, "/autosave/maps/hub1.sav");
		frome1m1map = strcat("profiles/", profilename, "/autosave/maps/e1m1.sav");
		frome1m2map = strcat("profiles/", profilename, "/autosave/maps/e1m2.sav");
	}

	fcopy(fromhub1map, tohub1map);
	fcopy(frome1m1map, toe1m1map);
	fcopy(frome1m2map, toe1m2map);

	local string hub1stat, e1m1stat, e1m2stat;
	hub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	if (fexists(hub1stat))
		fremove(hub1stat);
	if (fexists(e1m1stat))
		fremove(e1m1stat);
	if (fexists(e1m2stat))
		fremove(e1m2stat);

	string tohub1stat, toe1m1stat, toe1m2stat;
	string fromhub1stat, frome1m1stat, frome1m2stat;
	tohub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	toe1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	toe1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	if (istether == 1)
	{
		fromhub1stat = strcat("profiles/", profilename, "/tether/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/tether/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/tether/maps/e1m2.stats");
	}

	if (istether == 2)
	{
		fromhub1stat = strcat("profiles/", profilename, "/shrine/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/shrine/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/shrine/maps/e1m2.stats");
	}

	if (istether == 3)
	{
		fromhub1stat = strcat("profiles/", profilename, "/autosave/maps/hub1.stats");
		frome1m1stat = strcat("profiles/", profilename, "/autosave/maps/e1m1.stats");
		frome1m2stat = strcat("profiles/", profilename, "/autosave/maps/e1m2.stats");
	}

	fcopy(fromhub1stat, tohub1stat);
	fcopy(frome1m1stat, toe1m1stat);
	fcopy(frome1m2stat, toe1m2stat);

};
void() load_tether = { cmd("set cvar_restoregame 0\n");
	cmd("slowmo 1\n");cmd("r_glsl_saturation 1\n");
	read_currentprofileslot();
	load_save_maps(1);
	string cname;
	cname = strcat("load data/profiles/", profilename, "/tether.sav\n");
	//	bprint(cname);
	cmd("scratch3 0 \n");
	cmd(cname);
};
void() load_shrine = { cmd("set cvar_restoregame 0\n");
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