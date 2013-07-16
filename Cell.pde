class Cell{

  ArrayList<Element> elements;
  ArrayList<Element> departingElements;
  
  Cell() {
    elements = new ArrayList<Element>();
    departingElements = new ArrayList<Element>();
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
  
  void repotDepature(Element element) {
    departingElements.add(element);
  }
}
