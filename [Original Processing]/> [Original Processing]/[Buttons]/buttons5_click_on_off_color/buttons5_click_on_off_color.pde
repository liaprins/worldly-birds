// Click within the image to change 
// the value of the rectangle after
// after the mouse has been clicked

int dot_alpha = 255;

color bee_color = color(49,163,110,  dot_alpha);
color shearwater_color = color(70,107,79,  dot_alpha);
color penguin_color = color(113,81,161,  dot_alpha);

color bee_button_ON = color(49,163,110,  dot_alpha);

color bee_button_OFF = color(49,163,110,  100);

void setup(){
  size(200,200);
}

void draw() {
  fill(bee_button_ON);
  rect(25, 25, 50, 50);
  
  fill(penguin_color);
  rect(100,25,50,50);
}

//when the mouse is clicked, if the button is on, turn
//it to a new color to signify off
void mouseClicked() {
  if (bee_button_ON == color(49,163,110,  dot_alpha)) {
    bee_button_ON = bee_button_OFF;
  } else {
    bee_button_ON = color(49,163,110,  dot_alpha);
  }
  
}
