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
  size(200,200);

}  // close void setup


//----------------------------------------------------------------


void draw(){
  
  background(255,255,255);
  
  //  [BUTTON FUNCTIONALITY] set fill based on mouse input


  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
  if(clicked){  // currently set to false
      fill(255,125,125);  //  light red = OFF
  } else {
  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */  


      if(hover){
      
      //  red = ON  
      fill(255,0,0);  
      
      } else {
        
        //  light red = OFF
        fill(255,125,125);  
      
        }  
        
//  %%%% CLOSE IF CLICKED LOOP HERE %%%% -->  }
  
  //................................................................
  
  //  [VISIBLE BUTTONS] 50x50px square, centered 
  
  rectMode(CENTER);
  
  rect(width/2, height/2, boxWidth, boxWidth);

}  //close "void draw"


//----------------------------------------------------------------


// [FUNCTIONAL BUTTONS] a method to check if a point is inside our box


boolean isInside( int x_dodo, int y_dodo){
  
  if(x_dodo > width/2 - boxWidth/2 && x_dodo < width/2 + boxWidth/2 &&
    y_dodo > height/2 - boxWidth/2 && y_dodo < height/2 + boxWidth/2){
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
