class Boundary {
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
    
  
  
}
