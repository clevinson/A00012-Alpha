class CapacityHandler {
  
  long observer;
  long startTime;
  long cycleDuration;
  double currentCapacityUsage;
  boolean conductingMeasurement;
  
  CapacityHandler() {
    observer = 16000000;
    currentCapacityUsage = 0;
    conductingMeasurement = false;
  }
  
  void startCapacityMeasurement() {
    conductingMeasurement = true;
    startTime = System.nanoTime();
  }
  
  void endCapacityMeasurement() {
    if(conductingMeasurement = true) {
      cycleDuration = System.nanoTime() - startTime;
      currentCapacityUsage = (double) cycleDuration / (double) observer;
      conductingMeasurement = false;
    } else {
      println("endCapacityMeasurement() was call without a measurement being started");
    }
  }
  
  void displayGraph() {
  }
  
  String toString() {
    return "Observer: " + observer + "ns   Current Capacity Usage: " + nf((float)currentCapacityUsage, 1, 3) + "%   Cycle duration: " + cycleDuration + "ns"; 
  }
}
