class Graphview {
  
  ArrayList<Vec2D> samples;
  float lineRes;
  Vec2D pos, res;
  float scaling;
  int numbers;
  
  float xorg, yorg, x, y, xmin, xmax, ymin, ymax, xres, yres, fres;
  
  Graphview() {
    fres = .25; // resolution of graph ( low = better )
    xres = 2; // resolution of grid ( low = higher )
    yres = 5; // resolution of grid ( low = higher )
    xmin = -50; // graph x start
    xmax = 50; // graph x end
    ymin = -100; // graph y start
    ymax = 100; // graph y end
 
    xorg = width / 2;
    yorg = height / 2;
    
    samples = new ArrayList();
    pos = new Vec2D(width*0.5, height*0.5);
    res = new Vec2D(1,1);
    scaling = 30;
    numbers = 2;
    lineRes = 1;
  }

  void drawGrid() {
    stroke(255); strokeWeight(1);
    for(float x=xmin; x < abs(xmin)+xmax; x++) {
      for(float y=ymin; y < abs(ymin)+ymax; y++) {
        point( x*scaling+pos.x, y*scaling+pos.y );
      }
    }
  }
  
  void drawNumbers() {
    textAlign(CENTER); fill(255); float nudge = -3;
    for(float x=-numbers; x > xmin; x-=numbers) text(nf(x*res.x,0,2), x*scaling+pos.x, pos.y + nudge);
    for(float x=+numbers; x < xmax; x+=numbers) text(nf(x*res.x,0,2), x*scaling+pos.x, pos.y + nudge);
    for(float y=-numbers; y > ymin; y-=numbers) text(nf(-y*res.y,0,2), pos.x, y*scaling+pos.y + nudge);
    for(float y=+numbers; y < ymax; y+=numbers) text(nf(-y*res.y,0,2), pos.x, y*scaling+pos.y + nudge);
  }
  
  void drawSamples() {
    stroke( 255, 150 );
    if( samples.size() >= 1) {
      Vec2D p1 = samples.get(0);
      for(Vec2D p2 : samples) {
        line(pos.x + p1.x * scaling / res.x, 
             pos.y - p1.y * scaling / res.y,
             pos.x + p2.x * scaling / res.x,
             pos.y - p2.y * scaling / res.y);
        p1 = p2;
      }
    }
  }
  
  void drawMouse() {
    stroke( 255,50 ); strokeWeight( 1 );
    line(mouseX, 0, mouseX, height);
    line(0, mouseY, width, mouseY);
    
    textAlign(LEFT); fill(255);
    text( nf((mouseX-pos.x)/scaling * res.x, 0, 3) + "\n" + nf((mouseY-pos.y)/scaling * -res.y, 0, 3), mouseX + 20, mouseY + 30);
  }
  
  void sampleFunction(Element element) {
    float n = ceil(width/lineRes);
    samples.clear();
    updateBounds();
    
    if(element.type.equals("Mook")) {
      for(float s=-n*0.5; s < n*0.5; s++) {
        float x = map(s, -n*0.5, n*0.5, xmin*res.x, xmax*res.x);
        float y = ((Mook) element).mookFunction(x);
        samples.add(new Vec2D(x,y));
      }
    }
    
    if(element.type.equals("Pulk")) {
      for(float s=-n*0.5; s < n*0.5; s++) {
        float x = map(s, -n*0.5, n*0.5, xmin*res.x, xmax*res.x);
        float y = ((Pulk) element).collapseFunction(x);
        samples.add(new Vec2D(x,y));
      }
    }
    
  }
  void updateBounds() {
    xmin = floor(-pos.x / scaling);
    xmax = ceil((width-pos.x) / scaling);
    ymin = floor(-pos.y / scaling);
    ymax = ceil((height-pos.y) / scaling);
  }
  
  void render() {
    stroke(255); strokeWeight(5);
    point(pos.x, pos.y);
    
    updateBounds();
    drawMouse();
    drawGrid();
    drawNumbers();
    drawSamples();
  }
}
