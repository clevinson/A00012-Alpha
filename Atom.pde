class Atom extends Element {
  
  Vec2D position;
  Vec2D velocity;
  
  Atom() {
   type = "Atom";
  }
  
  Atom( Vec2D position, Vec2D velocity ) {
    type = "Atom";
    this.position = position;
    this.velocity = velocity;
  }
  
  void reactWith(Element element) {
    if( element.type.equals( "Boundary" ) ) reactWithBoundary((Boundary) element);
  }
  
  void reactWithBoundary( Boundary boundary ) {
    boundary.reactWithAtom( this );
  }
  
  void act() {
    position.addSelf( velocity );
  }
}
