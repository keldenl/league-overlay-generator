PImage backImg;
PFont font;

String teamWin = "";
int score1 = 0;
int score2 = 0;
int scoreLimit = 1;

String team1 = "LAG"; // Home (Blue)
String team2 = "C10"; // Away (red)
String league = "Rampage";
int week = 4;


void setup() {
  font = loadFont("OpenSans-Bold-32.vlw");
  textFont(font, 32);
  
  //pixelDensity(2);
  size(1920,1080);
  backImg = loadImage(league + ".png");
}

void draw() {
  background(0, 0, 0, 0);
  // FRAME COUNTER //
  if (score1 == scoreLimit && score2 == scoreLimit) 
    exit();  
    
  // BASE IMAGE // 
  image(backImg, 0, 0, width, height);  
  
  textSize(27); 
  
  // Ramp: #e16941, Dom: #4169e1
  if (league == "Dominate") {
    fill(#4169e1);
    text(week, 1170, 827);
  } else {
    fill(#e16941);
    text(week, 1157, 827);
  }
  
  // TEAM + SCORE DISPLAY //  
  textSize(32);
  fill(#53aacc);
  text(team1, 495, 32);
  text(score1, 495 - 50, 32);
  
  fill(#c54d4c);
  text(team2, 1370, 32);
  text(score2, 1370 + 100, 32);
  
  // SAVE FRAME AS PNG //
  saveFrame("Gameplay-G" + (score1 + score2 + 1) + "-" + teamWin + ".png");
  convertTrans("Gameplay-G" + (score1 + score2 + 1) + "-" + teamWin + ".png");
  
  if (score2 == scoreLimit) {
      score2 = 0;
      score1++;
      teamWin = team1;
  } 
  else {
    score2++;
    
    String temp1 = team1;
    String temp2 = team2;
    team1 = temp2;
    team2 = temp1;
    teamWin = team2;
    if (score1 + score2 > scoreLimit )
      teamWin = "";
  }
}

void convertTrans(String imageName) {
  PImage img;
  PImage newImg;
  int x, y, i;
  img = loadImage( imageName );
  newImg = createImage( img.width, img.height, ARGB );
  for( x = 0; x < img.width; x++ ){
    for( y = 0; y < img.height; y++ ){
      i = ( ( y * img.width ) + x );
      if( img.pixels[i] == color( 0, 0, 0 ) ){
        newImg.pixels[i] = color( 0, 0, 0, 0 );
      } 
      else {
        newImg.pixels[i] = img.pixels[i];
      }
    }
  }
  newImg.save( imageName );
}