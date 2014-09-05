float angle;

void setup() {
  angle = 2120;
  
  size(700,300);
  angle = 0;
  frameRate(24);
  strokeWeight(2);
  smooth();
}

void draw(){
  background(0,0,0,0);

  stroke(255);

  line(0,(angle*25)%(height),width/2,(angle*30)%(height));
  line(0,(angle*25+angle*2)%(height),width/2,(angle*30+angle*2)%(height));
  line(0,(angle*25+angle*4)%(height),width/2,(angle*30+angle*4)%(height));  

  line((angle*25)%(width/2),0,(angle*30)%(width/2),height);
  line((angle*25)%(width/2)+angle*2,0,(angle*30+angle*2)%(width/2),height);
  line((angle*25)%(width/2)+angle*4,0,(angle*30+angle*4)%(width/2),height);
  oscillate();

  mirror();
}

void oscillate() {
  angle += PI/40;
}

void mirror(){
  loadPixels();
  
  for(int x = 0; x < width / 2; x++){
    for(int y = 0; y < height; y++){
      int original = pixelNum(x, y);
      int flip = pixelNum((width-1)-x, y);
      pixels[flip] = pixels[original];
    }
  }
  
  updatePixels();
}

int pixelNum(int x, int y) {
  return x + (y * width);
}
