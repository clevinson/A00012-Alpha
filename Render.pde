class Render{
  
  Cell cell;
        
  Render( Cell cell ) {
    this.cell = cell;
  }
  
  void render() {
    
    // To Console
    // println(cell.capacityHandler.toString());
    
    boolean mouseNavigation = false;
    boolean fluxLines = true;
    
    cam.beginHUD();    
      noStroke();
      fill(3, 7, 10, 100); 
      rect(0,0,width,height);
    cam.endHUD();

    lights();

    if(cell.cartisianElements.size() > 0) drawKdTree(cell.kdTree.root, null);
    
    /* Elements */ 
    for(Element e : cell.elements) {
      
      if(e.type.equals("Atom")) {
        Atom atom = (Atom) e;
        strokeWeight(4);
        stroke(252, 191, 33);
        gfx.point(atom.pos);
      }
      
      if(e.type.equals("Boundary")) {
        Boundary b = (Boundary) e;
        noStroke();
        fill(20,20,50);
        gfx.sphere(new Sphere(b.pos, b.radius), 50, true);
      }
      
      if(e.type.equals( "Flux" )) { 
        Flux flux = (Flux) e;  
        strokeWeight(1);
        stroke(255);
        if( fluxLines ) {
          for( Flux f : ((Flux) e).bonds ) {
            gfx.line( flux.pos, f.pos );
          }
        }
        strokeWeight(2);
        stroke(230);
        gfx.point( flux.pos );
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
  
  void drawKdTree(KdTree.Node node, KdTree.Node parent) {
    if(!node.isLeaf()) {
      drawKdTree(node.L, node);
      drawKdTree(node.R, node);
      
      if(parent==null) {
        strokeWeight(1);
        int rayLength = 3000;
        gfx.line(node.cartElement.pos.add(rayLength,0,0), node.cartElement.pos.sub(rayLength,0,0));
      } else {
        if(node.depth%3 == 0) {
          stroke(255,0,0);
          if(node.cartElement.pos.x > parent.cartElement.pos.x ) {
            gfx.line(
          } else {
            
          }
        } else if(node.depth%3  == 1) {
          stroke(0,255,0);
        } else {
          stroke(0,0,255);
        }
        
        strokeWeight(2);
        gfx.point(node.cartElement.pos);
      }
    } else {
      strokeWeight(2);
      stroke(255);
      gfx.point(node.cartElement.pos);
    }
  }
 
}
