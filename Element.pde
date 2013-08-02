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
    JSONObject element = new JSONObject();
    element.setString("type", "element");
    return element;
  }
}
