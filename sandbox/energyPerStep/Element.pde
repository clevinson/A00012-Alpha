class Element{
  
  PVector pos;
  float   dist;
  
  Element() {
    pos = new PVector(random(0,width), random(0,height));
    dist = 0;
  }
  
  void reactWith(Element element) {
    dist = pos.dist(element.pos);
  }
  
  void act() {
    
  }
}
