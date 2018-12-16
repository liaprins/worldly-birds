/*
parent file = wb15
 
 NEW PLAN:
 
 5. Try to move galah...?
 6. Illustrate everything.
 7. Mess around with variables to hone look.
 
 ...
 2. Pause/play timer.
 3. Scrub timer.
 
 PROBLEMS:
 
 Hover and click latency.
 
 Can't get it to make the sighting dots bigger when I hover over them. Right now I am planning to not have this feature.
 
 It is skipping January 1 for some reason. (Compare to plain text counter, which is behind by one.)
 
 When I try to rise the y-value(s) of the clock, it starts to go mildly off orbit. (Add '+ vertical_button_offset' to counter y-values, then compare top to Greenland.)
 
 Gotham Light turns itself into Gotham Book (or Medium?) when turned into a .vlw file.
 
 
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

//  ??????????????????????????????????????????????????????????????
//  questions/problem areas to show Tad



void setup() {

  //  load map image
  background = loadImage("world_map.png"); 
  caption = loadImage("caption.png");

  //................................................................

  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #1 start
  //  load bird illustrations
  hummingbird_img = loadImage("hummingbird.png");
  ostrich_img = loadImage("ostrich.png");
  crane_img = loadImage("crane.png");
  tern_img = loadImage("tern.png");
  puffin_img = loadImage("puffin.png");
  swan_img = loadImage("swan.png");
  oriole_img = loadImage("oriole.png");
  pelican_img = loadImage("pelican.png");
  albatross_img = loadImage("albatross.png");
  flicker_img = loadImage("flicker.png");
  sandpiper_img = loadImage("sandpiper.png");
  owl_img = loadImage("owl.png");
  wagtail_img = loadImage("wagtail.png");
  macaw_img = loadImage("macaw.png");
  vireo_img = loadImage("vireo.png");
  bee_img = loadImage("bee.png");
  kingfisher_img = loadImage("kingfisher.png");
  pintail_img = loadImage("pintail.png");
  swallow_img = loadImage("swallow.png");
  shearwater_img = loadImage("shearwater.png");
  kite_img = loadImage("kite.png");
  penguin_img = loadImage("penguin.png");
  swift_img = loadImage("swift.png");
  martin_img = loadImage("martin.png");
  galah_img = loadImage("galah.png");  

  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #1 end


  //................................................................

  size(1250, 625);  
  frameRate(60);      
  noStroke();    //  so that nothing will have a stroke unless it is called
  //  typography
  PFont font_counter = loadFont("Gotham_Light_100.vlw");
  textFont(font_counter, monthTextSize);  
  vector = new PVector(0, clockArm);    //  the length of the clock arm when it points to 12 o'clock, before rotating

  //................................................................

  //load data from bird sightings spreadsheet
  birds = new ArrayList<Birds>();
  try {  
    BufferedReader reader = createReader("total_sightings.csv");  //  %%%%%%%%%% EXTERNAL FILE NAME %%%%%%%%%%
    String line = ",";
    while ( (line = reader.readLine ()) != null) {
      if (line.charAt(0) == '#' ) continue; 
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
    while ( ( line = reader.readLine () ) != null) {        
      if ( line.charAt(0) == '#' ) continue;        
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


void draw() { 

  //  conversion between screen pixel width and latitude...
  //  (screen height in pixels)/180=(conversion rate)...in this case 3.47 (or screenwidth/2[which is the same number as height])/180) will get the same result)
  //  just make sure the lng is negative!
  float map_lat = 3.47;
  float map_lng = -3.47;

  //................................................................

  if (millis() > starttime+1000*millis_multiplier) { 

    //................................................................

    image(background, 0, 0); 

    //................................................................
    
    if (title_hover_rollover == true) {
      title_alpha = 0;
      caption_alpha = clockStroke_Alpha;
      image(caption, 
           width - caption.width - horizontal_title_offset,
           height - height + vertical_title_offset + 9);    
           } else {title_alpha = clockStroke_Alpha;
           caption_alpha = 0;
           }    

    //  /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #2 start
    //  HOVER   
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_hummingbird_button == false) {                
      dot_size_hummingbird = dot_size;        
      hummingbird_stroke_alpha = alpha_off;
    }
    noFill();
    //  if YES hovering over species' button && the button is ON...
    if (hover_hummingbird_button == true && hummingbird_dot_alpha == alpha_on) {      
      dot_size_hummingbird = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + button_width + (hummingbird_img.width*scale + hummingbird_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      hummingbird_stroke_alpha = alpha_off;              
      hummingbird_button_stroke_alpha = alpha_off;
      hummingbird_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_hummingbird_button == true && hummingbird_dot_alpha == alpha_off) {
      dot_size_hummingbird = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + button_width + (hummingbird_img.width*scale + hummingbird_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 1)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      hummingbird_stroke_alpha = alpha_on;
      hummingbird_button_stroke_alpha = button_alpha_hover;
      hummingbird_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_hummingbird, g_hummingbird, b_hummingbird, hummingbird_button_stroke_alpha);
    fill(r_hummingbird, g_hummingbird, b_hummingbird, hummingbird_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 1)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 
    
    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_ostrich_button == false) {                
      dot_size_ostrich = dot_size;        
      ostrich_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_ostrich_button == true && ostrich_dot_alpha == alpha_on) {      
      dot_size_ostrich = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + button_width + (ostrich_img.width*scale + ostrich_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(ostrich_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - ostrich_img.height - line_height - line_diameter + img_vertical_offset, 
      ostrich_img.width*scale, ostrich_img.height*scale);
      ostrich_stroke_alpha = alpha_off;              
      ostrich_button_stroke_alpha = alpha_off;
      ostrich_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_ostrich_button == true && ostrich_dot_alpha == alpha_off) {
      dot_size_ostrich = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + button_width + (ostrich_img.width*scale + ostrich_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(ostrich_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 2)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - ostrich_img.height - line_height - line_diameter + img_vertical_offset, 
      ostrich_img.width*scale, ostrich_img.height*scale);
      ostrich_stroke_alpha = alpha_on;
      ostrich_button_stroke_alpha = button_alpha_hover;
      ostrich_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_ostrich, g_ostrich, b_ostrich, ostrich_button_stroke_alpha);
    fill(r_ostrich, g_ostrich, b_ostrich, ostrich_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 2)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_crane_button == false) {                
      dot_size_crane = dot_size;        
      crane_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_crane_button == true && crane_dot_alpha == alpha_on) {      
      dot_size_crane = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + button_width + (crane_img.width*scale + crane_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(crane_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - crane_img.height - line_height - line_diameter + img_vertical_offset, 
      crane_img.width*scale, crane_img.height*scale);
      crane_stroke_alpha = alpha_off;              
      crane_button_stroke_alpha = alpha_off;
      crane_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_crane_button == true && crane_dot_alpha == alpha_off) {
      dot_size_crane = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + button_width + (crane_img.width*scale + crane_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(crane_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 3)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - crane_img.height - line_height - line_diameter + img_vertical_offset, 
      crane_img.width*scale, crane_img.height*scale);
      crane_stroke_alpha = alpha_on;
      crane_button_stroke_alpha = button_alpha_hover;
      crane_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_crane, g_crane, b_crane, crane_button_stroke_alpha);
    fill(r_crane, g_crane, b_crane, crane_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 3)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_tern_button == false) {                
      dot_size_tern = dot_size;        
      tern_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_tern_button == true && tern_dot_alpha == alpha_on) {      
      dot_size_tern = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + button_width + (tern_img.width*scale + tern_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(tern_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - tern_img.height - line_height - line_diameter + img_vertical_offset, 
      tern_img.width*scale, tern_img.height*scale);
      tern_stroke_alpha = alpha_off;              
      tern_button_stroke_alpha = alpha_off;
      tern_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_tern_button == true && tern_dot_alpha == alpha_off) {
      dot_size_tern = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + button_width + (tern_img.width*scale + tern_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(tern_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 4)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - tern_img.height - line_height - line_diameter + img_vertical_offset, 
      tern_img.width*scale, tern_img.height*scale);
      tern_stroke_alpha = alpha_on;
      tern_button_stroke_alpha = button_alpha_hover;
      tern_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_tern, g_tern, b_tern, tern_button_stroke_alpha);
    fill(r_tern, g_tern, b_tern, tern_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 4)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_puffin_button == false) {                
      dot_size_puffin = dot_size;        
      puffin_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_puffin_button == true && puffin_dot_alpha == alpha_on) {      
      dot_size_puffin = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + button_width + (puffin_img.width*scale + puffin_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(puffin_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - puffin_img.height - line_height - line_diameter + img_vertical_offset, 
      puffin_img.width*scale, puffin_img.height*scale);
      puffin_stroke_alpha = alpha_off;              
      puffin_button_stroke_alpha = alpha_off;
      puffin_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_puffin_button == true && puffin_dot_alpha == alpha_off) {
      dot_size_puffin = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + button_width + (puffin_img.width*scale + puffin_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(puffin_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 5)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - puffin_img.height - line_height - line_diameter + img_vertical_offset, 
      puffin_img.width*scale, puffin_img.height*scale);
      puffin_stroke_alpha = alpha_on;
      puffin_button_stroke_alpha = button_alpha_hover;
      puffin_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_puffin, g_puffin, b_puffin, puffin_button_stroke_alpha);
    fill(r_puffin, g_puffin, b_puffin, puffin_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 5)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_swan_button == false) {                
      dot_size_swan = dot_size;        
      swan_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_swan_button == true && swan_dot_alpha == alpha_on) {      
      dot_size_swan = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + button_width + (swan_img.width*scale + swan_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(swan_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - swan_img.height - line_height - line_diameter + img_vertical_offset, 
      swan_img.width*scale, swan_img.height*scale);
      swan_stroke_alpha = alpha_off;              
      swan_button_stroke_alpha = alpha_off;
      swan_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_swan_button == true && swan_dot_alpha == alpha_off) {
      dot_size_swan = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + button_width + (swan_img.width*scale + swan_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(swan_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 6)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - swan_img.height - line_height - line_diameter + img_vertical_offset, 
      swan_img.width*scale, swan_img.height*scale);
      swan_stroke_alpha = alpha_on;
      swan_button_stroke_alpha = button_alpha_hover;
      swan_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_swan, g_swan, b_swan, swan_button_stroke_alpha);
    fill(r_swan, g_swan, b_swan, swan_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 6)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_oriole_button == false) {                
      dot_size_oriole = dot_size;        
      oriole_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_oriole_button == true && oriole_dot_alpha == alpha_on) {      
      dot_size_oriole = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + button_width + (oriole_img.width*scale + oriole_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(oriole_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - oriole_img.height - line_height - line_diameter + img_vertical_offset, 
      oriole_img.width*scale, oriole_img.height*scale);
      oriole_stroke_alpha = alpha_off;              
      oriole_button_stroke_alpha = alpha_off;
      oriole_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_oriole_button == true && oriole_dot_alpha == alpha_off) {
      dot_size_oriole = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + button_width + (oriole_img.width*scale + oriole_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(oriole_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 7)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - oriole_img.height - line_height - line_diameter + img_vertical_offset, 
      oriole_img.width*scale, oriole_img.height*scale);
      oriole_stroke_alpha = alpha_on;
      oriole_button_stroke_alpha = button_alpha_hover;
      oriole_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_oriole, g_oriole, b_oriole, oriole_button_stroke_alpha);
    fill(r_oriole, g_oriole, b_oriole, oriole_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 7)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_pelican_button == false) {                
      dot_size_pelican = dot_size;        
      pelican_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_pelican_button == true && pelican_dot_alpha == alpha_on) {      
      dot_size_pelican = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + button_width + (pelican_img.width*scale + pelican_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(pelican_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - pelican_img.height - line_height - line_diameter + img_vertical_offset, 
      pelican_img.width*scale, pelican_img.height*scale);
      pelican_stroke_alpha = alpha_off;              
      pelican_button_stroke_alpha = alpha_off;
      pelican_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_pelican_button == true && pelican_dot_alpha == alpha_off) {
      dot_size_pelican = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + button_width + (pelican_img.width*scale + pelican_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(pelican_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 8)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - pelican_img.height - line_height - line_diameter + img_vertical_offset, 
      pelican_img.width*scale, pelican_img.height*scale);
      pelican_stroke_alpha = alpha_on;
      pelican_button_stroke_alpha = button_alpha_hover;
      pelican_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_pelican, g_pelican, b_pelican, pelican_button_stroke_alpha);
    fill(r_pelican, g_pelican, b_pelican, pelican_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 8)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_albatross_button == false) {                
      dot_size_albatross = dot_size;        
      albatross_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_albatross_button == true && albatross_dot_alpha == alpha_on) {      
      dot_size_albatross = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + button_width + (albatross_img.width*scale + albatross_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(albatross_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - albatross_img.height - line_height - line_diameter + img_vertical_offset, 
      albatross_img.width*scale, albatross_img.height*scale);
      albatross_stroke_alpha = alpha_off;              
      albatross_button_stroke_alpha = alpha_off;
      albatross_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_albatross_button == true && albatross_dot_alpha == alpha_off) {
      dot_size_albatross = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + button_width + (albatross_img.width*scale + albatross_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(albatross_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 9)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - albatross_img.height - line_height - line_diameter + img_vertical_offset, 
      albatross_img.width*scale, albatross_img.height*scale);
      albatross_stroke_alpha = alpha_on;
      albatross_button_stroke_alpha = button_alpha_hover;
      albatross_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_albatross, g_albatross, b_albatross, albatross_button_stroke_alpha);
    fill(r_albatross, g_albatross, b_albatross, albatross_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 9)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_flicker_button == false) {                
      dot_size_flicker = dot_size;        
      flicker_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_flicker_button == true && flicker_dot_alpha == alpha_on) {      
      dot_size_flicker = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + button_width + (flicker_img.width*scale + flicker_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(flicker_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - flicker_img.height - line_height - line_diameter + img_vertical_offset, 
      flicker_img.width*scale, flicker_img.height*scale);
      flicker_stroke_alpha = alpha_off;              
      flicker_button_stroke_alpha = alpha_off;
      flicker_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_flicker_button == true && flicker_dot_alpha == alpha_off) {
      dot_size_flicker = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + button_width + (flicker_img.width*scale + flicker_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(flicker_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 10)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - flicker_img.height - line_height - line_diameter + img_vertical_offset, 
      flicker_img.width*scale, flicker_img.height*scale);
      flicker_stroke_alpha = alpha_on;
      flicker_button_stroke_alpha = button_alpha_hover;
      flicker_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_flicker, g_flicker, b_flicker, flicker_button_stroke_alpha);
    fill(r_flicker, g_flicker, b_flicker, flicker_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 10)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_sandpiper_button == false) {                
      dot_size_sandpiper = dot_size;        
      sandpiper_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_sandpiper_button == true && sandpiper_dot_alpha == alpha_on) {      
      dot_size_sandpiper = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + button_width + (sandpiper_img.width*scale + sandpiper_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(sandpiper_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - sandpiper_img.height - line_height - line_diameter + img_vertical_offset, 
      sandpiper_img.width*scale, sandpiper_img.height*scale);
      sandpiper_stroke_alpha = alpha_off;              
      sandpiper_button_stroke_alpha = alpha_off;
      sandpiper_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_sandpiper_button == true && sandpiper_dot_alpha == alpha_off) {
      dot_size_sandpiper = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + button_width + (sandpiper_img.width*scale + sandpiper_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(sandpiper_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 11)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - sandpiper_img.height - line_height - line_diameter + img_vertical_offset, 
      sandpiper_img.width*scale, sandpiper_img.height*scale);
      sandpiper_stroke_alpha = alpha_on;
      sandpiper_button_stroke_alpha = button_alpha_hover;
      sandpiper_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_sandpiper, g_sandpiper, b_sandpiper, sandpiper_button_stroke_alpha);
    fill(r_sandpiper, g_sandpiper, b_sandpiper, sandpiper_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 11)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_owl_button == false) {                
      dot_size_owl = dot_size;        
      owl_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_owl_button == true && owl_dot_alpha == alpha_on) {      
      dot_size_owl = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + button_width + (owl_img.width*scale + owl_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(owl_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - owl_img.height - line_height - line_diameter + img_vertical_offset, 
      owl_img.width*scale, owl_img.height*scale);
      owl_stroke_alpha = alpha_off;              
      owl_button_stroke_alpha = alpha_off;
      owl_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_owl_button == true && owl_dot_alpha == alpha_off) {
      dot_size_owl = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + button_width + (owl_img.width*scale + owl_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(owl_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 12)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - owl_img.height - line_height - line_diameter + img_vertical_offset, 
      owl_img.width*scale, owl_img.height*scale);
      owl_stroke_alpha = alpha_on;
      owl_button_stroke_alpha = button_alpha_hover;
      owl_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_owl, g_owl, b_owl, owl_button_stroke_alpha);
    fill(r_owl, g_owl, b_owl, owl_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 12)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_wagtail_button == false) {                
      dot_size_wagtail = dot_size;        
      wagtail_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_wagtail_button == true && wagtail_dot_alpha == alpha_on) {      
      dot_size_wagtail = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + button_width + (wagtail_img.width*scale + wagtail_line_edit) - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(wagtail_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - wagtail_img.height - line_height - line_diameter + img_vertical_offset, 
      wagtail_img.width*scale, wagtail_img.height*scale);
      wagtail_stroke_alpha = alpha_off;              
      wagtail_button_stroke_alpha = alpha_off;
      wagtail_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_wagtail_button == true && wagtail_dot_alpha == alpha_off) {
      dot_size_wagtail = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(180), radians (270));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + button_width + (wagtail_img.width*scale + wagtail_line_edit) - line_diameter, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(wagtail_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 13)
        + button_wall_offset + img_horizontal_offset, 
      height - (button_vertical_offset) - wagtail_img.height - line_height - line_diameter + img_vertical_offset, 
      wagtail_img.width*scale, wagtail_img.height*scale);
      wagtail_stroke_alpha = alpha_on;
      wagtail_button_stroke_alpha = button_alpha_hover;
      wagtail_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_wagtail, g_wagtail, b_wagtail, wagtail_button_stroke_alpha);
    fill(r_wagtail, g_wagtail, b_wagtail, wagtail_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 13)
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //................................................................ 

    noFill();
    //  if NOT hovering over species' button && the button is OFF...
    if (hover_macaw_button == false) {                
      dot_size_macaw = dot_size;        
      macaw_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_macaw_button == true && macaw_dot_alpha == alpha_on) {      
      dot_size_macaw = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + macaw_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      macaw_stroke_alpha = alpha_off;              
      macaw_button_stroke_alpha = alpha_off;
      macaw_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_macaw_button == true && macaw_dot_alpha == alpha_off) {
      dot_size_macaw = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + macaw_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 14)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      macaw_stroke_alpha = alpha_on;
      macaw_button_stroke_alpha = button_alpha_hover;
      macaw_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_macaw, g_macaw, b_macaw, macaw_button_stroke_alpha);
    fill(r_macaw, g_macaw, b_macaw, macaw_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 14) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);


    noFill();
    if (hover_vireo_button == false) {                
      dot_size_vireo = dot_size;        
      vireo_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_vireo_button == true && vireo_dot_alpha == alpha_on) {      
      dot_size_vireo = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + vireo_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      vireo_stroke_alpha = alpha_off;              
      vireo_button_stroke_alpha = alpha_off;
      vireo_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_vireo_button == true && vireo_dot_alpha == alpha_off) {
      dot_size_vireo = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + vireo_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 15)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      vireo_stroke_alpha = alpha_on;
      vireo_button_stroke_alpha = button_alpha_hover;
      vireo_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_vireo, g_vireo, b_vireo, vireo_button_stroke_alpha);
    fill(r_vireo, g_vireo, b_vireo, vireo_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 15) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_bee_button == false) {                
      dot_size_bee = dot_size;        
      bee_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_bee_button == true && bee_dot_alpha == alpha_on) {      
      dot_size_bee = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + bee_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      bee_stroke_alpha = alpha_off;              
      bee_button_stroke_alpha = alpha_off;
      bee_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_bee_button == true && bee_dot_alpha == alpha_off) {
      dot_size_bee = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + bee_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 16)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      bee_stroke_alpha = alpha_on;
      bee_button_stroke_alpha = button_alpha_hover;
      bee_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_bee, g_bee, b_bee, bee_button_stroke_alpha);
    fill(r_bee, g_bee, b_bee, bee_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 16) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_kingfisher_button == false) {                
      dot_size_kingfisher = dot_size;        
      kingfisher_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_kingfisher_button == true && kingfisher_dot_alpha == alpha_on) {      
      dot_size_kingfisher = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + kingfisher_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      kingfisher_stroke_alpha = alpha_off;              
      kingfisher_button_stroke_alpha = alpha_off;
      kingfisher_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_kingfisher_button == true && kingfisher_dot_alpha == alpha_off) {
      dot_size_kingfisher = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + kingfisher_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 17)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      kingfisher_stroke_alpha = alpha_on;
      kingfisher_button_stroke_alpha = button_alpha_hover;
      kingfisher_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_kingfisher, g_kingfisher, b_kingfisher, kingfisher_button_stroke_alpha);
    fill(r_kingfisher, g_kingfisher, b_kingfisher, kingfisher_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 17) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_pintail_button == false) {                
      dot_size_pintail = dot_size;        
      pintail_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_pintail_button == true && pintail_dot_alpha == alpha_on) {      
      dot_size_pintail = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + pintail_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      pintail_stroke_alpha = alpha_off;              
      pintail_button_stroke_alpha = alpha_off;
      pintail_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_pintail_button == true && pintail_dot_alpha == alpha_off) {
      dot_size_pintail = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + pintail_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 18)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      pintail_stroke_alpha = alpha_on;
      pintail_button_stroke_alpha = button_alpha_hover;
      pintail_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_pintail, g_pintail, b_pintail, pintail_button_stroke_alpha);
    fill(r_pintail, g_pintail, b_pintail, pintail_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 18) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_swallow_button == false) {                
      dot_size_swallow = dot_size;        
      swallow_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_swallow_button == true && swallow_dot_alpha == alpha_on) {      
      dot_size_swallow = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + swallow_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      swallow_stroke_alpha = alpha_off;              
      swallow_button_stroke_alpha = alpha_off;
      swallow_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_swallow_button == true && swallow_dot_alpha == alpha_off) {
      dot_size_swallow = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + swallow_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 19)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      swallow_stroke_alpha = alpha_on;
      swallow_button_stroke_alpha = button_alpha_hover;
      swallow_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_swallow, g_swallow, b_swallow, swallow_button_stroke_alpha);
    fill(r_swallow, g_swallow, b_swallow, swallow_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 19) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_shearwater_button == false) {                
      dot_size_shearwater = dot_size;        
      shearwater_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_shearwater_button == true && shearwater_dot_alpha == alpha_on) {      
      dot_size_shearwater = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + shearwater_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      shearwater_stroke_alpha = alpha_off;              
      shearwater_button_stroke_alpha = alpha_off;
      shearwater_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_shearwater_button == true && shearwater_dot_alpha == alpha_off) {
      dot_size_shearwater = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + shearwater_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 20)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      shearwater_stroke_alpha = alpha_on;
      shearwater_button_stroke_alpha = button_alpha_hover;
      shearwater_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_shearwater, g_shearwater, b_shearwater, shearwater_button_stroke_alpha);
    fill(r_shearwater, g_shearwater, b_shearwater, shearwater_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 20) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_kite_button == false) {                
      dot_size_kite = dot_size;        
      kite_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_kite_button == true && kite_dot_alpha == alpha_on) {      
      dot_size_kite = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + kite_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      kite_stroke_alpha = alpha_off;              
      kite_button_stroke_alpha = alpha_off;
      kite_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_kite_button == true && kite_dot_alpha == alpha_off) {
      dot_size_kite = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + kite_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 21)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      kite_stroke_alpha = alpha_on;
      kite_button_stroke_alpha = button_alpha_hover;
      kite_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_kite, g_kite, b_kite, kite_button_stroke_alpha);
    fill(r_kite, g_kite, b_kite, kite_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 21) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_penguin_button == false) {                
      dot_size_penguin = dot_size;        
      penguin_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_penguin_button == true && penguin_dot_alpha == alpha_on) {      
      dot_size_penguin = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + penguin_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      penguin_stroke_alpha = alpha_off;              
      penguin_button_stroke_alpha = alpha_off;
      penguin_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_penguin_button == true && penguin_dot_alpha == alpha_off) {
      dot_size_penguin = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + penguin_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 22)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      penguin_stroke_alpha = alpha_on;
      penguin_button_stroke_alpha = button_alpha_hover;
      penguin_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_penguin, g_penguin, b_penguin, penguin_button_stroke_alpha);
    fill(r_penguin, g_penguin, b_penguin, penguin_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 22) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_swift_button == false) {                
      dot_size_swift = dot_size;        
      swift_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_swift_button == true && swift_dot_alpha == alpha_on) {      
      dot_size_swift = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + swift_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      swift_stroke_alpha = alpha_off;              
      swift_button_stroke_alpha = alpha_off;
      swift_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_swift_button == true && swift_dot_alpha == alpha_off) {
      dot_size_swift = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + swift_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 23)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      swift_stroke_alpha = alpha_on;
      swift_button_stroke_alpha = button_alpha_hover;
      swift_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_swift, g_swift, b_swift, swift_button_stroke_alpha);
    fill(r_swift, g_swift, b_swift, swift_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 23) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_martin_button == false) {                
      dot_size_martin = dot_size;        
      martin_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_martin_button == true && martin_dot_alpha == alpha_on) {      
      dot_size_martin = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + martin_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      martin_stroke_alpha = alpha_off;              
      martin_button_stroke_alpha = alpha_off;
      martin_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_martin_button == true && martin_dot_alpha == alpha_off) {
      dot_size_martin = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + martin_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 24)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      martin_stroke_alpha = alpha_on;
      martin_button_stroke_alpha = button_alpha_hover;
      martin_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_martin, g_martin, b_martin, martin_button_stroke_alpha);
    fill(r_martin, g_martin, b_martin, martin_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 24) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //...............................................................................................................

    noFill();
    if (hover_galah_button == false) {                
      dot_size_galah = dot_size;        
      galah_stroke_alpha = alpha_off;
    }
    //  if YES hovering over species' button && the button is ON...
    if (hover_galah_button == true && galah_dot_alpha == alpha_on) {      
      dot_size_galah = dot_size_hover;      
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + galah_line_edit)- line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      galah_stroke_alpha = alpha_off;              
      galah_button_stroke_alpha = alpha_off;
      galah_button_fill_alpha = button_alpha_hover;
    }
    //  if YES hovering over species' button && the button is OFF...        
    if (hover_galah_button == true && galah_dot_alpha == alpha_off) {
      dot_size_galah = dot_size_hover;
      strokeWeight(line_stroke_weight);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5), 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset, 
      height - button_vertical_offset - (button_width*.5) - line_height);  
      arc(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - (line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height, 
      line_diameter, line_diameter, radians(270), radians (360));      
      line(((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - line_diameter*.5, 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset   - (button_width + (hummingbird_img.width*scale + galah_line_edit) - line_diameter*.5), 
      height - button_vertical_offset - (button_width*.5) - line_height - line_diameter*.5);
      image(hummingbird_img, 
      ((width - 2*button_wall_offset) / 24)*(-1 + 25)  
        + button_wall_offset - (hummingbird_img.width*scale + img_horizontal_offset), 
      height - (button_vertical_offset) - hummingbird_img.height - line_height - line_diameter + img_vertical_offset, 
      hummingbird_img.width*scale, hummingbird_img.height*scale);
      galah_stroke_alpha = alpha_on;
      galah_button_stroke_alpha = button_alpha_hover;
      galah_button_fill_alpha = alpha_off;
    }
    strokeWeight(button_stroke_weight);
    stroke(r_galah, g_galah, b_galah, galah_button_stroke_alpha);
    fill(r_galah, g_galah, b_galah, galah_button_fill_alpha);
    ellipse((((width - 2*button_wall_offset) / 24)*(-1 + 25) 
      + button_wall_offset), 
    height - (button_vertical_offset), 
    button_width, button_width);

    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #2 end

    //................................................................  

    //  array of button outlines
    for (int button_outline_number = 0; button_outline_number < 25; ++button_outline_number) {
      fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha*.25);
      stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
      strokeWeight(button_outline_stroke);
      ellipse(((width - 2*button_wall_offset) / 24)*button_outline_number //  <<<<<< REPRESENTS INDIVIDUAL SPECIES NUMBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      + button_wall_offset, 
      height - (button_vertical_offset), button_outline_width, button_outline_width);
    }
    //  ^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^ */    


    //................................................................

    translate(width*.5, height*.5 - clock_offset);  

    //................................................................

    ++counter;     
    if (counter>counter_duration) {
      counter=0;
    }  

    //................................................................

    for (int sighting = 0; sighting<birds.size(); ++sighting) { 
      float x_position = float(birds.get(sighting).lng);
      float y_position = float(birds.get(sighting).lat) + (clock_offset/map_lng);
      int date_projection = int(birds.get(sighting).date); 

      if ((counter>=date_projection - sighting_duration && 
        counter<=date_projection + sighting_duration) ||
        (counter>=counter_duration - sighting_duration &&
        counter<=sighting_duration)) {

        //................................................................

        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #3 start        
        //  sighting dot arrays
        if ((hummingbird_color_code.equals(birds.get(sighting).species) && hummingbird_dot_alpha == alpha_on) || (hummingbird_color_code.equals(birds.get(sighting).species) && hover_hummingbird_button == true)) {
          stroke(r_hummingbird, g_hummingbird, b_hummingbird, hummingbird_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_hummingbird, g_hummingbird, b_hummingbird, hummingbird_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_hummingbird, dot_size_hummingbird);
        }          

        if ((ostrich_color_code.equals(birds.get(sighting).species) && ostrich_dot_alpha == alpha_on) || (ostrich_color_code.equals(birds.get(sighting).species) && hover_ostrich_button == true)) {
          stroke(r_ostrich, g_ostrich, b_ostrich, ostrich_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_ostrich, g_ostrich, b_ostrich, ostrich_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_ostrich, dot_size_ostrich);
        }          

        if ((crane_color_code.equals(birds.get(sighting).species) && crane_dot_alpha == alpha_on) || (crane_color_code.equals(birds.get(sighting).species) && hover_crane_button == true)) {
          stroke(r_crane, g_crane, b_crane, crane_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_crane, g_crane, b_crane, crane_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_crane, dot_size_crane);
        }          

        if ((tern_color_code.equals(birds.get(sighting).species) && tern_dot_alpha == alpha_on) || (tern_color_code.equals(birds.get(sighting).species) && hover_tern_button == true)) {
          stroke(r_tern, g_tern, b_tern, tern_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_tern, g_tern, b_tern, tern_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_tern, dot_size_tern);
        }          

        if ((puffin_color_code.equals(birds.get(sighting).species) && puffin_dot_alpha == alpha_on) || (puffin_color_code.equals(birds.get(sighting).species) && hover_puffin_button == true)) {
          stroke(r_puffin, g_puffin, b_puffin, puffin_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_puffin, g_puffin, b_puffin, puffin_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_puffin, dot_size_puffin);
        }          

        if ((swan_color_code.equals(birds.get(sighting).species) && swan_dot_alpha == alpha_on) || (swan_color_code.equals(birds.get(sighting).species) && hover_swan_button == true)) {
          stroke(r_swan, g_swan, b_swan, swan_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_swan, g_swan, b_swan, swan_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_swan, dot_size_swan);
        }          

        if ((oriole_color_code.equals(birds.get(sighting).species) && oriole_dot_alpha == alpha_on) || (oriole_color_code.equals(birds.get(sighting).species) && hover_oriole_button == true)) {
          stroke(r_oriole, g_oriole, b_oriole, oriole_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_oriole, g_oriole, b_oriole, oriole_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_oriole, dot_size_oriole);
        }          

        if ((pelican_color_code.equals(birds.get(sighting).species) && pelican_dot_alpha == alpha_on) || (pelican_color_code.equals(birds.get(sighting).species) && hover_pelican_button == true)) {
          stroke(r_pelican, g_pelican, b_pelican, pelican_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_pelican, g_pelican, b_pelican, pelican_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_pelican, dot_size_pelican);
        }          

        if ((albatross_color_code.equals(birds.get(sighting).species) && albatross_dot_alpha == alpha_on) || (albatross_color_code.equals(birds.get(sighting).species) && hover_albatross_button == true)) {
          stroke(r_albatross, g_albatross, b_albatross, albatross_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_albatross, g_albatross, b_albatross, albatross_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_albatross, dot_size_albatross);
        }          

        if ((flicker_color_code.equals(birds.get(sighting).species) && flicker_dot_alpha == alpha_on) || (flicker_color_code.equals(birds.get(sighting).species) && hover_flicker_button == true)) {
          stroke(r_flicker, g_flicker, b_flicker, flicker_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_flicker, g_flicker, b_flicker, flicker_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_flicker, dot_size_flicker);
        }          

        if ((sandpiper_color_code.equals(birds.get(sighting).species) && sandpiper_dot_alpha == alpha_on) || (sandpiper_color_code.equals(birds.get(sighting).species) && hover_sandpiper_button == true)) {
          stroke(r_sandpiper, g_sandpiper, b_sandpiper, sandpiper_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_sandpiper, g_sandpiper, b_sandpiper, sandpiper_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_sandpiper, dot_size_sandpiper);
        }          

        if ((owl_color_code.equals(birds.get(sighting).species) && owl_dot_alpha == alpha_on) || (owl_color_code.equals(birds.get(sighting).species) && hover_owl_button == true)) {
          stroke(r_owl, g_owl, b_owl, owl_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_owl, g_owl, b_owl, owl_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_owl, dot_size_owl);
        }          

        if ((wagtail_color_code.equals(birds.get(sighting).species) && wagtail_dot_alpha == alpha_on) || (wagtail_color_code.equals(birds.get(sighting).species) && hover_wagtail_button == true)) {
          stroke(r_wagtail, g_wagtail, b_wagtail, wagtail_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_wagtail, g_wagtail, b_wagtail, wagtail_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_wagtail, dot_size_wagtail);
        }          

        if ((macaw_color_code.equals(birds.get(sighting).species) && macaw_dot_alpha == alpha_on) || (macaw_color_code.equals(birds.get(sighting).species) && hover_macaw_button == true)) {
          stroke(r_macaw, g_macaw, b_macaw, macaw_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_macaw, g_macaw, b_macaw, macaw_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_macaw, dot_size_macaw);
        }          

        if ((vireo_color_code.equals(birds.get(sighting).species) && vireo_dot_alpha == alpha_on) || (vireo_color_code.equals(birds.get(sighting).species) && hover_vireo_button == true)) {
          stroke(r_vireo, g_vireo, b_vireo, vireo_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_vireo, g_vireo, b_vireo, vireo_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_vireo, dot_size_vireo);
        }          

        if ((bee_color_code.equals(birds.get(sighting).species) && bee_dot_alpha == alpha_on) || (bee_color_code.equals(birds.get(sighting).species) && hover_bee_button == true)) {
          stroke(r_bee, g_bee, b_bee, bee_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_bee, g_bee, b_bee, bee_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_bee, dot_size_bee);
        }          

        if ((kingfisher_color_code.equals(birds.get(sighting).species) && kingfisher_dot_alpha == alpha_on) || (kingfisher_color_code.equals(birds.get(sighting).species) && hover_kingfisher_button == true)) {
          stroke(r_kingfisher, g_kingfisher, b_kingfisher, kingfisher_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_kingfisher, g_kingfisher, b_kingfisher, kingfisher_dot_alpha);          
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_kingfisher, dot_size_kingfisher);
        }          

        if ((pintail_color_code.equals(birds.get(sighting).species) && pintail_dot_alpha == alpha_on) || (pintail_color_code.equals(birds.get(sighting).species) && hover_pintail_button == true)) {
          stroke(r_pintail, g_pintail, b_pintail, pintail_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_pintail, g_pintail, b_pintail, pintail_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_pintail, dot_size_pintail);
        }         

        if ((swallow_color_code.equals(birds.get(sighting).species) && swallow_dot_alpha == alpha_on) || (swallow_color_code.equals(birds.get(sighting).species) && hover_swallow_button == true)) {
          stroke(r_swallow, g_swallow, b_swallow, swallow_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_swallow, g_swallow, b_swallow, swallow_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_swallow, dot_size_swallow);
        }         

        if ((shearwater_color_code.equals(birds.get(sighting).species) && shearwater_dot_alpha == alpha_on) || (shearwater_color_code.equals(birds.get(sighting).species) && hover_shearwater_button == true)) {
          stroke(r_shearwater, g_shearwater, b_shearwater, shearwater_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_shearwater, g_shearwater, b_shearwater, shearwater_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_shearwater, dot_size_shearwater);
        }         

        if ((kite_color_code.equals(birds.get(sighting).species) && kite_dot_alpha == alpha_on) || (kite_color_code.equals(birds.get(sighting).species) && hover_kite_button == true)) {
          stroke(r_kite, g_kite, b_kite, kite_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_kite, g_kite, b_kite, kite_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_kite, dot_size_kite);
        }         

        if ((penguin_color_code.equals(birds.get(sighting).species) && penguin_dot_alpha == alpha_on) || (penguin_color_code.equals(birds.get(sighting).species) && hover_penguin_button == true)) {
          stroke(r_penguin, g_penguin, b_penguin, penguin_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_penguin, g_penguin, b_penguin, penguin_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_penguin, dot_size_penguin);
        }         

        if ((swift_color_code.equals(birds.get(sighting).species) && swift_dot_alpha == alpha_on) || (swift_color_code.equals(birds.get(sighting).species) && hover_swift_button == true)) {
          stroke(r_swift, g_swift, b_swift, swift_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_swift, g_swift, b_swift, swift_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_swift, dot_size_swift);
        }         

        if ((martin_color_code.equals(birds.get(sighting).species) && martin_dot_alpha == alpha_on) || (martin_color_code.equals(birds.get(sighting).species) && hover_martin_button == true)) {
          stroke(r_martin, g_martin, b_martin, martin_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_martin, g_martin, b_martin, martin_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_martin, dot_size_martin);
        }         

        if ((galah_color_code.equals(birds.get(sighting).species) && galah_dot_alpha == alpha_on) || (galah_color_code.equals(birds.get(sighting).species) && hover_galah_button == true)) {
          stroke(r_galah, g_galah, b_galah, galah_stroke_alpha);
          strokeWeight(dot_stroke_weight_hover);
          fill(r_galah, g_galah, b_galah, galah_dot_alpha);         
          ellipse(x_position*map_lat, y_position*map_lng, dot_size_galah, dot_size_galah);
        }         

        //................................................................


        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #3 end                

        //................................................................

        /* v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v
         //  array of all dots
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

    //  ADD "WORLDLY BIRDS" EXPLANATION
    stroke(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    line(width - width*.5 - horizontal_title_offset, 
         height*.5 - height + clock_offset + title_line_offset, 
         width - width*.5 - horizontal_title_offset - title_line_length,
         height*.5 - height + clock_offset + title_line_offset);
    fill(clockStroke_R, clockStroke_G, clockStroke_B, title_alpha);
    textAlign(RIGHT);
    //    text("WORLDLY BIRDS", 0, (height*.5 - (height - 45)));  //  if 
    text("WORLDLY", (width - (width*.5 + horizontal_title_offset)), (-height*.5 + clock_offset + monthTextSize + vertical_title_offset));
    text("BIRDS", (width - (width*.5 + horizontal_title_offset)), (-height*.5 + clock_offset + monthTextSize + vertical_title_offset + title_leading));
    
    //................................................................

    //  LEAVING THESE COMMENTS FOR NOW, IN CASE NEEDED FOR HANDLE-DRAGGING COMMANDS

    if (counter>=dates.size() ) {
      counter=0;
    }  //  close if

    //  text showing the month and day
    fill(clockStroke_R, clockStroke_G, clockStroke_B, clockStroke_Alpha);
    textAlign(CENTER);
    text(dates.get(counter).month, 0, 0);
    text(dates.get(counter).day, 0, day_leading);

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


class Birds {  
  String species;
  String lat;
  String lng;
  String date;

  Birds(String s1, String s2, String s3, String s4, String s5) { 
    species = s1;
    lat = s2; 
    lng = s3;
    date = s5;
  }
}  

//................................................................

class Date { 
  String month;
  String day;

  Date(String s1, String s2 ) { 
    month = s1;
    day = s2;
  }
}  


//----------------------------------------------------------------


//  (width - (width*.5 + horizontal_title_offset)), (-height*.5 + clock_offset + monthTextSize + vertical_title_offset));

//  boolean for title rollover
boolean title_hover( int x_title, int y_title) {
  if (mouseX < (width - (/*width*.5 +*/ horizontal_title_offset)) &&
      mouseX > (width - horizontal_title_offset - caption.width) &&
      mouseY > vertical_title_offset &&
      mouseY < vertical_title_offset + caption.height)
      {
    return true;
  } 
  else { 
    return false;
  }
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #4 start                
//  setting up the functional buttons: a method to check if the mouse is over the button
//  not sure if it (e.g. 'x_swallow' and 'y_swallow') would have to change for each bird, or if it could stay the same for all, or even if it could be mouseX and mouseY?
boolean hummingbird_hover( int x_hummingbird, int y_hummingbird) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 1) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean ostrich_hover( int x_ostrich, int y_ostrich) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 2) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean crane_hover( int x_crane, int y_crane) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 3) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean tern_hover( int x_tern, int y_tern) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 4) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean puffin_hover( int x_puffin, int y_puffin) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 5) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean swan_hover( int x_swan, int y_swan) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 6) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean oriole_hover( int x_oriole, int y_oriole) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 7) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean pelican_hover( int x_pelican, int y_pelican) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 8) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean albatross_hover( int x_albatross, int y_albatross) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 9) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean flicker_hover( int x_flicker, int y_flicker) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 10) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean sandpiper_hover( int x_sandpiper, int y_sandpiper) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 11) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean owl_hover( int x_owl, int y_owl) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 12) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean wagtail_hover( int x_wagtail, int y_wagtail) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 13) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean macaw_hover( int x_macaw, int y_macaw) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 14) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean vireo_hover( int x_vireo, int y_vireo) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 15) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean bee_hover( int x_bee, int y_bee) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 16) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean kingfisher_hover( int x_kingfisher, int y_kingfisher) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 17) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean pintail_hover( int x_pintail, int y_pintail) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 18) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean swallow_hover( int x_swallow, int y_swallow) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 19) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean shearwater_hover( int x_shearwater, int y_shearwater) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 20) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean kite_hover( int x_kite, int y_kite) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 21) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean penguin_hover( int x_penguin, int y_penguin) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 22) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean swift_hover( int x_swift, int y_swift) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 23) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean martin_hover( int x_martin, int y_martin) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 24) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................

boolean galah_hover( int x_galah, int y_galah) {
  if (dist(((width - 2*button_wall_offset) / 24)*(-1 + 25) 
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    return true;
  } 
  else { 
    return false;
  }
}  

//................................................................


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #4 start                


//----------------------------------------------------------------


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #5 start
//  setting a true/false flag for hover

void mouseMoved() {
  
  if (title_hover(mouseX, mouseY)) title_hover_rollover = true;
  else title_hover_rollover = false;
  
  //................................................................
  
  if (hummingbird_hover(mouseX, mouseY)) hover_hummingbird_button = true;
  else hover_hummingbird_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................

  if (ostrich_hover(mouseX, mouseY)) hover_ostrich_button = true;
  else hover_ostrich_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................

  if (crane_hover(mouseX, mouseY)) hover_crane_button = true;
  else hover_crane_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................

  if (tern_hover(mouseX, mouseY)) hover_tern_button = true;
  else hover_tern_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................

  if (puffin_hover(mouseX, mouseY)) hover_puffin_button = true;
  else hover_puffin_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (swan_hover(mouseX, mouseY)) hover_swan_button = true;
  else hover_swan_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (oriole_hover(mouseX, mouseY)) hover_oriole_button = true;
  else hover_oriole_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (pelican_hover(mouseX, mouseY)) hover_pelican_button = true;
  else hover_pelican_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (albatross_hover(mouseX, mouseY)) hover_albatross_button = true;
  else hover_albatross_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (flicker_hover(mouseX, mouseY)) hover_flicker_button = true;
  else hover_flicker_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (sandpiper_hover(mouseX, mouseY)) hover_sandpiper_button = true;
  else hover_sandpiper_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (owl_hover(mouseX, mouseY)) hover_owl_button = true;
  else hover_owl_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (wagtail_hover(mouseX, mouseY)) hover_wagtail_button = true;
  else hover_wagtail_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (macaw_hover(mouseX, mouseY)) hover_macaw_button = true;
  else hover_macaw_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (vireo_hover(mouseX, mouseY)) hover_vireo_button = true;
  else hover_vireo_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (bee_hover(mouseX, mouseY)) hover_bee_button = true;
  else hover_bee_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (kingfisher_hover(mouseX, mouseY)) hover_kingfisher_button = true;
  else hover_kingfisher_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (pintail_hover(mouseX, mouseY)) hover_pintail_button = true;
  else hover_pintail_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (swallow_hover(mouseX, mouseY)) hover_swallow_button = true;
  else hover_swallow_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (shearwater_hover(mouseX, mouseY)) hover_shearwater_button = true;
  else hover_shearwater_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (kite_hover(mouseX, mouseY)) hover_kite_button = true;
  else hover_kite_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (penguin_hover(mouseX, mouseY)) hover_penguin_button = true;
  else hover_penguin_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (swift_hover(mouseX, mouseY)) hover_swift_button = true;
  else hover_swift_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (martin_hover(mouseX, mouseY)) hover_martin_button = true;
  else hover_martin_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...   

  //................................................................


  if (galah_hover(mouseX, mouseY)) hover_galah_button = true;
  else hover_galah_button = false;
  //redraw();  //  I haven't noticed that I need to call redraw...
}

//................................................................


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES  #5 end                


//----------------------------------------------------------------


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES #6 start
//  click
void mouseClicked() {
  //  I have no idea why putting '*2' at the end (almost) makes it the right size...
  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 1)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_hummingbird_button = true && hummingbird_dot_alpha == alpha_on) {
      hummingbird_dot_alpha = alpha_off;
    } 
    else
      if (hover_hummingbird_button = true && hummingbird_dot_alpha == alpha_off) {
        hummingbird_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 2)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_ostrich_button = true && ostrich_dot_alpha == alpha_on) {
      ostrich_dot_alpha = alpha_off;
    } 
    else
      if (hover_ostrich_button = true && ostrich_dot_alpha == alpha_off) {
        ostrich_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 3)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_crane_button = true && crane_dot_alpha == alpha_on) {
      crane_dot_alpha = alpha_off;
    } 
    else
      if (hover_crane_button = true && crane_dot_alpha == alpha_off) {
        crane_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 4)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_tern_button = true && tern_dot_alpha == alpha_on) {
      tern_dot_alpha = alpha_off;
    } 
    else
      if (hover_tern_button = true && tern_dot_alpha == alpha_off) {
        tern_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 5)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_puffin_button = true && puffin_dot_alpha == alpha_on) {
      puffin_dot_alpha = alpha_off;
    } 
    else
      if (hover_puffin_button = true && puffin_dot_alpha == alpha_off) {
        puffin_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 6)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_swan_button = true && swan_dot_alpha == alpha_on) {
      swan_dot_alpha = alpha_off;
    } 
    else
      if (hover_swan_button = true && swan_dot_alpha == alpha_off) {
        swan_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 7)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_oriole_button = true && oriole_dot_alpha == alpha_on) {
      oriole_dot_alpha = alpha_off;
    } 
    else
      if (hover_oriole_button = true && oriole_dot_alpha == alpha_off) {
        oriole_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 8)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_pelican_button = true && pelican_dot_alpha == alpha_on) {
      pelican_dot_alpha = alpha_off;
    } 
    else
      if (hover_pelican_button = true && pelican_dot_alpha == alpha_off) {
        pelican_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 9)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_albatross_button = true && albatross_dot_alpha == alpha_on) {
      albatross_dot_alpha = alpha_off;
    } 
    else
      if (hover_albatross_button = true && albatross_dot_alpha == alpha_off) {
        albatross_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 10)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_flicker_button = true && flicker_dot_alpha == alpha_on) {
      flicker_dot_alpha = alpha_off;
    } 
    else
      if (hover_flicker_button = true && flicker_dot_alpha == alpha_off) {
        flicker_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 11)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_sandpiper_button = true && sandpiper_dot_alpha == alpha_on) {
      sandpiper_dot_alpha = alpha_off;
    } 
    else
      if (hover_sandpiper_button = true && sandpiper_dot_alpha == alpha_off) {
        sandpiper_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 12)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_owl_button = true && owl_dot_alpha == alpha_on) {
      owl_dot_alpha = alpha_off;
    } 
    else
      if (hover_owl_button = true && owl_dot_alpha == alpha_off) {
        owl_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 13)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_wagtail_button = true && wagtail_dot_alpha == alpha_on) {
      wagtail_dot_alpha = alpha_off;
    } 
    else
      if (hover_wagtail_button = true && wagtail_dot_alpha == alpha_off) {
        wagtail_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 14)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_macaw_button = true && macaw_dot_alpha == alpha_on) {
      macaw_dot_alpha = alpha_off;
    } 
    else
      if (hover_macaw_button = true && macaw_dot_alpha == alpha_off) {
        macaw_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 15)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_vireo_button = true && vireo_dot_alpha == alpha_on) {
      vireo_dot_alpha = alpha_off;
    } 
    else
      if (hover_vireo_button = true && vireo_dot_alpha == alpha_off) {
        vireo_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 16)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_bee_button = true && bee_dot_alpha == alpha_on) {
      bee_dot_alpha = alpha_off;
    } 
    else
      if (hover_bee_button = true && bee_dot_alpha == alpha_off) {
        bee_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 17)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_kingfisher_button = true && kingfisher_dot_alpha == alpha_on) {
      kingfisher_dot_alpha = alpha_off;
    } 
    else
      if (hover_kingfisher_button = true && kingfisher_dot_alpha == alpha_off) {
        kingfisher_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 18)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_pintail_button = true && pintail_dot_alpha == alpha_on) {
      pintail_dot_alpha = alpha_off;
    } 
    else
      if (hover_pintail_button = true && pintail_dot_alpha == alpha_off) {
        pintail_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 19)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_swallow_button = true && swallow_dot_alpha == alpha_on) {
      swallow_dot_alpha = alpha_off;
    } 
    else
      if (hover_swallow_button = true && swallow_dot_alpha == alpha_off) {
        swallow_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 20)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_shearwater_button = true && shearwater_dot_alpha == alpha_on) {
      shearwater_dot_alpha = alpha_off;
    } 
    else
      if (hover_shearwater_button = true && shearwater_dot_alpha == alpha_off) {
        shearwater_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 21)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_kite_button = true && kite_dot_alpha == alpha_on) {
      kite_dot_alpha = alpha_off;
    } 
    else
      if (hover_kite_button = true && kite_dot_alpha == alpha_off) {
        kite_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 22)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_penguin_button = true && penguin_dot_alpha == alpha_on) {
      penguin_dot_alpha = alpha_off;
    } 
    else
      if (hover_penguin_button = true && penguin_dot_alpha == alpha_off) {
        penguin_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 23)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_swift_button = true && swift_dot_alpha == alpha_on) {
      swift_dot_alpha = alpha_off;
    } 
    else
      if (hover_swift_button = true && swift_dot_alpha == alpha_off) {
        swift_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 24)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_martin_button = true && martin_dot_alpha == alpha_on) {
      martin_dot_alpha = alpha_off;
    } 
    else
      if (hover_martin_button = true && martin_dot_alpha == alpha_off) {
        martin_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist

  if (dist(
  ((width - 2*button_wall_offset) / 24)*(-1 + 25)
    + button_wall_offset, 
  height - (button_vertical_offset), 
  mouseX, mouseY)*2 < button_width) {
    if (hover_galah_button = true && galah_dot_alpha == alpha_on) {
      galah_dot_alpha = alpha_off;
    } 
    else
      if (hover_galah_button = true && galah_dot_alpha == alpha_off) {
        galah_dot_alpha = alpha_on;
      }  //  close if (hover
  }  //  close if (dist
}  //  close void mouseClicked


//................................................................


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INDIVIDUAL SPECIES #6 end

