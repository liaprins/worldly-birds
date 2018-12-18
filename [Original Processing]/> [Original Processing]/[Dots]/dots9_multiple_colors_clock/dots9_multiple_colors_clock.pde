/*
Dots show up on command according to the serial date number

PROBLEMS:

It keeps running out of memory (at about #320) when the background image is there; I haven't tried adding more memory to Proecessing yet, though....



COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  separates void setup from void draw, etc.
    
//................................................................  separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */




//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

//  an ArrayList from external file: year_dates.txt
ArrayList<Date> dates; //an ArrayList of date objects

//  counter
int counter = 1;
float starttime = millis();
int counter_duration = 365;
//String s = String.valueOf(counter);  //  for testing the counter's value (not to be shown on final project)

//  typography
int monthTextSize = 50;
int dayTextSize = 35;

//  sizes for clock
int handleDiameter = 15;
int clockArm = 255;
float clockStroke = 1.5;  //outline of lines associated with clock

//  colors for clock
int clockStroke_R = 170;
int clockStroke_G = 165;
int clockStroke_B = 150;
int clockStroke_Alpha = 50;

//  (?)  don't delete
PVector vector;

//................................................................

//  dots
float dot_size = 4;
int dot_alpha = 100;

//  species colors and colorcodes
String bee_color_code = "bee";
String shearwater_color_code = "shearwater";
String penguin_color_code = "penguin";

color bee_color = color(49,163,110,  dot_alpha);
color shearwater_color = color(70,107,79,  dot_alpha);
color penguin_color = color(113,81,161,  dot_alpha);



/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//  PImage to hold the background image
PImage background;
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */


//----------------------------------------------------------------


void setup(){
  
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
      BufferedReader reader = createReader("0_sightings_test.csv");
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
  if(millis() > starttime+1.5*100){ 
    
    //................................................................
    
    //  %%%%%%%%%% SOMETHING TO TEST %%%%%%%%%%  redraw the background on each loop (otherwise the dots would stay...? test this by giving this background color an alpha...)
    //  Trying it without a background image this time to see if it uses less memory.
    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  load the background image. Source: wikipedia
    background = loadImage("world_map.png"); 
    //  draw the background image
    image(background,0,0);
    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */    
    background(225,225,225,  125);

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
      if(counter==date_projection){

        //................................................................
        
        //  matching every bird to its color (see global variables)
        
        noStroke();
        
        if(bee_color_code.equals(birds.get(sighting).species)){
        fill(bee_color);
        } 
        
        if(shearwater_color_code.equals(birds.get(sighting).species)){
        fill(shearwater_color);
        } 
        
        if(penguin_color_code.equals(birds.get(sighting).species)){
        fill(penguin_color);
        } 

        //................................................................
        
        //  array of dots
        ellipse(x_position*map_lat, y_position*map_lng,  dot_size,dot_size);
        
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


    //  %%%%%% NOTE %%%%%%  to make it keep cycling after it gets to the top; problem solved by using ">=" (greater than OR EQUAL!)
    if(counter>=dates.size() ){
      counter=1; 
    }  //  close if
    
    //  text showing the month and day
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    textAlign(CENTER);
    text(dates.get(counter).month,  0,0);
    text(dates.get(counter).day,  0,50);
    
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
