/*
parent file = dots18.pde

Hover over button and sighting dots for swallow show up bigger, also image appears. Both effects stop when roll off of image.
Click button and it turns test dot on/off with alpha.

1. Make click on and off work for alpha of the species' dots whose button it is.
2. Make stripey image for on/off over button.
3. Make all buttons have placeholder images so that all that needs to be done is add illustrated birds.
4. Make all buttons (functional). 
5. Add tabs. 
...
6. Worldly Birds hover explanation.
7. Pause/play timer.
8. Scrub timer.

PROBLEMS:

Can't get it to make the sighting dots bigger when I hover over them. Right now I am planning to not have this feature.


COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  separates void setup from void draw, etc.
    
//................................................................  separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

int alpha_test = 255;
color test_color = color(194,49,86, alpha_test);
int radius_test = 25;

//  %%%% TESTING HOVER %%%%
boolean hover_swallow_button = false;
boolean hover_swallow_dot = false;
float x_position;
float y_position;
float map_lat;
float map_lng;

//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

//  an ArrayList from external file: year_dates.txt
ArrayList<Date> dates; //an ArrayList of date objects

//  counter
int counter = 1;
float starttime = millis();
int counter_duration = 365;
float millis_multiplier = .025;  //  controls the speed of the counter; .15 ~= 60s/cycle; smaller number = faster
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

//  dots
float dot_size = 4;
float dot_size_hover = 15;
int dot_alpha = 50;

float dot_size_swallow = dot_size;
//float dot_size_swallow = 15;

int dot_size_none = 0;

//  buttons
float button_wall_offset = 25;
float button_vertical_offset = button_wall_offset;
int button_spacing = 20;
int button_width = 30;

//................................................................

//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//  species colors and colorcodes
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
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

float swallow_dot_alpha = 100;

//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
color hummingbird_color = color(194,49,86, dot_alpha);
color ostrich_color = color(215,40,62,  dot_alpha);
color crane_color = color(237,28,36,  dot_alpha);
color tern_color = color(239,70,35,  dot_alpha);
color puffin_color = color(242,101,34,  dot_alpha);
color swan_color = color(244,125,32,  dot_alpha);
color oriole_color = color(247,148,30,  dot_alpha);
color pelican_color = color(251,169,25,  dot_alpha);
color albatross_color = color(255,194,14,  dot_alpha);
color flicker_color = color(255,216,0,  dot_alpha);
color sandpiper_color = color(249,229,0,  dot_alpha);
color owl_color = color(217,224,33,  dot_alpha);
color wagtail_color = color(171,208,55,  dot_alpha);
color macaw_color = color(125,194,66,  dot_alpha);
color vireo_color = color(57,181,74,  dot_alpha);
color bee_color = color(49,163,110,  dot_alpha);
color kingfisher_color = color(42,149,141,  dot_alpha);
color pintail_color = color(34,132,166,  dot_alpha);
color swallow_color = color(27,117,188,  swallow_dot_alpha);
color shearwater_color = color(70,107,79,  dot_alpha);
color kite_color = color(93,95,170,  dot_alpha);
color penguin_color = color(113,81,161,  dot_alpha);
color swift_color = color(127,63,152,  dot_alpha);
color martin_color = color(151,59,129,  dot_alpha);
color galah_color = color(172,55,108,  dot_alpha);
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

//  PImage to hold bird illustrations for hover
PImage hummingbird_img;

//  PImage to hold the background image
PImage background;


//----------------------------------------------------------------


void setup(){
  
  //  load map image
  background = loadImage("world_map.png"); 
  
  //  load bird illustrations
  hummingbird_img = loadImage("hummingbird.png");
  
  size(1250,625);
  
  //  frameRate works with millis (in void draw) to make speed of counter
  frameRate(60);
      
  //  so that nothing will have a stroke unless it is called
  noStroke();
  
  //  typography
  PFont font; 
  font = loadFont("Gotham_Light_100.vlw");
  textFont(font, monthTextSize);
 
  //  the length of the clock arm when it points to 12 o'clock, before rotating
  vector = new PVector(0, clockArm); 
  
  //................................................................
  
  //load data from bird sightings spreadsheet
  birds = new ArrayList<Birds>();
    try {  
      
      //create reader to read file
      BufferedReader reader = createReader("total_sightings.csv");
      String line = ",";
      
      //keep getting the data until there is no more left, then stop (null)
      while((line = reader.readLine()) != null){
        
        //if the line sharts with "#" do not read it (the line is serving like a comment)
        if(line.charAt(0) == '#' ) continue; 
      
        //make anything on a line between commas (or columns on Excel) its own entity (used to be called "pieces", I re-named)
        String entity[] = split(line, ",");
        
        //parses apart the data within Excel columns ("entity"s) and adds them to something (I think?)
        birds.add(new Birds(entity[0], entity[1], entity[2], entity[3], entity[4]));

      }  //close while loop
    }  //close try
    
    //................................................................
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch
    
    //................................................................
    
  //load data so clock can read words and dates
  dates = new ArrayList<Date>(); //initialize dates
    
    try {
      
      BufferedReader reader = createReader("year_dates.csv");  //create reader to read file
      String line = "";
      
      //  readline() returns null when it gets to the end of the file, so this will keep looping as long as there's more data
      while( ( line = reader.readLine() ) != null){
        
        //  ignore headers
        if( line.charAt(0) == '#' ) continue;
        
        //  split the line into pieces at the commas
        String pieces[] = split(line, ",");
        
        //  adds new entry comprised of pieces
        dates.add( new Date(pieces[0], pieces[1]) );
        
      }  //  close while
      
    }  //  close try 
    
    //................................................................
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch
  }  //close void setup


//----------------------------------------------------------------


void draw(){ 
  
  //  conversion between screen pixel width and latitude...
  //  (screen height in pixels)/180=(conversion rate)...in this case 3.47 (or screenwidth/2[which is the same number as height])/180) will get the same result)
  //  just make sure the lng is negative!
  float map_lat = 3.47;
  float map_lng = -3.47;
  
  //................................................................
  
  //  this is to do with the speed of the handle rotating...HELP! I don't remember why!
  if(millis() > starttime+1000*millis_multiplier){ 
    
    //................................................................
    
    //  draw the background image (do NOT loadImage() here or it will crash around November, do that in void setup() !)
    image(background,0,0); 
    
        //  %%%% TESTING HOVER %%%% (before translate to center)
//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  hover state
    if(hover_swallow_button){
      
      //  if hover, species' dot gets bigger 
      dot_size_swallow = dot_size_hover;
      image(hummingbird_img, 20,20);
      
      //  %%%% TESTING HOVER %%%%
      println("inside!");
      
      } else {
                
        //    
        dot_size_swallow = dot_size;
      
        }  //  close if hover 
    
    //  draw button ('19' is swallow's number, how many buttons over it's button is
    fill(swallow_color);
    ellipse(((width - 2*button_wall_offset) / 25)*1, 
            height - (button_vertical_offset + (button_width*.5)),
            button_width, button_width);
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */



    //  move 0,0 to the center of the screen: important for my self-mapping!
    translate(width/2, height/2);  
    
    //................................................................
    
    //  counter for use by both the clock and the dots ('++counter' is shorthand for 'counter=counter+1' to make it actually count!)
    ++counter; 
    
    //  to make it keep cycling after it gets to the top
    if(counter>counter_duration){
      counter=1; 
    }  //  close if 
    
    //................................................................

    //  for loop to iterate through the external file of total bird sightings
    for(int sighting = 0; sighting<birds.size(); ++sighting){ 
     
      //  casting to make integers out of the Strings of data from the Excel sheet 
      //  NOTE: 'date_projection' refers to the on-screen representation of the date, to be coordinated with the counter, 'date' refers to the string in the Excel sheet with the date.
      float x_position = float(birds.get(sighting).lng);
      float y_position = float(birds.get(sighting).lat);
      int date_projection = int(birds.get(sighting).date); 
     
      //  if the value of the counter matches the value of the serial date in the Excel sheet, make a dot at spot specified by its line in the Excel sheet
      //  if the value of the counter is within a certain number of days' range ('sighting_duration'; see global variables) on either side of the actual date projection, make a dot according to lat and lng
      if((counter>=date_projection - sighting_duration && 
          counter<=date_projection + sighting_duration) ||
         (counter>=counter_duration - sighting_duration &&
          counter<=sighting_duration)){

        //................................................................
        
        //  matching every bird to its color (see global variables)
        
        noStroke();
        
        //  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v                
        if(hummingbird_color_code.equals(birds.get(sighting).species)){
          fill(hummingbird_color);
        } 
                
        if(ostrich_color_code.equals(birds.get(sighting).species)){
          fill(ostrich_color);
        } 
                
        if(crane_color_code.equals(birds.get(sighting).species)){
          fill(crane_color);
        } 
        
        if(tern_color_code.equals(birds.get(sighting).species)){
          fill(tern_color);
        }
        
        if(puffin_color_code.equals(birds.get(sighting).species)){
          fill(puffin_color);
        }

        if(swan_color_code.equals(birds.get(sighting).species)){
          fill(swan_color);
        }

        if(oriole_color_code.equals(birds.get(sighting).species)){
          fill(oriole_color);
        }

        if(pelican_color_code.equals(birds.get(sighting).species)){
          fill(pelican_color);
        }
        
        if(albatross_color_code.equals(birds.get(sighting).species)){
          fill(albatross_color);
        }   

        if(flicker_color_code.equals(birds.get(sighting).species)){
          fill(flicker_color);
        }

        if(sandpiper_color_code.equals(birds.get(sighting).species)){
          fill(sandpiper_color);
        }  
        
        if(owl_color_code.equals(birds.get(sighting).species)){
          fill(owl_color);
        }
        
        if(wagtail_color_code.equals(birds.get(sighting).species)){
          fill(wagtail_color);
        }
        
        if(macaw_color_code.equals(birds.get(sighting).species)){
          fill(macaw_color);
        }
                
        if(vireo_color_code.equals(birds.get(sighting).species)){
          fill(vireo_color);
        }
         
        if(bee_color_code.equals(birds.get(sighting).species)){
          fill(bee_color);
        }
         
        if(kingfisher_color_code.equals(birds.get(sighting).species)){
          fill(kingfisher_color);
        }
         
        if(pintail_color_code.equals(birds.get(sighting).species)){
          fill(pintail_color);
        }          
        
        if(swallow_color_code.equals(birds.get(sighting).species)){
          //  fill(swallow_color);
          fill(0,0,0, alpha_test);
          
          //  draw the swallow dots
          ellipse(x_position*map_lat, y_position*map_lng,  dot_size_swallow,dot_size_swallow);
        }                       
         
        if(shearwater_color_code.equals(birds.get(sighting).species)){
          fill(shearwater_color);
        }
         
        if(kite_color_code.equals(birds.get(sighting).species)){
          fill(kite_color);
        }
         
        if(penguin_color_code.equals(birds.get(sighting).species)){
          fill(penguin_color);
        }
         
        if(swift_color_code.equals(birds.get(sighting).species)){
          fill(swift_color);
        }
         
        if(martin_color_code.equals(birds.get(sighting).species)){
          fill(martin_color);
        }
         
        if(galah_color_code.equals(birds.get(sighting).species)){
          fill(galah_color);
        }
        //  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */       

 
        //................................................................
        
        //  array of dots
        ellipse(x_position*map_lat, y_position*map_lng,  dot_size,dot_size);
        
        
        //  %%%% Use this to test if sizes are turning on and off with click! %%%% Should show a black dot or should disappear depending how being called.
//        /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
        //  fill(0,0,0, alpha_test);
        fill(test_color);
        ellipse(50,50,  radius_test,radius_test); 
//        ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */
       

        
      }  //  close if(date_projection)
            
    }  // close for(int sighting...)
   
    //................................................................
    
    
  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  this is the text showing the VALUE of the counter (not the date), for testing the counter's value (not to be shown on final project)
    String s = String.valueOf(counter);  
    textAlign(CENTER);
    textSize(50);
    fill(0,0,0);    
    text(s, 0,0); 
    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */


    //  NOTE: to make it keep cycling after it gets to the top; problem solved by using ">=" (greater than OR EQUAL!)
    if(counter>=dates.size() ){
      counter=1; 
    }  //  close if
    
    //  text showing the month and day
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    textAlign(CENTER);
    text(dates.get(counter).month,  0,0);
    text(dates.get(counter).day,  0,day_leading);
    
    //  the circular, moving part of the clock
    
    //rotation command
    rotate( counter * radians(.986) ); //.986 = 360degrees/365"days" = 1 rotation every 60seconds (almost, as close as can get)
    
    //handle
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha*.25);
    stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    strokeWeight(clockStroke);
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);
    
    //clock edge is an arc with the part missing where the handle is, so it can be transparent
    noFill();
    strokeWeight(clockStroke);
    arc(0, 0, clockArm*2, clockArm*2, radians(-88), radians (268));
  
  //  without this, the counter won't listen to the speeds set earlier
  starttime = millis();

  }  //  close if(millis)

}  // close void draw


//----------------------------------------------------------------   


class Birds{
  
  //this declares that the data is going to be in Strings now (I think...?)
  String species;
  String lat;
  String lng;
  String date;
  
  //identifying the existing strings and naming the ones I want to use
  Birds(String s1, String s2, String s3, String s4, String s5){ 
    species = s1;
    lat = s2; 
    lng = s3;
    date = s5;
  }
}  //close the class

//................................................................

class Date{ 
  
  //  declare variables
  String month;
  String day;
  
  //  constructor
  Date(String s1, String s2 ){ 
     month = s1;
     day = s2;
  }  //  close Date constructor
  
}  //  close Date class


//----------------------------------------------------------------


// [FUNCTIONAL BUTTONS] a method to check if a point is inside our box

//  not sure if it would have to change for each bird, or if it could stay the same for all, or even if it could be mouseX and mouseY?
//  '19' is the species' number; change to match species!
boolean swallow_hover( int x_dodo, int y_dodo){
  
  if(dist(
    ((width - 2*button_wall_offset) / 25)*1, 
    height - (button_vertical_offset + (button_width*.5)),
    mouseX, mouseY)*2 
    < button_width) {

     return true;
    
     } else { return false; 
     
  }  //  close else
  
}  //  close boolean


//----------------------------------------------------------------


//  %%%% TESTING HOVER %%%%
// setting a true/false flag for hover

void mouseMoved(){
    
    //  I have no idea why putting '*2' at the end (almost) makes it the right size...
    if( swallow_hover(mouseX, mouseY) ) hover_swallow_button = true;
    else hover_swallow_button = false;
    
    redraw(); //call draw   

}  //  close void mouseMoved


//----------------------------------------------------------------


//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//  click
void mouseClicked(){
  
  //  I have no idea why putting '*2' at the end (almost) makes it the right size...
  if(dist(
    ((width - 2*button_wall_offset) / 25)*1, 
    height - (button_vertical_offset + (button_width*.5)),
    mouseX, mouseY)*2 
    < button_width) {
        
//      else          
      
        if(hover_swallow_button = true && alpha_test ==255){
    
//          if(alpha_test == 255) {
             
            alpha_test = 0;
        
            println("click");     
   
//        }  //  close if (alpha
       
      } //  close if (dot     

      else
      
      if(hover_swallow_button = true && alpha_test == 0){
     
        //  and if the value is gray-red...  set it to bright red
//        if(alpha_test == 0) {
        
          alpha_test = 255; 
        
//        }  //  close if (alpha
     
      }  //  close if (hover
                    
  }  //  close if (dist
          
}  //  close void mouseClicked
     
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

