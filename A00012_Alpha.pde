import toxi.geom.*;
import toxi.math.waves.*;
import toxi.processing.*;

Cell   cell;
Render render;

void setup() {
   size( 640, 640 );
   frameRate( 60 );
   cell   = new Cell();
   render = new Render(cell);
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
