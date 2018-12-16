
//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

//  an ArrayList from external file: year_dates.txt
ArrayList<Date> dates; //an ArrayList of date objects

//  PImage to hold the background image
PImage background;
PImage caption;

//  (?)  don't delete
PVector vector;

//  mapping
float x_position;
float y_position;
float map_lat;
float map_lng;

//  dot sizes
float dot_size = 4;
float dot_size_hover = 15;
float dot_stroke_weight_hover = 2;

//  buttons
float button_width = 25;
float button_stroke_weight = 2;
float button_outline_stroke = 2;
float button_wall_offset = 35;
float button_vertical_offset = button_width*.5 + 15;
float button_outline_width = button_width + button_stroke_weight;
float button_alpha_noHover = 100;
float button_alpha_hover = 200;

// illustrations
float scale = 1;  //  'scale' is what the current image size is multiplied by, e.g. img.width*scale
float line_stroke_weight = button_outline_stroke;
int line_height = 75;
int line_length = 150;
float line_diameter = button_width;
float img_vertical_offset = 67;  // (measure mock line's y-axis in Illustrator, subtract from artboard's height)
float img_horizontal_offset = line_diameter*.5;

//  hover, dots
int alpha_on = 125;
int alpha_off = 0;

//  counter
int counter = 0;
float starttime = millis();
int counter_duration = 365;
float millis_multiplier = .05;  //  controls the speed of the counter; .15 ~= 60s/cycle; smaller number = faster
int sighting_duration = 3;  //  ('0'=just its date) the date range for which a dot shows up; e.g. '10' means a dot show up 10 days ahead of when its date matches the counter value, and stays 10 days after
//String s = String.valueOf(counter);  //  for testing the counter's value (not to be shown on final project)

//  sizes for clock
int handleDiameter = 15;
int clockArm = 250;  //  clock radius in pixels
float clockStroke = 2;  //outline of lines associated with clock
float clock_offset = (button_vertical_offset - button_width*.5)*.5 + button_width*.5;  //  how much the clock is raised up to accomodate the buttons

//  colors for clock
int clockStroke_R = 170;
int clockStroke_G = 165;
int clockStroke_B = 150;
int clockStroke_Alpha = 155;

//  clock text
int monthTextSize = 35;
int dayTextSize = 35;
int day_leading = 40;  //   controls the vertical spacing between month and day (doesn't function exactly like leading numbers would...)

//  title
float vertical_title_offset = clock_offset + 10;
int horizontal_title_offset = 15;
int title_leading = monthTextSize;
float title_line_length = 191;
float title_line_offset = 25;
float title_alpha = clockStroke_Alpha;
//  float title_off = 0;
boolean title_hover_rollover = false;
float caption_alpha = clockStroke_Alpha;
