

//  1. Write the if statement to restrain clicking to just the button.



int valueRed = 125;
int valueGreen = 125;

void setup(){
  size(200,200);
}

void draw() {
  fill(valueRed, 0,0);
  rect(25, 25, 50, 50);
  
  fill(0, valueGreen, 0);
  rect(100,25,50,50);
}

void mouseClicked() {
  if (valueRed == 125) {
    valueRed = 255;
  } else {
    valueRed = 125;
  }
  
  if (valueGreen == 125) {
    valueGreen = 255;
  } else {
    valueGreen = 125;
  }
}
