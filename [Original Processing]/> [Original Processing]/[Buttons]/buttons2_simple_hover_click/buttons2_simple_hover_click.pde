/*

//  ON = red
//  OFF = light red
//  HOVER = green


COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  
separates void setup from void draw, etc.
    
//................................................................  
separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */


//  global variables

int boxWidth = 50;

boolean hover = false;  //  green
boolean clicked = false;
//  boolean clicked_on;  //  red
//  boolean clicked_off;  //  light red


//----------------------------------------------------------------


void setup(){
  size(200, 200);
  
  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
  noLoop();
  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

}  // close void setup


//----------------------------------------------------------------


void draw(){
  
  background(255,255,255);
  
  //  [BUTTON FUNCTIONALITY] set fill based on mouse input
  
  if(clicked){  // currently set to false
      fill(255,125,125);  //  light red = OFF
  } else {
      if(hover){ 
      fill(255,0,0);  //  red = ON
    } else {
        fill(255,125,125); }  //  light red = OFF
  }
  
  //................................................................
  
  //  [VISIBLE BUTTONS] 50x50px square, centered 
  
  rectMode(CENTER);
  rect(width/2, height/2, boxWidth, boxWidth);

}  //close "void draw"


//----------------------------------------------------------------


// [FUNCTIONAL BUTTONS] a method to check if a point is inside our box

boolean isInside( int x, int y){
  if(x > width/2 - boxWidth/2 && x < width/2 + boxWidth/2 &&
    y > height/2 - boxWidth/2 && mouseY < height/2 + boxWidth/2){
      return true;
    } else { return false; 
  }  //  close else
}


//----------------------------------------------------------------


// [HOVER FLAG] just setting a true/false flag

void mouseMoved(){
  
    if( isInside(mouseX, mouseY) ) hover = true;
    else hover = false;
    
    redraw(); //call draw   
}


//----------------------------------------------------------------


// [CLICKED FLAG] just setting a true/false flag

void mouseReleased(){
  if( isInside(mouseX, mouseY) ) clicked = true;
//    else clicked = false;  // commenting this out means the square stays blue after it was clicked, even if you click on the plain non-button background
 
 
  if(clicked = true){
    clicked = false;
  }
    else clicked = true;

    redraw();
}
