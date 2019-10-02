//Download processing.video
//Click laser to calibrate the color
//press up on the arrows to begin
//press down on the arrows to pause
//press left on the arrows to clear

paint p;
import processing.video.*;
import java.util.LinkedList;
import java.util.Queue;
Capture video;
int QCount=0;

float rS=71;
float bS=0;
float gS=55;
boolean start=false;

Queue <paint> painted;


void setup() {
  size(640, 360);
  background(0);

  printArray(Capture.list());
  video= new Capture(this, Capture.list()[3]);
  video.start();

  rS=255;
  bS=255;
  gS=255;

  painted = new <paint> LinkedList();
}



void captureEvent(Capture video) {
  video.read();
}



void mousePressed() {

  rS = red(get(mouseX, mouseY));
  gS = green(get(mouseX, mouseY));
  bS = blue(get(mouseX, mouseY));
  println(rS+ ", " +gS+", " + bS);
}


void keyPressed() { 
  if (key == CODED) {
    if (keyCode == UP) {
      println("round1");
      start=true;
    }

    if (keyCode == DOWN) {
      println("round2");
      start=false;
    }
    if (keyCode==LEFT) {
      painted.clear();
    }
  }
}


void draw() {

  image(video, 0, 0);

  int count=0;
  float xAvg=0;
  float yAvg =0;


  loadPixels();
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int index = x+y*width;
      float rC = red(pixels[index]);
      float bC = blue(pixels[index]);
      float gC = green(pixels[index]);
      float diff = sqrt(sq(rC-rS)+sq(bC-bS)+sq(gC-gS));
      if (diff<12) {
        count++;
        xAvg += x;
        yAvg += y;
      }
    }
  }


  xAvg = xAvg/count;
  yAvg = yAvg/count;
  updatePixels();


  if (count >3 && !start) {
    fill(rS, bS, gS);
    ellipse(xAvg, yAvg, 10, 10);
  }

  if (count>5 && start) {
    painted.add(new paint((int)xAvg, (int)yAvg));
  }

  for (paint p : painted) {
    p.show();
  }

  QCount++;
  if(QCount==100&& !painted.isEmpty()){
    QCount=0;
    painted.remove();
  }
}