/*

*/

//Declare variables with global scope
PVector vector;
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

//for the rows and columns of the array of words
int i = 0;
int j = 0;

//counter keeping track of lines on the Excel sheet (words)
int c = 0;


//introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Crayon> crayons;

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
  
    //load the data from the Excel spreadsheet
  crayons = new ArrayList<Crayon>();
    try {  
      
      //create reader to read file
      BufferedReader reader = createReader("500colors_dataset.csv");
      String line = ",";
      
      //keep getting the data until there is no more left, then stop (null)
      while((line = reader.readLine()) != null){
        
        //if the line sharts with "#" do not read it (the line is serving like a comment)
        if(line.charAt(0) == '#' ) continue; 
      
        //make anything on a line between commas (or columns on Excel) its own entity (used to be called "pieces", I re-named)
        String entity[] = split(line, ",");
        
        //parses apart the data within Excel columns ("entity"s) and adds them to something (I think?)
        crayons.add(new Crayon(entity[0], entity[1], entity[2], entity[3], entity [4]));

      }  //close ...?
    }  //close ...?
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close ...?
  
}  //close void setup




//this is a "class"
class Crayon{
  
  //this declares that the data is going to be in Strings now (I think...?)
  String r;
  String g;
  String b;
  
  //identifying the existing strings and naming the ones I want to use
  Crayon(String s1, String s2, String s3, String s4, String s5){ 
     r = s3;
     g = s4;
     b = s5;
  }
}  //close the class




void draw(){  
  
  /*  
  //setting up the grid for the array of rectangles to use
  int rows = 10;
  int columns = 50;
 
  //array of rectangles
  for(int j = 0; j<rows; ++j){ //outer loop: rows
         
    for(int i = 0; i<columns; ++i){ //inner loop: columns

      //casting to make integers out of the Strings of data from the Excel sheet
      int red = int(crayons.get(c).r);
      int green = int(crayons.get(c).g);
      int blue = int(crayons.get(c).b);
    
      //fill each rectangle according to the RGB values of its associated piece of data
      fill(red,green,blue);
      noStroke();
    }  //close inner loop
  }  //close outer loop
  */
  
  
  
  
  
  
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
    if (counter > 365){
      counter = 0;
    }
    
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
    
       
   
   
   
     //setting up the grid for the array of rectangles to use
  int rows = 10;
  int columns = 50;
 
  //array of rectangles
  for(int j = 0; j<rows; ++j){ //outer loop: rows
         
    for(int i = 0; i<columns; ++i){ //inner loop: columns

      //casting to make integers out of the Strings of data from the Excel sheet
      int red = int(crayons.get(c).r);
      int green = int(crayons.get(c).g);
      int blue = int(crayons.get(c).b);
    
      //fill each rectangle according to the RGB values of its associated piece of data
      fill(red,green,blue);
      noStroke();
    }  //close inner loop
  }  //close outer loop
   
    
  }
}
