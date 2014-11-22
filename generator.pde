ArrayList<Line> lines;
Line firstLine;
Line bufferLine;
int halfWidth;

void setup(){
//  TODO: accommodate odd values for width
  size(400,600);
  halfWidth = int(width / 2);
  lines = new ArrayList<Line>();
  
  Line firstLine = new Line(1);
  bufferLine = firstLine;
  lines.add(firstLine);
}

void draw(){
  background(0);
  if (frameCount % 16 == 15) {
    drawNewLine(1, bufferLine);
  }
  moveUpLines();
  drawLines();
  mirror();
}

void drawNewLine(int y, Line lineToCopy){
  int[] newLineDeviations = new int[halfWidth];
  
  for(int i = 0; i < halfWidth; i++){
    float chance = random(1);
    if (chance < 0.2) {
      newLineDeviations[i] = lineToCopy.deviations[i] + 1;
    } else if ( chance > 1 ) {
      newLineDeviations[i] = lineToCopy.deviations[i] - 1;
    } else {
      newLineDeviations[i] = lineToCopy.deviations[i];
    }
  }
  
  Line newLine = new Line(y, newLineDeviations);
  bufferLine = newLine;
  lines.add(newLine);
}

void moveUpLines(){
  for(int lineNum = 0; lineNum < lines.size(); lineNum++){
    lines.get(lineNum).y += 1;
  }
}

void drawLines(){
  loadPixels();
  for(int lineNum = 0; lineNum < lines.size(); lineNum++){
    for(int x = 0; x < halfWidth; x++){
      int y = lines.get(lineNum).getAbsoluteYCoordinate(x);
      
      if(y >= height){
        lines.remove(lines.get(lineNum));
        break;
      }
      
      pixels[pixelNum(x, y)] = color(255);
    }
  }
  updatePixels();
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

class Line{
  int[] deviations;
  int y;
  
  public Line(int _y, int[] _deviations){
    y = _y;
    deviations = _deviations;
  }
  
  public Line(int _y){
    y = _y;
    deviations = new int[halfWidth];
    
    for (int i = 0; i < halfWidth - 1; i++){
      deviations[i] = 0;
    }
  }
  
  public int getAbsoluteYCoordinate(int x){
    return y + deviations[x];
  }
}
