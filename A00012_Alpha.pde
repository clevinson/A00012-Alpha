import toxi.geom.*;
import toxi.math.waves.*;
import toxi.processing.*;
import java.util.Iterator;

Cell   cell;
Render render;

void setup() {
   size( 640, 640 );
   frameRate( 60 );
   cell   = new Cell();
   render = new Render(cell);
   addBoundary();
}

void draw() {
  background(50);
  cell.step();
  render.render();
}

void mousePressed() {
  Element e = new Atom( new Vec2D( mouseX, mouseY ), new Vec2D( random( -2, 2 ), random( -2, 2 ) ) );
  cell.addElement( e );
}

void mouseDragged() {
  Element e = new Atom( new Vec2D( mouseX, mouseY ), new Vec2D( random( -2, 2 ), random( -2, 2 ) ) );
  cell.addElement( e );
}

void addBoundary() {  
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
  shape1.setTightness( 0.1 );
  Element b1 = new Boundary( shape1, "First" );  
  cell.addElement( b1 );
  
  Spline2D shape3 = new Spline2D(); 
  shape3.add(new Vec2D(295, 395));
  shape3.add(new Vec2D(403, 370));
  shape3.add(new Vec2D(514, 427));
  shape3.add(new Vec2D(592, 467));
  shape3.setTightness( 0.1 );
  Element b3 = new Boundary( shape3, "Second" );  
  cell.addElement( b3 );
  
  Spline2D shape2 = new Spline2D(); 
  shape2.add(new Vec2D(195, 295));
  shape2.add(new Vec2D(303, 270));
  shape2.add(new Vec2D(414, 327));
  shape2.add(new Vec2D(492, 267));
  shape2.setTightness( 0.1 );
  Element b2 = new Boundary( shape2, "Third" );  
  cell.addElement( b2 );
}

