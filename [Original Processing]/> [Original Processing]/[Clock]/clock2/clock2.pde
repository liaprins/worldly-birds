/*

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
}

void draw(){  
  
  if(millis() > starttime+1.5*100){ //this is to do with the speed of the handle rotating...HELP! I don't remember why!
  
    background(210,205,190); //redraw the background on each loop
    translate(width/2, height/2); //move 0,0 to the center of the screen. N.B. all transformations are reset each time draw is called!
    
    /*  // reference ellipse at top
    fill(200,200,200); //a fill for the reference ellipse
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);
    */
    
    //counter, a.k.a. counter=counter+1;
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
  }
}
