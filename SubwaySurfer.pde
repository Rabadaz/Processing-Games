Subway[] subs = new Subway[4];
Player p = new Player();
int trainWidth;
int trainLength;
int trackwidth = 0;
boolean go = false;
long score = 0;


//Constants
final int trackMargin = 100;
final int PlayerHeight = 100;
final int playerR = 20;


void setup(){
  size(800,1500);
  
  trackwidth = (width- (2*trackMargin)) /3;
  trainWidth = (trackwidth/3)*2;
  trainLength = (int)(height-150)/(subs.length-1);
  drawTrack();
  int d = 0;
  for(int i = 0; i< subs.length; i++){
    subs[i] = new Subway((int)(random(3)+1), d);
    d += trainLength+150;
  }
}

void drawTrack(){
  clear();
  background(150);
  line(trackMargin,0,trackMargin,height);
  line(trackMargin+trackwidth, 0 , trackMargin+trackwidth,height);
  line(trackMargin+(2*trackwidth), 0, trackMargin+(2*trackwidth),height);
  line(trackMargin+(3*trackwidth), 0, trackMargin+(3*trackwidth),height);
}

void draw(){
  score ++;
  drawTrack();
  for(Subway s : subs){
    s.Update();
  }
  p.Update();
  if(checkPlayerIsColliding()){
    gameOver();
  }  
  
}

void keyPressed(){
  if(key == 'a'){
    p.goLeft();
  }else if(key == 'd'){
    p.goRight();
  }else if(key == 'r' && go){
    rGame();
  }else if(key >= '1' && key <= '3'){
    p.go(key-48);
  } 
}

void rGame(){
  go = false;
  loop();
}

boolean checkPlayerIsColliding(){
  text(p.getTrack(),100,100);
  for(Subway s : subs){
    if(s.isColliding(p.getTrack(),height - PlayerHeight)){
      return true;
    }
  }
  return false;
}

void gameOver(){
  go =true;
  noLoop();
  for(Subway s :subs)
    s.enabled = false;
  background(255,0,0);
  textSize(30);
  text("Game Over", width/2,height/2);
}  
class Subway{
  public int track;
  int d = -1;
  int x;
  boolean enabled = true;
  
  public Subway(int track, int spawnDistance){
    this.track = track;
    d = 0-spawnDistance-trainLength;
    x =  trackMargin + (track * trackwidth) - (trackwidth/2)-trainWidth/2;  
  }
  public void Update(){
    if(d >= height + trainLength)
      reset();
    
    text(""+score , 100,200); 
    d+= 10+ (score /1000);
    dr();
  
  }
  private void reset(){
    enabled = true;
    track = ((int)random(3))+1;
    x =  trackMargin + (track * trackwidth) - (trackwidth/2)-trainWidth/2;
    d = 0-trainLength;  
  }
  private void dr(){
    if(!enabled)
      return;
    
   rect(x,d,trainWidth,trainLength);
   textSize(35);
   text(d + " " + x , x,d);
  }
  public boolean isColliding(int t, int y){
    if(!enabled)
      return false;
    return (t == this.track &&( y >= this.d && y<= (this.d+trainLength)));
  }
}

class Player{
    int track;
     
   public Player(){
     track = 2;
   }
  
  public void go(int t){
    if(t>0 && t <= 3)  
      this.track = t;
  }
  
   public void goRight(){
     if(track <3)
       track++;
   }
   
   public void goLeft(){
     if(track > 1)
       track--;
   }
   
   public void Update(){
     display();
   }
   public void display(){
     int x = trackMargin + (track * trackwidth) - (trackwidth/2);
     ellipse(x , height - PlayerHeight,100,100);
   }
   public int getTrack(){
     return track;
   }  
}

/*
class Coin{
  int track = 0; 
  int y = 0; 
  int x;
  boolean enable = true; 
  
  public Coin(){
    spawn();
     
  }
  
  public void spawn(){
    int t = 1;
    int yTemp = -1;
    while(true){
      if(!isColWithtrain()){
        this.y = yTemp;
        this.track = t;
        break;
      }
      
      t++;
      if(t > 3){
        t = 1;
        y += 100;
      }
      
      
    }
    
    
    x =  trackMargin + (track * trackwidth) - (trackwidth/2)-trainWidth/2;
  }
  
  
  private boolean isColWithtrain(){
    for(Subway s : subs){
      if(s.isColliding(track, y))
        return true;
    }
    return false;
  }
  
  public void Update(){
    y+= 10+ (score /1000);
    
    display();
  }
  private void display(){
    ellipse(x, y, 50,50);
  }
  
}*/
