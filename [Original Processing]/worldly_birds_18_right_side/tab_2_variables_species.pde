
//  species' color codes, dot sizes, dot alphas, button alphas and button booleans are listed here
//  see for-loop in void draw for all species' dot and stroke colors


//  INDIVIDUAL SPECIES: colorcodes (string 1) to determine species, dot colors
String hummingbird_color_code = "hummingbird";
String ostrich_color_code = "ostrich";
String crane_color_code = "crane";
String tern_color_code = "tern";
String puffin_color_code = "puffin";
String swan_color_code = "swan";
String oriole_color_code = "oriole";
String pelican_color_code = "pelican";
String albatross_color_code = "albatross";
String flicker_color_code = "flicker";
String sandpiper_color_code = "sandpiper";
String owl_color_code = "owl";
String wagtail_color_code = "wagtail";
String macaw_color_code = "macaw";
String vireo_color_code = "vireo";
String bee_color_code = "bee";
String kingfisher_color_code = "kingfisher";
String pintail_color_code = "pintail";
String swallow_color_code = "swallow";
String shearwater_color_code = "shearwater";
String kite_color_code = "kite";
String penguin_color_code = "penguin";
String swift_color_code = "swift";
String martin_color_code = "martin";
String galah_color_code = "galah";

//................................................................

//  PImage to hold bird illustrations for hover
PImage hummingbird_img;

//................................................................

//  INDIVIDUAL SPECIES: dot sizes, no hover, for button on
float dot_size_swallow = dot_size;

//................................................................

//  INDIVIDUAL SPECIES: dot alpha, for hover & on/off
int swallow_dot_alpha = alpha_on;

//  INDIVIDUAL SPECIES: dot stroke alpha, for hover & on/off
int swallow_stroke_alpha = alpha_on;

//................................................................

//  INDIVIDUAL SPECIES: alphas for button fills
float swallow_button_fill_alpha = button_alpha_hover;

//  INDIVIDUAL SPECIES: alphas for button strokes
float swallow_button_stroke_alpha = alpha_off;

//................................................................

//  INDIVIDUAL SPECIES: boolean hover for button
boolean hover_swallow_button = false;

//  INDIVIDUAL SPECIES: RGB values
int r_hummingbird = 194;
int g_hummingbird = 49;
int b_hummingbird = 86;

int r_ostrich = 215;
int g_ostrich = 40;
int b_ostrich = 62;

int r_crane = 237;
int g_crane = 28;
int b_crane = 36;

int r_tern = 239;
int g_tern = 70;
int b_tern = 35;

int r_puffin = 242;
int g_puffin = 101;
int b_puffin = 34;

int r_swan = 244;
int g_swan = 125;
int b_swan = 32;

int r_oriole = 247;
int g_oriole = 148;
int b_oriole = 30;

int r_pelican = 251;
int g_pelican = 169;
int b_pelican = 25;

int r_albatross = 255;
int g_albatross = 194;
int b_albatross = 14;

int r_flicker = 255;
int g_flicker = 216;
int b_flicker = 0;

int r_sandpiper = 249;
int g_sandpiper = 229;
int b_sandpiper_color = 0;

int r_owl = 217;
int g_owl = 224;
int b_owl = 33;

int r_wagtail = 171;
int g_wagtail = 208;
int b_wagtail = 55;

int r_macaw = 125;
int g_macaw = 194;
int b_macaw = 66;

int r_vireo = 57;
int g_vireo = 181;
int b_vireo = 74;

int r_bee = 49;
int g_bee = 163;
int b_bee = 110;

int r_kingfisher = 42;
int g_kingfisher = 149;
int b_kingfisher = 141;

int r_pintail = 34;
int g_pintail = 132;
int b_pintail = 166;

int r_swallow = 27;
int g_swallow = 117;
int b_swallow = 188;

int r_shearwater = 70;
int g_shearwater = 107;
int b_shearwater = 79;

int r_kite = 93;
int g_kite = 95;
int b_kite = 170;

int r_penguin = 113;
int g_penguin = 81;
int b_penguin = 161;

int r_swift = 127;
int g_swift = 63;
int b_swift = 152;

int r_martin = 151;
int g_martin = 59;
int b_martin = 129;

int r_galah_color = 172;
int g_galah_color = 55;
int b_galah_color = 108;

//  INDIVIDUAL SPECIES: in case the line between illustration and name needs to be longer or shorter (for species on both sides, negative = shorter)
int swallow_line_edit = 0;
