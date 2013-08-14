class Cell{

  ArrayList<Element> elements;
  ArrayList<Boundary> boundaries;
  ArrayList<Element> departingElements;
  
  Cell() {
    elements = new ArrayList<Element>();
    boundaries = new ArrayList<Boundary>();
    departingElements = new ArrayList<Element>();
  }
  
  Cell(float boundaryRadius) {
    elements = new ArrayList<Element>();
    boundaries = new ArrayList<Boundary>();
    departingElements = new ArrayList<Element>();
    
    addBoundary(new Boundary(boundaryRadius, new Vec2D(width/2, height/2)));
  }
  
  void step() {
    
    for(int A=0; A < elements.size(); A++) {
      Element ElementA = (Element) elements.get(A);
      for(int B = A+1 ; B < elements.size(); B++) {
        Element ElementB = (Element) elements.get(B);
        ElementA.reactWith( ElementB );        
      }
    }
    
    for(Element e : departingElements) {
      if(elements.contains(e)) elements.remove(e);
    }
    
    for( Element e : elements) {
      e.act();
    }
  }
  
  void addElement(Element element) {
    elements.add(element);
  }

  void addBoundary(Boundary boundary) {
    elements.add(boundary);
    boundaries.add(boundary);
  }

  void reportDepature(Element element) {
    departingElements.add(element);
  }
  
  void debugCountElements( ArrayList<Element> elems ) {
    int atom      = 0;
    int boundary  = 0;
    int flux      = 0;
    for( Element e : elems ) {
      if(e.type.equals("Atom")) atom += 1;
      if(e.type.equals("Boundary")) boundary += 1;
      if(e.type.equals("Flux")) flux +=1;
    }
    println( "Element list contains " + atom + " atoms, " + boundary + " boundary and " + flux + " flux." );
  }
}
