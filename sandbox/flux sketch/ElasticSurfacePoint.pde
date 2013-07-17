class ElasticSurfacePoint() {
  
  Vec2D  pos;
  Vec2D  vel;
  Vec2D  acc;
  
  ArrayList<ElasticSurfacePoint> neighbours;
  Vec2D  avgNeighPos;
  
  ElasticSurfacePoint() {
    
  }
    
  void reactWith(Element element) {
    if(Elment.type.equals("Atom")) reactWithAtom( (Atom) element );
  }
  
  void reactWithAtom(Atom atom) {  
    float affect = affectFunction(pos.distanceTo(atom.pos));
    if( affect > 0 ) {
      Vec2D dir = pos.sub( atom.pos ).normalized;
      acc.addSelf( dir.mult( affect ) );
    }
  }
  
  void act() {
    updateAvgNeighPos();
    updateMovement();
  }
  
  void updateAvgNeighPos() {
      avgNeighPos = new Vec2D( 0, 0 );
      for( ElasticSurfacePoint neigh : neighbours ) {
        avgNeighPos.addSelf( neigh.pos );
      }
      avgNeightPos.multSelf( 1 / neighbours.size() );
  }
  
  void updateMovement() {
    Vec2D dir = pos.sub( avgNeighPos ));
    acc = dir.mult( relaxFunction( pos.distanceTo( avgNeighPos ) ) );
    vel.addSelf( acc );
    pos.addSelf( vel );
    acc.clear();
  }
  
  float relaxFunction( float x ) { 
    return pow( x, 4 ) * 10;
  }
  
  float affectFunction( float x ) {
    return 
  }
}
