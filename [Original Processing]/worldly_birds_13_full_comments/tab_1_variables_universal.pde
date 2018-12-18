

//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

//  an ArrayList from external file: year_dates.txt
ArrayList<Date> dates; //an ArrayList of date objects

//  counter
int counter = 1;
float starttime = millis();
int counter_duration = 365;
float millis_multiplier = .15;  //  controls the speed of the counter; .15 ~= 60s/cycle; smaller number = faster
int sighting_duration = 3;  //  ('0'=just its date) the date range for which a dot shows up; e.g. '10' means a dot show up 10 days ahead of when its date matches the counter value, and stays 10 days after
//String s = String.valueOf(counter);  //  for testing the counter's value (not to be shown on final project)

//  typography
int monthTextSize = 35;
int dayTextSize = 35;
int day_leading = 40;  //   controls the vertical spacing between month and day (doesn't function exactly like leading numbers would...)

//  sizes for clock
int handleDiameter = 15;
int clockArm = 250;  //  clock radius in pixels
float clockStroke = 2;  //outline of lines associated with clock

//  colors for clock
int clockStroke_R = 170;
int clockStroke_G = 165;
int clockStroke_B = 150;
int clockStroke_Alpha = 155;

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
float button_wall_offset = 25;
float button_vertical_offset = button_wall_offset;
int button_width = 30;
float button_stroke_weight = 3;

//  hover, dots
int alpha_on = 125;
int alpha_off = 0;

float button_alpha_noHover = 100;
float button_alpha_hover = 200;
