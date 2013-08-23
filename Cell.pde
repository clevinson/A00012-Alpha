class Cell{

  CapacityHandler capacityHandler;
  //VisibleOctree   octree;
  
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
/*
class VisibleOctree extends PointOctree {
  VisibleOctree(Vec3D origin, float size) {
    Vec3D v = new Vec3D(-1,-1,-1).scale(size/2).add(origin);
    super(v, size);
  } 
 
  void draw() {
    drawNode(this);
  }

  void drawNode(PointOctree n) {
    if (n.getNumChildren() > 0) {
      noFill();
      stroke(n.getDepth(), 20);
      pushMatrix(); 
      translate(n.x, n.y, n.z);
      box(n.getNodeSize());
      popMatrix();
      PointOctree[] childNodes=n.getChildren();
      for (int i = 0; i < 8; i++) {
        if(childNodes[i] != null) drawNode(childNodes[i]); 
      }
    }
  }
}*/
