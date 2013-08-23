class Element{
  
  String type;
  
  Element() {
    type = "Element";
  }
  
  void reactWith(Element element) {
  }
  
  void act() {
  }
  
  JSONObject toJSON() {
    return new JSONObject();
  }
}

class CartisianElement extends Element{
  
  Vec3D pos;
  
  CartisianElement() {
    type = "Cartisian Element";
  }
}
