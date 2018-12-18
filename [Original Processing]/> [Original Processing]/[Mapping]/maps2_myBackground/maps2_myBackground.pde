/*
1. Determine new size, and export .png from Illustrator at this new size (72ppi).
2. Re-map the lat and long to this new proportion (remember, similar to F and C temperature conversion).
*/

//data
Bird hummingbird = new Bird(40.1539, -76.7247);
Bird ostrich = new Bird(-16.6746, -49.2641);
Bird crane = new Bird(54.424861, -3.5);
Bird tern = new Bird(46.050242, -77.361002);
Bird puffin = new Bird(11.697222, 165.271944);
Bird swan = new Bird(43.133333, 131.9);
Bird oriole = new Bird(55.75, 60.716667);
Bird pelican = new Bird(51.389553, 30.099147);
Bird albatross = new Bird(37.319444, 141.021111);

//an array of birds
Bird birds[] = { hummingbird, ostrich, crane, tern, puffin, swan, oriole, pelican, albatross };

PImage background; //PImage to hold the background image

void setup(){
  
  background = loadImage("world_map.png"); //load the background image. Source: wikipedia
  size(1250,625);
  noLoop();
}

void draw(){
 
  image(background,0,0); //draw the background image
  noStroke();
  fill(255,0,0,125);
  
  for( int i = 0; i<birds.length; ++i ){ //iterate through the bird array
    fill(255,0,0,125);
    PVector pv = equiRectangular(birds[i].lat, birds[i].lng); //project each lat/lng, hold the result in a PVector. See below for equiRectangular method
    ellipse(pv.x, pv.y, 2,2); //draw an ellipse at the appropriate position
  }
}

//Equirectangular projection. 
PVector equiRectangular( float lat, float lng ){
  PVector pv = new PVector(); //a PVector to hold the result
  pv.x = map(lng, -180.0, 180.0, 0, width); //map lng from a range of -180.0 : 180.0 to a range of 0 : width
  pv.y = map(lat, 90.0, -90.0, 0, height);  //map lat from a range of 90.0 : -90.0 to a range of 0 : height
  return pv; //return the result
}

/*
//Mercator projection. Not used in this demo, but good to know about.
PVector mercator( float lat, float lng ) {
    //Mercator projection, adapted from Wikipedia 
    lat = degrees( log(tan( PI/4 + radians( lat  )/2 ) ) ); //do the latitude projection
    lng = lng;  //mercator leaves longitude alone.

    PVector pv = new PVector();
    pv.x = map(lng, -180.0, 180.0, 0, width); //map the projected longitude to the screen width
    pv.y = map(lat, 90.0, -90.0, 0, height);  //map the projected latitude to the screen height
    return pv;
}
*/

//Bird class
class Bird{
  float lat, lng;
  
  Bird( float f_lat, float f_lng){
    lat = f_lat;
    lng = f_lng;
  }
}






