class Cell{

  CapacityHandler capacityHandler;
  KdTree kdTree;
  
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

    kdTree = new KdTree(cartisianElements);    
    
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
    if(element.type.equals("Atom")) {
      cartisianElements.add((CartisianElement) element);
    }
    if(element.type.equals("Flux")) {
      cartisianElements.add((CartisianElement) element);
    }
    elements.add(element);
  }

  void addBoundary(Boundary boundary) {
    elements.add(boundary);
    boundaries.add(boundary);
  }

  void reportDepature(Element element) {
    departingElements.add(element);
  }
  
  void debugCountElements(ArrayList<Element> elems) {
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

class KdTree {
  
  KdTree.Node root;
  
  KdTree(ArrayList<CartisianElement> cartisianElements) {
    if(cartisianElements.size() > 0) {
      build(root = new KdTree.Node(0), cartisianElements);
    }
  }
   
  private void build(final KdTree.Node node, final ArrayList<CartisianElement> cartElements) {
    final int e = cartElements.size(); // Number of elements.
    final int m = e>>1; // Gets the media using bitshift? hm.. how?
    if(e > 1) {
      int depth = node.depth;
      
      if(depth%3 == 0) {
        sortX(cartElements);
      } else if( depth%3 == 1) {
        sortY(cartElements);
      } else {
        sortZ(cartElements);
      }
      
      build(node.L = new Node(++depth), copy(cartElements, 0, m)); // Why does the left node increment and not the right too? 
      build(node.R = new Node(  depth), copy(cartElements, m, e));
    }
    node.cartElement = cartElements.get(m);
  }
  
  private final ArrayList<CartisianElement> copy(final ArrayList<CartisianElement> src, final int from, final int to) {
    final ArrayList<CartisianElement> dst = new ArrayList<CartisianElement>(src.subList(from, to));
    return dst;
  }
  
  public int numLeafs(KdTree.Node n, int num_leafs){
    if( n.isLeaf() ){
      return num_leafs+1;
    } else {
      num_leafs = numLeafs(n.L, num_leafs);
      num_leafs = numLeafs(n.R, num_leafs);
      return num_leafs;
    }
  }
  
  public final void sortX(ArrayList<CartisianElement> cartElements) {
    Collections.sort(cartElements, new Comparator<CartisianElement>() {
      public int compare(final CartisianElement a, final CartisianElement b) {
        return (a.pos.x < b.pos.x) ? -1 : ((a.pos.x > b.pos.x) ? +1 : 0);
      }
    });
  }
  
  public final void sortY(ArrayList<CartisianElement> cartElements) {
    Collections.sort(cartElements, new Comparator<CartisianElement>() {
      public int compare(final CartisianElement a, final CartisianElement b) {
        return (a.pos.y < b.pos.y) ? -1 : ((a.pos.y > b.pos.y) ? +1 : 0);
      }
    });
  }
    
  public final void sortZ(ArrayList<CartisianElement> cartElements) {
    Collections.sort(cartElements, new Comparator<CartisianElement>() {
      public int compare(final CartisianElement a, final CartisianElement b) {
        return (a.pos.z < b.pos.z) ? -1 : ((a.pos.z > b.pos.z) ? +1 : 0);
      }
    });
  }
  
  public class Node {
    int depth;
    CartisianElement cartElement;
    Node L, R;
    
    Node(int depth) {
      this.depth = depth;
    }
    
    boolean isLeaf(){
      return (L==null) | (R==null);
    }
  }  
}
