.string map;
float CHAN_WEAPON2 = 6;
float CHAN_VOICE2 = 7;
.float wrathflags;

float FL_GARBAGE = 1;
float FL_RESPAWN = 2;
float FL_SHOOTER = 4;
float FL_TOSS = 8;
float FL_SPAWNER = 16;

.vector oldangles;
.float nojump;

.entity oldgroundentity;

//void(vector org, float class) blood_decal;	// = 

//.float gravity;
//.float stepheight_delta;	// modifier for stepheight
//
//globals
//
float movedist;
//float	gameover;		//setwhenaruleexits
string string_null;	//nullstring,nothingshouldbeheldhere
entity newmis;	//launch_spikesetsthisafterspawningit
entity activator;	//theentitythatactivatedatriggerorbrush
entity damage_attacker;	//setbyT_Damage
//float	framecount;
float skill;
.float timelightning1;
.float timelightning2;
.float timelightning3;
.float death_time_sound;
.float deathanim;
.float deathframe;

//.float		worldtype;	// 0=medieval 1=metal 2=base

//
//subs
//
.void() think1;
.vector finaldest, finalangle;
.vector rel_origin;	//thisistheoriginasiftheobjecthadnevermovedrelatively

//
//misc
//
.float dmg;
.float style;
.float speed;
.float height;
.float state;
.float pausetime;
.float wait;	//timefromfiringtorestarting
.float delay;	//timefromactivationtofiring
.float cnt;	//miscflag
.entity movetarget;
.entity goalentity;
.string killtarget;
.vector pos1, pos2;	//topandbottompositions
.vector dest, dest1, dest2;
.vector mangle;	//angleatstart
.float t_length, t_width;
.float count;	// for counting triggers
.float touchtime;
.float using;
.float inactive;
.float rad_sound;	// radius sound;
.float volume;
.string target2;
//
//sprites
//
.vector spriteorg;
.vector oangles;
.float pframe;
.float dframe;
//.float fscale;
.entity msprite;
//.float fake_illumination;
float globalfake_illumination;

//
//player
//
.float super_damage_finished;
.float invincible_finished;
//.float	invisible_finished;
//.float	invincible_time,invincible_sound;
//.float	invisible_time,invisible_sound;
//.float	super_time,super_sound;
//.float	rad_time;
.float fly_sound;
.float super_damage_finished;
.float radsuit_finished;
.float swim_flag;
.float air_finished;	//whentime>air_finished,startdrowning
.string deathtype;
.float crouch;
.float attemptcrouch;
.float maxspeed;
.float timefootstep;
.float luse;
.float roaming;
.float roamingtime;
.float aflag;

.float footstepvol;
.float footstepcrouchvol;

.float healthpulsetime;
.float rhealthpulsetime;	//secondary timing to reset pulse

.float armorpulsetime;
.float rarmorpulsetime;	//secondary timing to reset pulse

.float slugspulsetime;
.float rslugspulsetime;	//secondary timing to reset pulse

.float shellspulsetime;
.float rshellspulsetime;	//secondary timing to reset pulse

.float retcherpulsetime;
.float rretcherpulsetime;	//secondary timing to reset pulse

.float spitterpulsetime;
.float rspitterpulsetime;	//secondary timing to reset pulse

.float armorpulsetime;
.float rarmorpulsetime;	//secondary timing to reset pulse

.float darmorpulsetime;
.float rdarmorpulsetime;	//secondary timing to reset pulse

//
//Weapons
//
//.float	ammo;
.float ammo_coachgun;
.float ammo_bombs;
.float ammo_cannon;
.float ammo_spitter;
.float ammo_retcher;
.float ammo_spitter;
.float ammo_shotgun;

//.string vweaponmodel;
.float vweaponframe;
.float vgearframe;
.entity vgear;
.entity vbullet;
.entity vbullet2;

.float vgeartime;
.float vgearframetime;
.float vgearfps;
.float vgearrelease;

.float vweaponskin;
.vector vweaponglowmod;

//.float timevweapon;
.float timesound;
.float draw_w;
.float bloody;
//
//items
//

//.float bobitem;
.float rarmorvalue;
.float darmorvalue;

vector artifact_size;
vector dark_helm_size;
vector dark_armor_size;
vector dark_shard_size;
vector helm_size;
vector armor_size;
vector shard_size;
vector coffer_key_size;

vector artifact_nsize;
vector dark_helm_nsize;
vector dark_armor_nsize;
vector dark_shard_nsize;
vector helm_nsize;
vector armor_nsize;
vector shard_nsize;
vector coffer_key_nsize;

vector heart_size;
vector chalice_size;
vector vial_size;
vector beaker_size;
vector resin_size;
vector resinl_size;
vector ore_size;
vector orel_size;
vector explosives_size;
vector explosivesl_size;
vector shells_size;
vector shellsl_size;
vector slag_size;
vector spitter_size;
vector retcher_size;
vector coach_size;
vector slag_nsize;
vector spitter_nsize;
vector retcher_nsize;
vector coach_nsize;

//
//player&ai
//
.float pain_finished;
.float show_hostile;	//settotime+0.2wheneveraclientfiresa
//weaponortakesdamage.Usedtoalert
//monstersthatotherwisewouldlettheplayergo

//
//ai
//
.void() th_charge;
.void() th_stand;
.void() th_walk;
.void() th_run;
.void() th_missile;
.void() th_melee;
.void(entity attacker, float damage) th_pain;
.void() th_die;
.entity oldenemy;	//madatthisplayerbeforetakingdamage
.float lefty;
.float search_time;
.float attack_state;
.float attack_finished;
.float waitmin;
//.float waitmax;
float AS_STRAIGHT = 1;
float AS_SLIDING = 2;
float AS_MELEE = 3;
float AS_MISSILE = 4;

.float painsnd;
.float chattersnd;
.float attacksnd;
.float walksnd;
//.float sightsnd;
.float stunned;
.float execution_animation;
.float execution;
.entity execution_enemy;
.float glowmeleetime;
.float execution_enemy_spotted;
.float sight_time;
.float jmpsound;
.string noise1;
.string noise2;
.string noise3;
.float friendly_monster;

//
//func_water
//
.string cshift;
.float fwatershift;
.float fwatershifttime;
.float speed2;
.float zerogtime;
.float drag;
.float oldgravity;
//.float viewalpha;
//.vector viewcolor;
void() CheckFuncWaterDeath;

.vector ldorigin;
.vector ldtdest;

//
//funcs
//
.float usable;
.float lip;
//.string		noise4;
//.entity		trigger_field;	// door's trigger entity
.entity duser;

//
//FRIK FILES
//
.string dvweapon_model;
.float dvweapon_x;
.float dvweapon_y;
.float dvweapon_z;
.float dvweapon_scale;
.vector vweaponangles;

.string vvweapon_model;
.float vvweapon_x;
.float vvweapon_y;
.float vvweapon_z;
.float vvweapon_scale;
.vector vvweaponangles;

.float cgvweapon_x;
.float cgvweapon_y;
.float cgvweapon_z;
.float cgvweapon_scale;
.vector cgweaponangles;

.float svweapon_x;
.float svweapon_y;
.float svweapon_z;
.float svweapon_scale;
.vector sweaponangles;

.float pvweapon_x;
.float pvweapon_y;
.float pvweapon_z;
.float pvweapon_scale;
.vector pweaponangles;

.float rvweapon_x;
.float rvweapon_y;
.float rvweapon_z;
.float rvweapon_scale;
.vector rweaponangles;

.float cvweapon_x;
.float cvweapon_y;
.float cvweapon_z;
.float cvweapon_scale;
.vector cweaponangles;

.float coachgun_damage1;
.float coachgun_damage2;
.float coachgun_time1;
.float coachgun_time2;
.float coachgun_spread1;
.float coachgun_spread2;
.string coachgun_model;
.float coachgunclip;
.string coachgun_muzzleflash_model;
.float coachgun_muzzleflash_scale;
.vector coachgun_muzzle_pos1;
.vector coachgun_muzzle_pos2;
.vector coachgun_muzzle_pos3;
.float precoachgunclip;

.float shotgunclip;

.float voidbombs_damage1;
.float voidbombs_damage2;
.float voidbombs_time1;
.float voidbombs_time2;
.string voidbombs_model;
//.float voidbombs_wait;

.float slagcannon_damage1;
.float slagcannon_damage2;
.float slagcannon_time1;
.float slagcannon_time2;
.float holdcannon;
.float holdcannontime;
//.float holdcannonsnd;
.float slagcannonspread;
.float holdslagtime1;
.float holdslagtime2;
.float slagcannonangle;
.float slagcannonangle2;

.string slagcannon_model;

.float flamethrower_damage1;
.float flamethrower_damage1a;
.float flamethrower_damage2;
.float flamethrower_damage2a;
.float flamethrower_time1;
.float flamethrower_time2;
.string flamethrower_model;

//string cmonster1;
//string cmonster2;
//string cmonster3;
//string cmonster4;
//string cmonster5;
//string cmonster6;
//string cmonster7;
//string cmonster8;

//float cmonster_health;
//float cmonster_melee;
//float cmonster_melee_time;

//float cmonster_missile;
//float cmonster_missile_time;

//float cmonster_missile_type;
//float cmonster_missile_speed;
//float cmonster_missile_ammount;
//float cmonster_missile_movetype;
//float cmonster_missile_effects;

//float cmonster_speed;
//string cmonster_model;
//string cmonster_missile_model;

///radialmenu
.float radial_time;
.float radialactive;
.float rmenu;
.float radialruning;

.float LifeSiphon;
.float LifeSiphon_time;

.float SoulTether;
.float Tether_time;

.float DrownerApp;
.float DrownerApp_time;

.float TrinketofRespite;
float TrinketofRespite_time;

.float Aegis;
.float Aegis_time;

////coffer 

.float coffer;
.float coffer_ammo;
.float coffer_armor;
.float coffer_artifacts;
.float coffer_health;
//.float coffer_ammo;

.float bfg;

//////weapons
float devscreen;	// On/off for the flashlight
.float flash_flag;	// On/off for the flashlight
.entity flash;	// flash entity
.float use_finished;
.string classentity;

.float oldweaponn;
.float melee_runes;
.float melee_skin;
.float melee_kills;
.float melee_kill_time;
.float melee_kill_uber;
.float melee_charging;

.float lastweapon;

.float fall_state;

.float dmg_h;
.float dmg_t;
.float dmg_f;
.string model2;
.string particleffect;
.string tagorg2;
.float pick_up_time;

.vector lb_org;
.vector lb_org2;
.vector lb_dest;
.vector lb_dest2;
.float lb_active;
/////////////////////////////////

.float lspeedtime;
.float only_damage_monster;
.float journal;
.float time_fade;
.float heavymonster;
.float oldframe;
.vector oldvelocity;
.float nopain;
///////////////////////////////////end of qc file

.float respawnable;

.float classmonster;
.float classmonster1;
.float classmonster2;
.float classmonster3;
.float classmonster4;
.float classmonster5;

.float pathed;
.float pathtime;

.void() olduse;
.void() oldthink;
.void() oldtouch;
.float oldsolid;
.float oldeffects;
.float oldwait;
.float oldcount;
.float olddelay;
.string oldtarget;
.string oldtargetname;