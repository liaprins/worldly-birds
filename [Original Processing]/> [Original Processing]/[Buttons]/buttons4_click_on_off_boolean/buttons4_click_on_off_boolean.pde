
  
// Click within the image to change 
// the value of the rectangle after
// after the mouse has been clicked

//  '!clicked_on' or 'clicked_on = false' means off 
boolean clicked_on;  

void setup(){
  size(200,200);
}

void draw() {
  
  a = true;
  
  fill(0,valueA,0);
  rect(25, 25, 50, 50);
  
  fill(valueB, 0,0);
  rect(100,25,50,50);
}

void mouseClicked() {
  if (a == true) {
    fill(255,0,0)
  } else {
    fill(0,255,0);
  }

}
