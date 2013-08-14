import org.hyperic.sigar.*;

import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.ILine2DEquation;
import org.gwoptics.graphics.graph2D.traces.RollingLine2DTrace;

import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryPoolMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.ThreadMXBean;

int processingCapacity;
int paceTimeObserver;
int totalEnergyPerStep;
int actualEnergyUsedPerStep;


ComputerMonitor computerMonitor;
Cell cell;

void setup() {
  size(1280, 720);
  
  computerMonitor = new ComputerMonitor(this);
  
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
  computerMonitor.drawOnScreen();
    computerMonitor.printToConsole();
}

void mousePressed() {

}
 
void mouseDragged() {
  cell.addElements(10);
}

class ComputerMonitor {
  
  PApplet parent;
  
  String pid;
  Sigar sigar;
  Mem mem;
  Cpu cpu;
  ThreadCpu threadCpu;
  ProcTime procTime;
  ProcCpu procCpu;
  CpuPerc perc;
  CpuPerc[] cpuPercs; 
  
  RollingLine2DTrace cpuCombined;
  Graph2D graph;
    
  ComputerMonitor(PApplet parent) {
      this.parent = parent;
      
      /* SIGAR */
      sigar = new Sigar();
      
      /* ManagementFactory */ 
      pid = ManagementFactory.getRuntimeMXBean().getName();
      
      loadCpuObjects();
      
      /* Graphing */ 
      cpuCombined = new RollingLine2DTrace(new cpuCombined(), 5, 0.002f);
      cpuCombined.setTraceColour(255, 0, 0);
      cpuCombined.setLineWidth(1);
       
      graph = new Graph2D(parent, 1100, 500, false);
      graph.setYAxisMax(1);
      graph.setYAxisLabel("CPU Usage");
      graph.addTrace(cpuCombined);
      graph.position.y = 100;
      graph.position.x = 100;
      graph.setYAxisTickSpacing(0.1);
      graph.setXAxisMax(5f);
  }
  
  void drawOnScreen() {
    graph.draw();
  }
  
  void printToConsole() {
    loadCpuObjects();
        
    println(pid);
    println(sigar.getPid());
    println(procCpu.toString());
    
    if(false) {
      System.out.println(cpu.toString());
      System.out.println(procTime.toString());
      System.out.println(perc.toString());
    }
    
    if(false) {
      System.out.println("\nEACH CPU USAGE");
      for (CpuPerc cpuPerc : cpuPercs) {
        System.out.println(cpuPerc.toString());//get current CPU idle rate
      }
    }
    
    System.out.println("\n\n\n\n");
  }
  
  void loadCpuObjects() {
    
      pid = ManagementFactory.getRuntimeMXBean().getName();
      
      try {
        cpu = sigar.getCpu();
      } catch (SigarException se) {
        se.printStackTrace();
      }
      
      try {
        procCpu = sigar.getProcCpu( sigar.getPid() );
      } catch (SigarException se) {
        se.printStackTrace();
      }
      
      try {
        procTime = sigar.getProcTime( sigar.getPid() );
      } catch (SigarException se) {
        se.printStackTrace();
      }
      
      try {
        threadCpu = sigar.getThreadCpu();
      } catch (SigarException se) {
        se.printStackTrace();
      }
      
      try {
        perc = sigar.getCpuPerc();
      } catch (SigarException se) {
        se.printStackTrace();
      }
      
      try {
        cpuPercs = sigar.getCpuPercList();
      } catch (SigarException se) {
        se.printStackTrace();
      }
  }
  
  class cpuCombined implements ILine2DEquation{
    public double computePoint(double x, int pos) {
      loadCpuObjects();
      return threadCpu.getTotal();
    }
  }
}
