class Boundary extends Element {
  
  BoundaryHandler handler;
  float radius;
  Vec2D pos;
  NetAddress heaven;
  
  Boundary(float radius, Vec2D pos) {
    type = "Boundary"; 
    handler = new BoundaryHandler(this);
    this.radius = radius;
    this.pos = pos;
    heaven = new NetAddress("192.168.55.35",12000);
  }
  
  void reactWith(Element element) {
    if(element.type.equals("Atom")) reactWithAtom((Atom) element);
    if(element.type.equals("Flux")) reactWithFlux((Flux) element);
  }
  
  void reactWithAtom(Atom atom) {
    if(atom.pos.distanceTo(pos) >= radius) {
      handler.send(heaven, atom, getTetha(atom.pos));
    }
  }
  
  void reactWithFlux(Flux flux) {
    if(flux.pos.distanceTo(pos) >= radius) {
      handler.send(heaven, flux, getTetha(flux.pos));
    }
  }
  
  float getTetha(Vec2D elementPos) {
    Vec2D v = elementPos.sub(pos);
    
    return atan2(v.x, v.y);
  }
  
  Vec2D getPosition(float theta) {
    Vec2D v = new Vec2D(radius*cos(theta - HALF_PI), radius*sin(theta - HALF_PI ));
    v.y = -v.y; 
    return v;
  }
  
  Vec2D getNormalAtTheta(float theta) {
    return new Vec2D(radius*cos(theta - HALF_PI), radius*sin(theta - HALF_PI)).normalize().scaleSelf(-1,1);
  }
}
