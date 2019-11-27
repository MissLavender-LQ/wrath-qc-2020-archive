 float menuversion = 1.1899;

 void() m_display;
 float pausesound;
 float nprof;
 float type_load_selected;
 float number_load_selected;

 void(string txttoclear) writeempty = { local float writeparms;
 	writeparms = fopen_wrath(txttoclear, FILE_WRITE);	//open what file to use in write mode
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 }

 void() delete_profiles = { writeempty("profiles/currentprofileslot.txt");
 	writeempty("profiles/profilenames.txt");
 	writeempty("profiles/profileslot.txt");
 	writeempty("profiles/totalfileslot.txt");

 	local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("menuversion.txt", FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(menuversion);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 	//rmtree("profiles");	
 };

 void() check_menuversion = { local float readparms, localmenuversion;
 	local string readtext;
 	readparms = fopen_wrath("menuversion.txt", FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	readtext = fgets(readparms);	//read the text
 	localmenuversion = stof(readtext);	//turn the text into the float u want (by using stof: string to float)
 	fclose_wrath(readparms);

 	if (localmenuversion != menuversion)
 		delete_profiles();

 }

 void() refresh_mouse = {	//cvar_set("vid_conheight", ftos(cvar("vid_conwidth")*cvar("vid_height")/cvar("vid_width")));
 	//cmd("vid_conwidth 960\n");
 	//cmd("vid_conheight 540\n");
 	vid_rx = cvar("vid_conwidth");
 	vid_ry = cvar("vid_conheight");
 	mouse_pos_x = vid_rx / 2;
 	mouse_pos_y = vid_ry / 2;
 };

 void() updateMouse = { vid_rx = cvar("vid_conwidth");
 	vid_ry = cvar("vid_conheight");
 	vector raw_mouse;
 	raw_mouse = getmousepos();
 	// add some mouse acceleration 

 	local float mousesen;
 	mousesen = cvar("sensitivity");
 	raw_mouse_x = raw_mouse_x *mousesen *0.5;	//pow(vlen(raw_mouse), mousesen);
 	raw_mouse_y = raw_mouse_y *mousesen *0.5;
 	mouse_pos += raw_mouse;
 	if (mouse_pos_x < 0)
 		mouse_pos_x = 0;

 	if (mouse_pos_x > vid_rx)
 		mouse_pos_x = vid_rx;

 	if (mouse_pos_y < 0)
 		mouse_pos_y = 0;

 	if (mouse_pos_y > vid_ry)
 		mouse_pos_y = vid_ry;
 };

 string(float kn) keynumtostring_f = { if (kn == 127)
 		return "space bar";
 	else
 	{
 		string n = keynumtostring(kn);
 		return n;
 	}
 };
 void() check_save = { local float readparms;
 	local string readtext;
 	readparms = fopen_wrath("adpsav.dll", FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	if (readparms != -1)
 	{
 		readtext = fgets(readparms);	//read the text
 		checksaves = stof(readtext);	//turn the text into the float u want (by using stof: string to float)
 		fclose_wrath(readparms);
 	}
 };

 void(string nameprofile) check_profile_saves = { local float readparms;
 	local string readtext, profilename_svs;
 	profilename_svs = strcat("profiles/", nameprofile, ".frk");
 	readparms = fopen_wrath(profilename_svs, FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	if (readparms != -1)
 	{
 		readtext = fgets(readparms);	//read the text
 		currentprofilessaves = stof(readtext);	//turn the text into the float u want (by using stof: string to float)
 		fclose_wrath(readparms);
 	}
 };

 void() check_profileslot = { local float readparms;
 	local string readtext;
 	readparms = fopen_wrath("profiles/profileslot.txt", FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	if (readparms != -1)
 	{
 		readtext = fgets(readparms);	//read the text
 		profileslot = stof(readtext);	//turn the text into the float u want (by using stof: string to float)
 		fclose_wrath(readparms);
 	}
 };

 float() check_profileslottotal = { local float readparms;
 	local string readtext;
 	readparms = fopen_wrath("profiles/totalfileslot.txt", FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	if (readparms != -1)
 	{
 		readtext = fgets(readparms);	//read the text
 		local float localprofilesammount;
 		localprofilesammount = stof(readtext);	//turn the text into the float u want (by using stof: string to float)
 		fclose_wrath(readparms);
 		return localprofilesammount;
 	}
 	else
 		return 0;
 };
 void() check_profilenames = { local float readparms;
 	local string readtext;
 	readparms = fopen_wrath("profiles/profilenames.txt", FILE_READ);	//open what file to use (THIS TIME IN READ MODE)
 	if (readparms != -1)
 	{
 		readtext = fgets(readparms);	//read the text
 		profilename1 = (readtext);	//turn the text into the float u want (by using stof: string to float)
 		readtext = fgets(readparms);
 		profilename2 = (readtext);
 		readtext = fgets(readparms);
 		profilename3 = (readtext);
 		readtext = fgets(readparms);
 		profilename4 = (readtext);
 		readtext = fgets(readparms);
 		profilename5 = (readtext);
 		readtext = fgets(readparms);
 		profilename6 = (readtext);
 		readtext = fgets(readparms);
 		profilename7 = (readtext);
 		readtext = fgets(readparms);
 		profilename8 = (readtext);
 		readtext = fgets(readparms);
 		profilename9 = (readtext);
 		readtext = fgets(readparms);
 		profilename10 = (readtext);
 		readtext = fgets(readparms);
 		profilename11 = (readtext);
 		readtext = fgets(readparms);
 		profilename12 = (readtext);
 		fclose_wrath(readparms);
 	}
 };

 void(float nprofile) check_profilenames_str = { check_profilenames();
 	if (nprofile == 1) profilename = strzone(profilename1);
 	if (nprofile == 2) profilename = strzone(profilename2);
 	if (nprofile == 3) profilename = strzone(profilename3);
 	if (nprofile == 4) profilename = strzone(profilename4);
 	if (nprofile == 5) profilename = strzone(profilename5);
 	if (nprofile == 6) profilename = strzone(profilename6);
 	if (nprofile == 7) profilename = strzone(profilename7);
 	if (nprofile == 8) profilename = strzone(profilename8);
 	if (nprofile == 9) profilename = strzone(profilename9);
 	if (nprofile == 10) profilename = strzone(profilename10);
 	if (nprofile == 11) profilename = strzone(profilename11);
 	if (nprofile == 12) profilename = strzone(profilename12);
 };

 string c_profilename1;
 string c_profilename2;
 string c_profilename3;
 string c_profilename4;
 string c_profilename5;
 string c_profilename6;
 string c_profilename7;

 void() check_profilenames_str2 = { check_profilenames();
 	c_profilename1 = strzone(profilename1);
 	c_profilename2 = strzone(profilename2);
 	c_profilename3 = strzone(profilename3);
 	c_profilename4 = strzone(profilename4);
 	c_profilename5 = strzone(profilename5);
 	c_profilename6 = strzone(profilename6);
 	c_profilename7 = strzone(profilename7);
 };

 void() write_save = { local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("adpsav.dll", FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(1);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 };

 void() write_currentprofileslot = { check_profilenames_str(profileslot);
 	local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("profiles/currentprofileslot.txt", FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(profileslot);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	writethis = profilename;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename;
 	fclose_wrath(writeparms);
 	if (profilename != "")
 		strunzone(profilename);
 };

 void() write_totalprofileslot = { local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("profiles/totalfileslot.txt", FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(profilesammount);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 };

 void() write_currentprofileslotfirsttime = { check_profilenames_str(profileslot);
 	local float profilenamef;
 	local string profilenamestring;
 	profilenamestring = strcat("profiles/", profilename, ".frk");
 	profilenamef = fopen_wrath(profilenamestring, FILE_WRITE);	//open what file to use in write mode
 	fputs(profilenamef, "0\n");	//and again
 	fclose_wrath(profilenamef);
 	if (profilename != "")
 		strunzone(profilename);
 	write_currentprofileslot();
 };

 void() write_profileslot = { local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("profiles/profileslot.txt", FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(profileslot);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 };

 void() write_profilenames = { local float writeparms;
 	local string writethis;
 	writeparms = fopen_wrath("profiles/profilenames.txt", FILE_WRITE);	//open what file to use in write mode
 	writethis = profilename1;	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	writethis = profilename2;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename3;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename4;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename5;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename6;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename7;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename8;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename9;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename10;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename11;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	writethis = profilename12;
 	fputs(writeparms, writethis);
 	fputs(writeparms, "\n");
 	fclose_wrath(writeparms);
 };

 void() m_init = { check_menuversion();
 	cmd("exec start.cfg\n");
 	vid_wres = cvar("vid_width");
 	vid_hres = cvar("vid_height");
 	string consize_w, consize_h;
 	consize_w = ftos(vid_wres / 2);
 	consize_h = ftos(vid_hres / 2);
 	cmd(strcat("vid_conheight ", consize_h, " \n"));
 	cmd(strcat("vid_conwidth ", consize_w, " \n"));

 	cmd("set cvar_restoregame 0\n");
 	cmd("scratch3 0\n");
 	refresh_mouse();
 	Menu_Active = false;
 	cmd("play2 cdtracks/track006\n");
 	precache_file("gfx/help");
 	precache_file("gfx/credits");
 	precache_sound("musica/menu.ogg");
 	precache_sound("menu1.wav");
 	//	check_save();
 	check_profileslot();
 	//	check_profilenames();
 };

 void() remove_tether = { local float writeparms;
 	local string writethis;
 	read_currentprofileslot();
 	local string campaignloc;
 	campaignloc = strcat("profiles/", profilename, "/tether.txt");

 	writeparms = fopen_wrath(campaignloc, FILE_WRITE);	//open what file to use in write mode
 	writethis = ftos(0);	//prepare the next thing to write
 	fputs(writeparms, writethis);	//line 1
 	fputs(writeparms, "\n");	//and again
 	fclose_wrath(writeparms);
 };

 void() m_init2 = { refresh_mouse();
 	time = gettime();
 	cmd("play2 cdtracks/track006\n");
 	check_save();
 }

 void() m_main = { cmd("\n disconnect \n");
 	menutype = M_TYPE_NONE;
 	m_toggle(1);
 	m_init2();
 	selected_option = 0;
 }

 void(string s) GameCommand = { if (s == "backtomainmenu")
 		callfunction("m_main");
 };

 float releasedmouse;
 float mousereleased;

 void(float key, float ascii) m_keyup = { float deadmenu;
 	deadmenu = cvar("scratch3");

 	if (key == K_MOUSE1)
 		releasedmouse = 1;
 };

 string gah;
 float menuingame;
 float zmenuingame;

 void() restart_consize = { vid_wres = cvar("vid_width");
 	vid_hres = cvar("vid_height");
 	string consize_w, consize_h;
 	consize_w = ftos(vid_wres / 2);
 	consize_h = ftos(vid_hres / 2);
 	cmd(strcat("vid_conheight ", consize_h, " \n"));
 	cmd(strcat("vid_conwidth ", consize_w, " \n"));
 	refresh_mouse();
 };

 void(float key, float ascii) m_keydown = { float deadmenu;
 	deadmenu = cvar("scratch3");
 	if (deadmenu)
 		return;

 	if (key == K_ESCAPE)
 	{
 		localsound("sounds/menu.wav");

 		if (menutype == M_TYPE_PROFILE)
 		{
 			menutype = M_TYPE_NONE;
 			if (gah != "")
 				strunzone(gah);
 			gah = "";
 		}

 		if ((isserver() || (clientstate() == CS_CONNECTED)) && (zmenuingame == 1))	// don't back out to console only
 			m_hide();
 		if ((menutype == M_TYPE_OPTIONS) || (menutype == M_TYPE_RESUME))
 		{
 			menutype = M_TYPE_NONE;
 			zmenuingame = 1;
 		}

 		if ((menutype == M_TYPE_AUDIO) || (menutype == M_TYPE_VIDEO) || (menutype == M_TYPE_CONTROLS) || (menutype == M_TYPE_GAMEPLAY))
 			menutype = M_TYPE_OPTIONS;
 		if (menutype == M_TYPE_RESOLUTION)
 		{
 			menutype = M_TYPE_OPTIONS;
 			restart_consize();
 		}

 		if (menutype == M_TYPE_CONFIRMBIND)
 			menutype = M_TYPE_CONTROLS;
 		//if((menutype == M_TYPE_HELP) || (menutype == M_TYPE_CREDITS) || (menutype == M_TYPE_PROFILE) ||)
 		enterindex = 0;
 	}

 	if (menutype == M_YNQ)
 	{
 		if (ascii == 'y' || ascii == 'Y')
 			cmd("\nquit\n");
 		if ((ascii == 'n' || ascii == 'N') || (key == K_ESCAPE))
 			menutype = M_TYPE_NONE;
 	}

 	/*
 		if(menutype == M_TYPE_NONE)
 		{
 			if(ascii == 'y' || ascii == 'Y')
 			{
 				menutype = M_TYPE_NONE;
 				cmd("\n disconnect \n");
 				m_init2();
 			}

 			if((ascii == 'n' || ascii == 'N') || (key == K_ESCAPE))
 				menutype = M_TYPE_NONE;
 		}		
 	*/
 	if (menutype == M_YND)
 	{
 		if (ascii == 'y' || ascii == 'Y')
 		{
 			menutype = M_TYPE_NONE;
 			cmd("\n disconnect \n");
 			m_init2();
 		}

 		if ((ascii == 'n' || ascii == 'N') || (key == K_ESCAPE))
 			menutype = M_TYPE_NONE;
 	}

 	if (key == K_MOUSE1)
 	{
 		if ((clientstate() == CS_CONNECTED) && (menuingame == 1))
 			return;
 		time = gettime();

 		check_keys(selected_option, 0);

 		if (mousereleased == 0)
 		{
 			mousereleased = 1;
 			releasedmouse = 0;
 		}
 	}

 	if ((key == K_KP_ENTER) || (key == K_ENTER))
 	{
 		if ((clientstate() == CS_CONNECTED) && (menuingame == 1))
 			return;
 		time = gettime();
 		if (enterindex)
 			check_keys(enterindex, 1);

 	}

 	if (menutype == M_TYPE_PROFILE)
 	{
 		string theline;
 		theline = gah;
 		if ((ascii >= 48) && (ascii <= 57) || (ascii >= 65) && (ascii <= 90) || (ascii >= 97) && (ascii <= 122))
 		{
 			if (strlen(theline) < 16)
 				theline = strzone(strcat(theline, chr2str(ascii)));
 		}

 		if (key == K_BACKSPACE)
 		{
 			float theline_len, theline_end;
 			theline_len = strlen(theline) *-1;
 			theline_end = strlen(theline) - 1;
 			if (strlen(theline) > 0)
 				theline = strzone(substring(theline, theline_len, theline_end));
 			else
 				theline = "";
 		}

 		selected_option = 0;
 		gah = theline;
 	}

 	if (menutype == M_TYPE_CONFIRMBIND)
 	{
 		string localkey;
 		if (gkcommand == 1) localkey = "+forward";
 		if (gkcommand == 2) localkey = "+back";
 		if (gkcommand == 3) localkey = "+moveleft";
 		if (gkcommand == 4) localkey = "+moveright";
 		if (gkcommand == 5) localkey = "+attack";
 		if (gkcommand == 6) localkey = "+button3";
 		if (gkcommand == 7) localkey = "+button6";
 		if (gkcommand == 8) localkey = "+jump";
 		if (gkcommand == 9) localkey = "+button4";	//crouch  508
 		if (gkcommand == 10) localkey = "\"impulse 1\"";
 		if (gkcommand == 11) localkey = "\"impulse 2\"";
 		if (gkcommand == 12) localkey = "\"impulse 3\"";
 		if (gkcommand == 13) localkey = "\"impulse 4\"";	// 512
 		if (gkcommand == 14) localkey = "\"impulse 5\"";
 		if (gkcommand == 15) localkey = "\"impulse 6\"";
 		if (gkcommand == 16) localkey = "\"impulse 7\"";
 		if (gkcommand == 17) localkey = "\"impulse 8\"";	// 516
 		if (gkcommand == 18) localkey = "\"impulse 9\"";
 		if (gkcommand == 19) localkey = "+button5";	//use
 		if (gkcommand == 20) localkey = "\"impulse 35\"";	//journal
 		if (gkcommand == 21) localkey = "\"impulse 15\"";	//artifact
 		if (gkcommand == 22) localkey = "+moveup";	// 521
 		if (gkcommand == 23) localkey = "+movedown";
 		if (gkcommand == 24) localkey = "\"impulse 57\"";	// last weapon
 		if (gkcommand == 25) localkey = "\"impulse 55\"";
 		if (gkcommand == 26) localkey = "\"impulse 56\"";	// 525
 		if (gkcommand == 27) localkey = "+button7";	// 527

 		if (!releasedmouse)
 			return;

 		if (key == K_ESCAPE)
 			return;

 		//		keybind = ascii;	

 		//		if(key == K_MOUSE1)
 		keybind = key;

 		tokenize(findkeysforcommand(localkey, 0));
 		if (stof(argv(0)) == keybind)
 		{
 			menutype = M_TYPE_CONTROLS;
 			return;
 		}

 		float keybind1, keybind2, keybind3, keybind4;

 		if (argv1 != -1)
 		{
 			keybind1 = (argv1);
 			cmd(strcat("unbind ", keynumtostring(keybind1), "\n"));
 		}

 		if (argv2 != -1)
 		{
 			keybind2 = (argv2);
 			cmd(strcat("unbind ", keynumtostring(keybind2), "\n"));
 		}

 		if (argv3 != -1)
 		{
 			keybind3 = (argv3);
 			cmd(strcat("unbind ", keynumtostring(keybind3), "\n"));
 		}

 		if (argv4 != -1)
 		{
 			keybind4 = (argv4);
 			cmd(strcat("unbind ", keynumtostring(keybind4), "\n"));
 		}

 		setkeybind_bindmap(keybind, localkey, 0);
 		string bindcmd;
 		bindcmd = strcat("in_bind 0 ", keynumtostring(keybind), " ", localkey, "\n");
 		cmd(bindcmd);
 		if (keybind)
 			menutype = M_TYPE_CONTROLS;
 		return;
 	}

 	//if (gah) 
 	//	strunzone(gah);
 };

 float mouseactive;

 float check_mouse(vector pos)
 {
 	local vector mins, max;
 	mins = pos;
 	max = pos + BTT_IMG_SIZE;
 	if (mouse_pos_x > mins_x && mouse_pos_x < max_x)
 	{
 		if (mouse_pos_y > mins_y && mouse_pos_y < max_y)
 		{
 			return 1;
 		}
 	}

 	return 0;
 };

 float check_mouse2(vector pos)
 {
 	local vector mins, max;
 	mins = pos;
 	max = pos + BTT_IMG_SIZE2;
 	if (mouse_pos_x > mins_x && mouse_pos_x < max_x)
 	{
 		if (mouse_pos_y > mins_y && mouse_pos_y < max_y)
 		{
 			return 1;
 		}
 	}

 	return 0;
 };

 float last_selected_option;
 float mouseactive;

 void(vector pos, string txt, float index) draw_buttionwrath = { local float txt_len;
 	local vector txt_pos;
 	local string picimage;

 	vector posfix, imgsize;
 	posfix_x = 128 * vx_rel;
 	posfix_y = 10 * vy_rel;

 	txt_pos = pos + posfix;
 	txt_len = stringwidth("NEWGAME GAME", true, BTT_FONT_SIZE);
 	txt_pos_x -= (txt_len / 2);

 	vector colorm;
 	colorm = '1 1 1';

 	if (check_mouse(pos))
 	{
 		selected_option = index;
 		last_selected_option = selected_option;
 		mouseactive = 1;
 		if (txt == "New Game")
 			picimage = "gfx/menu/begin_active.tga";
 		if (txt == "Resume")
 			picimage = "gfx/menu/resume_active.tga";
 		if (txt == "Options")
 			picimage = "gfx/menu/options_active.tga";
 		if (txt == "Quit")
 			picimage = "gfx/menu/depart_active.tga";
 		if ((txt == "Load"))
 		{
 			picimage = "gfx/menu/load_game_active2.tga";
 			//colorm = '1.25 0.5 0.5';
 		}
 	}
 	else
 	{
 		if ((last_selected_option == index) && (mouseactive == 1))
 		{
 			last_selected_option = 0;
 			mouseactive = 0;
 			selected_option = 0;
 		}

 		if (txt == "New Game")
 			picimage = "gfx/menu/begin.tga";
 		if (txt == "Resume")
 			picimage = "gfx/menu/resume.tga";
 		if (txt == "Options")
 			picimage = "gfx/menu/options.tga";
 		if (txt == "Quit")
 			picimage = "gfx/menu/depart.tga";
 		if (txt == "Load")
 			picimage = "gfx/menu/load_game_active.tga";
 	}

 	imgsize_x = rint(192 *vx_rel);
 	imgsize_y = rint(48 *vx_rel);

 	vector local_imgsize;
 	if (index != 7)
 		local_imgsize = imgsize;
 	else
 		local_imgsize = fixed_vector2('152 40 0');

 	drawpic(txt_pos, picimage, local_imgsize, colorm, 1, 0);
 };

 float check_mouse_c(vector pos, vector pos2)
 {
 	local vector mins, max;
 	mins = pos;
 	max = pos2;
 	mins -= fixed_vector('24 32 0');
 	max += fixed_vector('8 -8 0');

 	if (mouse_pos_x > mins_x && mouse_pos_x < max_x)
 	{
 		if ((mouse_pos_y > mins_y) && (mouse_pos_y < max_y))
 			return 1;
 	}

 	return 0;
 };

 float check_mouse_d(vector pos, vector pos2)
 {
 	local vector mins, max;
 	mins = pos;
 	max = pos2;

 	mins -= fixed_vector('12 16 0');
 	max += fixed_vector('12 0 0');

 	if (mouse_pos_x > mins_x && mouse_pos_x < max_x)
 	{
 		if ((mouse_pos_y > mins_y) && (mouse_pos_y < max_y))
 			return 1;
 	}

 	return 0;
 };

 float check_mouse_e(vector pos, vector pos2)
 {
 	local vector mins, max;
 	mins = pos;
 	max = pos2;

 	mins -= fixed_vector('24 20 0');
 	max += fixed_vector('0 -8 0');

 	if (mouse_pos_x > mins_x && mouse_pos_x < max_x)
 	{
 		if ((mouse_pos_y > mins_y) && (mouse_pos_y < max_y))
 			return 1;
 	}

 	return 0;
 };

 float last_selected_option2;
 void draw_buttionprofile(vector pos, string txt, float nprof_local)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, pos2;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, fixed_vector('12 12 0'));
 	txt_pos_x -= (txt_len / 2);
 	local vector cb, bfont;
 	pos = txt_pos;
 	pos2 = pos + fixed_vector('12 12 0');
 	pos2_x = pos_x + txt_len;
 	vector filllip;

 	if ((check_mouse_e(pos, pos2)) && (profileslotpage != nprof_local))
 	{
 		selected_option = 5;
 		nprof = nprof_local;
 		last_selected_option2 = nprof_local;
 		mouseactive = 1;

 	}
 	else
 	{
 		if (last_selected_option2 == nprof_local)
 		{
 			last_selected_option2 = 0;
 			mouseactive = 0;
 			selected_option = 0;
 		}
 	}

 	if ((last_selected_option2 == nprof_local) && (mouseactive == 1))
 	{
 		cb = '4 4 0.5';
 		bfont = fixed_vector('12 12 0');
 		//txt_pos_x -= txt_len *0.125;
 		alpha = 1;
 		filllip = fixed_vector('0 0 0');
 	}
 	else
 	{
 		bfont = fixed_vector('12 12 0');
 		cb = '-1 -1 -1';
 		alpha = 0.75;
 		filllip = '0 0 0';
 	}

 	if (profileslotpage == nprof_local)
 	{
 		bfont = fixed_vector('12 12 0');
 		cb = '2 2 2';
 		alpha = 1;
 		filllip = '0 0 0';
 	}

 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };
 float last_selected_option3;
 void draw_buttionload(vector pos, string txt, float nprof_local)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, pos2;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, fixed_vector('12 12 0'));
 	txt_pos_x -= (txt_len / 2);
 	local vector cb, bfont;
 	pos = txt_pos;
 	pos2 = pos + fixed_vector('12 12 0');
 	pos2_x = pos_x + txt_len;
 	vector filllip;

 	if ((check_mouse_c(pos, pos2)) && (type_load_selected != nprof_local))
 	{
 		selected_option = 6;
 		number_load_selected = nprof_local;
 		last_selected_option3 = nprof_local;
 		mouseactive = 1;

 	}
 	else
 	{
 		if (last_selected_option3 == nprof_local)
 		{
 			last_selected_option3 = 0;
 			mouseactive = 0;
 			selected_option = 0;
 		}
 	}

 	if ((last_selected_option3 == nprof_local) && (mouseactive == 1))
 	{
 		cb = '4 4 0.5';
 		bfont = fixed_vector('12 12 0');
 		//txt_pos_x -= txt_len *0.125;
 		alpha = 1;
 		filllip = fixed_vector('0 0 0');
 	}
 	else
 	{
 		bfont = fixed_vector('12 12 0');
 		cb = '-1 -1 -1';
 		alpha = 0.75;
 		filllip = '0 0 0';
 	}

 	if (type_load_selected == nprof_local)
 	{
 		bfont = fixed_vector('12 12 0');
 		cb = '2 2 2';
 		alpha = 1;
 		filllip = '0 0 0';
 	}

 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };
 void draw_buttion(vector pos, string txt, float index)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, pos2;
 	txt_pos = pos + fixed_vector('128 10 0');

 	vector FONT_SIZE;
 	if ((index >= 7) && (index <= 9))
 		FONT_SIZE = '10 10 0';
 	else
 		FONT_SIZE = BTT_FONT_SIZE;

 	if ((index >= 500) && (index <= 526))
 		FONT_SIZE = '10 10 0';

 	txt_len = stringwidth(txt, true, FONT_SIZE);
 	txt_pos_x -= (txt_len / 2);
 	local vector cb, bfont;

 	pos = txt_pos;
 	pos2 = pos + FONT_SIZE;
 	pos2_x = pos_x + txt_len;

 	if ((index >= 250) && (index <= 271))
 	{
 		float selectedres;
 		vid_rx = cvar("vid_width");
 		vid_ry = cvar("vid_height");
 		if ((vid_rx == 1280) && (vid_ry == 960)) selectedres = 250;
 		if ((vid_rx == 1360) && (vid_ry == 1024)) selectedres = 251;
 		if ((vid_rx == 1600) && (vid_ry == 1200)) selectedres = 252;
 		if ((vid_rx == 1920) && (vid_ry == 1440)) selectedres = 253;
 		if ((vid_rx == 2560) && (vid_ry == 1920)) selectedres = 254;
 		if ((vid_rx == 1280) && (vid_ry == 768)) selectedres = 255;
 		if ((vid_rx == 1280) && (vid_ry == 1024)) selectedres = 256;
 		if ((vid_rx == 1600) && (vid_ry == 1280)) selectedres = 257;
 		if ((vid_rx == 2560) && (vid_ry == 2048)) selectedres = 258;
 		if ((vid_rx == 1280) && (vid_ry == 720)) selectedres = 259;
 		if ((vid_rx == 1360) && (vid_ry == 768)) selectedres = 260;
 		if ((vid_rx == 1366) && (vid_ry == 768)) selectedres = 261;
 		if ((vid_rx == 1600) && (vid_ry == 900)) selectedres = 262;
 		if ((vid_rx == 1680) && (vid_ry == 1050)) selectedres = 263;
 		if ((vid_rx == 1920) && (vid_ry == 1080)) selectedres = 264;
 		if ((vid_rx == 2560) && (vid_ry == 1440)) selectedres = 265;
 		if ((vid_rx == 3840) && (vid_ry == 2160)) selectedres = 266;
 		if ((vid_rx == 1280) && (vid_ry == 800)) selectedres = 267;
 		if ((vid_rx == 1440) && (vid_ry == 900)) selectedres = 268;
 		if ((vid_rx == 1920) && (vid_ry == 1200)) selectedres = 269;
 		if ((vid_rx == 2560) && (vid_ry == 1600)) selectedres = 270;
 		if ((vid_rx == 3840) && (vid_ry == 2400)) selectedres = 271;

 		if (index == selectedres)
 		{
 			bfont = FONT_SIZE;
 			cb = '3 0 0';
 			alpha = 1;
 			drawstring(txt_pos, txt, bfont, cb, alpha, 0);
 			return;
 		}

 		pos2_y = pos2_y - 4;
 	}

 	vector text_lenght, filllip;

 	if ((index >= 250) && (index <= 271))
 	{
 		if (check_mouse_d(pos, pos2))
 		{
 			selected_option = index;
 			last_selected_option = selected_option;
 			mouseactive = 1;

 		}
 		else
 		{
 			if (last_selected_option == index)
 			{
 				last_selected_option = 0;
 				mouseactive = 0;
 				selected_option = 0;
 			}
 		}
 	}
 	else if (((index >= 105) && (index <= 109)) || ((index == 320) || (index == 290)))
 	{
 		if (check_mouse_e(pos, pos2))
 		{
 			selected_option = index;
 			last_selected_option = selected_option;
 			mouseactive = 1;

 		}
 		else
 		{
 			if (last_selected_option == index)
 			{
 				last_selected_option = 0;
 				mouseactive = 0;
 				selected_option = 0;
 			}
 		}
 	}
 	else
 	{
 		if (check_mouse_c(pos, pos2))
 		{
 			selected_option = index;
 			last_selected_option = selected_option;
 			mouseactive = 1;

 		}
 		else
 		{
 			if (last_selected_option == index)
 			{
 				last_selected_option = 0;
 				mouseactive = 0;
 				selected_option = 0;
 			}
 		}
 	}

 	if ((selected_option == index) && (mouseactive == 1))
 	{
 		if ((index >= 500) && (index <= 526))
 			cb = '5 5 5';
 		else
 			cb = '4 4 2';
 		if ((index < 7) && (index > 9))
 		{
 			bfont = FONT_SIZE + fixed_vector('2 2 0');
 			filllip = fixed_vector('10 0 0');
 		}
 		else
 		{
 			bfont = FONT_SIZE;
 			filllip = '0 0 0';
 		}

 		//txt_pos_x -= txt_len *0.125;
 		alpha = 1;
 	}
 	else
 	{
 		bfont = FONT_SIZE;
 		if ((index >= 500) && (index <= 526))
 			cb = '1 1 1';
 		else
 			cb = '2 1.5 1.5';
 		alpha = 0.75;
 		filllip = '0 0 0';
 	}

 	if ((index >= 250) && (index <= 271))
 	{
 		text_lenght_x = txt_len;
 		text_lenght_y = bfont_y;
 		drawfill(txt_pos + '0 0 0', text_lenght + filllip, '0.5 0.5 0.5', 0.25, 0);
 	}

 	if ((index >= 500) && (index <= 526))
 	{
 		text_lenght_x = txt_len;
 		text_lenght_y = 12;
 		drawfill(txt_pos + '0 -2 0', text_lenght + filllip, '0.75 0.7 0.5', alpha *0.25, 0);
 		text_lenght_y = 1;
 		drawfill(txt_pos + '0 -2 0', text_lenght + filllip, '1 0.9 0.75', alpha *0.35, 0);
 		text_lenght_y = 1;
 		drawfill(txt_pos + '0 10 0', text_lenght + filllip, '0.35 0.35 0.35', alpha *0.35, 0);
 	}

 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };

 void draw_fbuttion(vector pos, string txt)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, bfont, cb;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, BTT_FONT_SIZE);
 	txt_pos_x -= (txt_len / 2);

 	bfont = BTT_FONT_SIZE;
 	cb = '0.5 0.5 0.25';
 	alpha = 0.75;
 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };
 void draw_fbuttionsmall(vector pos, string txt, float index)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, bfont, cb;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, '10 10 0');
 	txt_pos_x -= (txt_len / 2);

 	bfont = '10 10 0';

 	if (selected_option == index)
 	{
 		cb = '9 9 0.9';
 		alpha = 1;
 	}
 	else
 	{
 		cb = '0.5 0.5 0.5';

 		alpha = 0.75;
 	}

 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };
 void draw_fbuttion3(vector pos, string txt)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, bfont, cb, text_lenght;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, BTT_FONT_SIZE);
 	txt_pos_x -= (txt_len / 2);

 	bfont = BTT_FONT_SIZE;
 	cb = '1 1 0.5';
 	alpha = 1;
 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);
 	cb = '0.5 0.5 0.25';
 	text_lenght_x = txt_len;
 	text_lenght_y = 2;
 	alpha = 0.5;
 	drawfill(txt_pos + fixed_vector('0 16 0'), text_lenght, cb, alpha, 0);
 	//	drawfill (buttions_locs ,'256 4 0', '0.5 0.5 0.35', 0.7, 0);

 };

 void draw_fbuttion2(vector pos, string txt)
 {
 	local float txt_len, alpha;
 	local vector txt_pos, bfont, cb;
 	txt_pos = pos + fixed_vector('128 10 0');
 	txt_len = stringwidth(txt, true, '8 8 8');
 	txt_pos_x -= (txt_len / 2);

 	bfont = '12 12 0';
 	cb = '0.5 0.5 0.25';
 	alpha = 0.75;
 	drawstring(txt_pos, txt, bfont, cb, alpha, 0);

 };

 void() confirm_profile;
 void() menuprofile_prev;
 void() menuprofile_next;
 void() load_tether;
 void() load_shrine;
 float checked_profiles;
 float oldprofileslot;

 void() menuprofile_select;
 void(float local_option, float isenter) check_keys = { if ((!mouseactive) && (isenter == 1))
 		return;

 	if (local_option > 0)
 		localsound("sounds/menu.wav");
 	if ((local_option >= 250) && (local_option <= 271))
 		menutype = M_TYPE_CONFIRMRESOLUTION;
 	//	if((selected_option >= 274) && (selected_option <= 276))
 	//	menutype = M_TYPE_CONFIRMRESOLUTION;

 	if ((local_option >= 307) && (local_option <= 311))
 		menutype = M_TYPE_CONFIRMANTIALIAS;

 	if (local_option == 322)
 		menutype = M_TYPE_CONFIRMFULLSCREEN;
 	if ((local_option >= 500) && (local_option <= 526))
 	{
 		keybind = 0;
 		mousereleased = 0;
 		menutype = M_TYPE_CONFIRMBIND;
 		gkcommand = local_option - 499;
 	}

 	switch (local_option)
 	{
 		case 1:
 			menutype = M_TYPE_PROFILE;
 			break;
 		case 2:
 			read_currentprofileslot();
 			//check_profileslot();
 			profileslotpage = profileslot;
 			check_profilenames();
 			menutype = M_TYPE_RESUME;
 			break;
 		case 3:
 			cmd("\nquit\n");
 			//menutype = M_YNQ;
 			break;
 		case 4:
 			confirm_profile();
 			menutype = M_TYPE_SELECT_DIFFICULT;
 			break;
 		case 5:
 			menuprofile_select();
 			number_load_selected = 0;
 			type_load_selected = 0;
 			//menuprofile_prev();
 			break;
 		case 6:
 			//menuprofile_next();
 			type_load_selected = number_load_selected;
 			break;
 			// In Game Menu
 		case 7:	// new game
 			menutype = M_TYPE_PLAYING;
 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			if (type_load_selected == 1)
 				load_autosave();
 			if (type_load_selected == 2)
 			{
 				write_tether2(1);
 				load_tether();
 			}

 			if (type_load_selected == 3)
 			{
 				write_shrine(1);
 				load_shrine();
 			}

 			type_load_selected = 0;
 			number_load_selected = 0;
 			break;
 		case 8:
 			menutype = M_TYPE_PLAYING;

 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_tether();
 			break;
 		case 9:
 			menutype = M_TYPE_PLAYING;

 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_shrine();
 			break;
 		case 10:
 			restart_consize();
 			checked_profiles = 0;
 			menutype = M_TYPE_OPTIONS;
 			break;
 		case 11:
 			menutype = M_TYPE_CONTROLS;
 			break;
 		case 12:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			break;
 		case 13:
 			cmd("map newmap\n");
 			cmd("skill 2\n");
 			break;
 		case 14:
 			menutype = M_TYPE_AUDIO;
 			break;
 		case 15:
 			menutype = M_TYPE_GAMEPLAY;
 			break;
 		case 18:
 			menutype = M_TYPE_RESOLUTION;
 			vid_fullscr = cvar("vid_fullscreen");
 			vid_wres = cvar("vid_width");
 			vid_hres = cvar("vid_height");
 			break;
 		case 34:
 			if (coronaoclussion == 1)
 				cmd("r_coronas_occlusionquery 0\n");
 			else
 				cmd("r_coronas_occlusionquery 1\n");
 			break;
 		case 35:
 			string vols, volsv;
 			float volv;
 			if (volm > 0)
 				volv = volm - 0.1;
 			else
 				volv = 0;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 36:
 			if (volm < 1)
 				volv = volm + 0.1;
 			else
 				volv = 1;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 99:
 			if (fscselected == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 39:
 			if (versync == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			cmd("vid_restart \n");
 			break;
 		case 40:
 			if (antial == 8)
 				cmd("vid_samples 0\n");
 			else
 				cmd("vid_samples 8\n");
 			cmd("vid_restart \n");
 			break;
 		case 41:
 			menutype = M_TYPE_DNONE;
 			break;
 		case 42:
 			menutype = M_TYPE_NONE;
 			cmd("\n disconnect \n");
 			m_init2();
 			//menutype = M_YND;
 			break;
 		case 43:
 			if (isserver() || (clientstate() == CS_CONNECTED))	// don't back out to console only
 				m_hide();
 			break;

 			//////////// SELECT DIFFICULT		
 		case 45:
 			cmd("skill 0 \n");
 			cmd("map hub1\n");
 			break;
 		case 46:
 			cmd("skill 1 \n");
 			cmd("map hub1\n");
 			break;
 		case 47:
 			cmd("skill 2 \n");
 			cmd("map hub1\n");
 			break;
 		case 48:
 			cmd("skill 3 \n");
 			cmd("map hub1\n");
 			break;
 			//////////// CONTROLS BUTTONS		
 		case 101:
 			string sens, sensv;
 			float senv;
 			if (senm > 1)
 				senv = senm - 1;
 			else
 				senv = 1;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;
 		case 102:
 			if (senm < 10)
 				senv = senm + 1;
 			else
 				senv = 10;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;

 		case 103:
 			string acels, acelsv;
 			float acelv;
 			if (acel > 0)
 				acelv = acel - 1;
 			else
 				acelv = 0;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 104:
 			if (acel < 10)
 				acelv = acel + 1;
 			else
 				acelv = 10;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 105:
 			float checked;
 			checked = cvar("m_filter");
 			if (checked == 1)
 				cmd("m_filter 0\n");
 			else
 				cmd("m_filter 1\n");
 			break;
 		case 106:
 			float checked2;
 			checked2 = cvar("m_pitch");
 			if (checked2 <= -0.022)
 				cmd("m_pitch 0.022\n");
 			else
 				cmd("m_pitch -0.022\n");
 			break;
 		case 107:
 			float checked3;
 			checked3 = cvar("cl_rollangle");
 			if (checked3 == 2)
 				cmd("cl_rollangle 0\n");
 			else
 				cmd("cl_rollangle 2\n");
 			break;
 		case 108:
 			float checked4;
 			checked4 = cvar("cl_bob");
 			if (checked4 == 0.005)
 				cmd("cl_bob 0\n");
 			else
 				cmd("cl_bob 0.005\n");
 			break;
 		case 109:
 			float checked5;
 			checked5 = cvar("scratch1");
 			if (checked5 == 1)
 				cmd("scratch1 0\n");
 			else
 				cmd("scratch1 1\n");
 			break;

 			//////////// VOLUME BUTTONS
 		case 201:
 			string mvolumes, mvolumesv;
 			float mvolumev;
 			if (mvol >= 0.05)
 				mvolumev = mvol - 0.05;
 			else
 				mvolumev = 0;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 202:
 			if (mvol < 1)
 				mvolumev = mvol + 0.05;
 			else
 				mvolumev = 1;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 203:
 			string effvolumes, effvolumesv;
 			float effvolumev;
 			if (effvol >= 0.05)
 				effvolumev = effvol - 0.05;
 			else
 				effvolumev = 0;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 204:
 			if (effvol < 1)
 				effvolumev = effvol + 0.05;
 			else
 				effvolumev = 1;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 205:
 			string bgmvolumes, bgmvolumesv;
 			float bgmvolumev;
 			if (bgmvol >= 0.05)
 				bgmvolumev = bgmvol - 0.05;
 			else
 				bgmvolumev = 0;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;
 		case 206:
 			if (bgmvol < 1)
 				bgmvolumev = bgmvol + 0.05;
 			else
 				bgmvolumev = 1;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;

 			//////////// VIDEO BUTTONS

 		case 250:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 960\n");
 			break;
 		case 251:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 252:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 253:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 254:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1920\n");
 			break;
 		case 255:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 768\n");
 			break;
 		case 256:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 257:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1280\n");
 			break;
 		case 258:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 2048\n");
 			break;
 		case 259:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 720\n");
 			break;
 		case 260:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 768\n");
 			break;
 		case 261:
 			cmd("vid_width 1366\n");
 			cmd("vid_height 768\n");
 			break;
 		case 262:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 900\n");
 			break;
 		case 263:
 			cmd("vid_width 1680\n");
 			cmd("vid_height 1050\n");
 			break;
 		case 264:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1080\n");
 			break;
 		case 265:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 266:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2160\n");
 			break;
 		case 267:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 800\n");
 			break;
 		case 268:
 			cmd("vid_width 1440\n");
 			cmd("vid_height 900\n");
 			break;
 		case 269:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 270:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1600\n");
 			break;
 		case 271:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2400\n");
 			break;
 			/*
 			case 274:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1080\n");
 			break;
 			case 275:
 			cmd("vid_width 3440\n");
 			cmd("vid_height 1440\n");
 			break;
 			case 276:
 			cmd("vid_width 5120\n");
 			cmd("vid_height 2160\n");
 			break;
 			*/
 		case 272:
 			menutype = M_TYPE_RESOLUTION;
 			cmd("vid_restart\n");
 			restart_consize();
 			refresh_mouse();
 			break;
 		case 273:
 			string vid_wres_s, vid_wres_s2;
 			vid_wres_s = ftos(vid_wres);
 			vid_wres_s2 = strcat("vid_width ", vid_wres_s, " \n");
 			cmd(vid_wres_s2);
 			string vid_hres_s, vid_hres_s2;
 			vid_hres_s = ftos(vid_hres);
 			vid_hres_s2 = strcat("vid_height ", vid_hres_s, " \n");
 			cmd(vid_hres_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 290:
 			float checked6;
 			checked6 = cvar("vid_vsync");
 			if (checked6 == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			break;
 		case 291:
 			string bright_s, bright_c;
 			float bright_f;
 			if (brightlev > 0.05)
 				bright_f = brightlev - 0.05;
 			else
 				bright_f = 0.05;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 292:
 			if (brightlev < 2)
 				bright_f = brightlev + 0.05;
 			else
 				bright_f = 2;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 293:
 			string gamma_s, gamma_c;
 			float gamma_f;
 			if (gammalev > 0.05)
 				gamma_f = gammalev - 0.05;
 			else
 				gamma_f = 0.05;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 294:
 			if (gammalev < 2)
 				gamma_f = gammalev + 0.05;
 			else
 				gamma_f = 2;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 295:
 			string cont_s, cont_c;
 			float cont_f;
 			if (contlev > 0.05)
 				cont_f = contlev - 0.05;
 			else
 				cont_f = 0.05;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 296:
 			if (contlev < 2)
 				cont_f = contlev + 0.05;
 			else
 				cont_f = 2;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 297:
 			string fov_s, fov_c;
 			float fov_f;
 			if (fovlev > 80)
 				fov_f = fovlev - 1;
 			else
 				fov_f = 80;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 		case 298:
 			if (fovlev < 100)
 				fov_f = fovlev + 1;
 			else
 				fov_f = 100;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 			//////// PIXEL SCALING
 		case 700:
 			cmd("r_viewscale 1\n");
 			break;
 		case 701:
 			cmd("r_viewscale 0.5\n");
 			break;
 		case 702:
 			cmd("r_viewscale 0.333\n");
 			break;
 		case 703:
 			cmd("r_viewscale 0.25\n");
 			break;
 		case 704:
 			cmd("r_viewscale 0.125\n");
 			break;
 			//////// ANISOTROPY FILTERING
 		case 303:
 			cmd("gl_texture_anisotropy 2\n");
 			break;
 		case 304:
 			cmd("gl_texture_anisotropy 4\n");
 			break;
 		case 305:
 			cmd("gl_texture_anisotropy 8\n");
 			break;
 		case 306:
 			cmd("gl_texture_anisotropy 16\n");
 			break;

 			//////// ANTIALIASING
 		case 307:
 			cmd("vid_samples 0\n");
 			break;
 		case 308:
 			cmd("vid_samples 2\n");
 			break;
 		case 309:
 			cmd("vid_samples 4\n");
 			break;
 		case 310:
 			cmd("vid_samples 8\n");
 			break;
 		case 311:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			cmd("vid_restart\n");
 			break;
 		case 312:
 			string vid_aalias_s, vid_aalias_s2;
 			vid_aalias_s = ftos(vid_aalias);
 			vid_aalias_s2 = strcat("vid_samples ", vid_aalias_s, " \n");
 			cmd(vid_aalias_s2);
 			menutype = M_TYPE_VIDEO;
 			break;
 		case 314:
 			float checked7;
 			checked7 = cvar("r_fxaa");
 			if (checked7 == 1)
 				cmd("r_fxaa 0\n");
 			else
 				cmd("r_fxaa 1\n");
 			break;
 		case 315:
 			cmd("gl_texturemode gl_nearest\n");
 			cmd("scratch2 0\n");
 			break;
 		case 316:
 			cmd("gl_texturemode gl_nearest_mipmap_linear\n");
 			cmd("scratch2 1\n");
 			break;
 		case 317:
 			cmd("gl_texturemode gl_linear\n");
 			cmd("scratch2 2\n");
 			break;
 		case 318:
 			float checked8;
 			checked8 = cvar("r_mipskins");
 			if (checked8 == 1)
 				cmd("r_mipskins 0\n");
 			else
 				cmd("r_mipskins 1\n");
 			break;
 		case 319:
 			float checked9;
 			checked9 = cvar("r_lerpmodels");
 			if (checked9 == 1)
 				cmd("r_lerpmodels 0\n");
 			else
 				cmd("r_lerpmodels 1\n");
 			break;
 		case 320:
 			float checked10;
 			checked10 = cvar("vid_fullscreen");
 			menutype = M_TYPE_CONFIRMFULLSCREEN;
 			if (checked10 == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 321:
 			vid_fullscr = cvar("vid_fullscreen");
 			cmd("vid_restart\n");
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 322:
 			string vid_f_s, vid_f_s2;
 			vid_f_s = ftos(vid_fullscr);
 			vid_f_s2 = strcat("vid_fullscreen ", vid_f_s, " \n");
 			cmd(vid_f_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 323:
 			float checked11;
 			checked11 = cvar("r_glsl_postprocess");
 			if (checked11 == 1)
 				cmd("r_glsl_postprocess 0\n");
 			else
 				cmd("r_glsl_postprocess 1\n");
 			break;
 		case 324:
 			float checked12;
 			checked12 = cvar("r_dynamic");
 			if (checked12 == 1)
 				cmd("r_dynamic 0\n");
 			else
 				cmd("r_dynamic 1\n");
 			break;
 	}

 	selected_option = 0;
 	enterindex = 0;
 };
 void check_keysbac()
 {
 	if (!mouseactive)
 		return;
 	localsound("sounds/menu.wav");
 	if ((selected_option >= 250) && (selected_option <= 271))
 		menutype = M_TYPE_CONFIRMRESOLUTION;
 	//	if((selected_option >= 274) && (selected_option <= 276))
 	//	menutype = M_TYPE_CONFIRMRESOLUTION;

 	if ((selected_option >= 307) && (selected_option <= 311))
 		menutype = M_TYPE_CONFIRMANTIALIAS;

 	if (selected_option == 322)
 		menutype = M_TYPE_CONFIRMFULLSCREEN;
 	if ((selected_option >= 500) && (selected_option <= 526))
 	{
 		keybind = 0;
 		mousereleased = 0;
 		menutype = M_TYPE_CONFIRMBIND;
 		gkcommand = selected_option - 499;
 	}

 	switch (selected_option)
 	{
 		case 1:
 			menutype = M_TYPE_PROFILE;
 			break;
 		case 2:
 			check_profileslot();
 			profileslotpage = profileslot;
 			check_profilenames();
 			menutype = M_TYPE_RESUME;
 			break;
 		case 3:
 			cmd("\nquit\n");
 			//menutype = M_YNQ;
 			break;
 		case 4:
 			confirm_profile();
 			menutype = M_TYPE_SELECT_DIFFICULT;
 			break;
 		case 5:
 			menuprofile_prev();
 			break;
 		case 6:
 			menuprofile_next();
 			break;
 			// In Game Menu
 		case 7:	// new game
 			menutype = M_TYPE_PLAYING;
 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_autosave();
 			break;
 		case 8:
 			menutype = M_TYPE_PLAYING;
 			write_tether2(1);
 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_tether();
 			break;
 		case 9:
 			menutype = M_TYPE_PLAYING;
 			write_shrine(1);
 			if (pausesound)
 			{
 				cmd("pausesound 0\n");
 				pausesound = 0;
 			}

 			load_shrine();
 			break;
 		case 10:
 			restart_consize();
 			checked_profiles = 0;
 			menutype = M_TYPE_OPTIONS;
 			break;
 		case 11:
 			menutype = M_TYPE_CONTROLS;
 			break;
 		case 12:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			break;
 		case 13:
 			cmd("map newmap\n");
 			cmd("skill 2\n");
 			break;
 		case 14:
 			menutype = M_TYPE_AUDIO;
 			break;
 		case 15:
 			menutype = M_TYPE_GAMEPLAY;
 			break;
 		case 18:
 			menutype = M_TYPE_RESOLUTION;
 			vid_fullscr = cvar("vid_fullscreen");
 			vid_wres = cvar("vid_width");
 			vid_hres = cvar("vid_height");
 			break;
 		case 34:
 			if (coronaoclussion == 1)
 				cmd("r_coronas_occlusionquery 0\n");
 			else
 				cmd("r_coronas_occlusionquery 1\n");
 			break;
 		case 35:
 			string vols, volsv;
 			float volv;
 			if (volm > 0)
 				volv = volm - 0.1;
 			else
 				volv = 0;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 36:
 			if (volm < 1)
 				volv = volm + 0.1;
 			else
 				volv = 1;
 			volsv = ftos(volv);
 			vols = strcat("volume ", volsv, " \n");
 			cmd(vols);
 			break;
 		case 99:
 			if (fscselected == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 39:
 			if (versync == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			cmd("vid_restart \n");
 			break;
 		case 40:
 			if (antial == 8)
 				cmd("vid_samples 0\n");
 			else
 				cmd("vid_samples 8\n");
 			cmd("vid_restart \n");
 			break;
 		case 41:
 			menutype = M_TYPE_DNONE;
 			break;
 		case 42:
 			menutype = M_TYPE_NONE;
 			cmd("\n disconnect \n");
 			m_init2();
 			//menutype = M_YND;
 			break;
 		case 43:
 			if (isserver() || (clientstate() == CS_CONNECTED))	// don't back out to console only
 				m_hide();
 			break;

 			//////////// SELECT DIFFICULT		
 		case 45:
 			cmd("skill 0 \n");
 			cmd("map hub1\n");
 			break;
 		case 46:
 			cmd("skill 1 \n");
 			cmd("map hub1\n");
 			break;
 		case 47:
 			cmd("skill 2 \n");
 			cmd("map hub1\n");
 			break;
 		case 48:
 			cmd("skill 3 \n");
 			cmd("map hub1\n");
 			break;
 			//////////// CONTROLS BUTTONS		
 		case 101:
 			string sens, sensv;
 			float senv;
 			if (senm > 1)
 				senv = senm - 1;
 			else
 				senv = 1;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;
 		case 102:
 			if (senm < 10)
 				senv = senm + 1;
 			else
 				senv = 10;
 			sensv = ftos(senv);
 			sens = strcat("sensitivity ", sensv, " \n");
 			cmd(sens);
 			break;

 		case 103:
 			string acels, acelsv;
 			float acelv;
 			if (acel > 0)
 				acelv = acel - 1;
 			else
 				acelv = 0;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 104:
 			if (acel < 10)
 				acelv = acel + 1;
 			else
 				acelv = 10;
 			acelsv = ftos(acelv);
 			acels = strcat("m_accelerate ", acelsv, " \n");
 			cmd(acels);
 			break;
 		case 105:
 			float checked;
 			checked = cvar("m_filter");
 			if (checked == 1)
 				cmd("m_filter 0\n");
 			else
 				cmd("m_filter 1\n");
 			break;
 		case 106:
 			float checked2;
 			checked2 = cvar("m_pitch");
 			if (checked2 <= -0.022)
 				cmd("m_pitch 0.022\n");
 			else
 				cmd("m_pitch -0.022\n");
 			break;
 		case 107:
 			float checked3;
 			checked3 = cvar("cl_rollangle");
 			if (checked3 == 2)
 				cmd("cl_rollangle 0\n");
 			else
 				cmd("cl_rollangle 2\n");
 			break;
 		case 108:
 			float checked4;
 			checked4 = cvar("cl_bob");
 			if (checked4 == 0.005)
 				cmd("cl_bob 0\n");
 			else
 				cmd("cl_bob 0.005\n");
 			break;
 		case 109:
 			float checked5;
 			checked5 = cvar("scratch1");
 			if (checked5 == 1)
 				cmd("scratch1 0\n");
 			else
 				cmd("scratch1 1\n");
 			break;

 			//////////// VOLUME BUTTONS
 		case 201:
 			string mvolumes, mvolumesv;
 			float mvolumev;
 			if (mvol >= 0.05)
 				mvolumev = mvol - 0.05;
 			else
 				mvolumev = 0;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 202:
 			if (mvol < 1)
 				mvolumev = mvol + 0.05;
 			else
 				mvolumev = 1;
 			mvolumesv = ftos(mvolumev);
 			mvolumes = strcat("mastervolume ", mvolumesv, " \n");
 			cmd(mvolumes);
 			break;
 		case 203:
 			string effvolumes, effvolumesv;
 			float effvolumev;
 			if (effvol >= 0.05)
 				effvolumev = effvol - 0.05;
 			else
 				effvolumev = 0;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 204:
 			if (effvol < 1)
 				effvolumev = effvol + 0.05;
 			else
 				effvolumev = 1;
 			effvolumesv = ftos(effvolumev);
 			effvolumes = strcat("volume ", effvolumesv, " \n");
 			cmd(effvolumes);
 			break;
 		case 205:
 			string bgmvolumes, bgmvolumesv;
 			float bgmvolumev;
 			if (bgmvol >= 0.05)
 				bgmvolumev = bgmvol - 0.05;
 			else
 				bgmvolumev = 0;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;
 		case 206:
 			if (bgmvol < 1)
 				bgmvolumev = bgmvol + 0.05;
 			else
 				bgmvolumev = 1;
 			bgmvolumesv = ftos(bgmvolumev);
 			bgmvolumes = strcat("bgmvolume ", bgmvolumesv, " \n");
 			cmd(bgmvolumes);
 			break;

 			//////////// VIDEO BUTTONS

 		case 250:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 960\n");
 			break;
 		case 251:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 252:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 253:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 254:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1920\n");
 			break;
 		case 255:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 768\n");
 			break;
 		case 256:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 1024\n");
 			break;
 		case 257:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 1280\n");
 			break;
 		case 258:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 2048\n");
 			break;
 		case 259:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 720\n");
 			break;
 		case 260:
 			cmd("vid_width 1360\n");
 			cmd("vid_height 768\n");
 			break;
 		case 261:
 			cmd("vid_width 1366\n");
 			cmd("vid_height 768\n");
 			break;
 		case 262:
 			cmd("vid_width 1600\n");
 			cmd("vid_height 900\n");
 			break;
 		case 263:
 			cmd("vid_width 1680\n");
 			cmd("vid_height 1050\n");
 			break;
 		case 264:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1080\n");
 			break;
 		case 265:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1440\n");
 			break;
 		case 266:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2160\n");
 			break;
 		case 267:
 			cmd("vid_width 1280\n");
 			cmd("vid_height 800\n");
 			break;
 		case 268:
 			cmd("vid_width 1440\n");
 			cmd("vid_height 900\n");
 			break;
 		case 269:
 			cmd("vid_width 1920\n");
 			cmd("vid_height 1200\n");
 			break;
 		case 270:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1600\n");
 			break;
 		case 271:
 			cmd("vid_width 3840\n");
 			cmd("vid_height 2400\n");
 			break;
 			/*
 			case 274:
 			cmd("vid_width 2560\n");
 			cmd("vid_height 1080\n");
 			break;
 			case 275:
 			cmd("vid_width 3440\n");
 			cmd("vid_height 1440\n");
 			break;
 			case 276:
 			cmd("vid_width 5120\n");
 			cmd("vid_height 2160\n");
 			break;		
 			*/

 		case 272:
 			menutype = M_TYPE_RESOLUTION;
 			cmd("vid_restart\n");
 			restart_consize();
 			refresh_mouse();
 			break;
 		case 273:
 			string vid_wres_s, vid_wres_s2;
 			vid_wres_s = ftos(vid_wres);
 			vid_wres_s2 = strcat("vid_width ", vid_wres_s, " \n");
 			cmd(vid_wres_s2);
 			string vid_hres_s, vid_hres_s2;
 			vid_hres_s = ftos(vid_hres);
 			vid_hres_s2 = strcat("vid_height ", vid_hres_s, " \n");
 			cmd(vid_hres_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;

 		case 290:
 			float checked6;
 			checked6 = cvar("vid_vsync");
 			if (checked6 == 1)
 				cmd("vid_vsync 0\n");
 			else
 				cmd("vid_vsync 1\n");
 			break;
 		case 291:
 			string bright_s, bright_c;
 			float bright_f;
 			if (brightlev > 0.05)
 				bright_f = brightlev - 0.05;
 			else
 				bright_f = 0.05;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 292:
 			if (brightlev < 2)
 				bright_f = brightlev + 0.05;
 			else
 				bright_f = 2;
 			bright_s = ftos(bright_f);
 			bright_c = strcat("r_hdr_scenebrightness ", bright_s, " \n");
 			cmd(bright_c);
 			break;
 		case 293:
 			string gamma_s, gamma_c;
 			float gamma_f;
 			if (gammalev > 0.05)
 				gamma_f = gammalev - 0.05;
 			else
 				gamma_f = 0.05;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 294:
 			if (gammalev < 2)
 				gamma_f = gammalev + 0.05;
 			else
 				gamma_f = 2;
 			gamma_s = ftos(gamma_f);
 			gamma_c = strcat("v_gamma ", gamma_s, " \n");
 			cmd(gamma_c);
 			break;
 		case 295:
 			string cont_s, cont_c;
 			float cont_f;
 			if (contlev > 0.05)
 				cont_f = contlev - 0.05;
 			else
 				cont_f = 0.05;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 296:
 			if (contlev < 2)
 				cont_f = contlev + 0.05;
 			else
 				cont_f = 2;
 			cont_s = ftos(cont_f);
 			cont_c = strcat("v_contrast ", cont_s, " \n");
 			cmd(cont_c);
 			break;
 		case 297:
 			string fov_s, fov_c;
 			float fov_f;
 			if (fovlev > 80)
 				fov_f = fovlev - 1;
 			else
 				fov_f = 80;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 		case 298:
 			if (fovlev < 100)
 				fov_f = fovlev + 1;
 			else
 				fov_f = 100;
 			fov_s = ftos(fov_f);
 			fov_c = strcat("fov ", fov_s, " \n");
 			cmd(fov_c);
 			break;
 			//////// PIXEL SCALING
 		case 700:
 			cmd("r_viewscale 1\n");
 			break;
 		case 701:
 			cmd("r_viewscale 0.5\n");
 			break;
 		case 702:
 			cmd("r_viewscale 0.333\n");
 			break;
 		case 703:
 			cmd("r_viewscale 0.25\n");
 			break;
 		case 704:
 			cmd("r_viewscale 0.125\n");
 			break;
 			//////// ANISOTROPY FILTERING
 		case 303:
 			cmd("gl_texture_anisotropy 2\n");
 			break;
 		case 304:
 			cmd("gl_texture_anisotropy 4\n");
 			break;
 		case 305:
 			cmd("gl_texture_anisotropy 8\n");
 			break;
 		case 306:
 			cmd("gl_texture_anisotropy 16\n");
 			break;

 			//////// ANTIALIASING
 		case 307:
 			cmd("vid_samples 0\n");
 			break;
 		case 308:
 			cmd("vid_samples 2\n");
 			break;
 		case 309:
 			cmd("vid_samples 4\n");
 			break;
 		case 310:
 			cmd("vid_samples 8\n");
 			break;
 		case 311:
 			menutype = M_TYPE_VIDEO;
 			vid_aalias = cvar("vid_samples");
 			cmd("vid_restart\n");
 			break;
 		case 312:
 			string vid_aalias_s, vid_aalias_s2;
 			vid_aalias_s = ftos(vid_aalias);
 			vid_aalias_s2 = strcat("vid_samples ", vid_aalias_s, " \n");
 			cmd(vid_aalias_s2);
 			menutype = M_TYPE_VIDEO;
 			break;
 		case 314:
 			float checked7;
 			checked7 = cvar("r_fxaa");
 			if (checked7 == 1)
 				cmd("r_fxaa 0\n");
 			else
 				cmd("r_fxaa 1\n");
 			break;
 		case 315:
 			cmd("gl_texturemode gl_nearest\n");
 			cmd("scratch2 0\n");
 			break;
 		case 316:
 			cmd("gl_texturemode gl_nearest_mipmap_linear\n");
 			cmd("scratch2 1\n");
 			break;
 		case 317:
 			cmd("gl_texturemode gl_linear\n");
 			cmd("scratch2 2\n");
 			break;
 		case 318:
 			float checked8;
 			checked8 = cvar("r_mipskins");
 			if (checked8 == 1)
 				cmd("r_mipskins 0\n");
 			else
 				cmd("r_mipskins 1\n");
 			break;
 		case 319:
 			float checked9;
 			checked9 = cvar("r_lerpmodels");
 			if (checked9 == 1)
 				cmd("r_lerpmodels 0\n");
 			else
 				cmd("r_lerpmodels 1\n");
 			break;
 		case 320:
 			float checked10;
 			checked10 = cvar("vid_fullscreen");
 			menutype = M_TYPE_CONFIRMFULLSCREEN;
 			if (checked10 == 1)
 				cmd("vid_fullscreen 0\n");
 			else
 				cmd("vid_fullscreen 1\n");
 			break;
 		case 321:
 			vid_fullscr = cvar("vid_fullscreen");
 			cmd("vid_restart\n");
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 322:
 			string vid_f_s, vid_f_s2;
 			vid_f_s = ftos(vid_fullscr);
 			vid_f_s2 = strcat("vid_fullscreen ", vid_f_s, " \n");
 			cmd(vid_f_s2);
 			menutype = M_TYPE_RESOLUTION;
 			break;
 		case 323:
 			float checked11;
 			checked11 = cvar("r_glsl_postprocess");
 			if (checked11 == 1)
 				cmd("r_glsl_postprocess 0\n");
 			else
 				cmd("r_glsl_postprocess 1\n");
 			break;
 		case 324:
 			float checked12;
 			checked12 = cvar("r_dynamic");
 			if (checked12 == 1)
 				cmd("r_dynamic 0\n");
 			else
 				cmd("r_dynamic 1\n");
 			break;
 	}

 	selected_option = 0;
 };
 void(float alternative) menu_type_confirmbind;

 void() menu_type_confirmresolution;
 void() menu_type_confirmantialias;
 void() menu_type_confirmfullscreen;
 void(vector txt_pos) menu_type_profile;
 void(vector txt_pos) menu_type_main;
 void() menu_type_resume;
 void() menu_type_options;
 void() menu_type_options_controls;
 void() menu_type_options_video;
 void() menu_type_options_resolution;
 void() menu_type_options_audio;
 void() menu_type_options_gameplay;
 void() menu_type_ingame;
 void() menu_type_difficult;

 float clframetime;
 float cltime;
 float slayeralpha;
 float slayerstate;

 void(float a, float b) m_draw = { time = gettime();
 	static float oldtime;
 	cltime = gettime();
 	clframetime = oldtime ? cltime - oldtime : 0.1;
 	oldtime = cltime;

 	if (slayerstate != 1)
 	{
 		if (slayeralpha > 1)
 			slayerstate = 1;

 		slayeralpha += clframetime *0.125;
 	}
 	else
 	{
 		slayeralpha -= clframetime *0.125;
 		if (slayeralpha < 0.1)
 			slayerstate = 0;
 	}

 	float deadmenu;
 	deadmenu = cvar("scratch3");
 	if (deadmenu)
 	{
 		m_hide();
 		return;
 	}

 	vid_x = cvar("vid_conwidth");
 	vid_y = cvar("vid_conheight");

 	/*	if(vid_x / vid_y == 16/9)
 		{*/
 	vx_rel = ((vid_x / 960));
 	vy_rel = ((vid_y / 540));
 	/*	}

 		if(vid_x / vid_y == 4/3)
 		{
 		vx_rel = (vid_x / 960);
 		vy_rel = (vid_y / 640);
 		}

 		if(vid_x / vid_y == 5/3)
 		{
 		vx_rel = (vid_x / 640);
 		vy_rel = (vid_y / 384);
 		}

 		if(vid_x / vid_y == 5/4)
 		{
 		vx_rel = (vid_x / 640);
 		vy_rel = (vid_y / 512);
 		}

 		if(vid_x / vid_y == 16/10)
 		{
 		vx_rel = (vid_x / 640);
 		vy_rel = (vid_y / 400);
 		}

 	*/
 	menuingame = 0;

 	float imgsizex, imgsizey, img2sizex, img2sizey, img3sizex, img3sizey;

 	imgsizex = 256 * vx_rel;
 	imgsizey = 32 * vy_rel;
 	img2sizex = 128 * vx_rel;
 	img2sizey = 32 * vy_rel;
 	img3sizex = 32 * vx_rel;
 	img3sizey = 32 * vy_rel;

 	BTT_FONT_SIZE = fixed_vector('16 16 0');
 	BTT_IMG_SIZE_x = imgsizex;
 	BTT_IMG_SIZE_y = imgsizey;
 	BTT_IMG_SIZE2_x = img2sizex;
 	BTT_IMG_SIZE2_y = img2sizey;
 	BTT_IMG_SIZE3_x = img3sizex;
 	BTT_IMG_SIZE3_y = img3sizey;

 	updateMouse();
 	local float w;
 	if (Menu_Active)
 	{
 		if (getmousetarget() != MT_MENU || getkeydest() != KEY_MENU)
 			m_hide();
 	}

 	if (!Menu_Active)
 		return;

 	local vector size, buttions_locs;
 	size_x = vid_x;
 	size_y = vid_y;
 	buttions_locs_x = ((vid_x / 2) - 128) *vx_rel;
 	buttions_locs_y = 196 * vy_rel;

 	if (clientstate() != CS_CONNECTED)
 	{
 		// Draw the background
 		drawpic('0 0 0', "gfx/conback", size, ' 1 1 1', 1, 0);
 		local vector txt_pos;
 		if (menutype == M_TYPE_SKILL) {}
 		else if (menutype == M_YNQ)
 		{
 			drawfill('0 0 0', vid_x *'1 0 0' + vid_y *'0 1 0', '0 0 0', 0.65, 0);
 			drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '1 1 1', 1, 0);
 			drawpic(fixed_vector('228 64 0'), "gfx/menu/logo.tga", fixed_vector('504 136 0'), '1 1 1', 1, 0);
 			w = stringwidth("Are you sure you want to quit?", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0' - 8 *'0 1 0', "Are you sure you want to quit?", '8 8 0', 1, 0);
 			w = stringwidth("Press ^1Y^7 to quit, ^1N^7!", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0', "Press ^1Y^7 to quit, ^1N^7!", '8 8 0', 1, 0);
 		}
 		else if (menutype == M_TYPE_CREDITS) {}
 		else if (menutype == M_TYPE_HELP) {}
 		else if (menutype == M_TYPE_OPTIONS)
 			menu_type_options();

 		else if (menutype == M_TYPE_SELECT_DIFFICULT)
 			menu_type_difficult();

 		else if (menutype == M_TYPE_AUDIO)
 			menu_type_options_audio();
 		else if (menutype == M_TYPE_CONTROLS)
 			menu_type_options_controls();
 		else if (menutype == M_TYPE_GAMEPLAY)
 			menu_type_options_gameplay();
 		else if (menutype == M_TYPE_VIDEO)
 			menu_type_options_video();
 		else if (menutype == M_TYPE_RESOLUTION)
 			menu_type_options_resolution();
 		else if (menutype == M_TYPE_CONFIRMRESOLUTION)
 			menu_type_confirmresolution();
 		else if (menutype == M_TYPE_CONFIRMBIND)
 			menu_type_confirmbind(0);
 		else if (menutype == M_TYPE_CONFIRMANTIALIAS)
 			menu_type_confirmantialias();
 		else if (menutype == M_TYPE_CONFIRMFULLSCREEN)
 			menu_type_confirmfullscreen();

 		else if (menutype == M_TYPE_RESUME)
 			menu_type_resume();

 		else if (menutype == M_TYPE_PROFILE)
 			menu_type_profile(txt_pos);
 		else
 			menu_type_main(txt_pos);
 	}
 	else
 	{
 		if (menutype == M_TYPE_NONE)
 			zmenuingame = 1;
 		else
 			zmenuingame = 0;

 		if (menutype == M_TYPE_NONE)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			if (!pausesound)
 				cmd("pausesound 1\n");
 			pausesound = 1;

 			menu_type_ingame();
 		}
 		else if (menutype == M_TYPE_DNONE)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			w = stringwidth("Are you sure you returnt to main menu? Not saved progress will be lost", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0' - 8 *'0 1 0', "Are you sure you want to quit2? Not saved progress will be lost", '8 8 0', 1, 0);
 			w = stringwidth("Press ^1Y^7 to quit, ^1N^7!", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0', "Press ^1Y^7 to quit, ^1N^7!", '8 8 0', 1, 0);
 		}
 		else if (menutype == M_TYPE_OPTIONS)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options();
 		}
 		else if (menutype == M_TYPE_AUDIO)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options_audio();
 		}
 		else if (menutype == M_TYPE_CONTROLS)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options_controls();
 		}
 		else if (menutype == M_TYPE_GAMEPLAY)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options_gameplay();
 		}
 		else if (menutype == M_TYPE_VIDEO)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options_video();
 		}
 		else if (menutype == M_TYPE_RESOLUTION)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_options_resolution();
 		}
 		else if (menutype == M_TYPE_CONFIRMRESOLUTION)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_confirmresolution();
 		}
 		else if (menutype == M_TYPE_CONFIRMBIND)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_confirmbind(0);
 		}
 		else if (menutype == M_TYPE_CONFIRMANTIALIAS)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_confirmantialias();
 		}
 		else if (menutype == M_TYPE_CONFIRMFULLSCREEN)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			menu_type_confirmfullscreen();
 		}
 		else if (menutype == M_YND)
 		{
 			drawfill('0 0 0', size, '0 0 0', 0.7, 0);
 			w = stringwidth("Are you sure you want to return to main menu? Not saved progress will be lost", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0' - 8 *'0 1 0', "Are you sure you want to quit3? Not saved progress will be lost", '8 8 0', 1, 0);
 			w = stringwidth("Press ^1Y^7 to quit, ^1N^7!", true, '8 8 0');
 			drawcolorcodedstring((vid_x - w) *'0.5 0 0' + vid_y *'0 0.5 0', "Press ^1Y^7 to quit, ^1N^7!", '8 8 0', 1, 0);
 		}
 	}

 	drawpic(mouse_pos + '16 12 0', "gfx/cursor", '24 24 0', ' 1 1 1', 1, 0);
 };

 void() m_display = { vid_x = cvar("vid_conwidth");
 	vid_y = cvar("vid_conheight");
 	Menu_Active = true;
 	setkeydest(KEY_MENU);
 	setmousetarget(MT_MENU);
 };

 void() m_hide = { if (pausesound)
 	{
 		cmd("pausesound 0\n");
 		pausesound = 0;
 	}

 	menutype = M_TYPE_NONE;
 	zmenuingame = 0;
 	menuingame = 1;
 	Menu_Active = false;
 	setkeydest(KEY_GAME);
 	setmousetarget(MT_CLIENT);
 };

 void(float n) m_toggle = { menutype = M_TYPE_NONE;
 	Menu_Active = n;
 	if (Menu_Active)
 		m_display();
 	else
 		m_hide();
 };

 void() m_shutdown = {};
	///