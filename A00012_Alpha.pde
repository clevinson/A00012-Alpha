
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
String  gui;  // Scene, Graph

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
   createBoundary();
   createFluxObject( 1000, 4, 20 );
   
   
}

void draw() {
  
  cell.step();
  render.render();
  
  // debug 50r20phics
  if( false ) {
    if( false ) fill(255); text( "FRAMERATE: " + frameRate, 50, 50 );
  }
}
