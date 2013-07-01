class Cell{

  ArrayList elements;
  
  Cell() {
    elements = new ArrayList();
  }
  
  void step() {
    for(int A=0; A < elements.size(); A++) {
      Element ElementA = (Element) elements.get(A);
      for(int B = A++ ; B < elements.size(); B++) {
        Element ElementB = (Element) element.get(B);
        A.reactWith(B);        
      }
    }
  }
  
  void addElement(element) {
    elements.add(elment);
  }
}
