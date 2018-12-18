/*
Instead of using the Excel file's strings as RGB values, use them as x and y values
*/

//introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Crayon> crayons;

//for the click and hover states
boolean hover = false;
boolean click = false;

int i = 0;
int j = 0;

//counter keeping track of lines on the Excel sheet (colors!)
int c = 0;

//--------------------------------------------

void setup(){
  size(1010,800);
  noLoop();
  
  //load the data from the Excel spreadsheet
  crayons = new ArrayList<Crayon>();
    try {  
      
      //create reader to read file
      BufferedReader reader = createReader("coordinates_test.csv");
      String line = ",";
      
      //keep getting the data until there is no more left, then stop (null)
      while((line = reader.readLine()) != null){
        
        //if the line sharts with "#" do not read it (the line is serving like a comment)
        if(line.charAt(0) == '#' ) continue; 
      
        //make anything on a line between commas (or columns on Excel) its own entity (used to be called "pieces", I re-named)
        String entity[] = split(line, ",");
        
        //parses apart the data within Excel columns ("entity"s) and adds them tosomething (I think?)
        crayons.add(new Crayon(entity[0], entity[1], entity[2], entity[3], entity [4]));

      }  //close ...?
    }  //close ...?
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close ...?
  }  //close ...?

//--------------------------------------------   

//this is a "class"
class Crayon{
  
  //this declares that the data is going to be in Strings now (I think...?)
  String x;
  String y;
  
  //identifying the existing strings and naming the ones I want to use
  Crayon(String s1, String s2, String s3, String s4, String s5){ 
     x = s3;
     y = s4;
  }
}  //close the class

//--------------------------------------------

void draw(){
  background(255,255,255);
  
  //setting up the grid for the array of rectangles to use
  int columns = 500;
 
  //array of rectangles
//TEST///////  for(int j = 0; j<rows; ++j){ //outer loop: rows
         
    for(int i = 0; i<columns; ++i){ //inner loop: columns

      //casting to make integers out of the Strings of data from the Excel sheet
      int x_position = int(crayons.get(c).x);
      int y_position = int(crayons.get(c).y);
    
      //fill each rectangle according to the RGB values of its associated piece of data
      fill(x_position, y_position, 100,100);
      noStroke();
      
      //  array of dots
      ellipse(x_position, y_position,  20, 20);
      
      //go to the next line on the Excel sheet (next color)... c = c + 1
      ++c;
      
    
    }  //close inner loop, i
//TEST///////   }  //close outer loop, j

}  // close void draw
