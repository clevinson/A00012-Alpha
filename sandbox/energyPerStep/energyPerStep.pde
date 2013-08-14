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
EnergyMonitor energyMonitor;

void setup() {
  size(1280, 720);
  cell = new Cell();
  cell.addElements(200);
  
  energyMonitor = new 
  
  processingCapacity = 0;// how to find processing capcity?
  paceTimeObserver = 60; // Measure in Hertz
  totalEnergyPerStep = processingCapacity / paceTimeObserver;
  actualEnergyUsedPerStep = -1;
}

void draw() {
  background(200);
  cell.step();
  cell.render();
  EnergyMonitor
}

void mousePressed() {

}
 
void mouseDragged() {
  cell.addElements(10);
}

class EnergyMonitor {
  PApplet parent;
  Graph2D graph;
  
  EnergyMonitor(PApplet parent) {
    
    this.parent = parent;  
    
    actualEnergyUsedPerStepFunction = new RollingLine2DTrace(new cpuCombined(), 5, 0.002f);
    actualEnergyUsedPerStepFunction.setTraceColour(255, 0, 0);
    actualEnergyUsedPerStepFunction.setLineWidth(1);
       
    
    graph = new Graph2D(parent, 1100, 500, false);
    graph.setYAxisMax(1);
    graph.setYAxisLabel("Time in Nanoseconds");
    graph.addTrace(actualEnergyUsedPerStepFunction);
    graph.position.y = 100;
    graph.position.x = 100;
    graph.setYAxisTickSpacing(0.1);
    graph.setXAxisMax(5f);
  }
  
  void drawGraph() {
    graph.draw();
  }
  
  String toString() {
    return actualEnergyUsedPerStep;
  }
  
  class actualEnergyUsedPerStepFunction implements ILine2DEquation{
    public double computePoint(double x, int pos) {
      loadCpuObjects();
      return actualEnergyUsedPerStep;
    }
  }
}
