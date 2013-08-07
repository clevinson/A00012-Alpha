class Boundary extends Element {
  
  BoundaryHandler handler;
  float radius;
  Vec2D pos;
  
  Boundary(float radius, Vec2D pos) {
    type = "Boundary"; 
    handler = new BoundaryHandler(this);
    this.radius = radius;
    this.pos = pos;
  }
  
  void reactWith(Element element) {
    if(element.type.equals("Atom")) reactWithAtom((Atom) element);
    if(element.type.equals("Flux")) reactWithFlux((Flux) element);
  }
  
  void reactWithAtom(Atom atom) {
    if(atom.pos.distanceTo(pos) >= radius) {
      handler.sendDebug(atom, getTetha(atom.pos));
    }
  }
  
  void reactWithFlux(Flux flux) {
    if(flux.pos.distanceTo(pos) >= radius) {
      handler.sendDebug(flux, getTetha(flux.pos));
    }
  }
  
  float getTetha(Vec2D elementPos) {
    Vec2D v = elementPos.sub(pos);
    if(v.x >= 0) {
      return -atan(v.y/v.x);
    } else {
      return atan(v.y/v.x);
    } 
  }
}
