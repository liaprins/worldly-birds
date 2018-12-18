


int valueRed = 125;

int redCornerX = 25;
int redCornerY = 25;

int boxDimension = 50;



void draw() {
  fill(valueRed, 0,0);
  rect(redCornerX, redCornerY, boxDimension, boxDimension);
 
  if (mouseX > redCornerX && mouseX < redCornerX + boxDimension &&
     mouseY > redCornerY && mouseY < redCornerY + boxDimension){
       
     println("inside");
     println(valueRed);
     
     valueRed = 255;  
   
     redraw();
    
   }  //  close if 1      
       
    else
       //  otherwise if it is bright red... set it to gray-red
      {if(mouseX < redCornerX && mouseX > redCornerX + boxDimension &&
          mouseY < redCornerY && mouseY > redCornerY + boxDimension)
     
        valueRed = 125;
     
        println("outside");
        println(valueRed);
     
        redraw();
      
      }  //  close if 2
  
}  //  close void draw
