class Cell{

  ArrayList<Element> elements;
  
  Cell() {
    elements = new ArrayList();
  }
  
  void step() {
    for(int A=0; A < elements.size(); A++) {
      Element ElementA = (Element) elements.get(A);
      for(int B = A++ ; B < elements.size(); B++) {
        Element ElementB = (Element) elements.get(B);
        ElementA.reactWith( ElementB );        
      }
    }
    for( Element e : elements) {
      e.act();
    }
  }
  
  void addElement(Element element) {
    elements.add(element);
  }
}
