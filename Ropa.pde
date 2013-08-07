class Ropa extends Element {
  
  Ropa() {
    
  }
  
  void reactWith(Element element) {
    if(element.type.equals("Pulk")) reactWithPulk((Pulk) element);
  }
  
  void reactWithPulk(Pulk pulk) {
    pulk.reactWithRopa(this);
  }
  
  Vec2D brownianNoise() {
    Vec2D v = new Vec2D(random(-1,1), random(-1,1)).normalize();
    return v;
  }
}
