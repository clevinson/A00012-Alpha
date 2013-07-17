import toxi.geom.*;
import toxi.math.waves.*;
import toxi.processing.*;
import java.util.Iterator;
import java.awt.event.*;

Cell   cell;
Render render;

void setup() {
   size(1024, 800);
   background(3, 7, 10);
   frameRate(60);
   addMouseWheelListener(new MouseWheelListener() { 
     public void mouseWheelMoved(MouseWheelEvent mwe) { 
     mouseWheel(mwe.getWheelRotation());
   }}); 
   
   cell   = new Cell();
   render = new Render(cell);
   
   createBoundary();
   createFluxObject(500, 5, 50);
}

void draw() {
  
  cell.step();
  render.render();
  
  // debug graphics
  if( false ) {
    if( true )  fill(255); text( "FRAMERATE: " + frameRate, 50, 50 );
    if( false ) drawFunction(new Flux(new Vec2D()));
  }
}

// INTERACTION

void mouseDragged() {
  render.xOffset -= pmouseX - mouseX;
  render.yOffset -= pmouseY - mouseY;
}

void mouseWheel(float delta) {
  render.scale -= delta * 0.025;
}

void keyPressed() {
  if( key=='a' ) {
    Element e = new Atom( new Vec2D( mouseX, mouseY ), new Vec2D( random( -2, 2 ), random( -2, 2 ) ) );
    cell.addElement( e );
  }
  if( key=='c' ) {
    cell.debugCountElements(cell.elements);
  }
}

// VARIOUS INITIALIZATION and DEBUG FUNCTIONS

void createFluxObject( int amount, int numberOfNeighbours, float bondingDistance ) {
  ArrayList<Flux> scatteredPoints = new ArrayList<Flux>();
  if( true ) for( int n=0; n < amount; n++ ) scatteredPoints.add( new Flux(new Vec2D(random(200, width-200), random(200, height-200))) );
  if( false ) {
    for( int x=0; x < sqrt(amount); x++ ) {
      for( int y=0; y < sqrt(amount); y++ ) {
       scatteredPoints.add( new Flux( new Vec2D( 50 + x * ( bondingDistance - 1 ) , 50 + y * ( bondingDistance - 1 ) ) ) );
      }
    }
    for( Flux f1 : scatteredPoints ) {
      for( Flux f2 : scatteredPoints ) {
        if( f1.pos.distanceTo(f2.pos) < bondingDistance ) {
          f1.neighbours.add(f2);
        }
      } 
    }
  }
  for( Flux f : scatteredPoints ) {
    cell.elements.add(f);
  }
}

void drawFunction( Element element ) { 
  float xorg, yorg, x, y, xmin, xmax, ymin, ymax, xres, yres, fres;
  
  fres = .25;    // resolution of graph ( low = better )
  xres = 2;      // resolution of grid  ( low = higher )
  yres = 5;      // resolution of grid  ( low = higher )
  xmin = -50;    // graph x start
  xmax = 50;     // graph x end
  ymin = -100;   // graph y start
  ymax = 100;    // graph y end
 
  xorg = width / 2;
  yorg = height / 2;  
  
  stroke( 255 ); 
  strokeWeight( 1 );
  for( x=xmin; x < xmax; x += xres ) {
    for( y=ymin; y < ymax; y += yres ) {
      point( map(x, xmin, xmax, 0, width), map(y, ymin, ymax, 0, height ) );
    } 
  }
  
  stroke( 255 );
  textAlign(CENTER);
  for( x=0; x <= xmax; x += xres ) {
    text( nf(x,1,0), map(x, 0, xmax, xorg, width), yorg - 2 );
  }
  for( x=-xres; x >= xmin; x -= xres ) {
    text( nf(x,1,0), map(x, 0, xmin, xorg, 0), yorg - 2 );
  }
  for( y=+yres; y <= ymax; y += yres ) {
    text( nf(-y,1,0), xorg, map(y, 0, ymax, yorg, height) - 2 );
  }
  for( y=-yres; y >= ymin; y -= yres ) {
    text( nf(-y,1,0), xorg, map(y, 0, ymin, yorg, 0) - 2 );
  }
  
  // Function ( Be aware: I've flipped the rendering, so that the y positive face upwards, this could lead to potential confusion. ) 
  if(element.type.equals("Flux")) {
    if(true) {  // Relax Function
      stroke( 255, 212, 70 );
      for( x=xmin; x < xmax; x += fres ) {
        line( map( x-fres, xmin, xmax, 0, width), 
              map(-((Flux) element).relaxFunction( x-fres ), ymin, ymax, 0, height), 
              map( x, xmin, xmax, 0, width),
              map(-((Flux) element).relaxFunction( x ), ymin, ymax, 0, height) ); 
      }
    }
    if(true) {  // Affect Function
      stroke( 181, 240, 220 );
      for( x=xmin; x < xmax; x += fres ) {
      line( map( x-fres, xmin, xmax, 0, width), 
            map(-((Flux) element).affectFunction( x-fres ), ymin, ymax, 0, height), 
            map( x, xmin, xmax, 0, width),
            map(-((Flux) element).affectFunction( x ), ymin, ymax, 0, height) ); 
      }
    }
  }
}

void createBoundary() {  
  float xorg = width / 2;
  float yorg = height / 2;
  int   nPoints = 8;
  float radius = height;
  Vec2D pos;
  Spline2D shape4 = new Spline2D(); 
  for( int i=0; i <= nPoints; i++) {
    pos = new Vec2D( sin(map(i, 0, nPoints, 0, TWO_PI)), cos(map(i, 0, nPoints, 0, TWO_PI)));
    pos.scaleSelf(radius);
    pos.addSelf(new Vec2D(xorg, yorg));
    shape4.add(new Vec2D(pos.x, pos.y));
  }
  Element b4 = new Boundary(shape4, "Forth");

  Spline2D shape1 = new Spline2D(); 
  shape1.add(new Vec2D(86, 306));
  shape1.add(new Vec2D(129, 173));
  shape1.add(new Vec2D(295, 82));
  shape1.add(new Vec2D(473, 89));
  shape1.add(new Vec2D(562, 211));
  shape1.add(new Vec2D(583, 364));
  shape1.add(new Vec2D(528, 424));
  shape1.add(new Vec2D(447, 560));
  shape1.add(new Vec2D(334, 562));
  shape1.add(new Vec2D(224, 471));
  shape1.add(new Vec2D(103, 364));
  shape1.add(new Vec2D(86, 306));
  shape1.setTightness( 0.2 );
  Element b1 = new Boundary( shape1, "First" );  

  Spline2D shape3 = new Spline2D(); 
  shape3.add(new Vec2D(295, 395));
  shape3.add(new Vec2D(403, 370));
  shape3.add(new Vec2D(514, 427));
  shape3.add(new Vec2D(592, 467));
  shape3.setTightness( 0.2 );
  Element b3 = new Boundary( shape3, "Second" );  

  Spline2D shape2 = new Spline2D(); 
  shape2.add(new Vec2D(195, 295));
  shape2.add(new Vec2D(303, 270));
  shape2.add(new Vec2D(414, 327));
  shape2.add(new Vec2D(492, 267));
  shape2.setTightness( 0.2 );
  Element b2 = new Boundary( shape2, "Third" );  

  //cell.addElement(b1);
  //cell.addElement(b2);
  //cell.addElement(b3);
  cell.addElement(b4);
}

