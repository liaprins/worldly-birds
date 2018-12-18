/*
1.) Try to use the mapping that Tad taught to get lat and long, and implement my background.
2.) Then get it to attribute colors (maybe HEX?) to the dots, representative of all my diff colors.
*/

//  introducing the idea that there will be an Excel spreadsheet for the program to refer to
ArrayList<Crayon> crayons;

//  for the click and hover states
boolean hover = false;
boolean click = false;

int i = 0;
int j = 0;

//  counter keeping track of lines on the Excel sheet (colors!)
int c = 0;

//  PImage to hold the background image
PImage background;


//--------------------------------------------


void setup(){
  size(1250,625);
  noLoop();
  
  //load the data from the Excel spreadsheet
  crayons = new ArrayList<Crayon>();
    try {  
      
      //create reader to read file
      BufferedReader reader = createReader("penguin.csv");
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


void draw(){
  
//  conversion between screen pixel width and latitude...
//  screen height in pixels / 180 = conversion rate (in this case 3.47) ((or screenwidth/2 which is the same number) / 180) will get the same result)
//  just make sure the lng is negative!
float map_lat = 3.47;
float map_lng = -3.47;
  
  //  load the background image. Source: wikipedia
  background = loadImage("world_map.png"); 
  //  draw the background image
  image(background,0,0);

  //  move 0,0 to the center of the screen: important for my self-mapping!
  translate(width/2, height/2); 
  
  //  setting up the grid for the array of rectangles to use
  int columns = crayons.size();
     
    //  inner loop: columns
    for(int i = 0; i<columns; ++i){ 
     
      //casting to make integers out of the Strings of data from the Excel sheet
      float x_position = float(crayons.get(c).x);
      float y_position = float(crayons.get(c).y);
    
      //  fill each dot according to the RGB values of its associated piece of data
      fill(0,0,125,  175);
      noStroke();
      
      //  array of dots
      ellipse(x_position*map_lat, 
      y_position*map_lng,  
      2,2);
      
      //  go to the next line on the Excel sheet (next color)... c = c + 1
      ++c;
    
    }  //close inner loop, i
//TEST///////   }  //close outer loop, j

}  // close void draw


//--------------------------------------------   


class Crayon{
  
  //this declares that the data is going to be in Strings now (I think...?)
  String x;
  String y;
  
  //identifying the existing strings and naming the ones I want to use
  Crayon(String s1, String s2, String s3, String s4, String s5){ 
     x = s3;
     y = s2;
  }
}  //close the class
