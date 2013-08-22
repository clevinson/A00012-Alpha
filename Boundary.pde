class Boundary extends Element {
  
  BoundaryHandler handler;
  float radius;
  Vec3D pos;
  NetAddress heaven;
  
  Boundary(float radius, Vec3D pos) {
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
      handler.send(heaven, atom, getUV(atom.pos));
    }
  }
  
  void reactWithFlux(Flux flux) {
    if(flux.pos.distanceTo(pos) >= radius) {
      flux.isGhost = true;
      handler.send(heaven, flux, getUV(flux.pos));
    }
  }
  
  float getTetha(Vec2D elementPos) {
    Vec2D v = elementPos.sub(pos.to2DXY());
    return atan2(v.x, v.y);
  }
  
  Vec2D getUV(Vec3D elementsPos) {
    return new Vec2D();
  }
  
  Vec3D getPosition(Vec2D UV) {
    return new Vec3D();
  }
  
  Vec2D getPosition(float theta) {
    Vec2D v = new Vec2D(radius*cos(theta - HALF_PI), radius*sin(theta - HALF_PI ));
    v.y = -v.y;
    println(v); 
    v = v.getInverted();
    println(v);
    return v.addSelf(pos.to2DXY());
  }
  
  Vec2D getNormalAtTheta(float theta) {
    Vec2D v = new Vec2D(cos(theta - HALF_PI), sin(theta - HALF_PI));
    v.y = -v.y;
    return v.getInverted();
  }
}
