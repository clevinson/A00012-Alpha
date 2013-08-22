/*
 * Added this Tab to avoid having so much crap in the main app Tab. In theory one should be able to just comment out this entire tab.
 * Now I've sectioned it into two parts. 
 * * A: Interaction : Mouse and Key-Events.
 * * B: Methods : Debug and initialization methods which mostly are used for testing spesific classes.
 */
void keyPressed() {
  if( key=='a' ) {
    Element e = new Atom( new Vec3D( mouseX, mouseY, 0 ), new Vec3D( random( -2, 2 ), random( -2, 2 ), random( -2, 2 ) ) );
    cell.addElement( e );
  }
  if( key=='f' ) {
    Flux f = new Flux(new Vec3D(mouseX, mouseY, random( -20, 20 )));
    cell.addElement(f);
  }
}

