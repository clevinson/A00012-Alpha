class Boundary extends Element {

  BoundaryHandler handler;
  Spline2D        shape;
  int             detail;
  float           thickness;
  String          name;
  
  Boundary( Spline2D Shape, String Name ) {
    type      = "Boundary";
    handler   = new BoundaryHandler(this);
    shape     = Shape;
    detail    = shape.getPointList().size() * 4 ;
    thickness = 10;
    name      = Name;
  }
  
  void reactWith(Element element) {
    if(element.type.equals("Atom")) reactWithAtom((Atom) element);
    if(element.type.equals("Flux")) reactWithFlux((Flux) element);
  }
  
  void reactWithAtom(Atom atom) {
    float count = 0;
    ArrayList<Vec2D> curvePoints = (ArrayList) shape.computeVertices(detail);
    for(Iterator s=curvePoints.iterator(); s.hasNext();) {
      Vec2D shapePoint = (Vec2D) s.next();
      if( atom.pos.distanceTo( shapePoint ) < thickness ) {
        handler.send( atom, count / curvePoints.size() );
        break;
      } else {
        count++;
      }
    }
  }
  void reactWithFlux(Flux flux) {
    float count = 0;
    ArrayList<Vec2D> curvePoints = (ArrayList) shape.computeVertices(detail);
    for(Iterator s=curvePoints.iterator(); s.hasNext();) {
      Vec2D shapePoint = (Vec2D) s.next();
      if( flux.pos.distanceTo( shapePoint ) < thickness ) {
        for( Flux neigh : flux.neighbours ) neigh.neighbours.remove( flux );
        handler.send( flux, count / curvePoints.size() );
        break;
      } else {
        count++;
      }
    }
  }
}

// OLDER SKETCH 

/*class Boundary {
  linkPointsMap = {
    0.1 => links[0],
    0.3 => false,
    0.5 => links[1]
  }
  
  linkPoints = linkPointsMap.keySet;
  ArrayList<LinearLinks> links;
  BoundaryHandler handler;
  
  Boundary(){
    handler = new BoundaryHandler(this);
  }
  
  void addLink(link){
    links.add(link);
    linkPointsMap.put(link.start, link);
    linkPointsMap.put(link.end, 
  }
  
  void distributeLinks(){
    length = 1 / links.size();
    for( int i=0; i < links.size(); i++ ) {
      link = (LinearLink) links.get(i);
      link.start = i * length;
      link.end = link.start + length;
    }
  }
  
  void updateLinkPoints() {
    //  recreate hashmap.
  }
  
  void placeLink(link){
    
  }
  
  float checkCollision(Element elem){
    float arcPos = arcPosition(elem);
    for(i in linkPoints){
      if(arcPos > i){
        if(linkPointsMap(i-1) is a link){
          handler.send(linkPointsMap(i-1), elem)
        }else{
          reaction(element)
        }
      }
    }
  }

  float arcPosition(element){
    element.position // do something with this
    //some float 0.0 - 1.0  
  }  
}*/
