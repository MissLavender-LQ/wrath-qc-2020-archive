string profilename;
float profileslot;
float(string filename, float mode) fopen_wrath = { 
local float frikfile;
//	if(!(fexists(filename)))
//		return FALSE;	

	frikfile = fopen(filename, mode);
	if (frikfile > 0)
		return frikfile;
	else
		return FALSE;	
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

void(float val) write_shrine_user = { read_currentprofileslot();
	local string saveloc;
	saveloc = strcat("profiles/", profilename, "/shrine_user.txt");

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
	local string hub1map, e1m1map, e1m2map,e1m3map, e1m4map, e1m5map;
	hub1map = strcat("data/profiles/", profilename, "/maps/hub1.sav");
	e1m1map = strcat("data/profiles/", profilename, "/maps/e1m1.sav");
	e1m2map = strcat("data/profiles/", profilename, "/maps/e1m2.sav");
	e1m3map = strcat("data/profiles/", profilename, "/maps/e1m3.sav");
	e1m4map = strcat("data/profiles/", profilename, "/maps/e1m4.sav");
	e1m5map = strcat("data/profiles/", profilename, "/maps/e1m5.sav");
	if (fexists(hub1map))
		fremove(hub1map);
	if (fexists(e1m1map))
		fremove(e1m1map);
	if (fexists(e1m2map))
		fremove(e1m2map);
	if (fexists(e1m3map))
		fremove(e1m3map);
	if (fexists(e1m4map))
		fremove(e1m4map);
	if (fexists(e1m5map))
		fremove(e1m5map);
		
	local string hub1stat, e1m1stat, e1m2stat, e1m3stat, e1m4stat, e1m5stat;
	hub1stat = strcat("data/profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("data/profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("data/profiles/", profilename, "/maps/e1m2.stats");
	e1m3stat = strcat("data/profiles/", profilename, "/maps/e1m3.stats");
	e1m4stat = strcat("data/profiles/", profilename, "/maps/e1m4.stats");
	e1m5stat = strcat("data/profiles/", profilename, "/maps/e1m5.stats");
	if (fexists(hub1stat))
		fremove(hub1stat);
	if (fexists(e1m1stat))
		fremove(e1m1stat);
	if (fexists(e1m2stat))
		fremove(e1m2stat);
	if (fexists(e1m3stat))
		fremove(e1m3stat);
	if (fexists(e1m4stat))
		fremove(e1m4stat);
	if (fexists(e1m5stat))
		fremove(e1m5stat);
		
};
void(string filefrom, string fileto)fcopy_wrath =
{

if(fexists(strcat ("data/",filefrom)))
fcopy (filefrom, fileto);
};
void(float istether) copy_save_maps = { read_currentprofileslot();
	string hub1map, e1m1map, e1m2map, e1m3map, e1m4map, e1m5map;
	string tohub1map, toe1m1map, toe1m2map, toe1m3map, toe1m4map, toe1m5map;
	hub1map = strcat("profiles/", profilename, "/maps/hub1.sav");
	e1m1map = strcat("profiles/", profilename, "/maps/e1m1.sav");
	e1m2map = strcat("profiles/", profilename, "/maps/e1m2.sav");
	e1m3map = strcat("profiles/", profilename, "/maps/e1m3.sav");
	e1m4map = strcat("profiles/", profilename, "/maps/e1m4.sav");
	e1m5map = strcat("profiles/", profilename, "/maps/e1m5.sav");

	if (istether == 2)
	{
		tohub1map = strcat("profiles/", profilename, "/autosave/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/autosave/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/autosave/maps/e1m2.sav");
		toe1m3map = strcat("profiles/", profilename, "/autosave/maps/e1m3.sav");
		toe1m4map = strcat("profiles/", profilename, "/autosave/maps/e1m4.sav");
		toe1m5map = strcat("profiles/", profilename, "/autosave/maps/e1m5.sav");
	}

	if (istether == 1)
	{
		tohub1map = strcat("profiles/", profilename, "/tether/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/tether/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/tether/maps/e1m2.sav");
		toe1m3map = strcat("profiles/", profilename, "/tether/maps/e1m3.sav");
		toe1m4map = strcat("profiles/", profilename, "/tether/maps/e1m4.sav");
		toe1m5map = strcat("profiles/", profilename, "/tether/maps/e1m5.sav");
	}

	if (istether == 0)
	{
		tohub1map = strcat("profiles/", profilename, "/shrine/maps/hub1.sav");
		toe1m1map = strcat("profiles/", profilename, "/shrine/maps/e1m1.sav");
		toe1m2map = strcat("profiles/", profilename, "/shrine/maps/e1m2.sav");
		toe1m3map = strcat("profiles/", profilename, "/shrine/maps/e1m3.sav");
		toe1m4map = strcat("profiles/", profilename, "/shrine/maps/e1m4.sav");
		toe1m5map = strcat("profiles/", profilename, "/shrine/maps/e1m5.sav");
	}

	fcopy_wrath (hub1map, tohub1map);
	fcopy_wrath (e1m1map, toe1m1map);
	fcopy_wrath (e1m2map, toe1m2map);
	fcopy_wrath (e1m3map, toe1m3map);
	fcopy_wrath (e1m4map, toe1m4map);
	fcopy_wrath (e1m5map, toe1m5map);

	string hub1stat, e1m1stat, e1m2stat, e1m3stat, e1m4stat, e1m5stat;
	string tohub1stat, toe1m1stat, toe1m2stat, toe1m3stat, toe1m4stat, toe1m5stat;
	hub1stat = strcat("profiles/", profilename, "/maps/hub1.stats");
	e1m1stat = strcat("profiles/", profilename, "/maps/e1m1.stats");
	e1m2stat = strcat("profiles/", profilename, "/maps/e1m2.stats");
	e1m3stat = strcat("profiles/", profilename, "/maps/e1m3.stats");
	e1m4stat = strcat("profiles/", profilename, "/maps/e1m4.stats");
	e1m5stat = strcat("profiles/", profilename, "/maps/e1m5.stats");

	if (istether == 2)
	{
		tohub1stat = strcat("profiles/", profilename, "/autosave/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/autosave/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/autosave/maps/e1m2.stats");
		toe1m3stat = strcat("profiles/", profilename, "/autosave/maps/e1m3.stats");
		toe1m4stat = strcat("profiles/", profilename, "/autosave/maps/e1m4.stats");
		toe1m5stat = strcat("profiles/", profilename, "/autosave/maps/e1m5.stats");
	}

	if (istether == 1)
	{
		tohub1stat = strcat("profiles/", profilename, "/tether/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/tether/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/tether/maps/e1m2.stats");
		toe1m3stat = strcat("profiles/", profilename, "/tether/maps/e1m3.stats");
		toe1m4stat = strcat("profiles/", profilename, "/tether/maps/e1m4.stats");
		toe1m5stat = strcat("profiles/", profilename, "/tether/maps/e1m5.stats");
	}

	if (istether == 0)
	{
		tohub1stat = strcat("profiles/", profilename, "/shrine/maps/hub1.stats");
		toe1m1stat = strcat("profiles/", profilename, "/shrine/maps/e1m1.stats");
		toe1m2stat = strcat("profiles/", profilename, "/shrine/maps/e1m2.stats");
		toe1m3stat = strcat("profiles/", profilename, "/shrine/maps/e1m3.stats");
		toe1m4stat = strcat("profiles/", profilename, "/shrine/maps/e1m4.stats");
		toe1m5stat = strcat("profiles/", profilename, "/shrine/maps/e1m5.stats");
	}

	fcopy_wrath (hub1stat, tohub1stat);
	fcopy_wrath (e1m1stat, toe1m1stat);
	fcopy_wrath (e1m2stat, toe1m2stat);
	fcopy_wrath (e1m3stat, toe1m3stat);
	fcopy_wrath (e1m4stat, toe1m4stat);
	fcopy_wrath (e1m5stat, toe1m5stat);

};