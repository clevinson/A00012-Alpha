import peasy.*;
import toxi.geom.*;
import toxi.math.waves.*;
import toxi.math.noise.*;
import toxi.processing.*;
import java.util.Iterator;
import java.awt.event.*;
import peasy.*;

Cell      cell;
NetworkIO networkIO;
Render    render;
ToxiclibsSupport gfx;
Graphview graphview;
PeasyCam cam;

String    gui;  // Scene, Graph

void setup() {
   size(1280, 720, P3D);
   background(3, 7, 10);
   frameRate(60);
 
   gfx = new ToxiclibsSupport(this); 
   cam = new PeasyCam(this, 100);
   
   gui = "Scene";
   graphview = new Graphview();
   
   networkIO = new NetworkIO();
   cell   = new Cell(2048);
   networkIO.setCell(cell);
   render = new Render(cell);
}

void draw() {
    
  networkIO.tick();
  cell.step();
  render.render();
}
