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
    for(Element e1 : elements) {
      for(Element e2 : elements) {
        e1.reactWith(e2);
      }
    }
  }
  
  void render() {
    stroke(255);
    strokeWeight(5);
    for(Element e : elements) {
      point(e.pos.x, e.pos.y); 
    }
  }
}
