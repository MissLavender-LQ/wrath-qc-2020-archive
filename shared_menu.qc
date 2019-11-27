string profilename;
float profileslot;
float(string filename, float mode) fopen_wrath = { local float frikfile;
	frikfile = fopen(filename, mode);
	if (frikfile > 0)
		return frikfile;
};
void(float fhandle) fclose_wrath = { if (fhandle != -1)
		fclose(fhandle);
}

void() read_currentprofileslot = { local float readparms;
	local string readtext;
	readparms = fopen_wrath("profiles/currentprofileslot.txt", FILE_READ);	
	readtext = fgets(readparms);	
	profileslot = stof(readtext);	
	readtext = fgets(readparms);
	profilename = (readtext);
	profilename = strzone(profilename);
	fclose_wrath(readparms);
};

void(float totalsaves) writeprofilesavedlist = { local float profilenamef;
	local string writethis, profilenamestring;

	profilenamestring = strcat("profiles/", profilename, ".frk");

	profilenamef = fopen_wrath(profilenamestring, FILE_WRITE);	
	writethis = ftos(totalsaves);	
	fputs(profilenamef, writethis);	
	fputs(profilenamef, "\n");	
	fclose_wrath(profilenamef);
};

void(float val) write_tether2 = { read_currentprofileslot();
	local string saveloc;
	saveloc = strcat("profiles/", profilename, "/tetherclient.txt");

	local float writeparms;
	local string writethis;
	writeparms = fopen_wrath(saveloc, FILE_WRITE);	
	writethis = ftos(val);	
	fputs(writeparms, writethis);	
	fputs(writeparms, "\n");	
	fclose_wrath(writeparms);
};
void(float val) write_shrine = { read_currentprofileslot();
	local string saveloc;
	saveloc = strcat("profiles/", profilename, "/shrine.txt");

	local float writeparms;
	local string writethis;
	writeparms = fopen_wrath(saveloc, FILE_WRITE);	
	writethis = ftos(val);	
	fputs(writeparms, writethis);	
	fputs(writeparms, "\n");	
	fclose_wrath(writeparms);
};

void() Kill_Tether = { read_currentprofileslot();
	local string campaignloc;
	campaignloc = strcat("profiles/", profilename, "/tether.txt");

	local float writeparms;
	local string writethis;
	writeparms = fopen_wrath(campaignloc, FILE_WRITE);	
	writethis = ftos(0);	
	fputs(writeparms, writethis);	
	fputs(writeparms, "\n");	
	fclose_wrath(writeparms);
	if (profilename)
		strunzone(profilename);
};

void() remove_save_maps = { read_currentprofileslot();
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

	local string hub1stat, e1m1stat, e1m2stat;
	hub1stat = strcat("data/profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("data/profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("data/profiles/", profilename, "/maps/e1m2.stats");
	if (fexists(hub1stat))
		fremove(hub1stat);
	if (fexists(e1m1stat))
		fremove(e1m1stat);
	if (fexists(e1m2stat))
		fremove(e1m2stat);
};

void(float istether) copy_save_maps = { read_currentprofileslot();
	string hub1map, e1m1map, e1m2map;
	string tohub1map, toe1m1map, toe1m2map;
	hub1map = strcat("profiles/", profilename, "/maps/hub1.sav");
	e1m1map = strcat("profiles/", profilename, "/maps/e1m1.sav");
	e1m2map = strcat("profiles/", profilename, "/maps/e1m2.sav");

	if (istether == 2)
	{
		tohub1map = strcat("profiles/", profilename, "/autosave/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/autosave/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/autosave/maps/e1m2.sav");
	}

	if (istether == 1)
	{
		tohub1map = strcat("profiles/", profilename, "/tether/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/tether/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/tether/maps/e1m2.sav");
	}

	if (istether == 0)
	{
		tohub1map = strcat("profiles/", profilename, "/shrine/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/shrine/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/shrine/maps/e1m2.sav");
	}

	fcopy(hub1map, tohub1map);
	fcopy(e1m1map, toe1m1map);
	fcopy(e1m2map, toe1m2map);

	string hub1stat, e1m1stat, e1m2stat;
	string tohub1stat, toe1m1stat, toe1m2stat;
	hub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	if (istether == 2)
	{
		tohub1stat = strcat("profiles/", profilename, "/autosave/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/autosave/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/autosave/maps/e1m2.stats");
	}

	if (istether == 1)
	{
		tohub1stat = strcat("profiles/", profilename, "/tether/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/tether/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/tether/maps/e1m2.stats");
	}

	if (istether == 0)
	{
		tohub1stat = strcat("profiles/", profilename, "/shrine/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/shrine/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/shrine/maps/e1m2.stats");
	}

	fcopy(hub1stat, tohub1stat);
	fcopy(e1m1stat, toe1m1stat);
	fcopy(e1m2stat, toe1m2stat);

};