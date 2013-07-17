class Render{
  
  float xOffset, yOffset, scale;
  Cell cell;
        
  Render( Cell cell ) {
    this.cell = cell;
    xOffset = 0;
    yOffset = 0;
    scale   = 1;
  }
  
  void render() {
    
    boolean mouseNavigation = true;
    boolean fluxLines = false;
        
    noStroke();
    fill(3, 7, 10, 100); 
    rect(0,0,width,height);
    
    if( mouseNavigation ) {
      pushMatrix();
      translate( xOffset, yOffset );
      scale( scale );
    }
    
    for( Element e : cell.elements ) {
      
      if(e.type.equals( "Atom" )) {
        strokeWeight( 4 );
        stroke( 252, 191, 33 );
        point( ((Atom) e).pos.x, ((Atom) e).pos.y);
      }
      
      if(e.type.equals( "Boundary" )) {
          strokeWeight( 3 );
          stroke( 252 );
          noFill();
          java.util.List vertices = ((Boundary) e).shape.computeVertices( ((Boundary) e).detail );
          for(Iterator i=vertices.iterator(); i.hasNext(); ) {
            Vec2D v=(Vec2D)i.next();
            point(v.x + random( -((Boundary) e).thickness * 0.5, ((Boundary) e).thickness ) * 0.5, v.y + random( -((Boundary) e).thickness * 0.5, ((Boundary) e).thickness * 0.5 ) );
            point(v.x + random( -((Boundary) e).thickness, ((Boundary) e).thickness ), v.y + random( -((Boundary) e).thickness, ((Boundary) e).thickness ) );
          }
      }
      
      if(e.type.equals( "Flux" )) {        
        strokeWeight(1);
        stroke(255);
        if( fluxLines ) {
          for( Flux f : ((Flux) e).neighbours ) {
            line( f.pos.x, f.pos.y, ((Flux) e).pos.x, ((Flux) e).pos.y );
          }
        }
        strokeWeight(2);
        stroke(230);
        point( ((Flux) e).pos.x, ((Flux) e).pos.y );
        line( ((Flux) e).pos.x, 
              ((Flux) e).pos.y, 
              ((Flux) e).pos.x + ((Flux) e).vel.x , 
              ((Flux) e).pos.y + ((Flux) e).vel.y );
      }
    }
    
    if( mouseNavigation ) {
      popMatrix();
    }
  }
}
 
