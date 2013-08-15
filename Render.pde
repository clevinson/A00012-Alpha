class Render{
  
  float xOffset, yOffset, scale;
  Cell cell;
        
  Render( Cell cell ) {
    this.cell = cell;
    xOffset = 0;
    yOffset = 0;
    scale   = 0.5;
  }
  
  void render() {
    
    boolean mouseNavigation = false;
    boolean fluxLines = true;
        
    noStroke();
    fill(3, 7, 10, 100); 
    rect(0,0,width,height);
    
    
    if( mouseNavigation ) {
      pushMatrix();
      translate( xOffset, yOffset );
      scale( scale );
    }
    
    for(Element e : cell.elements) {
      
      if(e.type.equals("Atom")) {
        strokeWeight(4);
        stroke(252, 191, 33);
        point(((Atom) e).pos.x, ((Atom) e).pos.y);
      }
      
      if(e.type.equals("Boundary")) {
        Boundary sb = (Boundary) e;
        stroke(255);
        strokeWeight(4);
        ellipse(sb.pos.x, sb.pos.y, sb.radius*2, sb.radius*2);
      }
      
      if(e.type.equals( "Flux" )) {   
        strokeWeight(1);
        stroke(255);
        if( fluxLines ) {
          for( Flux f : ((Flux) e).bonds ) {
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
      
      if(e.type.equals( "Pulk" )) {
        strokeWeight(3);
        stroke(240, 0, 255 * ((Pulk) e).vel.magnitude());
        point( ((Pulk) e).pos.x, ((Pulk) e).pos.y );
      }
    }
    
    if( mouseNavigation ) {
      popMatrix();
    }
  }
}
 
