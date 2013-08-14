class Cell {
  
  ArrayList<Element> elements;
  
  Cell() {
    elements = new ArrayList<Element>();
  }
  
  void addElements(int amount) {
    for(int i=0; i<amount; i++) {
      elements.add(new Element());
    }
  }
  
  void step() {
    long measureNano = System.nanoTime();
    for(Element e1 : elements) {
      for(Element e2 : elements) {
        e1.reactWith(e2);
      }
    }
    actualEnergyUsedPerStep = System.nanoTime() - measureNano;
  }
  
  void render() {
    stroke(255);
    strokeWeight(5);
    for(Element e : elements) {
      point(e.pos.x, e.pos.y); 
    }
  }
}
