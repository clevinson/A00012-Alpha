class Render{
  
  Cell cell;
        
  Render( Cell cell ) {
    this.cell = cell;
  }
  
  void render() {
    
    println(cell.capacityHandler.toString());
    
    boolean mouseNavigation = false;
    boolean fluxLines = true;
    
    cam.beginHUD();    
      noStroke();
      fill(3, 7, 10, 100); 
      rect(0,0,width,height);
    cam.endHUD();

    lights();
    
    stroke(255,0,0);
    if(true) { // Render Pivot Point
      strokeWeight(10);
      point(0,0,0);
    }
    if(false) { // Render Cell Axis-Aligned Bounding Box (AABB) 
      strokeWeight(1);
      noFill();
      gfx.mesh(cell.getAABB().toMesh());
    }
    
    
    if(cell.octree != null) cell.octree.draw();

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
        fill(20,20,100);
        //gfx.sphere(new Sphere(b.pos, b.radius), 50, true);
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
}
 
