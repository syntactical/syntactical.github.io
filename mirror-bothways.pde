float angle;

void setup() {
  angle = 2120;
  
  size(400,400);
  angle = 0;
  frameRate(16);
  strokeWeight(2);
  smooth();
}

void draw(){
  background(0);
  stroke(255);
  line(0,(angle*25)%(height/2),width/2,(angle*30)%(height/2));
  line(0,(angle*25+angle*2)%(height/2),width/2,(angle*30+angle*2)%(height/2));
  line(0,(angle*25+angle*4)%(height/2),width/2,(angle*30+angle*4)%(height/2));  
  
  line((angle*25)%(width/2),0,(angle*30)%(width/2),height/2);
  line((angle*25)%(width/2)+angle*2,0,(angle*30+angle*2)%(width/2),height/2);
  line((angle*25)%(width/2)+angle*4,0,(angle*30+angle*4)%(width/2),height/2);
  oscillate();
  
  mirrorHoriz();
  mirrorVert();
}

void oscillate() {
  angle += PI/40;
}

void mirrorHoriz(){
  loadPixels();
  
  for(int x = 0; x < width / 2; x++){
    for(int y = 0; y < height / 2; y++){
      int original = pixelNum(x, y);
      int flip = pixelNum((width-1)-x, y);
      pixels[flip] = pixels[original];
    }
  }
  
  updatePixels();
}

void mirrorVert(){
    loadPixels();
  
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height / 2; y++){
      int original = pixelNum(x, y);
      int flip = pixelNum(x, height - 1 - y);
      pixels[flip] = pixels[original];
    }
  }
  
  updatePixels();
}

int pixelNum(int x, int y) {
  return x + (y * width);
}
