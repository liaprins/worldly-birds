int boxWidth = 50;
boolean hover = false;
boolean clicked = false;

void setup(){
  noLoop();
}

void draw(){
  
  //set fill based on mouse input [SETTING FUNCTIONALITY]
  if(clicked){
      fill(0,0,255);
  }else{
    if(hover){ 
      fill(255,0,0); 
    }
    else{ fill(255,255,255); }
  }
  
  //50x50 pix square, centered [MAKING THE PHYSICAL RECTANGLE]
  rectMode(CENTER);
  rect(width/2, height/2, boxWidth, boxWidth);
}  //close "void draw"

// [HOVER, JUST SETTING A FLAG FOR NOW]
void mouseMoved(){
    if( isInside(mouseX, mouseY) ) hover = true;
    else hover = false;
    
    redraw(); //call draw   
}

// [CLICKED, JUST SETTING A FLAG FOR NOW]
void mouseReleased(){
  if( isInside(mouseX, mouseY) ) clicked = true;
    else clicked = false;
    
    redraw();   
}

//a method to check if a point is inside our box 
// [SET LOCATIONS OF FUNCTIONAL BUTTONS SO MOUSE KNOWS WHERE THEY ARE
boolean isInside( int x, int y){
  if(x > width/2 - boxWidth/2 && x < width/2 + boxWidth/2 &&
    y > height/2 - boxWidth/2 && mouseY < height/2 + boxWidth/2){
      return true;
    }
  else{ return false; }
}
