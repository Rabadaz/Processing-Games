Bird player = new Bird();
Bariere[] bars = new Bariere[5];

boolean dead = false;
final int playerx = 100;
final int mrg = 100;
final int starth = 500;
int score = 0;


void setup(){
  background(0);
  size(1000,1000);
  int v = 0;
  
  
  for(int i = 0; i< bars.length ; i++){
    bars[i] = new  Bariere(v,true);
    v += width/bars.length;    
  }
}

void draw(){
  clear();
  background(0);
  player.update();
  
  
  
  for(Bariere b : bars){
    b.update();
  }
  
  
  
  if(PlayerColliding())
    gameOver();
    
   if(player.getHeight() < 0 || player.getHeight() >= height)
     gameOver();
    
  
  if(PlayerParsing())
    score++;
  textSize(32);  
  text(score + "" , 100,100);
    
}

boolean PlayerColliding(){
  for(Bariere b :bars){
    if(b.isColliding(playerx,(int)player.getHeight())) {
      return true;
    }
  }
  return false;
}

boolean PlayerParsing(){
  for(Bariere b :bars){
    if(b.isParsing(playerx,(int)player.getHeight())) 
      return true;
  }
  return false;
}

void keyPressed(){
  
  if(key == 'w'){
     player.jump();
  }else if(key  == 'r' && dead){
    restartGame();
  }else if(key == ' '){
    player.jump();
  }
  
  
}

void restartGame(){
  for(Bariere b : bars){
    b.setInactive(true);
  }
  
  player.reset();
  score = 0;
  background(0);
  dead = false;
  loop();
}

void gameOver(){
  dead = true;
  clear();
  background(255, 16, 0);
  noLoop();
  text("Game over", width/2, height/2);
}

class Bariere{
  boolean inactive = false;
  int pad_top;
  public boolean parsed = false;
  int v;
  int w = 20;
  
  
  public Bariere(int v, boolean inactive){
      this.v = v;
      this.inactive = inactive;
      pad_top = (int)random(300,700);
          
  }
  
  public boolean isColliding(int x, int y){
    if(inactive)
      return false;
    return((x >= v && x <= v+w)&& !(y >= pad_top && y <= pad_top+mrg));
  }
   public boolean isParsing(int x, int y){
     if(inactive)
       return false;
     
    if((x >= v && x <= v+w)&& (y >= pad_top && y <= pad_top+mrg)&&!parsed){
       parsed = true;
      return true;
    }
    return false;
  }
  
  
  
  private void reset(){
      v = width+1;
      parsed = false;
      inactive= false;
          
  }
  
  public void update(){
    if(v < 0-w){
      reset();
    }
    dr();  
    v--;
  }  
  
  private void dr(){
    if(inactive)
      return;
     rect(v,0,w,pad_top);
     rect(v, pad_top+mrg, w, height-(pad_top+mrg));
 }
 public void setInactive(boolean state){
    inactive = state;
  }
}

class Bird{
  float jumpM = 1;
  float fallM = 1;
  float h;
  public Bird(){
    h = starth;
  }
  public float getHeight(){
    return h;
  }
 
  public void reset(){
    h = starth;
  }
  
  public void update(){
    if(jumpM > 1){
      jumpM-= .1;
    }
  
    fallM += .05;
    h += 1.5*fallM;
    drawBird();
  }
  private void drawBird(){
     ellipse(playerx, h, 10,10);
  }
  
 public void jump(){
   h = h - 25 *jumpM;
   jumpM += .2;
   fallM = 1;
 }
}
