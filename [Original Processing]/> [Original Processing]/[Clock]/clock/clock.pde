/*
Exercise 3: visualize 60 seconds
Sample code below
Due Midnight, Sunday January 27
*/

//Declare variables with global scope
int counter = 0; 
int rectWidth = 5; //
int typeSize = 14;
float starttime = millis();
PVector vector; 

void setup(){  
  //environmental variables
  size(200,200);
  frameRate(60); //set the frameRate. NOTE: frameRate is averaged over several frames. Don't use it if you need precision!
  
  //typography. Note: faces must be in your data directory, .vlw format. Use Tools>Create Font to convert faces to .vlw
  PFont font; 
  font = loadFont("Whitney-Black-24.vlw");  
  textFont(font, typeSize);
  
  //these could be set in draw, but it's a little more efficient to do it here
  vector = new PVector(0, height/4);  
  textSize(typeSize);
  noStroke();
}

void draw(){
  /*
  CAUTION! this loop locks the entire program: 
    while( millis() < starttime + 1000 ){ }    
  Not a good way to create a pause, especially if you expect user input.
  Instead, use a conditional (see below).
  */  
  
  if(millis() > starttime+1000){ //has a second elapsed since we last did anything?
  
    background(0,0,0); //redraw the background on each loop
    translate(width/2, height/2); //move 0,0 to the center of the screen. N.B. all transformations are reset each time draw is called!
  
    fill(200,200,200); //a fill for the reference ellipse
    ellipse(vector.x, -vector.y, rectWidth, rectWidth);
  
    ++counter;
    fill(255,0,0);
    String s = String.valueOf(counter);
    text(s, -textWidth(s)/2, 0 + typeSize/4); //position the text at the center. Note the use of textWidth()

    rotate( counter * radians(6) ); //6 = 360degrees/60seconds
    ellipse(vector.x, -vector.y, rectWidth, rectWidth);  
      
    starttime = millis();
  }
}
