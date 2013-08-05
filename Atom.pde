class Atom extends Element {
  
  Vec2D pos;
  Vec2D vel;
  
  Atom() {
   type = "Atom";
  }
  
  Atom( Vec2D position, Vec2D velocity ) {
    type = "Atom";
    pos  = position;
    vel  = velocity;
  }
  
  void reactWith(Element element) {
    if( element.type.equals( "Boundary" ) ) reactWithBoundary((Boundary) element);
  }
  
  void reactWith(Boundary element) {
    if( element.type.equals( "Boundary" ) ) reactWithBoundary((Boundary) element);
  }
  
  void reactWithBoundary( Boundary boundary ) {
    boundary.reactWithAtom( this );
  }
  
  void act() {
    pos.addSelf( vel );
  }
  
  JSONObject toJSON() {
    JSONObject JSONElement = new JSONObject();
    JSONElement.setString("type", type);
    JSONElement.setJSONArray("vel", new JSONArray().setFloat(0, vel.x).setFloat(1, vel.y));
    return JSONElement;
  }
}
