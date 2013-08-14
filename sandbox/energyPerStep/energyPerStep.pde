import org.hyperic.sigar.*;

import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.ILine2DEquation;
import org.gwoptics.graphics.graph2D.traces.RollingLine2DTrace;

import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryPoolMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.ThreadMXBean;

long processingCapacity;
int paceTimeObserver;
long totalEnergyPerStep;
long actualEnergyUsedPerStep;

Cell cell;

void setup() {
  size(1280, 720);
  cell = new Cell();
  cell.addElements(200);
  
  processingCapacity = 0;// how to find processing capcity?
  paceTimeObserver = 60; // Measure in Hertz
  totalEnergyPerStep = processingCapacity / paceTimeObserver;
  actualEnergyUsedPerStep = -1;
}

void draw() {
  background(200);
  cell.step();
  cell.render();
  //energyMonitor
}

void mousePressed() {

}
 
void mouseDragged() {
  cell.addElements(10);
}
