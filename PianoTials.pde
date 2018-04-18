final int numberOfRows = 4;
final int speed = 10;
final int margin  = 50;
final int triggerHeight = 400;

int titleLen = 300;
Field [] fields = new Field[4]; 
int rowWidth;
int FailScore = 0;
int Streak = 0;
int Score = 0;

void setup(){
  size(800,1500);
  titleLen = (int)(height/numberOfRows/1.5); 
  rowWidth = (width-margin*2)/ numberOfRows;
  drawRows();
  int v = -1;
  for(int i = 0; i<fields.length;i++){
    fields[i] =new Field(v); 
    
    v+=titleLen* 1.5;
  }


}
void draw(){
  clear();
  background(190);
  drawRows();
  for(Field f : fields){
    f.Update();
  }
  
  fill(0);
  textSize(30);
  text("Score =" + Score + "\nFails = " + FailScore + "\nStreak = " + Streak ,100,100);

}
void keyPressed(){
  
  if(key >= '1' && key <= numberOfRows + (int)'1'){
   boolean ok = false;
    for(Field f : fields){
      if(f.getTriggered(key-'0'-1))
        ok = true;
      }
    if(!ok){
      FailScore++;
      Streak = 0;
     }else{
       Streak++;
       Score++;
     }
    
  }
}

void drawRows(){
  for(int i = 0; i<= numberOfRows; i++){
     line((margin + i*rowWidth), 0,(margin + i*rowWidth), height); 
  }
  
  line(0, height-triggerHeight, width, height-triggerHeight);
  
}

enum FieldState{
  canTrigger(0,0,0),idle(0,0,0),checked(0,255,50),Failed(255,0,0);
  
  
  public final int r;
  public final int g;
  public final int b;
  
  
  private FieldState(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  
  
  
}


class Field{
  int row = -1;
  int y = 0;
  FieldState state = null;
  int x = 0;
  private boolean canTrigger = false;
 
  
  public Field(int y){
     row = (int)random(4);   
     state = FieldState.idle;
     
     this.y = y;
     x = margin + (row * rowWidth);

  }
  
  
  
  
  public void Update(){
    if(state != FieldState.checked && state != FieldState.Failed){
      if(y+titleLen >= height - triggerHeight&&  y<= height - triggerHeight&& !canTrigger){
          canTrigger = true;
      }
      if(y >= height - triggerHeight){
         notTriggered(); 
      }    
    }
    if(y > height)
      reset();
    fill(state.r,state.g,state.b);
    display();
    y+= speed;
  }
  
  private void reset(){
    y = -1;
    row = (int)random(4);
    x = margin + (row * rowWidth);
    state = FieldState.idle;   
  }
  
  private void display(){
    rect(x+rowWidth/6,y,rowWidth/3*2,titleLen);
  }
   
   private void notTriggered(){
     canTrigger = false;
     state = FieldState.Failed;
     ++FailScore;
   }
  
    private boolean getTriggered(int row){
      if(this.row == row && canTrigger){ //<>//
        state = FieldState.checked;
        canTrigger = false;
        return true;
      }
      return false;
    }
  
 
}
