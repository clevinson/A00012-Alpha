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
    }
  }  
}
