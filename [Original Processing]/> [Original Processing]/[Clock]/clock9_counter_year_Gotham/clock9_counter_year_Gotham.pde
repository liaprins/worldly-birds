/*
Idea for final: maybe don't even show the days (too distracting, months changing still gets the idea across).
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
    


//  Declare variables that apply to the entire sketch ("global scope") outside of void draw

int counter = 0; 
float starttime = millis();

//  sizes
int handleDiameter = 15;
int clockArm = 255;
int monthTextSize = 30;
float clockStroke = 1.5;  //outline of lines associated with clock

//  colors
int clockStroke_R = 170;
int clockStroke_G = 165;
int clockStroke_B = 150;
int clockStroke_Alpha = 50;

//  (?)
PVector vector; 

//  an ArrayList from external file: dates.txt
ArrayList<Date> dates; //an ArrayList of date objects


//---------------------------------------------------------------------------


void setup(){  
  
  //  variables for the setup of the sketch
  size(1250,625);
  
  //  frameRate works with millis (in void draw) to make speed of counter
  frameRate(60);
  
  //  typography
  PFont font; 
  font = loadFont("Gotham_Light_100.vlw");
  //  we will list typeface attributes throughout in this order: font, monthTextSize.....(?)  
  textFont(font, monthTextSize); 
  
  //  the length of the clock arm when it points to 12 o'clock, before rotating
  vector = new PVector(0, clockArm);
  
  
  //.........................................................................
  
  
  //load data from external file
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
  
  //  "catch" should keep the program running despite some things it thinks are wrong
  catch (IOException e) {
    e.printStackTrace();
  }  //close catch 

}  //  close void setup


//---------------------------------------------------------------------------


void draw(){  
  
  //  this is to do with the speed of the handle rotating...HELP! I don't remember why!
  if(millis() > starttime+1.5*100){ 
  
    //  redraw the background on each loop
    background(210,205,190); 
    
    //  move 0,0 to the center of the screen; all transformations are reset each time draw is called
    translate(width/2, height/2); //move 0,0 to the center of the screen. N.B. all transformations are reset each time draw is called!
    
    /*  //  this is the reference ellipse at top
    fill(200,200,200); //a fill for the reference ellipse
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);
    */
        
    //declare the string to be used in the text, so it knows what it is when we call it
    String s = String.valueOf(counter); 
  
    //  counter (a.k.a. counter=counter+1) to make it actually count!
    ++counter;  
        
    //  %%%%%%%%%%%%  to make it keep cycling after it gets to the top; problem solved by using ">=" (greater than OR EQUAL!)
    if(counter>=dates.size() ){
      counter=1; 
    }  //  close if
    
    //  text
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    textAlign(CENTER);
    text(dates.get(counter).month,  0,0);
    text(dates.get(counter).day,  0,50);

    
    
//    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //this is the text showing the value of the counter (not the date)
    fill(255,255,255);
    text(s, 0, 0); 
//    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */
    
    //.........................................................................
    
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
    
  }  //  close outer if
  
}  //close void draw


//---------------------------------------------------------------------------


//  Date class to hold data

//  declare the class
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

