class Cell{

  CapacityHandler capacityHandler;
  Octree octree;
  
  ArrayList<Element> elements;
  ArrayList<CartisianElement> cartisianElements;
  ArrayList<Boundary> boundaries;
  ArrayList<Element> departingElements;
  
  Cell() {
    capacityHandler = new CapacityHandler();
    elements = new ArrayList<Element>();
    cartisianElements = new ArrayList<CartisianElement>();
    boundaries = new ArrayList<Boundary>();
    departingElements = new ArrayList<Element>();
  }
  
  Cell(float boundaryRadius) {
    capacityHandler = new CapacityHandler();
    elements = new ArrayList<Element>();
    cartisianElements = new ArrayList<CartisianElement>();
    boundaries = new ArrayList<Boundary>();
    departingElements = new ArrayList<Element>();
    
    addBoundary(new Boundary(boundaryRadius, new Vec3D()));
  }
  
  void step() {
    
    capacityHandler.startCapacityMeasurement();
    octree = new Octree(new Vec3D(), max(getAABB().getExtent().toArray()));
    octree.addElements(cartisianElements);
    
    for(int A=0; A < elements.size(); A++) {
      Element ElementA = (Element) elements.get(A);
      for(int B = A+1 ; B < elements.size(); B++) {
        Element ElementB = (Element) elements.get(B);
        ElementA.reactWith( ElementB );        
      }
    }
    
    for(Element e : departingElements) {
      if(elements.contains(e)) {
        elements.remove(e);
      }
    }
    
    for( Element e : elements) {
      e.act();
    }
    
    capacityHandler.endCapacityMeasurement();
  }
  
  void addElement(Element element) {
    if(element.type.equals("Atom")) cartisianElements.add((CartisianElement) element);
    if(element.type.equals("Flux")) cartisianElements.add((CartisianElement) element);
    elements.add(element);
  }

  void addBoundary(Boundary boundary) {
    elements.add(boundary);
    boundaries.add(boundary);
  }

  void reportDepature(Element element) {
    departingElements.add(element);
  }
  
  AABB getAABB() {
    Vec3D min = new Vec3D();
    Vec3D max = new Vec3D();
    for(CartisianElement e : cartisianElements) {
      min.minSelf(e.pos);
      max.maxSelf(e.pos); 
    }
    
    
    return new AABB(new Vec3D(), min.abs().maxSelf(max));
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
