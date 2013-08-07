import toxi.geom.*;
import toxi.math.waves.*;
import toxi.math.noise.*;
import toxi.processing.*;
import java.util.Iterator;
import java.awt.event.*;

Cell      cell;
Render    render;
NetworkIO networkIO;
Graphview graphview;
String    gui;  // Scene, Graph

void setup() {
   size(1024, 800);
   background(3, 7, 10);
   frameRate(60);
   addMouseWheelListener(new MouseWheelListener() { 
     public void mouseWheelMoved(MouseWheelEvent mwe) { 
     mouseWheel(mwe.getWheelRotation());
   }}); 
      
   gui = "Scene";
   graphview = new Graphview();
   
   cell   = new Cell();
   networkIO = new NetworkIO(cell);
   render = new Render(cell);
   
   // Element mix list.
   cell.elements.add(new Boundary(512, new Vec2D(width/2, height/2)));
   createFluxObject( 100, 4, 20 );
}

void draw() {
  
  networkIO.tick();
  Boundary B = new Boundary(256, new Vec2D(width/2, height/2));
  fill(255);
  float theta = B.getTetha(new Vec2D(mouseX, mouseY));
  text("Theta: " + theta + " Retrun: " , mouseX, mouseY);
  
  point( B.getPosition(theta).x,  -B.getPosition(theta).y);
  
  cell.step();
  render.render();

}
