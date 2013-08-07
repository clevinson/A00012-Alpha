/*
 * Added this Tab to avoid having so much crap in the main app Tab. In theory one should be able to just comment out this entire tab.
 * Now I've sectioned it into two parts. 
 * * A: Interaction : Mouse and Key-Events.
 * * B: Methods : Debug and initialization methods which mostly are used for testing spesific classes.
 */
 

/*
 * INTERACTION
 */ 
 
void mouseDragged() {
  if(gui.equals("Graph")) {
    if(mouseButton==CENTER) {
      graphview.res.x = abs(graphview.res.x - (pmouseX - mouseX)*0.01);
      graphview.res.y = abs(graphview.res.y - (pmouseY - mouseY)*0.01);
    } else {
      graphview.pos.x -= pmouseX - mouseX;
      graphview.pos.y -= pmouseY - mouseY;
    }      
  } else if(gui.equals("Scene")) {
    render.xOffset -= pmouseX - mouseX;
    render.yOffset -= pmouseY - mouseY;    
  }
}

void mouseWheel(float delta) {
  if(gui.equals("Graph")) {
    graphview.res.x = abs(graphview.res.x - delta * 0.025);
    graphview.res.y = abs(graphview.res.y - delta * 0.025);
  } else if(gui.equals("Scene")) {
    render.scale -= delta * 0.025;
  }
}

void keyPressed() {
  if( key=='a' ) {
    Element e = new Atom( new Vec2D( mouseX, mouseY ), new Vec2D( random( -2, 2 ), random( -2, 2 ) ) );
    cell.addElement( e );
  }
  if( key=='p' ) {
    cell.elements.add( new Pulk( new Vec2D( mouseX, mouseY ) ) );
  }
  if( key=='c' ) {
    cell.debugCountElements(cell.elements);
  }
  if( key=='G' ) gui = "Graph";
  if( key=='S' ) gui = "Scene";
}

/*
 * METH...ODDS : crystals and oddity.  
 */

void pulkSeeder() {
  boolean foundNewPos = false;
  Vec2D   seedPosition = new Vec2D();
  Pulk    seedPulk;
  
  float   spawnRadius = 40;
  float   threshold   = 0.1;
  float   temperature = 0; // Average velocity
  int     counter     = 0;
  
  for(Element e : cell.elements) {
    if(e.type.equals("Pulk")) {
      temperature += ((Pulk) e).vel.magnitude();
      counter++;
    }
  }
  
  if( temperature / counter < threshold ) {
    while(!foundNewPos) {
      Element elm = cell.elements.get(floor(random(1, cell.elements.size())));
      if( elm.type.equals("Pulk") ) {
        seedPulk     = (Pulk) elm;
        seedPosition = new Vec2D(random(-spawnRadius,spawnRadius), random(-spawnRadius,spawnRadius)).addSelf(seedPulk.pos);;
        foundNewPos  = true;
        for(Element e : cell.elements) {
          if(e.type.equals("Pulk")) {
            if(((Pulk) e).pos.distanceTo(seedPosition) < spawnRadius * 0.5) foundNewPos = false;
          }
        }
      }
    }
    println( temperature / counter );
    println( "Added a new Pulk, now total count amounts to: " + (cell.elements.size()-1) + " at a framerate of: " + frameRate );
    cell.elements.add(new Pulk(seedPosition));
  }  
}

void createFluxObject( int amount, int numberOfNeighbours, float bondingDistance ) {
  ArrayList<Flux> scatteredPoints = new ArrayList<Flux>();
  if( true ) for( int n=0; n < amount; n++ ) scatteredPoints.add( new Flux(new Vec2D(random(200, width-200), random(200, height-200))) );
  if( false ) {
    for( int x=0; x < sqrt(amount); x++ ) {
      for( int y=0; y < sqrt(amount); y++ ) {
       scatteredPoints.add( new Flux( new Vec2D( 50 + x * ( bondingDistance - 1 ) , 50 + y * ( bondingDistance - 1 ) ) ) );
      }
    }
    for( Flux f1 : scatteredPoints ) {
      for( Flux f2 : scatteredPoints ) {
        if( f1.pos.distanceTo(f2.pos) < bondingDistance ) {
          f1.neighbours.add(f2);
        }
      } 
    }
  }
  for( Flux f : scatteredPoints ) {
    cell.elements.add(f);
  }
}
