/*
1.) get dots to show up on command according to the date in their own external file
2.) coordinate to timer
*/

/*
NOTES:

_Typefaces must be in your data directory, .vlw format. Use Tools>Create Font to convert faces to .vlw

_When possible, set variables in setup or outside of anything (globally) as this is more efficient than in the beginning of draw!

*/


//  COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//---------------------------------------------------------------------------  separates void setup from void draw, etc.
    
//.........................................................................  separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */




//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Birds> birds;

//  for the click and hover states
boolean hover = false;
boolean click = false;

float dot_size = 30;
int dot_alpha = 125;

//  counter keeping track of lines on the Excel sheet
int counter = 0;
float starttime = millis();

//typography
int monthTextSize = 50;

//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//  PImage to hold the background image
PImage background;
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */


//--------------------------------------------


void setup(){
  size(1250,625);
  frameRate(60);
  
  //  typography
  PFont font; 
  font = loadFont("Gotham_Light_100.vlw");
  //  we will list typeface attributes throughout in this order: font, monthTextSize.....(?)  
  textFont(font, monthTextSize); 
  
  //load the data from the Excel spreadsheet
  birds = new ArrayList<Birds>();
    try {  
      
      //create reader to read file
      BufferedReader reader = createReader("0_dodo.csv");
      String line = ",";
      
      //keep getting the data until there is no more left, then stop (null)
      while((line = reader.readLine()) != null){
        
        //if the line sharts with "#" do not read it (the line is serving like a comment)
        if(line.charAt(0) == '#' ) continue; 
      
        //make anything on a line between commas (or columns on Excel) its own entity (used to be called "pieces", I re-named)
        String entity[] = split(line, ",");
        
        //parses apart the data within Excel columns ("entity"s) and adds them to something (I think?)
        birds.add(new Birds(entity[0], entity[1], entity[2], entity[3]));

      }  //close ...?
    }  //close ...?
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close ...?
  }  //close ...?


//--------------------------------------------


void draw(){
  
  //  conversion between screen pixel width and latitude...
  //  screen height in pixels / 180 = conversion rate (in this case 3.47) ((or screenwidth/2 which is the same number) / 180) will get the same result)
  //  just make sure the lng is negative!
  float map_lat = 3.47;
  float map_lng = -3.47;
  
  
  //TEST
  //  this is to do with the speed of the handle rotating...HELP! I don't remember why!
  if(millis() > starttime+1.5*100){ 
  
  
//    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  load the background image. Source: wikipedia
    background = loadImage("world_map.png"); 
    //  draw the background image
    image(background,0,0);
//    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */ 
    //  redraw the background on each loop
    //  %%%TEST%%%  //  background(225,0,0);

    //  move 0,0 to the center of the screen: important for my self-mapping!
    translate(width/2, height/2); 
  
    /*  //I think we don't need to have this...but leave it in until this can be verified!
    //  refers to the number of rows in the Excel spreadsheet, a.k.a. the number of sightings for a bird
    //  %%%  //  int spreadsheet_rows = birds.size();
    */
    
    //declare the string to be used in the text, so it knows what it is when we call it on the next line below
    String s = String.valueOf(counter);  
    
    //  counter (a.k.a. counter=counter+1) to make it actually count!
    ++counter; 
    
    //  %%%%%%%%%%%%  to make it keep cycling after it gets to the top; problem solved by using ">=" (greater than OR EQUAL!)
    if(counter>=birds.size() ){
      counter=0; 
    }  //  close if
    
    //this is the text showing the value of the counter (not the date)
    textAlign(CENTER);
    textSize(50);
    fill(0,0,0);
    text(s, 0,0); 
    
    
    //  for loop to iterate through the external file of total bird sightings
    for(int sighting = 0; sighting<birds.size(); ++sighting){ 
     
    //  casting to make integers out of the Strings of data from the Excel sheet 
    //  NOTE: 'date_projection' refers to the on-screen representation of the date, to be coordinated with the counter, 'date' refers to the string in the Excel sheet with the date.
    float x_position = float(birds.get(sighting).lng);
    float y_position = float(birds.get(sighting).lat);
    int date_projection = int(birds.get(sighting).date);
      
    
      
    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  %%%%%%%%%%%%  problem solved by using ">=" (greater than OR EQUAL!)
    if(counter>=birds.size() ){
      counter=0; 
    }  //  close if
    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */    

      
      
    //WAITING FOR COUNTER TO BE ADDED//      if( date_projection >= counter){
    //  fill each dot according to the RGB values of its associated piece of data
    fill(100,0,125, dot_alpha);
    noStroke();    
  
    //  array of dots
    ellipse(x_position*map_lat, y_position*map_lng,  dot_size,dot_size);
        
    //WAITING FOR COUNTER TO BE ADDED//        
    
    }  // close for loop, sighting
  
  //  without this, the counter won't listen to the speeds set earlier
  starttime = millis();

  }  //  close if(millis), for counter

}  // close void draw


//--------------------------------------------   


class Birds{
  
  //this declares that the data is going to be in Strings now (I think...?)
  String lng;
  String lat;
  String date;
  
  //identifying the existing strings and naming the ones I want to use
  Birds(String s1, String s2, String s3, String s4){ 
     lng = s3;
     lat = s2;
     date = s4;
  }
}  //close the class
