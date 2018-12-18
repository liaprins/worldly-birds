
/*
PARENT FILE == buttons8

Clicking on button turns it on, clicking again turns it off.
Works for images as well, if the tint is set to have a value (tint must be defined for every every image after that, with its own tint name, though!).

NOTE: Can use a single image in the data file for multiple uses, but still need to load it for each instance/function. 
Do this in void setup; CANNOT use commas to list all the names that will be applied to that loadImage(); they must each be listed separately.
In global variables, CAN list with commas (I think) but don't do this for organizational reasons!

NEXT STEPS:
1. Make real-size mock-up with hash-line images that turn on and off, try to figure out if they each need their own separate file and/or name to work?
2. Apply to main file, and make sighting dots show up or disappear by changing their alpha to zero if clicked;
   will have to give each species its own alpha name, e.g. hummingbird_alpha (try to keep dependent upon main sighting_alpha, though, if this will work?)
   Also will have to give each bird's button color a separate name from the dots' color, otherwise it will disappear when the sighting dots' alphas go to zero.


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
int hummingbird_alpha = 255;
int hummingbird_alpha2 = 255;

int redCornerX = 25;
int redCornerY = 25;
int greenCornerX = 100;
int greenCornerY = 25;
int hummingbirdCornerX = 25;
int hummingbirdCornerY = 100;

int boxDimension = 50;
int redBoxDimension = 50;


//  introduce PImage for use later
PImage hummingbird_image, hummingbird_image2;


//----------------------------------------------------------------


void setup(){
  size(200,200);
  
  hummingbird_image = loadImage("hummingbird.png");
  hummingbird_image2 = loadImage("hummingbird.png");
    
}


//----------------------------------------------------------------


void draw() {
  
  background(255,255,255);
  
  //  set tint for image
  tint(255,255,255,  hummingbird_alpha);
  //  draw image, x,y,  width, height
  image(hummingbird_image, hummingbirdCornerX,hummingbirdCornerY, hummingbird_image.width, hummingbird_image.height);
  
  //  set tint for image 2
  tint(255,255,255,  hummingbird_alpha2);
  image(hummingbird_image2, hummingbirdCornerX + 75,hummingbirdCornerY, hummingbird_image2.width, hummingbird_image2.height);
  
  fill(valueRed, 0,0);
  rect(redCornerX, redCornerY, redBoxDimension, redBoxDimension);
  
  fill(0, valueGreen, 0);
  rect(greenCornerX, greenCornerY, boxDimension, boxDimension);

}


//----------------------------------------------------------------


void mouseClicked() {
  
  //  if the mouse is within the red box...
  if(mouseX > redCornerX && mouseX < redCornerX + boxDimension &&
     mouseY > redCornerY && mouseY < redCornerY + boxDimension){
     
     //  and if the value is gray-red...  set it to bright red
     if(valueRed == 125) {
       valueRed = 255;
       redBoxDimension = 25; 
     }
       //  otherwise if it is bright red... set it to gray-red
     
     else if(valueRed == 255) {
       valueRed = 125;
       redBoxDimension = 50; 
     }
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
     
  //................................................................
  

  //  if the mouse is within the hummingbird image...
  if(mouseX > hummingbirdCornerX && mouseX < hummingbirdCornerX + hummingbird_image.width &&
     mouseY > hummingbirdCornerY && mouseY < hummingbirdCornerY + hummingbird_image.height){
     
     //  and if the value is gray-green...  set it to bright green
     if(hummingbird_alpha == 255) hummingbird_alpha = 100;
       
       //  otherwise if it is bright green... set it to gray-green
       else if(hummingbird_alpha == 100) hummingbird_alpha = 255;
     
     //  Didn't notice a difference when I commented out 'redraw();'...not sure if I need it? Leave it for now, though!
     redraw();    
  
  }  //  close if-statement for hummingbird's bounding box
  
}  //  close void mouseClicked
