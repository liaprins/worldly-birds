/*
Using Tad's tunes example and my 500 colors sketch (b) try to get words to show up instead of the counter's value
*/

//Declare variables with global scope
int counter = 0; 
int handleDiameter = 15;
int clockArm = 255;
int typeSize = 14;
float starttime = millis();
float clockStroke = 1.5;  //outline of lines associated with clock

int clockStroke_R = 170;
int clockStroke_G = 165;
int clockStroke_B = 150;
int clockStroke_Alpha = 125;
PVector vector; 

//introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Song> songs; //an ArrayList of Tune objects


//--------------------------------------------


void setup(){  
  //environmental variables
  size(1200,650);
  frameRate(60); //set the frameRate. NOTE: frameRate is averaged over several frames. Don't use it if you need precision!
  
  //typography. Note: faces must be in your data directory, .vlw format. Use Tools>Create Font to convert faces to .vlw
  PFont font; 
  font = loadFont("Whitney-Black-24.vlw");  
  textFont(font, typeSize);
  
  //these could be set in draw, but it's a little more efficient to do it here
  vector = new PVector(0, clockArm);  //the length of the watch arm, in essence
  textSize(typeSize);
  noStroke();
  
  //load the external file data
  songs = new ArrayList<Song>(); //initialize songs
    
    try {
      
      BufferedReader reader = createReader("tunes.txt");  //create reader to read file
      String line = "";
      
      while( ( line = reader.readLine() ) != null){  //readline() returns null when it gets to the end of the file, so this will keep looping as long as there's more data to be had
      
        if( line.charAt(0) == '#' ) continue; //ignore headers
      
        String pieces[] = split(line, ",");  //split the line into parts at the commas
        
        //create new Tune, passing pieces as arguments, and add to songs
        songs.add( new Song(pieces[0], pieces[1], pieces[2]) );

      }  //close while
    }  //close try
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch 
}  //close void setup


//--------------------------------------------


void draw(){  
  
  if(millis() > starttime+1.5*100){ //this is to do with the speed of the handle rotating...HELP! I don't remember why!
  
    background(210,205,190); //redraw the background on each loop
    translate(width/2, height/2); //move 0,0 to the center of the screen. N.B. all transformations are reset each time draw is called!
    
    /*  // reference ellipse at top
    fill(200,200,200); //a fill for the reference ellipse
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);
    */
    
    //counter text
    ++counter;
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    String s = String.valueOf(counter);
    text(s, -textWidth(s)/2, 0 + typeSize/4); //position the text at the center. Note the use of textWidth()
    
    //this makes the numbers loop instead of keeping on increasing each clock cycle
    if (counter > 365){
      counter = 0;
      
    
  //  /* ******************************************   
  int xOffset = 10;
  int yOffset = 20;
  
  for(int i = 0;i<songs.size(); ++i){ //for loop... like an array, but notice: we use songs.size() not songs.length and...
    text(songs.get(i).year + ": " + songs.get(i).name, xOffset, i*20+yOffset);        //songs.get(i) not songs[i]
  }  //close for loop
  //  /* ******************************************   
  
      
    }  //close inner if
    
    //rotation command
    rotate( counter * radians(.986) ); //.986 = 360degrees/365"days" = 1 rotation every 60seconds
    
    //handle
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha*.25);
    stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    strokeWeight(clockStroke);
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);    
        
    //clock edge is an arc with the part missing where the handle is, so it can be transparent
    noFill();
    strokeWeight(clockStroke);
    arc(0, 0, clockArm*2, clockArm*2, radians(-88), radians (268));
      
    starttime = millis();
    
  }  //close outer if
  
}  //close void draw


//--------------------------------------------


//Song class to hold data
class Song{ //declare the class
  
  //declare variables
  String year;
  String artist;
  String name;
  
  //constructor
  Song(String s1, String s2, String s3 ){ 
     year = s1;
     artist = s2;
     name = s3;
  }  //close contructor song
  
}  //close class song
