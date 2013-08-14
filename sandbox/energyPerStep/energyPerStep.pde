import org.hyperic.sigar.*;

import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.ILine2DEquation;
import org.gwoptics.graphics.graph2D.traces.RollingLine2DTrace;

int processingCapacity;
int paceTimeObserver;
int totalEnergyPerStep;
int actualEnergyUsedPerStep;


ComputerMonitor computerMonitor;

void setup() {
  size(640, 640);
  
  computerMonitor = new ComputerMonitor(this);
    
  processingCapacity = 0;// how to find processing capcity?
  paceTimeObserver = 60; // Measure in Hertz
  totalEnergyPerStep = processingCapacity / paceTimeObserver;
  actualEnergyUsedPerStep = -1;
}

void draw() {
  background(125);
  
  computerMonitor.drawOnScreen();
  // To make visible if the program freezes or not.
  ellipse(mouseX, mouseY, 5, 5);
}

void mousePressed() {
  computerMonitor.printToConsole();
}

class ComputerMonitor {
  
  PApplet parent;
  Sigar sigar;
  Mem mem;
  Cpu cpu;
  CpuPerc perc;
  CpuPerc[] cpuPercs; 
  
  RollingLine2DTrace cpuCombined;
  RollingLine2DTrace r,r2,r3;
  Graph2D g;
    
  ComputerMonitor(PApplet parent) {
      this.parent = parent;
      sigar = new Sigar();
      mem = new Mem();
      cpu = new Cpu();
      
      /* Graphing */ 
      cpuCombined = new RollingLine2DTrace(new eq(), 100, 0.01f);
      cpuCombined.setTraceColour(255, 0, 0);
      cpuCombined.setLineWidth(3);
      
      r  = new RollingLine2DTrace(new eq() ,100,0.1f);
      r.setTraceColour(0, 255, 0);
      
      r2 = new RollingLine2DTrace(new eq2(),100,0.1f);
      r2.setTraceColour(255, 0, 0);
      
      r3 = new RollingLine2DTrace(new eq3(),100,0.1f);
      r3.setTraceColour(0, 0, 255);
       
      g = new Graph2D(parent, 400, 200, false);
      g.setYAxisMax(600);
      g.addTrace(r);
      g.addTrace(r2);
      g.addTrace(r3);
      g.position.y = 50;
      g.position.x = 100;
      g.setYAxisTickSpacing(100);
      g.setXAxisMax(5f);
  }
  
  void drawOnScreen() {
    g.draw();
  }
  
  void printToConsole() {
    try {
      cpu = sigar.getCpu();
    }
    catch (SigarException se) {
      se.printStackTrace();
    }
    System.out.println("CPU DETAILS");
    System.out.println("idle: " + cpu.getIdle());//get overall CPU idle
    System.out.println("irq: " + cpu.getIrq());
    System.out.println("nice: " + cpu.getNice());
    System.out.println("soft irq: " + cpu.getSoftIrq());
    System.out.println("stolen: " + cpu.getStolen());
    System.out.println("sys: " + cpu.getSys());
    System.out.println("total: " + cpu.getTotal());
    System.out.println("user: " + cpu.getUser());
    System.out.println();
  
    try {
      perc = sigar.getCpuPerc();
    } catch (SigarException se) {
      se.printStackTrace();
    }
    
    System.out.println("OVERALL CPU USAGE");
    System.out.println("system idle: " + perc.getIdle());//get current CPU idle rate
    System.out.println("conbined: "+ perc.getCombined());//get current CPU usage
    
    try {
      cpuPercs = sigar.getCpuPercList();
    } catch (SigarException se) {
      se.printStackTrace();
    }
    
    System.out.println("\nEACH CPU USAGE");
    for (CpuPerc cpuPerc : cpuPercs) {
      System.out.println("system idle: " + cpuPerc.getIdle());//get current CPU idle rate
      System.out.println("conbined: "+ cpuPerc.getCombined());//get current usage
      System.out.println();
    }
  }

  class eq implements ILine2DEquation{
    public double computePoint(double x,int pos) {
      return mouseX;
    }    
  }
  
  class eq2 implements ILine2DEquation{
    public double computePoint(double x,int pos) {
      return mouseY;
    }    
  }
  
  class eq3 implements ILine2DEquation{
    public double computePoint(double x,int pos) {
      if(mousePressed)
        return 400;
      else
        return 0;
    }    
  }
}
