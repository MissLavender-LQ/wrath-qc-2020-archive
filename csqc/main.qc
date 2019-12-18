// --------------------------------------------------------------------------
// BEGIN REQUIRED CSQC FUNCTIONS

.float enttype;

void() Hud_Init;
void() rewritefriktether = {};
void() rewritefrikshrine = {};

// CSQC_Init : Called every time the CSQC code is initialized (essentially at map load)
void CSQC_Init(void)
{
	local string strCmd;
	strCmd = "";
	//	strCmd = strcat (strCmd, "vid_conwidth 960 \n");
	//	strCmd = strcat (strCmd, "vid_conheight 540 \n");
	strCmd = ("exec fonts/font.cfg \n");
	localcmd(strCmd);
	cvar_set("r_glsl_postprocess_uservec1", "0 0 0 0");
	//cvar_set("r_viewscale", "1");
	cvar_set("sv_maxvelocity", "10000");
	Hud_Init();
	check_frikfile();
	msgtime = gettime(GETTIME_UPTIME);
	precache_model("progs/flame.mdl");
	precache_pic("gfx/hud/2_ammo0.tga");
	precache_pic("gfx/hud/2_ammo1.tga");
	precache_pic("gfx/hud/2_ammo2.tga");
	precache_pic("gfx/hud/2_ammo3.tga");
	precache_pic("gfx/hud/2_ammo4.tga");
	precache_pic("gfx/hud/2_ammo5.tga");
	precache_pic("gfx/hud/2_ammo6.tga");
	precache_pic("gfx/hud/2_ammo7.tga");
	precache_pic("gfx/hud/2_ammo8.tga");
	precache_pic("gfx/hud/2_ammo9.tga");
	precache_pic("gfx/hud/3_ammo0.tga");
	precache_pic("gfx/hud/3_ammo1.tga");
	precache_pic("gfx/hud/3_ammo2.tga");
	precache_pic("gfx/hud/3_ammo3.tga");
	precache_pic("gfx/hud/3_ammo4.tga");
	precache_pic("gfx/hud/3_ammo5.tga");
	precache_pic("gfx/hud/3_ammo6.tga");
	precache_pic("gfx/hud/3_ammo7.tga");
	precache_pic("gfx/hud/3_ammo8.tga");
	precache_pic("gfx/hud/3_ammo9.tga");
	precache_pic("gfx/hud/4_ammo0.tga");
	precache_pic("gfx/hud/4_ammo1.tga");
	precache_pic("gfx/hud/4_ammo2.tga");
	precache_pic("gfx/hud/4_ammo3.tga");
	precache_pic("gfx/hud/4_ammo4.tga");
	precache_pic("gfx/hud/4_ammo5.tga");
	precache_pic("gfx/hud/4_ammo6.tga");
	precache_pic("gfx/hud/4_ammo7.tga");
	precache_pic("gfx/hud/4_ammo8.tga");
	precache_pic("gfx/hud/4_ammo9.tga");
	precache_pic("gfx/hud/5_ammo0.tga");
	precache_pic("gfx/hud/5_ammo1.tga");
	precache_pic("gfx/hud/5_ammo2.tga");
	precache_pic("gfx/hud/5_ammo3.tga");
	precache_pic("gfx/hud/5_ammo4.tga");
	precache_pic("gfx/hud/5_ammo5.tga");
	precache_pic("gfx/hud/5_ammo6.tga");
	precache_pic("gfx/hud/5_ammo7.tga");
	precache_pic("gfx/hud/5_ammo8.tga");
	precache_pic("gfx/hud/5_ammo9.tga");
	precache_pic("gfx/hud/6_ammo0.tga");
	precache_pic("gfx/hud/6_ammo1.tga");
	precache_pic("gfx/hud/6_ammo2.tga");
	precache_pic("gfx/hud/6_ammo3.tga");
	precache_pic("gfx/hud/6_ammo4.tga");
	precache_pic("gfx/hud/6_ammo5.tga");
	precache_pic("gfx/hud/6_ammo6.tga");
	precache_pic("gfx/hud/6_ammo7.tga");
	precache_pic("gfx/hud/6_ammo8.tga");
	precache_pic("gfx/hud/6_ammo9.tga");
	precache_pic("gfx/hud/7_ammo0.tga");
	precache_pic("gfx/hud/7_ammo1.tga");
	precache_pic("gfx/hud/7_ammo2.tga");
	precache_pic("gfx/hud/7_ammo3.tga");
	precache_pic("gfx/hud/7_ammo4.tga");
	precache_pic("gfx/hud/7_ammo5.tga");
	precache_pic("gfx/hud/7_ammo6.tga");
	precache_pic("gfx/hud/7_ammo7.tga");
	precache_pic("gfx/hud/7_ammo8.tga");
	precache_pic("gfx/hud/7_ammo9.tga");
	precache_pic("gfx/hud/armor0.tga");
	precache_pic("gfx/hud/armor1.tga");
	precache_pic("gfx/hud/armor2.tga");
	precache_pic("gfx/hud/armor3.tga");
	precache_pic("gfx/hud/armor4.tga");
	precache_pic("gfx/hud/armor5.tga");
	precache_pic("gfx/hud/armor6.tga");
	precache_pic("gfx/hud/armor7.tga");
	precache_pic("gfx/hud/armor8.tga");
	precache_pic("gfx/hud/armor9.tga");
	precache_pic("gfx/hud/armor_6.tga");
	precache_pic("gfx/hud/armorp1_0.tga");
	precache_pic("gfx/hud/armorp1_1.tga");
	precache_pic("gfx/hud/armorp1_2.tga");
	precache_pic("gfx/hud/armorp1_3.tga");
	precache_pic("gfx/hud/armorp1_4.tga");
	precache_pic("gfx/hud/armorp1_5.tga");
	precache_pic("gfx/hud/armorp1_6.tga");
	precache_pic("gfx/hud/armorp1_7.tga");
	precache_pic("gfx/hud/armorp1_8.tga");
	precache_pic("gfx/hud/armorp1_9.tga");
	precache_pic("gfx/hud/armorp2_0.tga");
	precache_pic("gfx/hud/armorp2_1.tga");
	precache_pic("gfx/hud/armorp2_2.tga");
	precache_pic("gfx/hud/armorp2_3.tga");
	precache_pic("gfx/hud/armorp2_4.tga");
	precache_pic("gfx/hud/armorp2_5.tga");
	precache_pic("gfx/hud/armorp2_6.tga");
	precache_pic("gfx/hud/armorp2_7.tga");
	precache_pic("gfx/hud/armorp2_8.tga");
	precache_pic("gfx/hud/armorp2_9.tga");
	precache_pic("gfx/hud/armorp3_0.tga");
	precache_pic("gfx/hud/armorp3_1.tga");
	precache_pic("gfx/hud/armorp3_2.tga");
	precache_pic("gfx/hud/armorp3_3.tga");
	precache_pic("gfx/hud/armorp3_4.tga");
	precache_pic("gfx/hud/armorp3_5.tga");
	precache_pic("gfx/hud/armorp3_6.tga");
	precache_pic("gfx/hud/armorp3_7.tga");
	precache_pic("gfx/hud/armorp3_8.tga");
	precache_pic("gfx/hud/armorp3_9.tga");
	precache_pic("gfx/hud/armorp4_0.tga");
	precache_pic("gfx/hud/armorp4_1.tga");
	precache_pic("gfx/hud/armorp4_2.tga");
	precache_pic("gfx/hud/armorp4_3.tga");
	precache_pic("gfx/hud/armorp4_4.tga");
	precache_pic("gfx/hud/armorp4_5.tga");
	precache_pic("gfx/hud/armorp4_6.tga");
	precache_pic("gfx/hud/armorp4_7.tga");
	precache_pic("gfx/hud/armorp4_8.tga");
	precache_pic("gfx/hud/armorp4_9.tga");
	precache_pic("gfx/hud/armorp5_0.tga");
	precache_pic("gfx/hud/armorp5_1.tga");
	precache_pic("gfx/hud/armorp5_2.tga");
	precache_pic("gfx/hud/armorp5_3.tga");
	precache_pic("gfx/hud/armorp5_4.tga");
	precache_pic("gfx/hud/armorp5_5.tga");
	precache_pic("gfx/hud/armorp5_6.tga");
	precache_pic("gfx/hud/armorp5_7.tga");
	precache_pic("gfx/hud/armorp5_8.tga");
	precache_pic("gfx/hud/armorp5_9.tga");
	precache_pic("gfx/hud/armorp6_0.tga");
	precache_pic("gfx/hud/armorp6_1.tga");
	precache_pic("gfx/hud/armorp6_2.tga");
	precache_pic("gfx/hud/armorp6_3.tga");
	precache_pic("gfx/hud/armorp6_4.tga");
	precache_pic("gfx/hud/armorp6_5.tga");
	precache_pic("gfx/hud/armorp6_6.tga");
	precache_pic("gfx/hud/armorp6_7.tga");
	precache_pic("gfx/hud/armorp6_8.tga");
	precache_pic("gfx/hud/armorp6_9.tga");
	precache_pic("gfx/hud/armorp7_0.tga");
	precache_pic("gfx/hud/armorp7_1.tga");
	precache_pic("gfx/hud/armorp7_2.tga");
	precache_pic("gfx/hud/armorp7_3.tga");
	precache_pic("gfx/hud/armorp7_4.tga");
	precache_pic("gfx/hud/armorp7_5.tga");
	precache_pic("gfx/hud/armorp7_6.tga");
	precache_pic("gfx/hud/armorp7_7.tga");
	precache_pic("gfx/hud/armorp7_8.tga");
	precache_pic("gfx/hud/armorp7_9.tga");
	precache_pic("gfx/hud/armorp8_0.tga");
	precache_pic("gfx/hud/armorp8_1.tga");
	precache_pic("gfx/hud/armorp8_2.tga");
	precache_pic("gfx/hud/armorp8_3.tga");
	precache_pic("gfx/hud/armorp8_4.tga");
	precache_pic("gfx/hud/armorp8_5.tga");
	precache_pic("gfx/hud/armorp8_6.tga");
	precache_pic("gfx/hud/armorp8_7.tga");
	precache_pic("gfx/hud/armorp8_8.tga");
	precache_pic("gfx/hud/armorp8_9.tga");
	precache_pic("gfx/hud/armorp9_0.tga");
	precache_pic("gfx/hud/armorp9_1.tga");
	precache_pic("gfx/hud/armorp9_2.tga");
	precache_pic("gfx/hud/armorp9_3.tga");
	precache_pic("gfx/hud/armorp9_4.tga");
	precache_pic("gfx/hud/armorp9_5.tga");
	precache_pic("gfx/hud/armorp9_6.tga");
	precache_pic("gfx/hud/armorp9_7.tga");
	precache_pic("gfx/hud/armorp9_8.tga");
	precache_pic("gfx/hud/armorp9_9.tga");
	precache_pic("gfx/hud/coffer_key.tga");
	precache_pic("gfx/hud/cooldown/artifactA_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactA_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactA_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactB_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactB_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactB_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactC_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactC_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactC_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactD_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactD_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactD_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactE_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactE_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactE_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactF_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactF_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactF_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactG_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactG_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactG_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactH_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactH_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactH_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactI_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactI_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactI_pulseB.tga");
	precache_pic("gfx/hud/cooldown/artifactJ_hud.tga");
	precache_pic("gfx/hud/cooldown/artifactJ_pulseA.tga");
	precache_pic("gfx/hud/cooldown/artifactJ_pulseB.tga");
	precache_pic("gfx/hud/cooldown/cd1.tga");
	precache_pic("gfx/hud/cooldown/cd10.tga");
	precache_pic("gfx/hud/cooldown/cd100.tga");
	precache_pic("gfx/hud/cooldown/cd101.tga");
	precache_pic("gfx/hud/cooldown/cd102.tga");
	precache_pic("gfx/hud/cooldown/cd103.tga");
	precache_pic("gfx/hud/cooldown/cd104.tga");
	precache_pic("gfx/hud/cooldown/cd105.tga");
	precache_pic("gfx/hud/cooldown/cd106.tga");
	precache_pic("gfx/hud/cooldown/cd107.tga");
	precache_pic("gfx/hud/cooldown/cd108.tga");
	precache_pic("gfx/hud/cooldown/cd109.tga");
	precache_pic("gfx/hud/cooldown/cd11.tga");
	precache_pic("gfx/hud/cooldown/cd110.tga");
	precache_pic("gfx/hud/cooldown/cd111.tga");
	precache_pic("gfx/hud/cooldown/cd112.tga");
	precache_pic("gfx/hud/cooldown/cd113.tga");
	precache_pic("gfx/hud/cooldown/cd114.tga");
	precache_pic("gfx/hud/cooldown/cd115.tga");
	precache_pic("gfx/hud/cooldown/cd116.tga");
	precache_pic("gfx/hud/cooldown/cd117.tga");
	precache_pic("gfx/hud/cooldown/cd118.tga");
	precache_pic("gfx/hud/cooldown/cd119.tga");
	precache_pic("gfx/hud/cooldown/cd12.tga");
	precache_pic("gfx/hud/cooldown/cd120.tga");
	precache_pic("gfx/hud/cooldown/cd121.tga");
	precache_pic("gfx/hud/cooldown/cd122.tga");
	precache_pic("gfx/hud/cooldown/cd123.tga");
	precache_pic("gfx/hud/cooldown/cd124.tga");
	precache_pic("gfx/hud/cooldown/cd125.tga");
	precache_pic("gfx/hud/cooldown/cd126.tga");
	precache_pic("gfx/hud/cooldown/cd127.tga");
	precache_pic("gfx/hud/cooldown/cd128.tga");
	precache_pic("gfx/hud/cooldown/cd129.tga");
	precache_pic("gfx/hud/cooldown/cd13.tga");
	precache_pic("gfx/hud/cooldown/cd130.tga");
	precache_pic("gfx/hud/cooldown/cd131.tga");
	precache_pic("gfx/hud/cooldown/cd132.tga");
	precache_pic("gfx/hud/cooldown/cd133.tga");
	precache_pic("gfx/hud/cooldown/cd134.tga");
	precache_pic("gfx/hud/cooldown/cd135.tga");
	precache_pic("gfx/hud/cooldown/cd136.tga");
	precache_pic("gfx/hud/cooldown/cd14.tga");
	precache_pic("gfx/hud/cooldown/cd15.tga");
	precache_pic("gfx/hud/cooldown/cd16.tga");
	precache_pic("gfx/hud/cooldown/cd17.tga");
	precache_pic("gfx/hud/cooldown/cd18.tga");
	precache_pic("gfx/hud/cooldown/cd19.tga");
	precache_pic("gfx/hud/cooldown/cd2.tga");
	precache_pic("gfx/hud/cooldown/cd20.tga");
	precache_pic("gfx/hud/cooldown/cd21.tga");
	precache_pic("gfx/hud/cooldown/cd22.tga");
	precache_pic("gfx/hud/cooldown/cd23.tga");
	precache_pic("gfx/hud/cooldown/cd24.tga");
	precache_pic("gfx/hud/cooldown/cd25.tga");
	precache_pic("gfx/hud/cooldown/cd26.tga");
	precache_pic("gfx/hud/cooldown/cd27.tga");
	precache_pic("gfx/hud/cooldown/cd28.tga");
	precache_pic("gfx/hud/cooldown/cd29.tga");
	precache_pic("gfx/hud/cooldown/cd3.tga");
	precache_pic("gfx/hud/cooldown/cd30.tga");
	precache_pic("gfx/hud/cooldown/cd31.tga");
	precache_pic("gfx/hud/cooldown/cd32.tga");
	precache_pic("gfx/hud/cooldown/cd33.tga");
	precache_pic("gfx/hud/cooldown/cd34.tga");
	precache_pic("gfx/hud/cooldown/cd35.tga");
	precache_pic("gfx/hud/cooldown/cd36.tga");
	precache_pic("gfx/hud/cooldown/cd37.tga");
	precache_pic("gfx/hud/cooldown/cd38.tga");
	precache_pic("gfx/hud/cooldown/cd39.tga");
	precache_pic("gfx/hud/cooldown/cd4.tga");
	precache_pic("gfx/hud/cooldown/cd40.tga");
	precache_pic("gfx/hud/cooldown/cd41.tga");
	precache_pic("gfx/hud/cooldown/cd42.tga");
	precache_pic("gfx/hud/cooldown/cd43.tga");
	precache_pic("gfx/hud/cooldown/cd44.tga");
	precache_pic("gfx/hud/cooldown/cd45.tga");
	precache_pic("gfx/hud/cooldown/cd46.tga");
	precache_pic("gfx/hud/cooldown/cd47.tga");
	precache_pic("gfx/hud/cooldown/cd48.tga");
	precache_pic("gfx/hud/cooldown/cd49.tga");
	precache_pic("gfx/hud/cooldown/cd5.tga");
	precache_pic("gfx/hud/cooldown/cd50.tga");
	precache_pic("gfx/hud/cooldown/cd51.tga");
	precache_pic("gfx/hud/cooldown/cd52.tga");
	precache_pic("gfx/hud/cooldown/cd53.tga");
	precache_pic("gfx/hud/cooldown/cd54.tga");
	precache_pic("gfx/hud/cooldown/cd55.tga");
	precache_pic("gfx/hud/cooldown/cd56.tga");
	precache_pic("gfx/hud/cooldown/cd57.tga");
	precache_pic("gfx/hud/cooldown/cd58.tga");
	precache_pic("gfx/hud/cooldown/cd59.tga");
	precache_pic("gfx/hud/cooldown/cd6.tga");
	precache_pic("gfx/hud/cooldown/cd60.tga");
	precache_pic("gfx/hud/cooldown/cd61.tga");
	precache_pic("gfx/hud/cooldown/cd62.tga");
	precache_pic("gfx/hud/cooldown/cd63.tga");
	precache_pic("gfx/hud/cooldown/cd64.tga");
	precache_pic("gfx/hud/cooldown/cd65.tga");
	precache_pic("gfx/hud/cooldown/cd66.tga");
	precache_pic("gfx/hud/cooldown/cd67.tga");
	precache_pic("gfx/hud/cooldown/cd68.tga");
	precache_pic("gfx/hud/cooldown/cd69.tga");
	precache_pic("gfx/hud/cooldown/cd7.tga");
	precache_pic("gfx/hud/cooldown/cd70.tga");
	precache_pic("gfx/hud/cooldown/cd71.tga");
	precache_pic("gfx/hud/cooldown/cd72.tga");
	precache_pic("gfx/hud/cooldown/cd73.tga");
	precache_pic("gfx/hud/cooldown/cd74.tga");
	precache_pic("gfx/hud/cooldown/cd75.tga");
	precache_pic("gfx/hud/cooldown/cd76.tga");
	precache_pic("gfx/hud/cooldown/cd77.tga");
	precache_pic("gfx/hud/cooldown/cd78.tga");
	precache_pic("gfx/hud/cooldown/cd79.tga");
	precache_pic("gfx/hud/cooldown/cd8.tga");
	precache_pic("gfx/hud/cooldown/cd80.tga");
	precache_pic("gfx/hud/cooldown/cd81.tga");
	precache_pic("gfx/hud/cooldown/cd82.tga");
	precache_pic("gfx/hud/cooldown/cd83.tga");
	precache_pic("gfx/hud/cooldown/cd84.tga");
	precache_pic("gfx/hud/cooldown/cd85.tga");
	precache_pic("gfx/hud/cooldown/cd86.tga");
	precache_pic("gfx/hud/cooldown/cd87.tga");
	precache_pic("gfx/hud/cooldown/cd88.tga");
	precache_pic("gfx/hud/cooldown/cd89.tga");
	precache_pic("gfx/hud/cooldown/cd9.tga");
	precache_pic("gfx/hud/cooldown/cd90.tga");
	precache_pic("gfx/hud/cooldown/cd91.tga");
	precache_pic("gfx/hud/cooldown/cd92.tga");
	precache_pic("gfx/hud/cooldown/cd93.tga");
	precache_pic("gfx/hud/cooldown/cd94.tga");
	precache_pic("gfx/hud/cooldown/cd95.tga");
	precache_pic("gfx/hud/cooldown/cd96.tga");
	precache_pic("gfx/hud/cooldown/cd97.tga");
	precache_pic("gfx/hud/cooldown/cd98.tga");
	precache_pic("gfx/hud/cooldown/cd99.tga");
	precache_pic("gfx/hud/cooldown/cd_pulse.tga");
	precache_pic("gfx/hud/crosshair1.tga");
	precache_pic("gfx/hud/crosshair1_active.tga");
	precache_pic("gfx/hud/crosshair1_use.tga");
	precache_pic("gfx/hud/cystsp1_0.tga");
	precache_pic("gfx/hud/cystsp1_1.tga");
	precache_pic("gfx/hud/cystsp1_2.tga");
	precache_pic("gfx/hud/cystsp1_3.tga");
	precache_pic("gfx/hud/cystsp1_4.tga");
	precache_pic("gfx/hud/cystsp1_5.tga");
	precache_pic("gfx/hud/cystsp1_6.tga");
	precache_pic("gfx/hud/cystsp1_7.tga");
	precache_pic("gfx/hud/cystsp1_8.tga");
	precache_pic("gfx/hud/cystsp1_9.tga");
	precache_pic("gfx/hud/cystsp2_0.tga");
	precache_pic("gfx/hud/cystsp2_1.tga");
	precache_pic("gfx/hud/cystsp2_2.tga");
	precache_pic("gfx/hud/cystsp2_3.tga");
	precache_pic("gfx/hud/cystsp2_4.tga");
	precache_pic("gfx/hud/cystsp2_5.tga");
	precache_pic("gfx/hud/cystsp2_6.tga");
	precache_pic("gfx/hud/cystsp2_7.tga");
	precache_pic("gfx/hud/cystsp2_8.tga");
	precache_pic("gfx/hud/cystsp2_9.tga");
	precache_pic("gfx/hud/cystsp3_0.tga");
	precache_pic("gfx/hud/cystsp3_1.tga");
	precache_pic("gfx/hud/cystsp3_2.tga");
	precache_pic("gfx/hud/cystsp3_3.tga");
	precache_pic("gfx/hud/cystsp3_4.tga");
	precache_pic("gfx/hud/cystsp3_5.tga");
	precache_pic("gfx/hud/cystsp3_6.tga");
	precache_pic("gfx/hud/cystsp3_7.tga");
	precache_pic("gfx/hud/cystsp3_8.tga");
	precache_pic("gfx/hud/cystsp3_9.tga");
	precache_pic("gfx/hud/cystsp4_0.tga");
	precache_pic("gfx/hud/cystsp4_1.tga");
	precache_pic("gfx/hud/cystsp4_2.tga");
	precache_pic("gfx/hud/cystsp4_3.tga");
	precache_pic("gfx/hud/cystsp4_4.tga");
	precache_pic("gfx/hud/cystsp4_5.tga");
	precache_pic("gfx/hud/cystsp4_6.tga");
	precache_pic("gfx/hud/cystsp4_7.tga");
	precache_pic("gfx/hud/cystsp4_8.tga");
	precache_pic("gfx/hud/cystsp4_9.tga");
	precache_pic("gfx/hud/cystsp5_0.tga");
	precache_pic("gfx/hud/cystsp5_1.tga");
	precache_pic("gfx/hud/cystsp5_2.tga");
	precache_pic("gfx/hud/cystsp5_3.tga");
	precache_pic("gfx/hud/cystsp5_4.tga");
	precache_pic("gfx/hud/cystsp5_5.tga");
	precache_pic("gfx/hud/cystsp5_6.tga");
	precache_pic("gfx/hud/cystsp5_7.tga");
	precache_pic("gfx/hud/cystsp5_8.tga");
	precache_pic("gfx/hud/cystsp5_9.tga");
	precache_pic("gfx/hud/cystsp6_0.tga");
	precache_pic("gfx/hud/cystsp6_1.tga");
	precache_pic("gfx/hud/cystsp6_2.tga");
	precache_pic("gfx/hud/cystsp6_3.tga");
	precache_pic("gfx/hud/cystsp6_4.tga");
	precache_pic("gfx/hud/cystsp6_5.tga");
	precache_pic("gfx/hud/cystsp6_6.tga");
	precache_pic("gfx/hud/cystsp6_7.tga");
	precache_pic("gfx/hud/cystsp6_8.tga");
	precache_pic("gfx/hud/cystsp6_9.tga");
	precache_pic("gfx/hud/cystsp7_0.tga");
	precache_pic("gfx/hud/cystsp7_1.tga");
	precache_pic("gfx/hud/cystsp7_2.tga");
	precache_pic("gfx/hud/cystsp7_3.tga");
	precache_pic("gfx/hud/cystsp7_4.tga");
	precache_pic("gfx/hud/cystsp7_5.tga");
	precache_pic("gfx/hud/cystsp7_6.tga");
	precache_pic("gfx/hud/cystsp7_7.tga");
	precache_pic("gfx/hud/cystsp7_8.tga");
	precache_pic("gfx/hud/cystsp7_9.tga");
	precache_pic("gfx/hud/cystsp8_0.tga");
	precache_pic("gfx/hud/cystsp8_1.tga");
	precache_pic("gfx/hud/cystsp8_2.tga");
	precache_pic("gfx/hud/cystsp8_3.tga");
	precache_pic("gfx/hud/cystsp8_4.tga");
	precache_pic("gfx/hud/cystsp8_5.tga");
	precache_pic("gfx/hud/cystsp8_6.tga");
	precache_pic("gfx/hud/cystsp8_7.tga");
	precache_pic("gfx/hud/cystsp8_8.tga");
	precache_pic("gfx/hud/cystsp8_9.tga");
	precache_pic("gfx/hud/cystsp9_0.tga");
	precache_pic("gfx/hud/cystsp9_1.tga");
	precache_pic("gfx/hud/cystsp9_2.tga");
	precache_pic("gfx/hud/cystsp9_3.tga");
	precache_pic("gfx/hud/cystsp9_4.tga");
	precache_pic("gfx/hud/cystsp9_5.tga");
	precache_pic("gfx/hud/cystsp9_6.tga");
	precache_pic("gfx/hud/cystsp9_7.tga");
	precache_pic("gfx/hud/cystsp9_8.tga");
	precache_pic("gfx/hud/cystsp9_9.tga");
	precache_pic("gfx/hud/darmor0.tga");
	precache_pic("gfx/hud/darmor1.tga");
	precache_pic("gfx/hud/darmor2.tga");
	precache_pic("gfx/hud/darmor3.tga");
	precache_pic("gfx/hud/darmor4.tga");
	precache_pic("gfx/hud/darmor5.tga");
	precache_pic("gfx/hud/darmor6.tga");
	precache_pic("gfx/hud/darmor7.tga");
	precache_pic("gfx/hud/darmor8.tga");
	precache_pic("gfx/hud/darmor9.tga");
	precache_pic("gfx/hud/darmorp1_0.tga");
	precache_pic("gfx/hud/darmorp1_1.tga");
	precache_pic("gfx/hud/darmorp1_2.tga");
	precache_pic("gfx/hud/darmorp1_3.tga");
	precache_pic("gfx/hud/darmorp1_4.tga");
	precache_pic("gfx/hud/darmorp1_5.tga");
	precache_pic("gfx/hud/darmorp1_6.tga");
	precache_pic("gfx/hud/darmorp1_7.tga");
	precache_pic("gfx/hud/darmorp1_8.tga");
	precache_pic("gfx/hud/darmorp1_9.tga");
	precache_pic("gfx/hud/darmorp2_0.tga");
	precache_pic("gfx/hud/darmorp2_1.tga");
	precache_pic("gfx/hud/darmorp2_2.tga");
	precache_pic("gfx/hud/darmorp2_3.tga");
	precache_pic("gfx/hud/darmorp2_4.tga");
	precache_pic("gfx/hud/darmorp2_5.tga");
	precache_pic("gfx/hud/darmorp2_6.tga");
	precache_pic("gfx/hud/darmorp2_7.tga");
	precache_pic("gfx/hud/darmorp2_8.tga");
	precache_pic("gfx/hud/darmorp2_9.tga");
	precache_pic("gfx/hud/darmorp3_0.tga");
	precache_pic("gfx/hud/darmorp3_1.tga");
	precache_pic("gfx/hud/darmorp3_2.tga");
	precache_pic("gfx/hud/darmorp3_3.tga");
	precache_pic("gfx/hud/darmorp3_4.tga");
	precache_pic("gfx/hud/darmorp3_5.tga");
	precache_pic("gfx/hud/darmorp3_6.tga");
	precache_pic("gfx/hud/darmorp3_7.tga");
	precache_pic("gfx/hud/darmorp3_8.tga");
	precache_pic("gfx/hud/darmorp3_9.tga");
	precache_pic("gfx/hud/darmorp4_0.tga");
	precache_pic("gfx/hud/darmorp4_1.tga");
	precache_pic("gfx/hud/darmorp4_2.tga");
	precache_pic("gfx/hud/darmorp4_3.tga");
	precache_pic("gfx/hud/darmorp4_4.tga");
	precache_pic("gfx/hud/darmorp4_5.tga");
	precache_pic("gfx/hud/darmorp4_6.tga");
	precache_pic("gfx/hud/darmorp4_7.tga");
	precache_pic("gfx/hud/darmorp4_8.tga");
	precache_pic("gfx/hud/darmorp4_9.tga");
	precache_pic("gfx/hud/darmorp5_0.tga");
	precache_pic("gfx/hud/darmorp5_1.tga");
	precache_pic("gfx/hud/darmorp5_2.tga");
	precache_pic("gfx/hud/darmorp5_3.tga");
	precache_pic("gfx/hud/darmorp5_4.tga");
	precache_pic("gfx/hud/darmorp5_5.tga");
	precache_pic("gfx/hud/darmorp5_6.tga");
	precache_pic("gfx/hud/darmorp5_7.tga");
	precache_pic("gfx/hud/darmorp5_8.tga");
	precache_pic("gfx/hud/darmorp5_9.tga");
	precache_pic("gfx/hud/darmorp6_0.tga");
	precache_pic("gfx/hud/darmorp6_1.tga");
	precache_pic("gfx/hud/darmorp6_2.tga");
	precache_pic("gfx/hud/darmorp6_3.tga");
	precache_pic("gfx/hud/darmorp6_4.tga");
	precache_pic("gfx/hud/darmorp6_5.tga");
	precache_pic("gfx/hud/darmorp6_6.tga");
	precache_pic("gfx/hud/darmorp6_7.tga");
	precache_pic("gfx/hud/darmorp6_8.tga");
	precache_pic("gfx/hud/darmorp6_9.tga");
	precache_pic("gfx/hud/darmorp7_0.tga");
	precache_pic("gfx/hud/darmorp7_1.tga");
	precache_pic("gfx/hud/darmorp7_2.tga");
	precache_pic("gfx/hud/darmorp7_3.tga");
	precache_pic("gfx/hud/darmorp7_4.tga");
	precache_pic("gfx/hud/darmorp7_5.tga");
	precache_pic("gfx/hud/darmorp7_6.tga");
	precache_pic("gfx/hud/darmorp7_7.tga");
	precache_pic("gfx/hud/darmorp7_8.tga");
	precache_pic("gfx/hud/darmorp7_9.tga");
	precache_pic("gfx/hud/darmorp8_0.tga");
	precache_pic("gfx/hud/darmorp8_1.tga");
	precache_pic("gfx/hud/darmorp8_2.tga");
	precache_pic("gfx/hud/darmorp8_3.tga");
	precache_pic("gfx/hud/darmorp8_4.tga");
	precache_pic("gfx/hud/darmorp8_5.tga");
	precache_pic("gfx/hud/darmorp8_6.tga");
	precache_pic("gfx/hud/darmorp8_7.tga");
	precache_pic("gfx/hud/darmorp8_8.tga");
	precache_pic("gfx/hud/darmorp8_9.tga");
	precache_pic("gfx/hud/darmorp9_0.tga");
	precache_pic("gfx/hud/darmorp9_1.tga");
	precache_pic("gfx/hud/darmorp9_2.tga");
	precache_pic("gfx/hud/darmorp9_3.tga");
	precache_pic("gfx/hud/darmorp9_4.tga");
	precache_pic("gfx/hud/darmorp9_5.tga");
	precache_pic("gfx/hud/darmorp9_6.tga");
	precache_pic("gfx/hud/darmorp9_7.tga");
	precache_pic("gfx/hud/darmorp9_8.tga");
	precache_pic("gfx/hud/darmorp9_9.tga");
	precache_pic("gfx/hud/di_bottom.tga");
	precache_pic("gfx/hud/di_left.tga");
	precache_pic("gfx/hud/di_right.tga");
	precache_pic("gfx/hud/di_top.tga");
	precache_pic("gfx/hud/fangsp1_0.tga");
	precache_pic("gfx/hud/fangsp1_1.tga");
	precache_pic("gfx/hud/fangsp1_2.tga");
	precache_pic("gfx/hud/fangsp1_3.tga");
	precache_pic("gfx/hud/fangsp1_4.tga");
	precache_pic("gfx/hud/fangsp1_5.tga");
	precache_pic("gfx/hud/fangsp1_6.tga");
	precache_pic("gfx/hud/fangsp1_7.tga");
	precache_pic("gfx/hud/fangsp1_8.tga");
	precache_pic("gfx/hud/fangsp1_9.tga");
	precache_pic("gfx/hud/fangsp2_0.tga");
	precache_pic("gfx/hud/fangsp2_1.tga");
	precache_pic("gfx/hud/fangsp2_2.tga");
	precache_pic("gfx/hud/fangsp2_3.tga");
	precache_pic("gfx/hud/fangsp2_4.tga");
	precache_pic("gfx/hud/fangsp2_5.tga");
	precache_pic("gfx/hud/fangsp2_6.tga");
	precache_pic("gfx/hud/fangsp2_7.tga");
	precache_pic("gfx/hud/fangsp2_8.tga");
	precache_pic("gfx/hud/fangsp2_9.tga");
	precache_pic("gfx/hud/fangsp3_0.tga");
	precache_pic("gfx/hud/fangsp3_1.tga");
	precache_pic("gfx/hud/fangsp3_2.tga");
	precache_pic("gfx/hud/fangsp3_3.tga");
	precache_pic("gfx/hud/fangsp3_4.tga");
	precache_pic("gfx/hud/fangsp3_5.tga");
	precache_pic("gfx/hud/fangsp3_6.tga");
	precache_pic("gfx/hud/fangsp3_7.tga");
	precache_pic("gfx/hud/fangsp3_8.tga");
	precache_pic("gfx/hud/fangsp3_9.tga");
	precache_pic("gfx/hud/fangsp4_0.tga");
	precache_pic("gfx/hud/fangsp4_1.tga");
	precache_pic("gfx/hud/fangsp4_2.tga");
	precache_pic("gfx/hud/fangsp4_3.tga");
	precache_pic("gfx/hud/fangsp4_4.tga");
	precache_pic("gfx/hud/fangsp4_5.tga");
	precache_pic("gfx/hud/fangsp4_6.tga");
	precache_pic("gfx/hud/fangsp4_7.tga");
	precache_pic("gfx/hud/fangsp4_8.tga");
	precache_pic("gfx/hud/fangsp4_9.tga");
	precache_pic("gfx/hud/fangsp5_0.tga");
	precache_pic("gfx/hud/fangsp5_1.tga");
	precache_pic("gfx/hud/fangsp5_2.tga");
	precache_pic("gfx/hud/fangsp5_3.tga");
	precache_pic("gfx/hud/fangsp5_4.tga");
	precache_pic("gfx/hud/fangsp5_5.tga");
	precache_pic("gfx/hud/fangsp5_6.tga");
	precache_pic("gfx/hud/fangsp5_7.tga");
	precache_pic("gfx/hud/fangsp5_8.tga");
	precache_pic("gfx/hud/fangsp5_9.tga");
	precache_pic("gfx/hud/fangsp6_0.tga");
	precache_pic("gfx/hud/fangsp6_1.tga");
	precache_pic("gfx/hud/fangsp6_2.tga");
	precache_pic("gfx/hud/fangsp6_3.tga");
	precache_pic("gfx/hud/fangsp6_4.tga");
	precache_pic("gfx/hud/fangsp6_5.tga");
	precache_pic("gfx/hud/fangsp6_6.tga");
	precache_pic("gfx/hud/fangsp6_7.tga");
	precache_pic("gfx/hud/fangsp6_8.tga");
	precache_pic("gfx/hud/fangsp6_9.tga");
	precache_pic("gfx/hud/fangsp7_0.tga");
	precache_pic("gfx/hud/fangsp7_1.tga");
	precache_pic("gfx/hud/fangsp7_2.tga");
	precache_pic("gfx/hud/fangsp7_3.tga");
	precache_pic("gfx/hud/fangsp7_4.tga");
	precache_pic("gfx/hud/fangsp7_5.tga");
	precache_pic("gfx/hud/fangsp7_6.tga");
	precache_pic("gfx/hud/fangsp7_7.tga");
	precache_pic("gfx/hud/fangsp7_8.tga");
	precache_pic("gfx/hud/fangsp7_9.tga");
	precache_pic("gfx/hud/fangsp8_0.tga");
	precache_pic("gfx/hud/fangsp8_1.tga");
	precache_pic("gfx/hud/fangsp8_2.tga");
	precache_pic("gfx/hud/fangsp8_3.tga");
	precache_pic("gfx/hud/fangsp8_4.tga");
	precache_pic("gfx/hud/fangsp8_5.tga");
	precache_pic("gfx/hud/fangsp8_6.tga");
	precache_pic("gfx/hud/fangsp8_7.tga");
	precache_pic("gfx/hud/fangsp8_8.tga");
	precache_pic("gfx/hud/fangsp8_9.tga");
	precache_pic("gfx/hud/fangsp9_0.tga");
	precache_pic("gfx/hud/fangsp9_1.tga");
	precache_pic("gfx/hud/fangsp9_2.tga");
	precache_pic("gfx/hud/fangsp9_3.tga");
	precache_pic("gfx/hud/fangsp9_4.tga");
	precache_pic("gfx/hud/fangsp9_5.tga");
	precache_pic("gfx/hud/fangsp9_6.tga");
	precache_pic("gfx/hud/fangsp9_7.tga");
	precache_pic("gfx/hud/fangsp9_8.tga");
	precache_pic("gfx/hud/fangsp9_9.tga");
	precache_pic("gfx/hud/glyph_red.tga");
	precache_pic("gfx/hud/health0.tga");
	precache_pic("gfx/hud/health1.tga");
	precache_pic("gfx/hud/health2.tga");
	precache_pic("gfx/hud/health3.tga");
	precache_pic("gfx/hud/health4.tga");
	precache_pic("gfx/hud/health5.tga");
	precache_pic("gfx/hud/health6.tga");
	precache_pic("gfx/hud/health7.tga");
	precache_pic("gfx/hud/health8.tga");
	precache_pic("gfx/hud/health9.tga");
	precache_pic("gfx/hud/healthp1_0.tga");
	precache_pic("gfx/hud/healthp1_1.tga");
	precache_pic("gfx/hud/healthp1_2.tga");
	precache_pic("gfx/hud/healthp1_3.tga");
	precache_pic("gfx/hud/healthp1_4.tga");
	precache_pic("gfx/hud/healthp1_5.tga");
	precache_pic("gfx/hud/healthp1_6.tga");
	precache_pic("gfx/hud/healthp1_7.tga");
	precache_pic("gfx/hud/healthp1_8.tga");
	precache_pic("gfx/hud/healthp1_9.tga");
	precache_pic("gfx/hud/healthp2_0.tga");
	precache_pic("gfx/hud/healthp2_1.tga");
	precache_pic("gfx/hud/healthp2_2.tga");
	precache_pic("gfx/hud/healthp2_3.tga");
	precache_pic("gfx/hud/healthp2_4.tga");
	precache_pic("gfx/hud/healthp2_5.tga");
	precache_pic("gfx/hud/healthp2_6.tga");
	precache_pic("gfx/hud/healthp2_7.tga");
	precache_pic("gfx/hud/healthp2_8.tga");
	precache_pic("gfx/hud/healthp2_9.tga");
	precache_pic("gfx/hud/healthp3_0.tga");
	precache_pic("gfx/hud/healthp3_1.tga");
	precache_pic("gfx/hud/healthp3_2.tga");
	precache_pic("gfx/hud/healthp3_3.tga");
	precache_pic("gfx/hud/healthp3_4.tga");
	precache_pic("gfx/hud/healthp3_5.tga");
	precache_pic("gfx/hud/healthp3_6.tga");
	precache_pic("gfx/hud/healthp3_7.tga");
	precache_pic("gfx/hud/healthp3_8.tga");
	precache_pic("gfx/hud/healthp3_9.tga");
	precache_pic("gfx/hud/healthp4_0.tga");
	precache_pic("gfx/hud/healthp4_1.tga");
	precache_pic("gfx/hud/healthp4_2.tga");
	precache_pic("gfx/hud/healthp4_3.tga");
	precache_pic("gfx/hud/healthp4_4.tga");
	precache_pic("gfx/hud/healthp4_5.tga");
	precache_pic("gfx/hud/healthp4_6.tga");
	precache_pic("gfx/hud/healthp4_7.tga");
	precache_pic("gfx/hud/healthp4_8.tga");
	precache_pic("gfx/hud/healthp4_9.tga");
	precache_pic("gfx/hud/healthp5_0.tga");
	precache_pic("gfx/hud/healthp5_1.tga");
	precache_pic("gfx/hud/healthp5_2.tga");
	precache_pic("gfx/hud/healthp5_3.tga");
	precache_pic("gfx/hud/healthp5_4.tga");
	precache_pic("gfx/hud/healthp5_5.tga");
	precache_pic("gfx/hud/healthp5_6.tga");
	precache_pic("gfx/hud/healthp5_7.tga");
	precache_pic("gfx/hud/healthp5_8.tga");
	precache_pic("gfx/hud/healthp5_9.tga");
	precache_pic("gfx/hud/healthp6_0.tga");
	precache_pic("gfx/hud/healthp6_1.tga");
	precache_pic("gfx/hud/healthp6_2.tga");
	precache_pic("gfx/hud/healthp6_3.tga");
	precache_pic("gfx/hud/healthp6_4.tga");
	precache_pic("gfx/hud/healthp6_5.tga");
	precache_pic("gfx/hud/healthp6_6.tga");
	precache_pic("gfx/hud/healthp6_7.tga");
	precache_pic("gfx/hud/healthp6_8.tga");
	precache_pic("gfx/hud/healthp6_9.tga");
	precache_pic("gfx/hud/healthp7_0.tga");
	precache_pic("gfx/hud/healthp7_1.tga");
	precache_pic("gfx/hud/healthp7_2.tga");
	precache_pic("gfx/hud/healthp7_3.tga");
	precache_pic("gfx/hud/healthp7_4.tga");
	precache_pic("gfx/hud/healthp7_5.tga");
	precache_pic("gfx/hud/healthp7_6.tga");
	precache_pic("gfx/hud/healthp7_7.tga");
	precache_pic("gfx/hud/healthp7_8.tga");
	precache_pic("gfx/hud/healthp7_9.tga");
	precache_pic("gfx/hud/healthp8_0.tga");
	precache_pic("gfx/hud/healthp8_1.tga");
	precache_pic("gfx/hud/healthp8_2.tga");
	precache_pic("gfx/hud/healthp8_3.tga");
	precache_pic("gfx/hud/healthp8_4.tga");
	precache_pic("gfx/hud/healthp8_5.tga");
	precache_pic("gfx/hud/healthp8_6.tga");
	precache_pic("gfx/hud/healthp8_7.tga");
	precache_pic("gfx/hud/healthp8_8.tga");
	precache_pic("gfx/hud/healthp8_9.tga");
	precache_pic("gfx/hud/healthp9_0.tga");
	precache_pic("gfx/hud/healthp9_1.tga");
	precache_pic("gfx/hud/healthp9_2.tga");
	precache_pic("gfx/hud/healthp9_3.tga");
	precache_pic("gfx/hud/healthp9_4.tga");
	precache_pic("gfx/hud/healthp9_5.tga");
	precache_pic("gfx/hud/healthp9_6.tga");
	precache_pic("gfx/hud/healthp9_7.tga");
	precache_pic("gfx/hud/healthp9_8.tga");
	precache_pic("gfx/hud/healthp9_9.tga");
	precache_pic("gfx/hud/msg_armor.tga");
	precache_pic("gfx/hud/msg_artifactA.tga");
	precache_pic("gfx/hud/msg_artifactB.tga");
	precache_pic("gfx/hud/msg_artifactC.tga");
	precache_pic("gfx/hud/msg_artifactD.tga");
	precache_pic("gfx/hud/msg_artifactE.tga");
	precache_pic("gfx/hud/msg_artifactF.tga");
	precache_pic("gfx/hud/msg_artifactG.tga");
	precache_pic("gfx/hud/msg_artifactH.tga");
	precache_pic("gfx/hud/msg_artifactI.tga");
	precache_pic("gfx/hud/msg_artifactJ.tga");
	precache_pic("gfx/hud/msg_coachgun.tga");
	precache_pic("gfx/hud/msg_coffer_key.tga");
	precache_pic("gfx/hud/msg_cysts.tga");
	precache_pic("gfx/hud/msg_dark_armor.tga");
	precache_pic("gfx/hud/msg_dark_helm.tga");
	precache_pic("gfx/hud/msg_dark_shard.tga");
	precache_pic("gfx/hud/msg_fangs.tga");
	precache_pic("gfx/hud/msg_glyph_red.tga");
	precache_pic("gfx/hud/msg_helm.tga");
	precache_pic("gfx/hud/msg_journal_update.tga");
	precache_pic("gfx/hud/msg_lifeblood_beaker.tga");
	precache_pic("gfx/hud/msg_lifeblood_vial.tga");
	precache_pic("gfx/hud/msg_load.tga");
	precache_pic("gfx/hud/msg_locked_blue.tga");
	precache_pic("gfx/hud/msg_locked_coffer.tga");
	precache_pic("gfx/hud/msg_locked_red.tga");
	precache_pic("gfx/hud/msg_locked_yellow.tga");
	precache_pic("gfx/hud/msg_ore.tga");
	precache_pic("gfx/hud/msg_retcher.tga");
	precache_pic("gfx/hud/msg_saved.tga");
	precache_pic("gfx/hud/msg_secret.tga");
	precache_pic("gfx/hud/msg_shard.tga");
	precache_pic("gfx/hud/msg_shells.tga");
	precache_pic("gfx/hud/msg_shotgun.tga");
	precache_pic("gfx/hud/msg_shrine.tga");
	precache_pic("gfx/hud/msg_sigil_flight.tga");
	precache_pic("gfx/hud/msg_slagcannon.tga");
	precache_pic("gfx/hud/msg_slugs.tga");
	precache_pic("gfx/hud/msg_spitter.tga");

	precache_pic("gfx/hud/shellsp1_0.tga");
	precache_pic("gfx/hud/shellsp1_1.tga");
	precache_pic("gfx/hud/shellsp1_2.tga");
	precache_pic("gfx/hud/shellsp1_3.tga");
	precache_pic("gfx/hud/shellsp1_4.tga");
	precache_pic("gfx/hud/shellsp1_5.tga");
	precache_pic("gfx/hud/shellsp1_6.tga");
	precache_pic("gfx/hud/shellsp1_7.tga");
	precache_pic("gfx/hud/shellsp1_8.tga");
	precache_pic("gfx/hud/shellsp1_9.tga");
	precache_pic("gfx/hud/shellsp2_0.tga");
	precache_pic("gfx/hud/shellsp2_1.tga");
	precache_pic("gfx/hud/shellsp2_2.tga");
	precache_pic("gfx/hud/shellsp2_3.tga");
	precache_pic("gfx/hud/shellsp2_4.tga");
	precache_pic("gfx/hud/shellsp2_5.tga");
	precache_pic("gfx/hud/shellsp2_6.tga");
	precache_pic("gfx/hud/shellsp2_7.tga");
	precache_pic("gfx/hud/shellsp2_8.tga");
	precache_pic("gfx/hud/shellsp2_9.tga");
	precache_pic("gfx/hud/shellsp3_0.tga");
	precache_pic("gfx/hud/shellsp3_1.tga");
	precache_pic("gfx/hud/shellsp3_2.tga");
	precache_pic("gfx/hud/shellsp3_3.tga");
	precache_pic("gfx/hud/shellsp3_4.tga");
	precache_pic("gfx/hud/shellsp3_5.tga");
	precache_pic("gfx/hud/shellsp3_6.tga");
	precache_pic("gfx/hud/shellsp3_7.tga");
	precache_pic("gfx/hud/shellsp3_8.tga");
	precache_pic("gfx/hud/shellsp3_9.tga");
	precache_pic("gfx/hud/shellsp4_0.tga");
	precache_pic("gfx/hud/shellsp4_1.tga");
	precache_pic("gfx/hud/shellsp4_2.tga");
	precache_pic("gfx/hud/shellsp4_3.tga");
	precache_pic("gfx/hud/shellsp4_4.tga");
	precache_pic("gfx/hud/shellsp4_5.tga");
	precache_pic("gfx/hud/shellsp4_6.tga");
	precache_pic("gfx/hud/shellsp4_7.tga");
	precache_pic("gfx/hud/shellsp4_8.tga");
	precache_pic("gfx/hud/shellsp4_9.tga");
	precache_pic("gfx/hud/shellsp5_0.tga");
	precache_pic("gfx/hud/shellsp5_1.tga");
	precache_pic("gfx/hud/shellsp5_2.tga");
	precache_pic("gfx/hud/shellsp5_3.tga");
	precache_pic("gfx/hud/shellsp5_4.tga");
	precache_pic("gfx/hud/shellsp5_5.tga");
	precache_pic("gfx/hud/shellsp5_6.tga");
	precache_pic("gfx/hud/shellsp5_7.tga");
	precache_pic("gfx/hud/shellsp5_8.tga");
	precache_pic("gfx/hud/shellsp5_9.tga");
	precache_pic("gfx/hud/shellsp6_0.tga");
	precache_pic("gfx/hud/shellsp6_1.tga");
	precache_pic("gfx/hud/shellsp6_2.tga");
	precache_pic("gfx/hud/shellsp6_3.tga");
	precache_pic("gfx/hud/shellsp6_4.tga");
	precache_pic("gfx/hud/shellsp6_5.tga");
	precache_pic("gfx/hud/shellsp6_6.tga");
	precache_pic("gfx/hud/shellsp6_7.tga");
	precache_pic("gfx/hud/shellsp6_8.tga");
	precache_pic("gfx/hud/shellsp6_9.tga");
	precache_pic("gfx/hud/shellsp7_0.tga");
	precache_pic("gfx/hud/shellsp7_1.tga");
	precache_pic("gfx/hud/shellsp7_2.tga");
	precache_pic("gfx/hud/shellsp7_3.tga");
	precache_pic("gfx/hud/shellsp7_4.tga");
	precache_pic("gfx/hud/shellsp7_5.tga");
	precache_pic("gfx/hud/shellsp7_6.tga");
	precache_pic("gfx/hud/shellsp7_7.tga");
	precache_pic("gfx/hud/shellsp7_8.tga");
	precache_pic("gfx/hud/shellsp7_9.tga");
	precache_pic("gfx/hud/shellsp8_0.tga");
	precache_pic("gfx/hud/shellsp8_1.tga");
	precache_pic("gfx/hud/shellsp8_2.tga");
	precache_pic("gfx/hud/shellsp8_3.tga");
	precache_pic("gfx/hud/shellsp8_4.tga");
	precache_pic("gfx/hud/shellsp8_5.tga");
	precache_pic("gfx/hud/shellsp8_6.tga");
	precache_pic("gfx/hud/shellsp8_7.tga");
	precache_pic("gfx/hud/shellsp8_8.tga");
	precache_pic("gfx/hud/shellsp8_9.tga");
	precache_pic("gfx/hud/shellsp9_0.tga");
	precache_pic("gfx/hud/shellsp9_1.tga");
	precache_pic("gfx/hud/shellsp9_2.tga");
	precache_pic("gfx/hud/shellsp9_3.tga");
	precache_pic("gfx/hud/shellsp9_4.tga");
	precache_pic("gfx/hud/shellsp9_5.tga");
	precache_pic("gfx/hud/shellsp9_6.tga");
	precache_pic("gfx/hud/shellsp9_7.tga");
	precache_pic("gfx/hud/shellsp9_8.tga");
	precache_pic("gfx/hud/shellsp9_9.tga");
	precache_pic("gfx/hud/slugsp1_0.tga");
	precache_pic("gfx/hud/slugsp1_1.tga");
	precache_pic("gfx/hud/slugsp1_2.tga");
	precache_pic("gfx/hud/slugsp1_3.tga");
	precache_pic("gfx/hud/slugsp1_4.tga");
	precache_pic("gfx/hud/slugsp1_5.tga");
	precache_pic("gfx/hud/slugsp1_6.tga");
	precache_pic("gfx/hud/slugsp1_7.tga");
	precache_pic("gfx/hud/slugsp1_8.tga");
	precache_pic("gfx/hud/slugsp1_9.tga");
	precache_pic("gfx/hud/slugsp2_0.tga");
	precache_pic("gfx/hud/slugsp2_1.tga");
	precache_pic("gfx/hud/slugsp2_2.tga");
	precache_pic("gfx/hud/slugsp2_3.tga");
	precache_pic("gfx/hud/slugsp2_4.tga");
	precache_pic("gfx/hud/slugsp2_5.tga");
	precache_pic("gfx/hud/slugsp2_6.tga");
	precache_pic("gfx/hud/slugsp2_7.tga");
	precache_pic("gfx/hud/slugsp2_8.tga");
	precache_pic("gfx/hud/slugsp2_9.tga");
	precache_pic("gfx/hud/slugsp3_0.tga");
	precache_pic("gfx/hud/slugsp3_1.tga");
	precache_pic("gfx/hud/slugsp3_2.tga");
	precache_pic("gfx/hud/slugsp3_3.tga");
	precache_pic("gfx/hud/slugsp3_4.tga");
	precache_pic("gfx/hud/slugsp3_5.tga");
	precache_pic("gfx/hud/slugsp3_6.tga");
	precache_pic("gfx/hud/slugsp3_7.tga");
	precache_pic("gfx/hud/slugsp3_8.tga");
	precache_pic("gfx/hud/slugsp3_9.tga");
	precache_pic("gfx/hud/slugsp4_0.tga");
	precache_pic("gfx/hud/slugsp4_1.tga");
	precache_pic("gfx/hud/slugsp4_2.tga");
	precache_pic("gfx/hud/slugsp4_3.tga");
	precache_pic("gfx/hud/slugsp4_4.tga");
	precache_pic("gfx/hud/slugsp4_5.tga");
	precache_pic("gfx/hud/slugsp4_6.tga");
	precache_pic("gfx/hud/slugsp4_7.tga");
	precache_pic("gfx/hud/slugsp4_8.tga");
	precache_pic("gfx/hud/slugsp4_9.tga");
	precache_pic("gfx/hud/slugsp5_0.tga");
	precache_pic("gfx/hud/slugsp5_1.tga");
	precache_pic("gfx/hud/slugsp5_2.tga");
	precache_pic("gfx/hud/slugsp5_3.tga");
	precache_pic("gfx/hud/slugsp5_4.tga");
	precache_pic("gfx/hud/slugsp5_5.tga");
	precache_pic("gfx/hud/slugsp5_6.tga");
	precache_pic("gfx/hud/slugsp5_7.tga");
	precache_pic("gfx/hud/slugsp5_8.tga");
	precache_pic("gfx/hud/slugsp5_9.tga");
	precache_pic("gfx/hud/slugsp6_0.tga");
	precache_pic("gfx/hud/slugsp6_1.tga");
	precache_pic("gfx/hud/slugsp6_2.tga");
	precache_pic("gfx/hud/slugsp6_3.tga");
	precache_pic("gfx/hud/slugsp6_4.tga");
	precache_pic("gfx/hud/slugsp6_5.tga");
	precache_pic("gfx/hud/slugsp6_6.tga");
	precache_pic("gfx/hud/slugsp6_7.tga");
	precache_pic("gfx/hud/slugsp6_8.tga");
	precache_pic("gfx/hud/slugsp6_9.tga");
	precache_pic("gfx/hud/slugsp7_0.tga");
	precache_pic("gfx/hud/slugsp7_1.tga");
	precache_pic("gfx/hud/slugsp7_2.tga");
	precache_pic("gfx/hud/slugsp7_3.tga");
	precache_pic("gfx/hud/slugsp7_4.tga");
	precache_pic("gfx/hud/slugsp7_5.tga");
	precache_pic("gfx/hud/slugsp7_6.tga");
	precache_pic("gfx/hud/slugsp7_7.tga");
	precache_pic("gfx/hud/slugsp7_8.tga");
	precache_pic("gfx/hud/slugsp7_9.tga");
	precache_pic("gfx/hud/slugsp8_0.tga");
	precache_pic("gfx/hud/slugsp8_1.tga");
	precache_pic("gfx/hud/slugsp8_2.tga");
	precache_pic("gfx/hud/slugsp8_3.tga");
	precache_pic("gfx/hud/slugsp8_4.tga");
	precache_pic("gfx/hud/slugsp8_5.tga");
	precache_pic("gfx/hud/slugsp8_6.tga");
	precache_pic("gfx/hud/slugsp8_7.tga");
	precache_pic("gfx/hud/slugsp8_8.tga");
	precache_pic("gfx/hud/slugsp8_9.tga");
	precache_pic("gfx/hud/slugsp9_0.tga");
	precache_pic("gfx/hud/slugsp9_1.tga");
	precache_pic("gfx/hud/slugsp9_2.tga");
	precache_pic("gfx/hud/slugsp9_3.tga");
	precache_pic("gfx/hud/slugsp9_4.tga");
	precache_pic("gfx/hud/slugsp9_5.tga");
	precache_pic("gfx/hud/slugsp9_6.tga");
	precache_pic("gfx/hud/slugsp9_7.tga");
	precache_pic("gfx/hud/slugsp9_8.tga");
	precache_pic("gfx/hud/slugsp9_9.tga");
};

// CSQC_Shutdown : Called every time the CSQC code is shutdown (changing maps, quitting, etc)
void CSQC_Shutdown(void) {};

// CSQC_ConsoleCommand : Used to parse commands in the console that have been registered with the "registercmd" function
// Return value should be 1 if CSQC handled the command, otherwise return 0 to have the engine handle it.
float CSQC_ConsoleCommand(string strMessage)
{
	local float nReturn;
	nReturn = true;
	// Tokenize String
	tokenize(strMessage);
	// Acquire Command
	local string strCmd;
	strCmd = argv(0);
	switch (strCmd)
	{
		default:
			nReturn = false;
			break;
	}

	return nReturn;
};

// CSQC_InputEvent : Used to perform actions based on any key pressed or released by the client.
// Return value should be 1 if CSQC handled the key press, otherwise return 0 to have the key passed to the engine.

float tether;
float dmenualpha;
float lastsoundjournal;

float CSQC_InputEvent(float bKeyReleased, float nKey, float n)
{
	if ((bKeyReleased == 0) && (DMselected >= 1))
	{
		if ((nKey == 512) && (dmenualpha == 1))	// mouse1
		{
			localcmd("crosshair 2\n");
			if (DMselected == 1)
			{
				write_tether2(1);
				localcmd("stopsound\n");
				localcmd("slowmo 1\n");
				localcmd("r_glsl_saturation 1\n");
				setcursormode(0);
				load_tether();
				localcmd("scratch3 0\n");
			}

			if (DMselected == 2)
			{
				write_shrine(1);
				localcmd("slowmo 1\n");
				localcmd("stopsound\n");
				localcmd("r_glsl_saturation 1\n");
				setcursormode(0);
				load_shrine();
				localcmd("scratch3 0\n");
			}

			if (DMselected == 3)
			{
				localcmd("slowmo 1\n");
				localcmd("stopsound\n");
				localcmd("r_glsl_saturation 1\n");
				setcursormode(0);
				load_autosave();
				localcmd("scratch3 0\n");
			}

			if (DMselected == 4)
			{
				localcmd("wmenu\n");
				localcmd("stopsound\n");
				localcmd("menu_cmd backtomainmenu\n");
				localcmd("scratch3 0\n");
				setcursormode(0);
			}

			return 1;
		}

		if ((nKey == (12 + 1)) && (dmenualpha == 1))	// enter
		{
			localcmd("crosshair 2\n");
			if (DMselected == 1)
			{
				write_tether2(1);
				rewritefriktether();
				localcmd("stopsound\n");
				localcmd("slowmo 1\n");
				localcmd("r_glsl_saturation 1\n");
				load_tether();
				localcmd("scratch3 0\n");
				setcursormode(0);
			}

			if (DMselected == 2)
			{
				write_shrine(1);
				localcmd("slowmo 1\n");
				localcmd("stopsound\n");
				localcmd("r_glsl_saturation 1\n");
				load_shrine();
				localcmd("scratch3 0\n");
				setcursormode(0);
			}

			if (DMselected == 3)
			{
				localcmd("slowmo 1\n");
				localcmd("stopsound\n");
				localcmd("r_glsl_saturation 1\n");
				setcursormode(0);
				load_autosave();
				localcmd("scratch3 0\n");
			}

			if (DMselected == 4)
			{
				localcmd("wmenu\n");
				localcmd("stopsound\n");
				localcmd("menu_cmd backtomainmenu\n");
				localcmd("scratch3 0\n");
				setcursormode(0);
			}

			return 1;
		}
	}

	float showjournal;
	showjournal = getstatf(STAT_JOURNAL);
	if ((bKeyReleased == 0) && (nKey == 27) && (showjournal > 0))
	{
		localcmd("impulse 35\n");
	}

	if ((showjournal > 0) && (journal_chapter == 3))
	{
		float selected_journal_page_bestiary;
		float jitems_bestiary;
		jitems_bestiary = getstatf(STAT_JOURNAL_MESSAGESM);
		if ((bKeyReleased == 0) && (nKey == 515))
		{
			if (journal_page_bestiary == 2)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 3)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 4)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (jitems_bestiary & JB_C) selected_journal_page_bestiary = 3;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 5)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (jitems_bestiary & JB_C) selected_journal_page_bestiary = 3;
				if (jitems_bestiary & JB_D) selected_journal_page_bestiary = 4;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 6)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (jitems_bestiary & JB_C) selected_journal_page_bestiary = 3;
				if (jitems_bestiary & JB_D) selected_journal_page_bestiary = 4;
				if (jitems_bestiary & JB_E) selected_journal_page_bestiary = 5;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 7)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (jitems_bestiary & JB_C) selected_journal_page_bestiary = 3;
				if (jitems_bestiary & JB_D) selected_journal_page_bestiary = 4;
				if (jitems_bestiary & JB_E) selected_journal_page_bestiary = 5;
				if (jitems_bestiary & JB_F) selected_journal_page_bestiary = 6;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}

			if (journal_page_bestiary == 8)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;
				if (jitems_bestiary & JB_B) selected_journal_page_bestiary = 2;
				if (jitems_bestiary & JB_C) selected_journal_page_bestiary = 3;
				if (jitems_bestiary & JB_D) selected_journal_page_bestiary = 4;
				if (jitems_bestiary & JB_E) selected_journal_page_bestiary = 5;
				if (jitems_bestiary & JB_F) selected_journal_page_bestiary = 6;
				if (jitems_bestiary & JB_G) selected_journal_page_bestiary = 7;
				if (selected_journal_page_bestiary > 0)
					journal_page_bestiary = selected_journal_page_bestiary;
			}
		}

		if ((bKeyReleased == 0) && (nKey == 516))
		{
			selected_journal_page_bestiary = 0;
			if (journal_page_bestiary == 1)
			{
				if (jitems_bestiary & JB_A) selected_journal_page_bestiary = 1;

				if (jitems_bestiary & JB_B)
					selected_journal_page_bestiary = 2;
				if ((!(jitems_bestiary & JB_B)) && (jitems_bestiary & JB_C))
					selected_journal_page_bestiary = 3;
				if ((!(jitems_bestiary & JB_B)) && (!(jitems_bestiary & JB_C)) && (jitems_bestiary & JB_D))
					selected_journal_page_bestiary = 4;
				if ((!(jitems_bestiary & JB_B)) && (!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (jitems_bestiary & JB_E))
					selected_journal_page_bestiary = 5;
				if ((!(jitems_bestiary & JB_B)) && (!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (jitems_bestiary & JB_F))
					selected_journal_page_bestiary = 6;
				if ((!(jitems_bestiary & JB_B)) && (!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_B)) && (!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 2)
			{
				if (jitems_bestiary & JB_C)
					selected_journal_page_bestiary = 3;
				if ((!(jitems_bestiary & JB_C)) && (jitems_bestiary & JB_D))
					selected_journal_page_bestiary = 4;
				if ((!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (jitems_bestiary & JB_E))
					selected_journal_page_bestiary = 5;
				if ((!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (jitems_bestiary & JB_F))
					selected_journal_page_bestiary = 6;
				if ((!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_C)) && (!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 3)
			{
				if ((jitems_bestiary & JB_D))
					selected_journal_page_bestiary = 4;
				if ((!(jitems_bestiary & JB_D)) && (jitems_bestiary & JB_E))
					selected_journal_page_bestiary = 5;
				if ((!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (jitems_bestiary & JB_F))
					selected_journal_page_bestiary = 6;
				if ((!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_D)) && (!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 4)
			{
				if ((jitems_bestiary & JB_E))
					selected_journal_page_bestiary = 5;
				if ((!(jitems_bestiary & JB_E)) && (jitems_bestiary & JB_F))
					selected_journal_page_bestiary = 6;
				if ((!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_E)) && (!!(jitems_bestiary & JB_F)) && (!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 5)
			{
				if ((jitems_bestiary & JB_F))
					selected_journal_page_bestiary = 6;
				if ((!(jitems_bestiary & JB_F)) && (jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_F)) && (!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 6)
			{
				if ((jitems_bestiary & JB_G))
					selected_journal_page_bestiary = 7;
				if ((!(jitems_bestiary & JB_G)) && (jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 8;
			}

			if (journal_page_bestiary == 7)
			{
				if ((jitems_bestiary & JB_H))
					selected_journal_page_bestiary = 7;
			}

			if (selected_journal_page_bestiary > 0)
				journal_page_bestiary = selected_journal_page_bestiary;
		}

		local float r;
		local string rsound;
		r = floor(random() *7) + 1;
		if (r == lastsoundjournal)
			r += 1;
		if (r > 7)
			r = 1;
		lastsoundjournal = r;
		rsound = ftos(r);
		if (selected_journal_page_bestiary > 0)
			localcmd(strcat("play2 sound/ui/journal/journal_page", rsound, ".ogg\n"));

		selected_journal_page_bestiary = 0;
	}

	if (using_cursor)
	{
		if (bKeyReleased == 0)
		{
			if (nKey == 512)
			{
				if ((journal_page_selected) && (mouse_inbutton > 0))
				{
					local float r;
					local string rsound;
					r = floor(random() *7) + 1;
					if (r == lastsoundjournal)
						r += 1;
					if (r > 7)
						r = 1;
					lastsoundjournal = r;
					rsound = ftos(r);
					localcmd(strcat("play2 sound/ui/journal/journal_page", rsound, ".ogg\n"));
				}

				//localsound ("playsound sounds/ui/journal/journal_page3.ogg\n");
				if ((journal_page_selected == 100) && (mouse_inbutton == 1))
				{
					if (journal_chapter == 2)
						journal_scroll -= 1;
					if (journal_chapter == 3)
						journal_scroll_bestiary -= 1;
					mouse_inbutton = 0;
				}

				if ((journal_page_selected == 101) && (mouse_inbutton == 1))
				{
					if (journal_chapter == 2)
					{
						if (journal_scroll >= 0)
							journal_scroll += 1;
					}

					if (journal_chapter == 3)
					{
						if (journal_scroll_bestiary >= 0)
							journal_scroll_bestiary += 1;
					}

					mouse_inbutton = 0;
				}

				if ((journal_page_selected == 200) && (mouse_inbutton == 2))
				{
					//journal_page = 1;
					//journal_scroll = 0;
					journal_chapter = 1;
					mouse_inbutton = 0;
				}

				if ((journal_page_selected == 201) && (mouse_inbutton == 2))
				{
					//journal_page = 1;
					//journal_scroll = 0;
					journal_chapter = 2;
					mouse_inbutton = 0;
				}

				if ((journal_page_selected == 202) && (mouse_inbutton == 2))
				{
					//journal_page = 1;
					//journal_scroll = 0;
					journal_chapter = 3;
					mouse_inbutton = 0;
				}

				if ((journal_page_selected == 203) && (mouse_inbutton == 2))
				{
					//journal_page = 1;
					//journal_scroll = 0;
					journal_chapter = 4;
					mouse_inbutton = 0;
				}

				if ((journal_page_selected > 300) && (mouse_inbutton == 2))
				{
					if (journal_page_selected)
					{
						if (journal_chapter == 1)
							journal_page_maps = journal_page_selected;
						if (journal_chapter == 2)
							journal_page_armory = journal_page_selected;
						if (journal_chapter == 3)
							journal_page_bestiary = journal_page_selected;
					}
				}

				if ((journal_page_selected < 100) && (mouse_inbutton == 1))
				{
					if (journal_page_selected)
					{
						if (journal_chapter == 1)
							journal_page_maps = journal_page_selected;
						if (journal_chapter == 2)
							journal_page_armory = journal_page_selected;
						if (journal_chapter == 3)
							journal_page_bestiary = journal_page_selected;
					}
				}

				firstscroll = 0;
				lastscroll = 0;
				mouse_inbutton = 0;
				journal_page_selected = 0;
				return TRUE;
			}
		}
	}

	local float bSkipKey;
	bSkipKey = false;
	return bSkipKey;
}

// END REQUIRED CSQC FUNCTIONS
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// BEGIN OPTIONAL CSQC FUNCTIONS

//#ifdef USE_CSQC_OPTIONALFUNCTIONS
// CSQC_Ent_Update : Called every frame that the server has indicated an update to the SSQC / CSQC entity has occured.
// The only parameter reflects if the entity is "new" to the client, meaning it just came into the client's PVS.
void CSQC_Ent_Update(float bIsNewEntity)
{
	self.enttype = ReadByte();
	if (self.enttype == ENT_HUDMSG)
		Hud_Messages(bIsNewEntity);
	if (self.enttype == ENT_HUDMSG2)
		Hud_Messages2(bIsNewEntity);
	if (self.enttype == ENT_HMMSG)
		Health_Indicator(bIsNewEntity);
	/*	
	if (self.enttype == ENT_ARTIFACT)
		artifact_spawn(bIsNewEntity); */
};

// CSQC_Ent_Remove : Called when the server requests a SSQC / CSQC entity to be removed.  Essentially call remove(self) as well.
void CSQC_Ent_Remove()
{
	if (self.enttype == ENT_HUDMSG)
		Remove_Message();
	else if (self.enttype == ENT_HUDMSG2)
		Remove_Message2();
	else
		remove(self);
};

// CSQC_Parse_StuffCmd : Provides the stuffcmd string in the first parameter that the server provided.  To execute standard behavior, simply execute localcmd with the string.
void CSQC_Parse_StuffCmd(string strMessage)
{
	localcmd(strMessage);
};

// CSQC_Parse_Print : Provides the print string in the first parameter that the server provided.  To execute standard behavior, simply execute print with the string.
void CSQC_Parse_Print(string strMessage)
{
	print(strMessage);
};

// CSQC_Parse_CenterPrint : Provides the centerprint string in the first parameter that the server provided.  To execute standard behavior, simply execute cprint with the string.
void CSQC_Parse_CenterPrint(string strMessage)
{
	centerprint(strMessage);
};

// CSQC_Parse_TempEntity : Handles all temporary entity network data in the CSQC layer.
// You must ALWAYS first acquire the temporary ID, which is sent as a byte.
// Return value should be 1 if CSQC handled the temporary entity, otherwise return 0 to have the engine process the event.
float CSQC_Parse_TempEntity()
{
	local float bHandled;
	bHandled = true;
	// Acquire TE ID
	local float nTEID;
	nTEID = ReadByte();
	switch (nTEID)
	{
		//case TE_GUNSHOT:
		//	Do something cool with TE_GUNSHOT!
		//	break;
		default:
			// No special logic for this temporary entity; return 0 so the engine can handle it
			bHandled = false;
			break;
	}

	return bHandled;
};
//endif	///////////////
