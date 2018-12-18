/*
parent file = wb12

Hover over button and sighting dots for swallow show up bigger, also image appears. Both effects stop when roll off of image.
Click button and it turns test dot on/off with alpha.
Hovering makes the dots bigger. If button is off, they are just hollow outlines. If the button is on, they are fills.
Also can control stroke weight when button is off but hovering; still need to make an int for this!
Right now ellipses for total sightings are commented out, because they will be replaced with ones specific to their own species, like swallow.

1. Make click on and off work for alpha of the species' dots whose button it is.
2. Make stripey image for on/off over button.
3. Make all buttons have placeholder images so that all that needs to be done is add illustrated birds.
4. Make all buttons (functional). 
5. Add tabs. 
...
6. Worldly Birds hover explanation.
7. Pause/play timer.
8. Scrub timer.

PROBLEMS:

Can't get it to make the sighting dots bigger when I hover over them. Right now I am planning to not have this feature.

It is skipping January 1 for some reason. (Compare to plain text counter, which is behind by one.)

It will not obey my button offsets! I cannot figure out why it will not space them/center them the way I tell it to.

When I try to rise the y-value(s) of the clock, it starts to go mildly off orbit. (Add '+ vertical_button_offset' to counter y-values, then compare top to Greenland.)

Why is button #1 moved over into button #2's position?


COMMENTS LEGEND:

//  %%%%%%%%%%%% Very important comment!

//----------------------------------------------------------------  
//  separates void setup from void draw, etc.
    
//................................................................  
//  separates (very) main ideas within void setup, etc.    
            
/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
These encapsulate temporarily commented out sections for experimenting.
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
//  a place where INDIVIDUAL SPECIES data will need to be copy-and-pasted





void setup(){
  
  //  load map image
  background = loadImage("world_map.png"); 

//................................................................

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  
  //  load bird illustrations
  hummingbird_img = loadImage("hummingbird.png");

//................................................................
  
  size(1250,625);  
  frameRate(60);      
  noStroke();    //  so that nothing will have a stroke unless it is called
  //  typography
  PFont font; 
  font = loadFont("Gotham_Light_100.vlw");
  textFont(font, monthTextSize); 
  vector = new PVector(0, clockArm);    //  the length of the clock arm when it points to 12 o'clock, before rotating
  
  //................................................................
  
  //load data from bird sightings spreadsheet
  birds = new ArrayList<Birds>();
    try {  
      BufferedReader reader = createReader("total_sightings.csv");  //  %%%%%%%%%% EXTERNAL FILE NAME %%%%%%%%%%
      String line = ",";
      while((line = reader.readLine()) != null){
        if(line.charAt(0) == '#' ) continue; 
        String entity[] = split(line, ",");
        //parses apart the data within Excel columns ("entity"s) and adds them to something (I think?)
        birds.add(new Birds(entity[0], entity[1], entity[2], entity[3], entity[4]));
      }  //close while loop
    }  //close try
    
    //................................................................
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch
    
    //................................................................
    
  //load data so clock can read words and dates
  dates = new ArrayList<Date>(); //initialize dates
    try {
      BufferedReader reader = createReader("year_dates.csv");  //  %%%%%%%%%% EXTERNAL FILE NAME %%%%%%%%%%
      String line = "";      
      while( ( line = reader.readLine() ) != null){        
        if( line.charAt(0) == '#' ) continue;        
        String pieces[] = split(line, ",");        
        dates.add( new Date(pieces[0], pieces[1]) );
      }  //  close while
    }  //  close try 
    
    //................................................................
    
    catch (IOException e) {
      e.printStackTrace();
    }  //close catch
  }  //close void setup


//----------------------------------------------------------------


void draw(){ 
  
  //  conversion between screen pixel width and latitude...
  //  (screen height in pixels)/180=(conversion rate)...in this case 3.47 (or screenwidth/2[which is the same number as height])/180) will get the same result)
  //  just make sure the lng is negative!
  float map_lat = 3.47;
  float map_lng = -3.47;
  
  //................................................................
  
  if(millis() > starttime+1000*millis_multiplier){ 
    
    //................................................................
    
    image(background,0,0); 
    
    //................................................................

//  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
    //  HOVER   
    //  if NOT hovering over species' button && the button is OFF...
    if(hover_swallow_button == false){                
      dot_size_swallow = dot_size;        
      swallow_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if(hover_swallow_button == true && swallow_dot_alpha == alpha_on){      
      dot_size_swallow = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5),
          ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset,
            height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset + (line_diameter*.5),
            height - button_vertical_offset - (button_width*.5) - line_height,  
            line_diameter,line_diameter,  radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset + line_diameter*.5,
             height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5,      
           ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset + button_width + hummingbird_img.width*scale - line_diameter,
             height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img,
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + img_horizontal_offset,
              height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
              hummingbird_img.width*scale, hummingbird_img.height*scale);
      swallow_stroke_alpha = alpha_off;              
      swallow_button_stroke_alpha = alpha_off;
      swallow_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_swallow_button == true && swallow_dot_alpha == alpha_off){
      dot_size_swallow = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5),
           ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset + (line_diameter*.5),
            height - button_vertical_offset - (button_width*.5) - line_height,  
            line_diameter,line_diameter,  radians(180), radians (270));      
       line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + line_diameter*.5,
              height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5,      
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + button_width + hummingbird_img.width*scale - line_diameter,
              height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img,
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + img_horizontal_offset,
              height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
              hummingbird_img.width*scale, hummingbird_img.height*scale);
      swallow_stroke_alpha = alpha_on;
      swallow_button_stroke_alpha = button_alpha_hover;
      swallow_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_swallow, g_swallow, b_swallow,  swallow_button_stroke_alpha);
    fill(r_swallow, g_swallow, b_swallow,  swallow_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 + button_wall_offset),
               height - (button_vertical_offset),  
               button_width, button_width);

    //................................................................  
    
    //  array of button outlines
    for(int button_outline_number = 0; button_outline_number < 25; ++button_outline_number){
      fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha*.25);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
      strokeWeight(button_outline_stroke);
      ellipse(((width - 2*button_wall_offset) / 24)*button_outline_number //  <<<<<< REPRESENTS INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    + button_wall_offset,
                  height - (button_vertical_offset),  button_outline_width, button_outline_width);
      }
//  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */    

            
    //................................................................

    translate(width/2, height/2);  
    
    //................................................................
    
    ++counter;     
    if(counter>counter_duration){
      counter=1; 
    }  
    
    //................................................................

    for(int sighting = 0; sighting<birds.size(); ++sighting){ 
        float x_position = float(birds.get(sighting).lng);
        float y_position = float(birds.get(sighting).lat);
        int date_projection = int(birds.get(sighting).date); 
     
      if((counter>=date_projection - sighting_duration && 
          counter<=date_projection + sighting_duration) ||
         (counter>=counter_duration - sighting_duration &&
          counter<=sighting_duration)){

        //................................................................
        
        /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v 
        noStroke();
        if(hummingbird_color_code.equals(birds.get(sighting).species)){
          fill(hummingbird_color);
        } 
                
        if(ostrich_color_code.equals(birds.get(sighting).species)){
          fill(ostrich_color);
        } 
                
        if(crane_color_code.equals(birds.get(sighting).species)){
          fill(crane_color);
        } 
        
        if(tern_color_code.equals(birds.get(sighting).species)){
          fill(tern_color);
        }
        
        if(puffin_color_code.equals(birds.get(sighting).species)){
          fill(puffin_color);
        }

        if(swan_color_code.equals(birds.get(sighting).species)){
          fill(swan_color);
        }

        if(oriole_color_code.equals(birds.get(sighting).species)){
          fill(oriole_color);
        }

        if(pelican_color_code.equals(birds.get(sighting).species)){
          fill(pelican_color);
        }
        
        if(albatross_color_code.equals(birds.get(sighting).species)){
          fill(albatross_color);
        }   

        if(flicker_color_code.equals(birds.get(sighting).species)){
          fill(flicker_color);
        }

        if(sandpiper_color_code.equals(birds.get(sighting).species)){
          fill(sandpiper_color);
        }  
        
        if(owl_color_code.equals(birds.get(sighting).species)){
          fill(owl_color);
        }
        
        if(wagtail_color_code.equals(birds.get(sighting).species)){
          fill(wagtail_color);
        }
        
        if(macaw_color_code.equals(birds.get(sighting).species)){
          fill(macaw_color);
        }
                
        if(vireo_color_code.equals(birds.get(sighting).species)){
          fill(vireo_color);
        }
         
        if(bee_color_code.equals(birds.get(sighting).species)){
          fill(bee_color);
        }
         
        if(kingfisher_color_code.equals(birds.get(sighting).species)){
          fill(kingfisher_color);
        }
         
        if(pintail_color_code.equals(birds.get(sighting).species)){
          fill(pintail_color);
        }
        ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */
        
        
        
        if((swallow_color_code.equals(birds.get(sighting).species) && swallow_dot_alpha == alpha_on) || (swallow_color_code.equals(birds.get(sighting).species) && hover_swallow_button == true)){
          stroke(r_swallow, g_swallow, b_swallow,  swallow_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_swallow, g_swallow, b_swallow,  swallow_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng,  dot_size_swallow,dot_size_swallow);
        }                       


/* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
    //  HOVER   
    //  if NOT hovering over species' button && the button is OFF...
    if(hover_swallow_button == false){                
    }
    //  if YES hovering over species' button && the button is ON...
    if(hover_swallow_button == true && swallow_dot_alpha == alpha_on){      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5),
          ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset,
            height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset + (line_diameter*.5),
            height - button_vertical_offset - (button_width*.5) - line_height,  
            line_diameter,line_diameter,  radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset + line_diameter*.5,
             height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5,      
           ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset + button_width + hummingbird_img.width*scale - line_diameter,
             height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img,
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + img_horizontal_offset,
              height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
              hummingbird_img.width*scale, hummingbird_img.height*scale);
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_swallow_button == true && swallow_dot_alpha == alpha_off){
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5),
           ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             + button_wall_offset,
             height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            + button_wall_offset + (line_diameter*.5),
            height - button_vertical_offset - (button_width*.5) - line_height,  
            line_diameter,line_diameter,  radians(180), radians (270));      
       line(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + line_diameter*.5,
              height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5,      
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + button_width + hummingbird_img.width*scale - line_diameter,
              height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img,
            ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset + img_horizontal_offset,
              height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
              hummingbird_img.width*scale, hummingbird_img.height*scale);
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */        
        
        
        /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
        if(shearwater_color_code.equals(birds.get(sighting).species)){
          fill(shearwater_color);
        }
         
        if(kite_color_code.equals(birds.get(sighting).species)){
          fill(kite_color);
        }
         
        if(penguin_color_code.equals(birds.get(sighting).species)){
          fill(penguin_color);
        }
         
        if(swift_color_code.equals(birds.get(sighting).species)){
          fill(swift_color);
        }
         
        if(martin_color_code.equals(birds.get(sighting).species)){
          fill(martin_color);
        }
         
        if(galah_color_code.equals(birds.get(sighting).species)){
          fill(galah_color);
        }
        ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */       
 
        //................................................................
        
        /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
        //  array of dots
        ellipse(x_position*map_lat, y_position*map_lng,  dot_size,dot_size);
        ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */             
        
      }  //  close if(date_projection)
            
    }  // close for(int sighting...)
   
    //................................................................
    
    /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //  this is the text showing the VALUE of the counter (not the date), for testing the counter's value (not to be shown on final project)
    String s = String.valueOf(counter);  
    textAlign(CENTER);
    textSize(50);
    fill(0,0,0);    
    text(s, 0,0); 
    ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */
    
    //  LEAVING THESE COMMENTS FOR NOW, IN CASE NEEDED FOR HANDLE-DRAGGING COMMANDS
    
    if(counter>=dates.size() ){
      counter=1; 
    }  //  close if
    
    //  text showing the month and day
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    textAlign(CENTER);
    text(dates.get(counter).month,  0,0);
    text(dates.get(counter).day,  0,day_leading);
    
    //  the circular, moving part of the clock
    
    //rotation command
    rotate( counter * radians(.986) ); //.986 = 360degrees/365"days" = 1 rotation every 60seconds (almost, as close as can get)
    
    //handle
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha*.25);
    stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    strokeWeight(clockStroke);
    ellipse(vector.x, -vector.y, handleDiameter, handleDiameter);
    
    //clock edge is an arc with the part missing where the handle is, so it can be transparent
    noFill();
    strokeWeight(clockStroke);
    
    //  ??????????????????????????????????????????????????????????????  Why can't I put ' - button_vertical_offset' here so that the clock will shift upwards to make way for buttons?
    arc(0, 0, clockArm*2, clockArm*2, radians(-88), radians (268));
  
  //  without this, the counter won't listen to the speeds set earlier
  starttime = millis();

  }  //  close if(millis)

}  // close void draw


//----------------------------------------------------------------   


class Birds{  
  String species;
  String lat;
  String lng;
  String date;
  
  Birds(String s1, String s2, String s3, String s4, String s5){ 
    species = s1;
    lat = s2; 
    lng = s3;
    date = s5;
  }
}  

//................................................................

class Date{ 
  String month;
  String day;
  
  Date(String s1, String s2 ){ 
     month = s1;
     day = s2;
  }  
}  


//----------------------------------------------------------------


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
//  setting up the functional buttons: a method to check if the mouse is over the button
//  not sure if it (e.g. 'x_swallow' and 'y_swallow') would have to change for each bird, or if it could stay the same for all, or even if it could be mouseX and mouseY?
boolean swallow_hover( int x_swallow, int y_swallow){
  if(dist(((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIE'S NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              + button_wall_offset,
            height - (button_vertical_offset),  
            mouseX, mouseY)*2 < button_width) {
    return true;
    } else { 
      return false; 
      }  
}  


//----------------------------------------------------------------

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
//  setting a true/false flag for hover
void mouseMoved(){
    
    if(swallow_hover(mouseX, mouseY)) hover_swallow_button = true;
      else hover_swallow_button = false;
    //redraw();  //  I haven't noticed that I need to call redraw... but maybe...?  
}


//----------------------------------------------------------------

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES
//  click
void mouseClicked(){
  //  I have no idea why putting '*2' at the end (almost) makes it the right size...
  if(dist(
    ((width - 2*button_wall_offset) / 24)*(-1 + 1)  //  <<<<<< REPLACE WITH INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        + button_wall_offset,
      height - (button_vertical_offset),
      mouseX, mouseY)*2 < button_width) {
      if(hover_swallow_button = true && swallow_dot_alpha == alpha_on){
      swallow_dot_alpha = alpha_off;
      } else
        if(hover_swallow_button = true && swallow_dot_alpha == alpha_off){
          swallow_dot_alpha = alpha_on; 
      }  //  close if (hover
  }  //  close if (dist
}  //  close void mouseClicked
