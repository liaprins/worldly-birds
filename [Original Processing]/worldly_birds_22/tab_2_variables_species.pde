
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
PImage ostrich_img;
PImage crane_img;
PImage tern_img;
PImage puffin_img;
PImage swan_img;
PImage oriole_img;
PImage pelican_img;
PImage albatross_img;
PImage flicker_img;
PImage sandpiper_img;
PImage owl_img;
PImage wagtail_img;
PImage macaw_img;
PImage vireo_img;
PImage bee_img;
PImage kingfisher_img;
PImage pintail_img;
PImage swallow_img;
PImage shearwater_img;
PImage kite_img;
PImage penguin_img;
PImage swift_img;
PImage martin_img;
PImage galah_img;

//  ^A
//................................................................

//  INDIVIDUAL SPECIES: dot sizes, no hover, for button on
float dot_size_hummingbird = dot_size;
float dot_size_ostrich = dot_size;
float dot_size_crane = dot_size;
float dot_size_tern = dot_size;
float dot_size_puffin = dot_size;
float dot_size_swan = dot_size;
float dot_size_oriole = dot_size;
float dot_size_pelican = dot_size;
float dot_size_albatross = dot_size;
float dot_size_flicker = dot_size;
float dot_size_sandpiper = dot_size;
float dot_size_owl = dot_size;
float dot_size_wagtail = dot_size;
float dot_size_macaw = dot_size;
float dot_size_vireo = dot_size;
float dot_size_bee = dot_size;
float dot_size_kingfisher = dot_size;
float dot_size_pintail = dot_size;
float dot_size_swallow = dot_size;
float dot_size_shearwater = dot_size;
float dot_size_kite = dot_size;
float dot_size_penguin = dot_size;
float dot_size_swift = dot_size;
float dot_size_martin = dot_size;
float dot_size_galah = dot_size;

//  ^B
//................................................................

//  INDIVIDUAL SPECIES: dot alpha, for hover & on/off
int hummingbird_dot_alpha = alpha_on;
int ostrich_dot_alpha = alpha_on;
int crane_dot_alpha = alpha_on;
int tern_dot_alpha = alpha_on;
int puffin_dot_alpha = alpha_on;
int swan_dot_alpha = alpha_on;
int oriole_dot_alpha = alpha_on;
int pelican_dot_alpha = alpha_on;
int albatross_dot_alpha = alpha_on;
int flicker_dot_alpha = alpha_on;
int sandpiper_dot_alpha = alpha_on;
int owl_dot_alpha = alpha_on;
int wagtail_dot_alpha = alpha_on;
int macaw_dot_alpha = alpha_on;
int vireo_dot_alpha = alpha_on;
int bee_dot_alpha = alpha_on;
int kingfisher_dot_alpha = alpha_on;
int pintail_dot_alpha = alpha_on;
int swallow_dot_alpha = alpha_on;
int shearwater_dot_alpha = alpha_on;
int kite_dot_alpha = alpha_on;
int penguin_dot_alpha = alpha_on;
int swift_dot_alpha = alpha_on;
int martin_dot_alpha = alpha_on;
int galah_dot_alpha = alpha_on;

//  ^C

//  INDIVIDUAL SPECIES: dot stroke alpha, for hover & on/off
int hummingbird_stroke_alpha = alpha_on;
int ostrich_stroke_alpha = alpha_on;
int crane_stroke_alpha = alpha_on;
int tern_stroke_alpha = alpha_on;
int puffin_stroke_alpha = alpha_on;
int swan_stroke_alpha = alpha_on;
int oriole_stroke_alpha = alpha_on;
int pelican_stroke_alpha = alpha_on;
int albatross_stroke_alpha = alpha_on;
int flicker_stroke_alpha = alpha_on;
int sandpiper_stroke_alpha = alpha_on;
int owl_stroke_alpha = alpha_on;
int wagtail_stroke_alpha = alpha_on;
int macaw_stroke_alpha = alpha_on;
int vireo_stroke_alpha = alpha_on;
int bee_stroke_alpha = alpha_on;
int kingfisher_stroke_alpha = alpha_on;
int pintail_stroke_alpha = alpha_on;
int swallow_stroke_alpha = alpha_on;
int shearwater_stroke_alpha = alpha_on;
int kite_stroke_alpha = alpha_on;
int penguin_stroke_alpha = alpha_on;
int swift_stroke_alpha = alpha_on;
int martin_stroke_alpha = alpha_on;
int galah_stroke_alpha = alpha_on;

//  ^D
//................................................................

//  INDIVIDUAL SPECIES: alphas for button fills
float hummingbird_button_fill_alpha = button_alpha_hover;
float ostrich_button_fill_alpha = button_alpha_hover;
float crane_button_fill_alpha = button_alpha_hover;
float tern_button_fill_alpha = button_alpha_hover;
float puffin_button_fill_alpha = button_alpha_hover;
float swan_button_fill_alpha = button_alpha_hover;
float oriole_button_fill_alpha = button_alpha_hover;
float pelican_button_fill_alpha = button_alpha_hover;
float albatross_button_fill_alpha = button_alpha_hover;
float flicker_button_fill_alpha = button_alpha_hover;
float sandpiper_button_fill_alpha = button_alpha_hover;
float owl_button_fill_alpha = button_alpha_hover;
float wagtail_button_fill_alpha = button_alpha_hover;
float macaw_button_fill_alpha = button_alpha_hover;
float vireo_button_fill_alpha = button_alpha_hover;
float bee_button_fill_alpha = button_alpha_hover;
float kingfisher_button_fill_alpha = button_alpha_hover;
float pintail_button_fill_alpha = button_alpha_hover;
float swallow_button_fill_alpha = button_alpha_hover;
float shearwater_button_fill_alpha = button_alpha_hover;
float kite_button_fill_alpha = button_alpha_hover;
float penguin_button_fill_alpha = button_alpha_hover;
float swift_button_fill_alpha = button_alpha_hover;
float martin_button_fill_alpha = button_alpha_hover;
float galah_button_fill_alpha = button_alpha_hover;

//  ^E

//  INDIVIDUAL SPECIES: alphas for button strokes
float hummingbird_button_stroke_alpha = alpha_off;
float ostrich_button_stroke_alpha = alpha_off;
float crane_button_stroke_alpha = alpha_off;
float tern_button_stroke_alpha = alpha_off;
float puffin_button_stroke_alpha = alpha_off;
float swan_button_stroke_alpha = alpha_off;
float oriole_button_stroke_alpha = alpha_off;
float pelican_button_stroke_alpha = alpha_off;
float albatross_button_stroke_alpha = alpha_off;
float flicker_button_stroke_alpha = alpha_off;
float sandpiper_button_stroke_alpha = alpha_off;
float owl_button_stroke_alpha = alpha_off;
float wagtail_button_stroke_alpha = alpha_off;
float macaw_button_stroke_alpha = alpha_off;
float vireo_button_stroke_alpha = alpha_off;
float bee_button_stroke_alpha = alpha_off;
float kingfisher_button_stroke_alpha = alpha_off;
float pintail_button_stroke_alpha = alpha_off;
float swallow_button_stroke_alpha = alpha_off;
float shearwater_button_stroke_alpha = alpha_off;
float kite_button_stroke_alpha = alpha_off;
float penguin_button_stroke_alpha = alpha_off;
float swift_button_stroke_alpha = alpha_off;
float martin_button_stroke_alpha = alpha_off;
float galah_button_stroke_alpha = alpha_off;

//  ^F
//................................................................

//  INDIVIDUAL SPECIES: boolean hover for button
boolean hover_hummingbird_button = false;
boolean hover_ostrich_button = false;
boolean hover_crane_button = false;
boolean hover_tern_button = false;
boolean hover_puffin_button = false;
boolean hover_swan_button = false;
boolean hover_oriole_button = false;
boolean hover_pelican_button = false;
boolean hover_albatross_button = false;
boolean hover_flicker_button = false;
boolean hover_sandpiper_button = false;
boolean hover_owl_button = false;
boolean hover_wagtail_button = false;
boolean hover_macaw_button = false;
boolean hover_vireo_button = false;
boolean hover_bee_button = false;
boolean hover_kingfisher_button = false;
boolean hover_pintail_button = false;
boolean hover_swallow_button = false;
boolean hover_shearwater_button = false;
boolean hover_kite_button = false;
boolean hover_penguin_button = false;
boolean hover_swift_button = false;
boolean hover_martin_button = false;
boolean hover_galah_button = false;

//  ^G
//................................................................

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
int b_sandpiper = 0;

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
int b_shearwater = 179;

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

int r_galah = 172;
int g_galah = 55;
int b_galah = 108;

//................................................................

//  INDIVIDUAL SPECIES: in case the line between illustration and name needs to be longer or shorter (for species on both sides, negative = shorter)
int hummingbird_line_edit = 0;
int ostrich_line_edit = 0;
int crane_line_edit = 0;
int tern_line_edit = 0;
int puffin_line_edit = 0;
int swan_line_edit = 0;
int oriole_line_edit = 0;
int pelican_line_edit = 0;
int albatross_line_edit = 0;
int flicker_line_edit = 0;
int sandpiper_line_edit = 0;
int owl_line_edit = 0;
int wagtail_line_edit = 0;
int macaw_line_edit = 0;
int vireo_line_edit = 0;
int bee_line_edit = 0;
int kingfisher_line_edit = 0;
int pintail_line_edit = 0;
int swallow_line_edit = 0;
int shearwater_line_edit = 0;
int kite_line_edit = 0;
int penguin_line_edit = 0;
int swift_line_edit = 0;
int martin_line_edit = 0;
int galah_line_edit = 0;

//  ^H
