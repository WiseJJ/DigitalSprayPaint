public class paint{
  int x;
  int y;
  int r;
  int g;
  int b;
  int time;
  
  public paint(int x1,int y1){
    x=x1;
    y=y1;
    r = 255;
    g = 0;
    b =0;
    time =0;
  }
  
  void show(){
    fill(r,g,b,90);
    noStroke();
    ellipse(x,y,20,20);
  }
  
  boolean life(){
    time ++;
    if(time >20000)
    return false;
    return true;
  }
  
  void setColor(int r1, int g1, int b1){
    r=r1;
    g= g1;
    b= b1;
  }
}