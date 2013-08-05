class Mook extends Element {
  
  Vec2D pos;
  float force;
  
  Mook(Vec2D position) {
    type = "Mook";
    pos = position;
    force = 0.5;
  }
  
  void reactWith(Element element) {
    if(element.type.equals("Pulk")) reactWithPulk(((Pulk) element));
  }
  
  void reactWithPulk(Pulk pulk) {
    pulk.reactWithMook(this);
  }
  
  float mookFunction(float x) {
    return  force;
  }
}
