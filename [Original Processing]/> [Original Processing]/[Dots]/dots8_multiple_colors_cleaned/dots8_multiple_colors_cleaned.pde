/*
Dots to show up on command according to the date serial number

PROBLEM: It keeps running out of memory (at #331)....
*/

/*
NOTES:
_When possible, set variables in setup or outside of anything (globally) as this is more efficient than in the beginning of draw!

*/


//  COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  separates void setup from void draw, etc.
    
//................................................................  separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */




//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

float dot_size = 40;
int dot_alpha = 100;

//  counter
int counter = 1;
float starttime = millis();
int counter_duration = 365;
//String s = String.valueOf(counter);  //  for testing the counter's value (not to be shown on final project)

//  typography
int monthTextSize = 50;

//species colors and colorcodes
String bee_color_code = "bee";
String shearwater_color_code = "shearwater";
String penguin_color_code = "penguin";


//  species colors
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
  frameRate(60);
      
  //  so that nothing will have a stroke unless it is called
  noStroke();
  
  //  typography
  PFont font; 
  font = loadFont("Gotham_Light_100.vlw");
  textFont(font, monthTextSize); 
  
  //................................................................
  
  //load the data from the Excel spreadsheet
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
    
    //  Trying it without a background image this time to see if it uses less memory.
    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  load the background image. Source: wikipedia
    background = loadImage("world_map.png"); 
    //  draw the background image
    image(background,0,0);
    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */    
    background(255,255,255);

    //  move 0,0 to the center of the screen: important for my self-mapping!
    translate(width/2, height/2);  
    
    //................................................................
    
    //  counter (a.k.a. counter=counter+1) to make it actually count!
    ++counter; 
    
    //  to make it keep cycling after it gets to the top
    if(counter>counter_duration){
      counter=1; 
    }  //  close if
 
    
//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  this is the text showing the VALUE of the counter (not the date), for testing the counter's value (not to be shown on final project)
    String s = String.valueOf(counter);  
    textAlign(CENTER);
    textSize(50);
    fill(0,0,0);    
    text(s, 0,0); 
//    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */


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
