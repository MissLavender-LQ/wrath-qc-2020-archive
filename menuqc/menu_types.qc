float oldtotalprofileslots;

void(vector txt_pos) menu_type_main = { vector buttions_locs;
	buttions_locs_x = ((vid_x / 2) - (128 *vx_rel));
	buttions_locs_y = 196 * vy_rel;

	txt_pos_x = buttions_locs_x;
	txt_pos_y = 64 * vy_rel;
	drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '1 1 1', 1, 0);
	//drawpic('0 0 0',"gfx/menu/background_layer1.tga" ,vid_x *'1 0 0' + vid_y *'0 1 0', '1 1 1', slayeralpha, 0);

	number_load_selected = 0;
	type_load_selected = 0;

	vector imgpos, imgsize;
	imgpos_x = (vid_x / 960) *228;
	imgpos_y = (vid_y / 540) *64;
	imgsize_x = (vid_x / 960) *504;
	imgsize_y = (vid_y / 540) *136;

	drawpic(imgpos, "gfx/menu/logo.tga", imgsize, '1 1 1', 1, 0);

	buttions_locs_y += 32 * vy_rel;

	local float totalprofileslots;

	//if(oldtotalprofileslots != totalprofileslots)
	totalprofileslots = check_profileslottotal();

	if (totalprofileslots < 10)
	{
		draw_buttionwrath(buttions_locs, "New Game", 1);
		buttions_locs_y += 48 * vy_rel;
	}

	if (profileslot)
	{
		draw_buttionwrath(buttions_locs, "Resume", 2);
		oldprofileslot = 0;
		buttions_locs_y += 48 * vy_rel;
	}

	draw_buttionwrath(buttions_locs, "Options", 10);
	buttions_locs_y += 48 * vy_rel;
	//oldtotalprofileslots = totalprofileslots;
	draw_buttionwrath(buttions_locs, "Quit", 3);
};

void() menu_type_ingame = { vector buttions_locs;
	buttions_locs_x = ((vid_x / 2) - (128 *vx_rel));
	buttions_locs_y = 196 * vy_rel;

	draw_buttionwrath(buttions_locs, "Resume", 43);
	if (oldprofileslot)
		oldprofileslot = 0;
	if (oldtotalprofileslots)
		oldtotalprofileslots = 0;

	buttions_locs_y += 48 * vy_rel;
	draw_buttionwrath(buttions_locs, "Options", 10);
	buttions_locs_y += 48 * vy_rel;

	draw_buttionwrath(buttions_locs, "Quit", 42);
};

void() confirm_profile = { check_profileslot();
	profileslot++;
	profilesammount++;

	write_profileslot();
	check_profilenames();

	write_totalprofileslot();
	if (profileslot == 1)
		profilename1 = gah;
	if (profileslot == 2)
		profilename2 = gah;
	if (profileslot == 3)
		profilename3 = gah;
	if (profileslot == 4)
		profilename4 = gah;
	if (profileslot == 5)
		profilename5 = gah;
	if (profileslot == 6)
		profilename6 = gah;
	if (profileslot == 7)
		profilename7 = gah;
	if (profileslot == 8)
		profilename8 = gah;
	if (profileslot == 9)
		profilename9 = gah;
	if (profileslot == 10)
		profilename10 = gah;
	if (profileslot == 11)
		profilename11 = gah;
	if (profileslot == 12)
		profilename12 = gah;
	write_profilenames();

	if (pausesound)
	{
		cmd("pausedsound 0\n");
		pausesound = 0;
	}

	if (gah)
		strunzone(gah);
	gah = "";
	write_currentprofileslotfirsttime();

};

void() menu_type_options = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;
	if (oldprofileslot)
		oldprofileslot = 0;
	if (oldtotalprofileslots)
		oldtotalprofileslots = 0;

	buttions_locs_x = ((vid_x / 2) - (128 *vx_rel));
	buttions_locs_y = 32 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	draw_fbuttion3(buttions_locs, "OPTIONS");
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "CONTROLS", 11);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "VIDEO", 12);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "DISPLAY RESOLUTION", 18);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "AUDIO", 14);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "GAMEPLAY", 15);
	buttions_locs_y += 56 * vy_rel;
};

void() menu_type_difficult = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;

	buttions_locs_x = ((vid_x / 2) - (128 *vx_rel));
	buttions_locs_y = 32 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	draw_fbuttion3(buttions_locs, "SELECT DIFFICULT");
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "EASY", 45);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "NORMAL", 46);
	buttions_locs_y += 56 * vy_rel;
	draw_buttion(buttions_locs, "HARD", 47);
};

void() menu_type_options_controls = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.25 0.25 0.3', 1, 0);

	buttions_locs_x = ((vid_x / 2) - (128 *vx_rel));
	buttions_locs_y = 8 * vy_rel;

	draw_fbuttion3(buttions_locs, "CONTROL OPTIONS");
	buttions_locs_x -= 322 * vx_rel;
	buttions_locs_y += 32 * vy_rel;

	////////// MOUSE SENSITIVITY
	draw_fbuttion(buttions_locs, "Mouse Sensitivity");
	buttions_locs_x += 256 * vx_rel;
	draw_buttion(buttions_locs, "<", 101);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 102);

	buttions_locs_x -= 145 * vx_rel;
	buttions_locs_y += 16 * vy_rel;

	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	senm = cvar("sensitivity");
	local vector barpos;
	barpos = buttions_locs - fixed_vector('28 0 0');
	barpos_y -= 8 * vy_rel;
	barpos_x += senm *28 * vx_rel;
	drawfill(barpos, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	buttions_locs_x -= 401 * vx_rel;	// back to the x pos
	buttions_locs_y += 28 * vy_rel;

	////////// MOUSE ACCELERATION
	draw_fbuttion(buttions_locs, "Mouse Acceleration");
	buttions_locs_x += 256 * vx_rel;
	draw_buttion(buttions_locs, "<", 103);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 104);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	acel = cvar("m_accelerate");
	local vector barpos2;
	barpos2 = buttions_locs - fixed_vector('28 0 0');
	barpos2_y -= 8 * vy_rel;
	barpos2_x += (acel *25.5 + 25.5) *vx_rel;
	drawfill(barpos2, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	buttions_locs_x -= 401 * vx_rel;	// back to the x pos
	buttions_locs_y += 28 * vy_rel;

	////////// MOUSE SMOOTHING
	draw_fbuttion(buttions_locs, "Mouse Smoothing");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked;
	string mark;
	checked = cvar("m_filter");
	if (checked == 1)
		mark = "x";
	else
		mark = " ";
	draw_buttion(buttions_locs, mark, 105);
	buttions_locs_x -= 320 * vx_rel;
	buttions_locs_y += 28 * vy_rel;

	////////// MOUSE INVERT
	draw_fbuttion(buttions_locs, "Invert Mouse");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked2;
	string mark2;
	checked2 = cvar("m_pitch");
	if (checked2 <= -0.022)
		mark2 = "x";
	else
		mark2 = " ";
	draw_buttion(buttions_locs, mark2, 106);
	//	buttions_locs_x -= 320 * vx_rel;
	//	buttions_locs_y +=  28 * vy_rel;

	////////// BIND KEYS
	buttions_locs_x = (vid_x / 2) - 128 * vx_rel;
	buttions_locs_y += 32 * vy_rel;

	draw_fbuttion3(buttions_locs, "Customize Keys");
	buttions_locs_y += 32 * vy_rel;
	buttions_locs_x -= 360 * vx_rel;

	float buttion_y = buttions_locs_y;
	float buttion_x = buttions_locs_x + (64 *vx_rel);

	////////////
	draw_fbuttionsmall(buttions_locs, "Move Forward", 500);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+forward", 0));
	if (argv(0) != "-1")
		string fw_key1 = keynumtostring(stof(argv(0)));
	else
		fw_key1 = " ";
	draw_buttion(buttions_locs, fw_key1, 500);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Move backward", 501);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+back", 0));
	if (argv(0) != "-1")
		string fw_key2 = keynumtostring(stof(argv(0)));
	else
		fw_key2 = " ";
	draw_buttion(buttions_locs, fw_key2, 501);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	////////////
	draw_fbuttionsmall(buttions_locs, "Move Left", 502);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+moveleft", 0));
	if (argv(0) != "-1")
		string fw_key3 = keynumtostring(stof(argv(0)));
	else
		fw_key3 = " ";
	draw_buttion(buttions_locs, fw_key3, 502);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	////////////
	draw_fbuttionsmall(buttions_locs, "Move Right", 503);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+moveright", 0));
	if (argv(0) != "-1")
		string fw_key4 = keynumtostring(stof(argv(0)));
	else
		fw_key4 = " ";
	draw_buttion(buttions_locs, fw_key4, 503);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	////////////
	draw_fbuttionsmall(buttions_locs, "Fire", 504);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+attack", 0));
	if (argv(0) != "-1")
		string fw_key5 = keynumtostring(stof(argv(0)));
	else
		fw_key5 = " ";
	draw_buttion(buttions_locs, fw_key5, 504);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Alt Fire", 505);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+button3", 0));
	if (argv(0) != "-1")
		string fw_key6 = keynumtostring(stof(argv(0)));
	else
		fw_key6 = " ";
	draw_buttion(buttions_locs, fw_key6, 505);
	buttions_locs += fixed_vector('-128 33 0');
	////////////

	draw_fbuttionsmall(buttions_locs, "Inventory", 506);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+button6", 0));
	if (argv(0) != "-1")
		string fw_key7 = keynumtostring(stof(argv(0)));
	else
		fw_key7 = " ";
	draw_buttion(buttions_locs, fw_key7, 506);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Jump", 507);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+jump", 0));
	if (argv(0) != "-1")
		string fw_key8 = keynumtostring(stof(argv(0)));
	else
		fw_key8 = " ";
	draw_buttion(buttions_locs, fw_key8, 507);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Crouch", 508);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+button4", 0));
	if (argv(0) != "-1")
		string fw_key9 = keynumtostring(stof(argv(0)));
	else
		fw_key9 = " ";
	draw_buttion(buttions_locs, fw_key9, 508);
	////////////

	buttions_locs_x += 170 * vx_rel;
	buttions_locs_y = buttion_y;

	draw_fbuttionsmall(buttions_locs, "Ruination Blade", 509);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 1", 0));
	if (argv(0) != "-1")
		string fw_key10 = keynumtostring(stof(argv(0)));
	else
		fw_key10 = " ";
	draw_buttion(buttions_locs, fw_key10, 509);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Coachgun", 510);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 2", 0));
	if (argv(0) != "-1")
		string fw_key11 = keynumtostring(stof(argv(0)));
	else
		fw_key11 = " ";
	draw_buttion(buttions_locs, fw_key11, 510);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Shotgun", 511);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 3", 0));
	if (argv(0) != "-1")
		string fw_key12 = keynumtostring(stof(argv(0)));
	else
		fw_key12 = " ";
	draw_buttion(buttions_locs, fw_key12, 511);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Fang Spitter", 512);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 4", 0));
	if (argv(0) != "-1")
		string fw_key14 = keynumtostring(stof(argv(0)));
	else
		fw_key14 = " ";
	draw_buttion(buttions_locs, fw_key14, 512);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Retcher", 513);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 5", 0));
	if (argv(0) != "-1")
		string fw_key15 = keynumtostring(stof(argv(0)));
	else
		fw_key15 = " ";
	draw_buttion(buttions_locs, fw_key15, 513);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Slag Cannon", 514);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 6", 0));
	if (argv(0) != "-1")
		string fw_key16 = keynumtostring(stof(argv(0)));
	else
		fw_key16 = " ";
	draw_buttion(buttions_locs, fw_key16, 514);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	/*
	draw_fbuttionsmall(buttions_locs, "Artifact Inventory",515);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 7",0));
	if(argv(0) != "-1")
	string fw_key17 = keynumtostring (stof(argv(0)));
	else
	fw_key17 = " ";	
	draw_buttion(buttions_locs, fw_key17, 515);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Artifact Inventory",516);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 8",0));
	if(argv(0) != "-1")
	string fw_key18 = keynumtostring (stof(argv(0)));
	else
	fw_key18 = " ";	
	draw_buttion(buttions_locs, fw_key18, 516);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Artifact Inventory",517);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 9",0));
	if(argv(0) != "-1")
	string fw_key19 = keynumtostring (stof(argv(0)));
	else
	fw_key19 = " ";	
	draw_buttion(buttions_locs, fw_key19, 517);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	*/
	draw_fbuttionsmall(buttions_locs, "Use", 518);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+button5", 0));
	if (argv(0) != "-1")
		string fw_key20 = keynumtostring(stof(argv(0)));
	else
		fw_key20 = " ";
	draw_buttion(buttions_locs, fw_key20, 518);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Journal", 519);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 35", 0));
	if (argv(0) != "-1")
		string fw_key21 = keynumtostring(stof(argv(0)));
	else
		fw_key21 = " ";
	draw_buttion(buttions_locs, fw_key21, 519);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Use Artifact", 520);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 15", 0));
	if (argv(0) != "-1")
		string fw_key22 = keynumtostring(stof(argv(0)));
	else
		fw_key22 = " ";
	draw_buttion(buttions_locs, fw_key22, 520);
	//	buttions_locs += fixed_vector('-128 33 0');
	////////////
	buttions_locs_y = buttion_y;
	buttions_locs_x += (170 *vx_rel);

	draw_fbuttionsmall(buttions_locs, "Walk", 526);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+button7", 0));
	if (argv(0) != "-1")
		string fw_key28 = keynumtostring(stof(argv(0)));
	else
		fw_key28 = " ";
	draw_buttion(buttions_locs, fw_key28, 526);
	buttions_locs += fixed_vector('-128 33 0');
	////////////	
	draw_fbuttionsmall(buttions_locs, "Swim Up", 521);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+moveup", 0));
	if (argv(0) != "-1")
		string fw_key23 = keynumtostring(stof(argv(0)));
	else
		fw_key23 = " ";
	draw_buttion(buttions_locs, fw_key23, 521);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Swim Down", 522);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("+movedown", 0));
	if (argv(0) != "-1")
		string fw_key24 = keynumtostring(stof(argv(0)));
	else
		fw_key24 = " ";
	draw_buttion(buttions_locs, fw_key24, 522);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Last Weapon", 523);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 57", 0));
	if (argv(0) != "-1")
		string fw_key25 = keynumtostring(stof(argv(0)));
	else
		fw_key25 = " ";
	draw_buttion(buttions_locs, fw_key25, 523);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Prev Weapon", 524);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 55", 0));
	if (argv(0) != "-1")
		string fw_key26 = keynumtostring(stof(argv(0)));
	else
		fw_key26 = " ";
	draw_buttion(buttions_locs, fw_key26, 524);
	buttions_locs += fixed_vector('-128 33 0');
	////////////
	draw_fbuttionsmall(buttions_locs, "Next Weapon", 525);
	buttions_locs_x += 128 * vx_rel;
	tokenize(findkeysforcommand("impulse 56", 0));
	if (argv(0) != "-1")
		string fw_key27 = keynumtostring(stof(argv(0)));
	else
		fw_key27 = " ";
	draw_buttion(buttions_locs, fw_key27, 525);
	buttions_locs += fixed_vector('-128 33 0');
};

void(float alternative) menu_type_confirmbind = { local vector buttions_locs;
	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);

	buttions_locs_y = 172 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	buttions_locs_x += 128 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-256 -32 0'), fixed_vector('464 128 0'), '0.2 0.2 0.23', 0.7, 0);
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);
	buttions_locs_x -= 148 * vx_rel;

	string localkey;

	if (gkcommand == 1) localkey = "+forward";
	if (gkcommand == 2) localkey = "+back";
	if (gkcommand == 3) localkey = "+moveleft";
	if (gkcommand == 4) localkey = "+moveright";
	if (gkcommand == 5) localkey = "+attack";
	if (gkcommand == 6) localkey = "+button3";
	if (gkcommand == 7) localkey = "+button6";
	if (gkcommand == 8) localkey = "+jump";
	if (gkcommand == 9) localkey = "+button4";	//crouch
	if (gkcommand == 10) localkey = "select blade";
	if (gkcommand == 11) localkey = "select coachgun";
	if (gkcommand == 12) localkey = "select shotgun";
	if (gkcommand == 13) localkey = "select fang spitter";
	if (gkcommand == 14) localkey = "select retcher";
	if (gkcommand == 15) localkey = "select slagcannon";
	//	if (gkcommand == 16) localkey =  "\"impulse 7\""
	//	if (gkcommand == 17) localkey =  "\"impulse 8\""
	//	if (gkcommand == 18) localkey = "\"impulse 9\""
	if (gkcommand == 19) localkey = "use";	//use
	if (gkcommand == 20) localkey = "journal";	//journal
	if (gkcommand == 21) localkey = "use artifact";	//artifact
	if (gkcommand == 22) localkey = "+moveup";
	if (gkcommand == 23) localkey = "+movedown";
	if (gkcommand == 24) localkey = "last weapon";
	if (gkcommand == 25) localkey = "previous weapon";
	if (gkcommand == 26) localkey = "next weapon";
	if (gkcommand == 27) localkey = "walk";

	buttions_locs_y -= 24 * vy_rel;
	draw_fbuttion3(buttions_locs, localkey);
	buttions_locs_y += 24 * vy_rel;

	draw_fbuttion(buttions_locs, "PRESS A KEY");

	buttions_locs_x += 148 * vx_rel;
	buttions_locs_y += 48 * vy_rel;
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);

	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CANCEL", 11);

	if (gkcommand == 1) localkey = "+forward";
	if (gkcommand == 2) localkey = "+back";
	if (gkcommand == 3) localkey = "+moveleft";
	if (gkcommand == 4) localkey = "+moveright";
	if (gkcommand == 5) localkey = "+attack";
	if (gkcommand == 6) localkey = "+button3";
	if (gkcommand == 7) localkey = "+button6";
	if (gkcommand == 8) localkey = "+jump";
	if (gkcommand == 9) localkey = "+button4";	//crouch
	if (gkcommand == 10) localkey = "\"impulse 1\"";
	if (gkcommand == 11) localkey = "\"impulse 2\"";
	if (gkcommand == 12) localkey = "\"impulse 3\"";
	if (gkcommand == 13) localkey = "\"impulse 4\"";
	if (gkcommand == 14) localkey = "\"impulse 5\"";
	if (gkcommand == 15) localkey = "\"impulse 6\"";
	if (gkcommand == 16) localkey = "\"impulse 7\"";
	if (gkcommand == 17) localkey = "\"impulse 8\"";
	if (gkcommand == 18) localkey = "\"impulse 9\"";
	if (gkcommand == 19) localkey = "+button5";	//use
	if (gkcommand == 20) localkey = "\"impulse 35\"";	//journal
	if (gkcommand == 21) localkey = "\"impulse 15\"";	//artifact
	if (gkcommand == 22) localkey = "+moveup";
	if (gkcommand == 23) localkey = "+movedown";
	if (gkcommand == 24) localkey = "\"impulse 57\"";
	if (gkcommand == 25) localkey = "\"impulse 55\"";
	if (gkcommand == 26) localkey = "\"impulse 56\"";
	if (gkcommand == 26) localkey = "+button7";

	tokenize((findkeysforcommand(localkey, 0)));

	argv1 = stof(argv(0));
	argv2 = stof(argv(1));
	argv3 = stof(argv(2));
	argv4 = stof(argv(3));

};

void() menu_type_options_gameplay = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);

	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);
	buttions_locs_y = 32 * vy_rel;

	draw_fbuttion3(buttions_locs, "GAMEPLAY OPTIONS");
	buttions_locs_x -= 322 * vx_rel;
	buttions_locs_y += 32 * vy_rel;

	////////// SRAFE TILTING
	draw_fbuttion(buttions_locs, "Strafe Tilting");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked;
	string mark;
	checked = cvar("cl_rollangle");
	if (checked == 2)
		mark = "x";
	else
		mark = " ";
	draw_buttion(buttions_locs, mark, 107);
	buttions_locs_x -= 320 * vx_rel;
	buttions_locs_y += 28 * vy_rel;

	////////// VIEW BOBBING
	draw_fbuttion(buttions_locs, "View Bobbing");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked2;
	string mark2;
	checked2 = cvar("cl_bob");
	if (checked2 >= 0.005)
		mark2 = "x";
	else
		mark2 = " ";
	draw_buttion(buttions_locs, mark2, 108);
	buttions_locs_x -= 320 * vx_rel;
	buttions_locs_y += 28 * vy_rel;

	////////// CROSSHAIR
	draw_fbuttion(buttions_locs, "Crosshair");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked3;
	string mark3;
	checked3 = cvar("scratch1");
	if (checked3 == 0)
		mark3 = "x";
	else
		mark3 = " ";
	draw_buttion(buttions_locs, mark3, 109);
	buttions_locs_x -= 320 * vx_rel;
	buttions_locs_y += 28 * vy_rel;

};
void() menu_type_options_audio = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);

	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);
	buttions_locs_y = 32 * vy_rel;

	draw_fbuttion3(buttions_locs, "AUDIO OPTIONS");

	////////// MASTER VOLUME
	buttions_locs_y += 32 * vy_rel;
	buttions_locs_x -= 322 * vx_rel;
	draw_fbuttion(buttions_locs, "Master Volume");
	buttions_locs_x += 256 * vx_rel;
	draw_buttion(buttions_locs, "<", 201);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 202);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	mvol = cvar("mastervolume");
	local vector barpos;
	barpos = buttions_locs - fixed_vector('0 0 0');
	barpos_y -= 8 * vy_rel;
	barpos_x += mvol *(256 *vx_rel);
	drawfill(barpos, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	////////// EFFECTS VOLUME
	buttions_locs_x -= 401 * vx_rel;	// back to the x pos
	buttions_locs_y += 28 * vy_rel;
	draw_fbuttion(buttions_locs, "Effects Volume");
	buttions_locs_x += 256 * vx_rel;
	draw_buttion(buttions_locs, "<", 203);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 204);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	effvol = cvar("volume");
	local vector barpos2;
	barpos2 = buttions_locs - fixed_vector('0 0 0');
	barpos2_y -= 8 * vy_rel;
	barpos2_x += effvol *256 * vx_rel;
	drawfill(barpos2, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	////////// MUSIC VOLUME
	buttions_locs_x -= 401 * vx_rel;	// back to the x pos
	buttions_locs_y += 28 * vy_rel;
	draw_fbuttion(buttions_locs, "Music Volume");
	buttions_locs_x += 256 * vx_rel;
	draw_buttion(buttions_locs, "<", 205);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 206);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	bgmvol = cvar("bgmvolume");
	local vector barpos3;
	barpos3 = buttions_locs - fixed_vector('0 0 0');
	barpos3_y -= 8 * vy_rel;
	barpos3_x += bgmvol *256 * vx_rel;
	drawfill(barpos3, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	buttions_locs_x -= 401 * vx_rel;	// back to the x pos
	buttions_locs_y += 28 * vy_rel;
};

void() menu_type_confirmresolution = { local vector buttions_locs;
	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);

	buttions_locs_y = 172 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	buttions_locs_x += 128 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-256 -32 0'), fixed_vector('464 128 0'), '0.2 0.2 0.23', 0.7, 0);
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);
	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CONFIRM RESOLUTION", 272);

	buttions_locs_x += 148 * vx_rel;
	buttions_locs_y += 48 * vy_rel;
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);

	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CANCEL", 273);
};

void() menu_type_confirmfullscreen = { local vector buttions_locs;
	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);

	buttions_locs_y = 172 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	buttions_locs_x += 128 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-256 -32 0'), fixed_vector('464 128 0'), '0.2 0.2 0.23', 0.7, 0);
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);
	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CONFIRM", 321);

	buttions_locs_x += 148 * vx_rel;
	buttions_locs_y += 48 * vy_rel;
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);

	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CANCEL", 322);
};

void() menu_type_confirmantialias = { local vector buttions_locs;
	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);

	buttions_locs_y = 172 * vy_rel;
	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	buttions_locs_x += 128 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-256 -32 0'), fixed_vector('464 128 0'), '0.2 0.2 0.23', 0.7, 0);
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);
	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CONFIRM", 311);

	buttions_locs_x += 148 * vx_rel;
	buttions_locs_y += 48 * vy_rel;
	drawfill(buttions_locs + fixed_vector('-200 4 0'), fixed_vector('380 32 0'), '0.1 0.1 0.1', 0.7, 0);

	buttions_locs_x -= 148 * vx_rel;
	draw_buttion(buttions_locs, "CANCEL", 312);
};

void() menu_type_options_resolution = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;

	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);

	buttions_locs_y = 32 * vy_rel;

	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	//	buttions_locs_x -= 180* vx_rel;

	draw_fbuttion3(buttions_locs, "DISPLAY RESOLUTION");
	buttions_locs_x -= 360 * vx_rel;

	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "4:3");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1280 * 960", 250);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1360 * 1024", 251);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1600 * 1200", 252);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1920 * 1440", 253);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "2560 * 1920", 254);
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "5:3");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1280 * 768", 255);
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "5:4");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1280 * 1024", 256);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1600 * 1280", 257);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "2560 * 2048", 258);
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "16:9");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1280 * 720", 259);
	//	buttions_locs_y += 32 * vy_rel;

	buttions_locs_y = 64 * vy_rel;
	buttions_locs_x += 250 * vx_rel;
	draw_fbuttion(buttions_locs, "16:9");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1360 * 768", 260);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1366 * 768", 261);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1600 * 900", 262);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1680 * 1050", 263);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1920 * 1080", 264);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "2560 * 1440", 265);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "3840 * 2160", 266);
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "16:10");
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1280 * 800", 267);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1440 * 900", 268);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "1920 * 1200", 269);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "2560 * 1600", 270);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "3840 * 2400", 271);

	/*buttions_locs_y = 64* vy_rel;
	buttions_locs_x += 250* vx_rel;

	draw_fbuttion(buttions_locs, "21:9");

	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "2560 * 1080", 274);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "3440 * 1440", 275);
	buttions_locs_y += 32 * vy_rel;
	draw_buttion(buttions_locs, "5120* 2160", 276);
	buttions_locs_y += 32 * vy_rel;
	buttions_locs_y += 32 * vy_rel;

	buttions_locs_x -= 250* vx_rel;
	*/

	////////// Fullscreen
	buttions_locs_y = 64 * vy_rel;
	buttions_locs_x += 250 * vx_rel;

	draw_fbuttion(buttions_locs, "Fullscreen");
	buttions_locs_x += 246 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked7;
	string anim_mark;
	checked7 = cvar("vid_fullscreen");
	if (checked7 == 1)
		anim_mark = "x";
	else
		anim_mark = " ";
	draw_buttion(buttions_locs, anim_mark, 320);
	buttions_locs_x -= 256 * vx_rel;

};

void() menu_type_options_video = { local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;

	buttions_locs_x = (vid_x / 2) - (128 *vx_rel);
	buttions_locs_y = 32 * vy_rel;

	if (clientstate() != CS_CONNECTED)
		drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);

	draw_fbuttion3(buttions_locs, "VIDEO OPTIONS");
	buttions_locs_x -= 360 * vx_rel;
	buttions_locs_y = 64;
	////////// V_SYNC
	draw_fbuttion(buttions_locs, "V-Sync");
	buttions_locs_x += 320 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked;
	string mark;
	checked = cvar("vid_vsync");
	if (checked == 1)
		mark = "x";
	else
		mark = " ";
	draw_buttion(buttions_locs, mark, 290);
	buttions_locs_x -= 320 * vx_rel;

	////////// BRIGHTNESS
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "Brightness");
	buttions_locs_x += 96 * vx_rel;	//
	draw_buttion(buttions_locs, "<", 291);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 292);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	brightlev = cvar("r_hdr_scenebrightness");
	local vector barpos1;
	barpos1 = buttions_locs - '14 0 0';
	barpos1_y -= 8 * vy_rel;
	barpos1_x += brightlev *133 * vx_rel;
	drawfill(barpos1, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	//	string bbri;bbri = ftos (brightlev);draw_fbuttion2(barpos1 + '-128.5 -24 0', bbri);
	buttions_locs_x -= 241 * vx_rel;	// back to the x pos

	////////// GAMMA
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "gamma");
	buttions_locs_x += 96 * vx_rel;	//
	draw_buttion(buttions_locs, "<", 293);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 294);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	gammalev = cvar("v_gamma");
	local vector barpos2;
	barpos2 = buttions_locs - fixed_vector('14 0 0');
	barpos2_y -= 8 * vy_rel;
	barpos2_x += gammalev *133 * vx_rel;
	drawfill(barpos2, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	//	string bgam;bgam = ftos (gammalev);draw_fbuttion2(barpos2 + '-128.5 -24 0', bgam);
	buttions_locs_x -= 241 * vx_rel;	// back to the x pos

	////////// CONTRAST
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "contrast");
	buttions_locs_x += 96 * vx_rel;	//
	draw_buttion(buttions_locs, "<", 295);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 296);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	contlev = cvar("v_contrast");
	local vector barpos3;
	barpos3 = buttions_locs - fixed_vector('14 0 0');
	barpos3_y -= 8 * vy_rel;
	barpos3_x += contlev *133 * vx_rel;
	drawfill(barpos3, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	//	string bcon;bcon = ftos (contlev);draw_fbuttion2(barpos3 + fixed_vector('-128.5 -24 0'), bcon);
	buttions_locs_x -= 241 * vx_rel;	// back to the x pos	

	////////// FOV
	buttions_locs_y += 32 * vy_rel;
	draw_fbuttion(buttions_locs, "fov");
	buttions_locs_x += 96 * vx_rel;	//
	draw_buttion(buttions_locs, "<", 297);
	buttions_locs_x += 290 * vx_rel;
	draw_buttion(buttions_locs, ">", 298);
	buttions_locs_y += 16 * vy_rel;
	buttions_locs_x -= 145 * vx_rel;
	drawfill(buttions_locs, fixed_vector('256 4 0'), '0.5 0.5 0.35', 0.7, 0);
	fovlev = cvar("fov");
	float fovlev_v;
	fovlev_v = (fovlev - 80) / 10;
	local vector barpos4;
	barpos4 = buttions_locs - fixed_vector('14 0 0');
	barpos4_y -= 8 * vy_rel;
	barpos4_x += fovlev_v *133 * vx_rel;
	drawfill(barpos4, fixed_vector('4 16 0'), '0.75 0.75 0.5', 1, 0);
	string bdesc;bdesc = ftos(fovlev);draw_fbuttion2(barpos4 + fixed_vector('-128.5 -24 0'), bdesc);
	buttions_locs_x -= 241 * vx_rel;	// back to the x pos		

	////////// PIXEL SCALING
	buttions_locs_x += 32 * vx_rel;	//
	buttions_locs_y += 48 * vy_rel;
	draw_fbuttion(buttions_locs, "pixel scaling");

	float checked2;
	string mark2, mark3, mark4, mark5, mark6;
	string pxelscale;

	checked2 = cvar("r_viewscale");
	if (checked2 == 1)
	{
		mark2 = "x";
		pxelscale = "native";
	}
	else
		mark2 = " ";
	if (checked2 == 0.5)
	{
		mark3 = "x";
		pxelscale = "double";
	}
	else
		mark3 = " ";
	if (checked2 == 0.333)
	{
		mark4 = "x";
		pxelscale = "triple";
	}
	else
		mark4 = " ";
	if (checked2 == 0.25)
	{
		mark5 = "x";
		pxelscale = "quadruple";
	}
	else
		mark5 = " ";
	if (checked2 == 0.125)
	{
		mark6 = "x";
		pxelscale = "octuple";
	}
	else
		mark6 = " ";

	buttions_locs_x += 196 * vx_rel;	//
	buttions_locs_y -= 18 * vy_rel;	//
	draw_fbuttion2(buttions_locs, pxelscale);
	buttions_locs_x -= 32 * vx_rel;
	buttions_locs_y += 18 * vy_rel;	//
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, mark2, 700);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, mark3, 701);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, mark4, 702);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, mark5, 703);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, mark6, 704);

	buttions_locs_x -= 322 * vx_rel;	// back to the x pos	
	//////// ANISOTROPY FILTERING	
	buttions_locs_x += 32 * vx_rel;	//
	buttions_locs_y += 48 * vy_rel;

	draw_fbuttion(buttions_locs, "ANISOTROPY");

	float checked3;
	string anysotrop_mark2, anysotrop_mark3, anysotrop_mark4, anysotrop_mark5;
	string anysotropicale;

	checked3 = cvar("gl_texture_anisotropy");
	if (checked3 == 2)
	{
		anysotrop_mark2 = "x";
		anysotropicale = "2X";
	}
	else
		anysotrop_mark2 = " ";
	if (checked3 == 4)
	{
		anysotrop_mark3 = "x";
		anysotropicale = "4X";
	}
	else
		anysotrop_mark3 = " ";
	if (checked3 == 8)
	{
		anysotrop_mark4 = "x";
		anysotropicale = "8X";
	}
	else
		anysotrop_mark4 = " ";
	if (checked3 == 16)
	{
		anysotrop_mark5 = "x";
		anysotropicale = "16X";
	}
	else
		anysotrop_mark5 = " ";

	buttions_locs_x += 196 * vx_rel;	//
	buttions_locs_y -= 18 * vy_rel;	//
	draw_fbuttion2(buttions_locs, anysotropicale);
	buttions_locs_x -= 32 * vx_rel;
	buttions_locs_y += 18 * vy_rel;	//
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, anysotrop_mark2, 303);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, anysotrop_mark3, 304);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, anysotrop_mark4, 305);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, anysotrop_mark5, 306);
	buttions_locs_x -= 322 * vx_rel;	// back to the x pos	

	//////// ANTI-ALIASING	
	buttions_locs_x += 32 * vx_rel;	//
	buttions_locs_y += 48 * vy_rel;

	draw_fbuttion(buttions_locs, "Anti-aliasing MSAA");
	float checked4;
	string antialias_mark2, antialias_mark3, antialias_mark4, antialias_mark5;
	string antialiasing;

	checked4 = cvar("vid_samples");
	if (checked4 < 2)
	{
		antialias_mark2 = "x";
		antialiasing = "Off";
	}
	else
		antialias_mark2 = " ";
	if (checked4 == 2)
	{
		antialias_mark3 = "x";
		antialiasing = "2X";
	}
	else
		antialias_mark3 = " ";
	if (checked4 == 4)
	{
		antialias_mark4 = "x";
		antialiasing = "4X";
	}
	else
		antialias_mark4 = " ";
	if (checked4 == 8)
	{
		antialias_mark5 = "x";
		antialiasing = "8X";
	}
	else
		antialias_mark5 = " ";

	buttions_locs_x += 196 * vx_rel;	//
	buttions_locs_y -= 18 * vy_rel;	//
	draw_fbuttion2(buttions_locs, antialiasing);
	buttions_locs_x -= 32 * vx_rel;
	buttions_locs_y += 18 * vy_rel;	//
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, antialias_mark2, 307);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, antialias_mark3, 308);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, antialias_mark4, 309);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, antialias_mark5, 310);
	buttions_locs_x -= 322 * vx_rel;	// back to the x pos	
	////////// Anti-aliasing FXAA
	buttions_locs_x += 32 * vx_rel;	//
	buttions_locs_y += 48 * vy_rel;

	draw_fbuttion(buttions_locs, "Anti-aliasing FXAA");
	buttions_locs_x += 290 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked5;
	string antialias_mark6;
	checked5 = cvar("r_fxaa");
	if (checked5 == 1)
		antialias_mark6 = "x";
	else
		antialias_mark6 = " ";
	draw_buttion(buttions_locs, antialias_mark6, 314);
	//	buttions_locs_x -= 352* vx_rel;	

	////////// Anti-aliasing FXAA
	buttions_locs_x += 196 * vx_rel;
	buttions_locs_y = 96 * vy_rel;
	float texturemodef;
	string texturemode;
	string text_mark2, text_mark3, text_mark4;

	texturemodef = cvar("scratch2");

	if (texturemodef == 0)
		texturemode = "None";
	if (texturemodef == 1)
		texturemode = "None + Linear Maps";
	if (texturemodef == 2)
		texturemode = "Linear";

	draw_fbuttion(buttions_locs, "Texture Filter");
	checked5 = cvar("scratch2");
	if (checked5 < 1)
	{
		text_mark2 = "x";
		texturemode = "None";
	}
	else
		antialias_mark2 = " ";
	if (checked5 == 1)
	{
		text_mark3 = "x";
		texturemode = " Linear Mips";
	}
	else
		antialias_mark3 = " ";
	if (checked5 == 2)
	{
		text_mark4 = "x";
		texturemode = "Linear";
	}
	else
		text_mark4 = " ";
	buttions_locs_y -= 18 * vy_rel;
	buttions_locs_x += 170 * vx_rel;
	draw_fbuttion2(buttions_locs, texturemode);
	buttions_locs_y += 18 * vy_rel;
	//	buttions_locs_x -= 128* vx_rel;

	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, text_mark2, 315);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, text_mark3, 316);
	buttions_locs_x += 42 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	draw_buttion(buttions_locs, text_mark4, 317);
	buttions_locs_x -= 254 * vx_rel;

	/*
	////////// MipMap Models 
	buttions_locs_y += 48* vy_rel;

	draw_fbuttion(buttions_locs, "MipMap Models");
	buttions_locs_x += 256* vx_rel;
	drawfill (buttions_locs +fixed_vector('118 10 0'),fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked6;
	string mipmap_mark;
	checked6 = cvar ("r_mipskins");
	if (checked6 == 1)
	mipmap_mark = "x";
	else
	mipmap_mark = " ";		
	draw_buttion(buttions_locs, mipmap_mark, 318);
	buttions_locs_x -= 256* vx_rel;
	*/
	////////// Animation Interpolation
	buttions_locs_y += 48 * vy_rel;
	buttions_locs_x += 10 * vx_rel;

	draw_fbuttion(buttions_locs, "Anim. Interpolation");
	buttions_locs_x += 246 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked7;
	string anim_mark;
	checked7 = cvar("r_lerpmodels");
	if (checked7 == 1)
		anim_mark = "x";
	else
		anim_mark = " ";
	draw_buttion(buttions_locs, anim_mark, 319);
	buttions_locs_x -= 256 * vx_rel;
	////////// Palettized 
	buttions_locs_y += 48 * vy_rel;
	buttions_locs_x += 10 * vx_rel;

	draw_fbuttion(buttions_locs, "software palettization");
	buttions_locs_x += 246 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked7;
	string anim_mark;
	checked7 = cvar("r_glsl_postprocess");
	if (checked7 == 1)
		anim_mark = "x";
	else
		anim_mark = " ";
	draw_buttion(buttions_locs, anim_mark, 323);
	buttions_locs_x -= 256 * vx_rel;
	////////// Real Time Lights
	buttions_locs_y += 48 * vy_rel;

	draw_fbuttion(buttions_locs, "Dynamic Lights");
	buttions_locs_x += 256 * vx_rel;
	drawfill(buttions_locs + fixed_vector('118 10 0'), fixed_vector('20 20 0'), '0.35 0.35 0.35', 0.7, 0);
	float checked8;
	string mipmap_mark;
	checked8 = cvar("r_dynamic");
	if (checked8 == 1)
		mipmap_mark = "x";
	else
		mipmap_mark = " ";
	draw_buttion(buttions_locs, mipmap_mark, 324);
	buttions_locs_x -= 256 * vx_rel;
	////////// 
};
string string_null;

void(vector txt_pos) menu_type_profile = { vector buttions_locs;
	buttions_locs_x = ((vid_x / 2) - (70 *vx_rel));
	buttions_locs_y = 216 * vy_rel;

	drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);
	buttions_locs_x += 128 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-256 -32 0'), fixed_vector('384 96 0'), '0.2 0.2 0.23', 0.7, 0);
	buttions_locs_x -= 100 * vx_rel;
	drawfill(buttions_locs + fixed_vector('154 4 0'), fixed_vector('48 32 0'), '0.5 0.3 0.3', 0.7, 0);
	buttions_locs_x += 100 * vx_rel;
	drawfill(buttions_locs + fixed_vector('-230 4 0'), fixed_vector('242 24 0'), '0.1 0.1 0.1', 0.7, 0);
	buttions_locs_x -= 48 * vx_rel;

	if (oldprofileslot)
		oldprofileslot = 0;
	if (oldtotalprofileslots)
		oldtotalprofileslots = 0;

	local float f, nameused;	// file handle, basically assigns a number to whatever file is open
	local string ln;	// ln = line of the file being read
	f = fopen("profiles/profilenames.txt", FILE_READ);
	if (f != -1)	// if f = -1 then the file could not be found
	{
		ln = fgets(f);	// this line sets ln to the string read from the file with the file handle of f
		while (ln != string_null)	// while there is still text to be read do the following
		{
			{
				if (ln == gah)
				{
					fclose(f);	// when the while loop is over (no lines left in file) close file with the handle f
					nameused = 1;
				}
			}

			ln = fgets(f);	// get a new line from the file
		}
	}

	fclose(f);	// when the while loop is over (no lines left in file) close file with the handle f

	if ((gah != "") && (!nameused))
	{
		draw_buttion(buttions_locs, "OK", 4);
		enterindex = 4;
	}
	else
	{
		draw_fbuttion(buttions_locs, "OK");
		enterindex = 0;
	}

	txt_pos_x += 312 * vx_rel;
	txt_pos_y += 199 * vy_rel;

	if (nameused == 1)
		drawstring(txt_pos, "Name Taken", fixed_vector('14 14 0'), '2 0.8 0.9', 1, 0);
	else
		drawstring(txt_pos, "Create Profile", fixed_vector('14 14 0'), '0.75 0.75 0.7', 1, 0);
	txt_pos_y += 28 * vy_rel;
	drawstring(txt_pos, gah, fixed_vector('14 14 0'), fixed_vector('4 4 2'), 1, 0);
	txt_pos_y += 64 * vy_rel;

};

void() menuprofile_next = { if (profileslotpage < 10)
		profileslotpage++;
	if (profileslotpage >= 10)
		profileslotpage = 10;
	profileslot = profileslotpage;
	write_currentprofileslot();
};
void() menuprofile_prev = { if (profileslotpage > 1)
		profileslotpage--;
	if (profileslotpage <= 1)
		profileslotpage = 1;
	profileslot = profileslotpage;
	write_currentprofileslot();
};

void() menuprofile_select = { profileslotpage = nprof;
	profileslot = profileslotpage;
	write_currentprofileslot();
};

void() menu_type_resume = { if (oldtotalprofileslots > 0)
		oldtotalprofileslots = 0;

	local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;

	buttions_locs_x = (vid_x / 2) - (512 *vx_rel);
	buttions_locs_y = 384 * vy_rel;

	drawpic('0 0 0', "gfx/menu/background.tga", vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);

	float vid_rwidth = cvar("vid_width");
	float vid_rheight = cvar("vid_height");

	vector journalpos, sizeimage;
	journalpos = (journalpos);
	sizeimage = fixed_vector2('512 360 0');
	journalpos_x = (vid_x / 2) - (sizeimage_x / 2);
	journalpos_y = (vid_y / 2) - (sizeimage_y / 2);

	drawpic(journalpos, "gfx/menu/load_menu.tga", sizeimage, '1 1 1', 1, 0);

	//drawfill (fixed_vector('90 60 0'),fixed_vector('270 320 0'), '0.1 0.1 0.1', 1, 0);
	////////////////////////////////////////////////////////////////////////////////
	//drawfill (fixed_vector('90 59 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	//drawfill (fixed_vector('90 60 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);

	/*string csn;
	if(profileslotpage == 1) csn = "character slot 1";
	if(profileslotpage == 2) csn = "character slot 2";
	if(profileslotpage == 3) csn = "character slot 3";
	if(profileslotpage == 4) csn = "character slot 4";
	if(profileslotpage == 5) csn = "character slot 5";
	if(profileslotpage == 6) csn = "character slot 6";
	if(profileslotpage == 7) csn = "character slot 7";
	if(profileslotpage == 8) csn = "character slot 8";
	if(profileslotpage == 9) csn = "character slot 9";
	if(profileslotpage == 10) csn = "character slot 10";
	//if(profileslotpage == 11) csn = "character slot 11";
	//if(profileslotpage == 12) csn = "character slot 12";
	*/
	//drawstring (fixed_vector('90 68 0'),ftos(selected_option), fixed_vector('14 14 0'), '0.75 0.75 0.7', 1, 0);

	//drawfill (fixed_vector('90 91 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	//drawfill (fixed_vector('90 92 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);
	/////////////////////////////////////////////////////////////////////////////////////
	//drawfill (fixed_vector('90 345 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	//drawfill (fixed_vector('90 346 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);

	string cname;
	if (oldprofileslot != profileslot)
		check_profilenames_str(profileslot);
	cname = profilename;

	float emptyprofile;

	if (cname != "")
	{
		emptyprofile = 0;
		//drawstring (fixed_vector('90 354 0'),cname, fixed_vector('14 14 0'), '0.75 0.75 0.7', 1, 0);
		if (oldprofileslot != profileslot)
			check_profile_saves(cname);
	}
	else
	{
		//drawstring (fixed_vector('90 354 0'),"<empty profile>", fixed_vector('14 14 0'), '1 0.25 0.25', 1, 0);
		emptyprofile = 1;
	}

	//drawfill (fixed_vector('90 377 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	//drawfill (fixed_vector('90 378 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);
	vector posstring, fixedpos;
	fixedpos = fixed_vector('240 80 0');

	local float posx_modifier;
	posx_modifier = (size_x / size_y);
	if (posx_modifier >= 1.6)
		posx_modifier = 1;

	if (posx_modifier >= 1.6)
		posx_modifier = 1;
	if (ceil((posx_modifier) *100) == (134))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (125))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (160))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (167))
		posx_modifier = 1.15;
	local float txt_len;

	posstring_x = (size_x / 2) - (fixedpos_x *posx_modifier);
	local float pos_y;
	posstring_y = journalpos_y + fixedpos_y;
	pos_y = posstring_y;
	check_profilenames();
	check_profilenames_str2();

	if (c_profilename1 == "")
		c_profilename1 = "<empty profile>";
	if (c_profilename2 == "")
		c_profilename2 = "<empty profile>";
	if (c_profilename3 == "")
		c_profilename3 = "<empty profile>";
	if (c_profilename4 == "")
		c_profilename4 = "<empty profile>";
	if (c_profilename5 == "")
		c_profilename5 = "<empty profile>";
	if (c_profilename6 == "")
		c_profilename6 = "<empty profile>";
	if (c_profilename7 == "")
		c_profilename7 = "<empty profile>";

	//posstring_x += aspectratio_fix_x *(vid_rwidth / vid_rheight);
	if (c_profilename1 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename1, 1);posstring += '0 32 0';
	if (c_profilename2 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename2, 2);posstring += '0 32 0';
	if (c_profilename3 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename3, 3);posstring += '0 32 0';
	if (c_profilename4 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename4, 4);posstring += '0 32 0';
	if (c_profilename5 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename5, 5);posstring += '0 32 0';
	if (c_profilename6 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename6, 6);posstring += '0 32 0';
	if (c_profilename7 != "<empty profile>")
		draw_buttionprofile((posstring), c_profilename7, 7);posstring += '0 32 0';

	if (c_profilename1 != "<empty profile>")
		strunzone(c_profilename1);
	if (c_profilename2 != "<empty profile>")
		strunzone(c_profilename2);
	if (c_profilename3 != "<empty profile>")
		strunzone(c_profilename3);
	if (c_profilename4 != "<empty profile>")
		strunzone(c_profilename4);
	if (c_profilename5 != "<empty profile>")
		strunzone(c_profilename5);
	if (c_profilename6 != "<empty profile>")
		strunzone(c_profilename6);
	if (c_profilename7 != "<empty profile>")
		strunzone(c_profilename7);

	/*	if(profileslotpage > 1)
		draw_buttion(buttions_locs, "<", 5);
		else
		draw_fbuttion(buttions_locs, "<");

		buttions_locs_x += 256* vx_rel;
		if(profileslotpage < 10)
		draw_buttion(buttions_locs, ">", 6);
		else
		draw_fbuttion(buttions_locs, ">");

	*/
	fixedpos = fixed_vector('-20 0 0');

	posx_modifier = (size_x / size_y);
	if (posx_modifier >= 1.6)
		posx_modifier = 1;

	if (posx_modifier >= 1.6)
		posx_modifier = 1;
	if (ceil((posx_modifier) *100) == (134))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (125))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (160))
		posx_modifier = 1.15;
	if (ceil((posx_modifier) *100) == (167))
		posx_modifier = 1.15;

	buttions_locs_x = (size_x / 2) + (fixedpos_x *(posx_modifier));
	buttions_locs_y = pos_y;

	local string sorete;
	sorete = ftos(currentprofilessaves);
	if (!emptyprofile)
	{
		//if((!currentprofilessaves) && 	(cname != ""))
		//{
		draw_buttionload((buttions_locs), "Autosave", 1);
		buttions_locs_y += 64 * vy_rel;
		//}

		if (currentprofilessaves & 1)
		{
			draw_buttionload((buttions_locs), " Soul Tether", 2);
			buttions_locs_y += 64 * vy_rel;
		}

		if (currentprofilessaves & 2)
		{
			draw_buttionload((buttions_locs), "Shrine", 3);
		}

		buttions_locs_y = pos_y + 186 * vy_rel;
		fixedpos = fixed_vector('20 0 0');
		buttions_locs_x += (fixedpos_x *(posx_modifier));
		local vector txt_pos;

		vector posfix, imgsize;
		posfix_x = 128 * vx_rel;
		posfix_y = 10 * vy_rel;

		txt_pos = buttions_locs + posfix;
		txt_len = stringwidth("NEWGAME GAME", true, BTT_FONT_SIZE);
		txt_pos_x -= (txt_len / 2);

		imgsize = fixed_vector2('152 40 0');

		if (type_load_selected > 0)
			draw_buttionwrath(buttions_locs, "Load", 7);
		else
			drawpic(txt_pos, "gfx/menu/load_game.tga", imgsize, '1 1 1', 1, 0);

	}

	oldprofileslot = profileslot;
};
/*
void() menu_type_resume =
{
	if(oldtotalprofileslots > 0)
	oldtotalprofileslots = 0;

	local vector size, buttions_locs;
	size_x = vid_x;
	size_y = vid_y;

	buttions_locs_x = (vid_x/2)-(512 *vx_rel);
	buttions_locs_y = 384 * vy_rel;

	drawpic('0 0 0',"gfx/menu/background.tga" ,vid_x *'1 0 0' + vid_y *'0 1 0', '0.65 0.65 0.65', 1, 0);

	drawfill (fixed_vector('90 60 0'),fixed_vector('270 320 0'), '0.1 0.1 0.1', 1, 0);
	////////////////////////////////////////////////////////////////////////////////
	drawfill (fixed_vector('90 59 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	drawfill (fixed_vector('90 60 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);

	string csn;
	if(profileslotpage == 1) csn = "character slot 1";
	if(profileslotpage == 2) csn = "character slot 2";
	if(profileslotpage == 3) csn = "character slot 3";
	if(profileslotpage == 4) csn = "character slot 4";
	if(profileslotpage == 5) csn = "character slot 5";
	if(profileslotpage == 6) csn = "character slot 6";
	if(profileslotpage == 7) csn = "character slot 7";
	if(profileslotpage == 8) csn = "character slot 8";
	if(profileslotpage == 9) csn = "character slot 9";
	if(profileslotpage == 10) csn = "character slot 10";
	//if(profileslotpage == 11) csn = "character slot 11";
	//if(profileslotpage == 12) csn = "character slot 12";
	drawstring (fixed_vector('90 68 0'),csn, fixed_vector('14 14 0'), '0.75 0.75 0.7', 1, 0);

	drawfill (fixed_vector('90 91 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	drawfill (fixed_vector('90 92 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);
	/////////////////////////////////////////////////////////////////////////////////////
	drawfill (fixed_vector('90 345 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	drawfill (fixed_vector('90 346 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);

	string cname;
	if(oldprofileslot != profileslot)
	check_profilenames_str(profileslot);
	cname = profilename;

	float emptyprofile;

	if(cname != "")
	{
	emptyprofile = 0;
	drawstring (fixed_vector('90 354 0'),cname, fixed_vector('14 14 0'), '0.75 0.75 0.7', 1, 0);
	if(oldprofileslot != profileslot)
	check_profile_saves(cname);
	}
	else
	{
	drawstring (fixed_vector('90 354 0'),"<empty profile>", fixed_vector('14 14 0'), '1 0.25 0.25', 1, 0);
	emptyprofile = 1;
	}

	drawfill (fixed_vector('90 377 0'),fixed_vector('270 1 0'), '0.5 0.5 0.6', 1, 0);
	drawfill (fixed_vector('90 378 0'),fixed_vector('270 2 0'), '0.3 0.3 0.4', 1, 0);
	if(profileslotpage > 1)
	draw_buttion(buttions_locs, "<", 5);
	else
	draw_fbuttion(buttions_locs, "<");

	buttions_locs_x += 256* vx_rel;
	if(profileslotpage < 10)
	draw_buttion(buttions_locs, ">", 6);
	else
	draw_fbuttion(buttions_locs, ">");

	buttions_locs_y -= 320* vy_rel;
	buttions_locs_x += 256* vx_rel;

	local string sorete;
	sorete = ftos (currentprofilessaves);
	if(!emptyprofile)
	{	
		//if((!currentprofilessaves) && 	(cname != ""))
		//{
		draw_buttion(buttions_locs, "LOAD AUTOSAVE", 7);
		buttions_locs_y += 80* vy_rel;
		//}

		if(currentprofilessaves & 1)
		{
		draw_buttion(buttions_locs, "LOAD TETHER", 8);
		buttions_locs_y += 80* vy_rel;
		}

		if(currentprofilessaves & 2)
		{
		draw_buttion(buttions_locs, "LOAD SHRINE", 9);
		}
	}

	oldprofileslot = profileslot;
};
*/