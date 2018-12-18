/*
Try to get strings from an external file to cycle through a counter instead of counter value. See also another sketch: clock.pde.
*/

/*
WORKING WITH DATA 1 : CSV files

1. opening/reading files
2. try / catch
2. parsing strings
3. custom clases/objects
4. ArrayList 
*/

ArrayList<Date> dates; //an ArrayList of Tune objects

void setup(){
  size(400,400);
  
  /*
  noLoop();
  */
  
  //LOAD DATA
  dates = new ArrayList<Date>(); //initialize dates
    try {
      
      BufferedReader reader = createReader("dates_test.txt");  //create reader to read file
      String line = "";
      while( ( line = reader.readLine() ) != null){ //readline() returns null when it gets to the end of the file, so this will keep looping as long as there's more data
      
        if( line.charAt(0) == '#' ) continue; //ignore headers
      
        String pieces[] = split(line, ","); //split the line into parts at the commas
        
        //create new Tune, passing pieces as arguments, and add to dates
        dates.add( new Date(pieces[0], pieces[1]) );

      }  //close while
    }  //close try
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch 
    
  }  //close void setup
   
   
//---------------------------------------------------------------------------


void draw(){
  
  background(0,0,0);
  textSize(16);

  int xOffset = 10;
  int yOffset = 20;
  
  
  //  this is where the writing of the text happens
  for(int i = 0;i<dates.size(); ++i){ //for loop... like an array, but notice: we use dates.size() not dates.length and...
    
    text(dates.get(i).month + ": " + dates.get(i).day, xOffset, i*20+yOffset);        //dates.get(i) not dates[i]
  
  }  //close for loop
  
}  //close void draw


//---------------------------------------------------------------------------


//Date class to hold data
class Date{ //declare the class
  
  //declare variables
  String month;
  String day;
  
  //constructor
  Date(String s1, String s2 ){ 
     month = s1;
     day = s2;
  }  //  close Date constructor
  
}  //  close Date class



