class Render{
  
  Cell cell;
        
  Render( Cell cell ) {
    this.cell = cell;
  }
  
  void render() {
    for( Element e : cell.elements ) {
      if(e.type.equals( "Atom" )) {
        strokeWeight( 4 );
        stroke( 252, 191, 33 );
        point( ((Atom) e).position.x, ((Atom) e).position.y);
      }
      if(e.type.equals( "Boundary" )) {
          strokeWeight( ((Boundary) e).thickness );
          stroke( 252 );
          noFill();
          java.util.List vertices = ((Boundary) e).shape.computeVertices( ((Boundary) e).detail );
          for(Iterator i=vertices.iterator(); i.hasNext(); ) {
            Vec2D v=(Vec2D)i.next();
            point(v.x, v.y);
          }
      }
    }
  }
}
 
