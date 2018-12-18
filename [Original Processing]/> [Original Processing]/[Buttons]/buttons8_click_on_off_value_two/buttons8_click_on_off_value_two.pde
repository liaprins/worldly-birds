
/*
If click on button turns it on, if click again, it turns it off.


COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  
separates void setup from void draw, etc.
    
//................................................................  
separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */



//global variables

int valueRed = 125;
int valueGreen = 125;

int redCornerX = 25;
int redCornerY = 25;
int greenCornerX = 100;
int greenCornerY = 25;

int boxDimension = 50;


//----------------------------------------------------------------


void setup(){
  size(200,200);
}


//----------------------------------------------------------------


void draw() {
  fill(valueRed, 0,0);
  rect(redCornerX, redCornerY, boxDimension, boxDimension);
  
  fill(0, valueGreen, 0);
  rect(greenCornerX, greenCornerY, boxDimension, boxDimension);
}


//----------------------------------------------------------------


void mouseClicked() {
  
  //  if the mouse is within the red box...
  if(mouseX > redCornerX && mouseX < redCornerX + boxDimension &&
     mouseY > redCornerY && mouseY < redCornerY + boxDimension){
     
     //  and if the value is gray-red...  set it to bright red
     if(valueRed == 125) valueRed = 255;  
       
       //  otherwise if it is bright red... set it to gray-red
       else if(valueRed == 255) valueRed = 125;
     
     //  Didn't notice a difference when I commented out 'redraw();'...not sure if I need it? Leave it for now, though!
     redraw();
  }  //  close if statement for red button's bounding box
  
  //................................................................
  
  //  if the mouse is within the green box...
  if(mouseX > greenCornerX && mouseX < greenCornerX + boxDimension &&
     mouseY > greenCornerY && mouseY < greenCornerY + boxDimension){
     
     //  and if the value is gray-green...  set it to bright green
     if(valueGreen == 125) valueGreen = 255;
       
       //  otherwise if it is bright green... set it to gray-green
       else if(valueGreen == 255) valueGreen = 125;
     
     //  Didn't notice a difference when I commented out 'redraw();'...not sure if I need it? Leave it for now, though!
     redraw();
  }  //  close if-statement for green button's bounding box
  
}  //  close void mouseClicked
