class Boundary extends Element {
  
  BoundaryHandler handler;
  float radius;
  Vec2D pos;
  
  Boundary(float radius, Vec2D pos) {
    type = "Boundary"; 
    handler = new BoundaryHandler(this);
    this.radius = radius;
    this.pos = pos;
    heaven = new NetAddress("127.0.0.1",12000);
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
      handler.send(heaven, flux, getTetha(flux.pos));
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
  
  Vec2D getPosition(float theta) {
    Vec2D v = new Vec2D(radius*cos(theta), radius*sin(theta));
    v.y = -v.y; 
    return v;
  }
  
  Vec2D getNormalAtTheta(float theta) {
    return new Vec2D(radius*cos(theta), radius*sin(theta)).getInverted();
  }
}
