class Atom extends Element {
  
  Vec3D pos;
  Vec3D vel;
  
  Atom() {
   type = "Atom";
  }
  
  Atom(Vec3D position, Vec3D velocity) {
    type = "Atom";
    pos  = position;
    vel  = velocity;
  }
  
  Atom(JSONObject atom) {
    type = atom.getString("type");
    pos  = new Vec3D();
    vel  = new Vec3D( atom.getJSONArray("vel").getFloat(0), atom.getJSONArray("vel").getFloat(1), atom.getJSONArray("vel").getFloat(2));
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
    JSONElement.setJSONArray("vel", new JSONArray().setFloat(0, vel.x).setFloat(1, vel.y).setFloat(2, vel.z));
    return JSONElement;
  }
}
