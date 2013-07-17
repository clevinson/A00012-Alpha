class BoundaryHandler {
  
  Boundary parent;
  
  BoundaryHandler(Boundary Parent) {
    parent = Parent;
  }
  
  void send(Element element, float transitPosition) {
    cell.repotDepature(element);
    print( "Element \"" );
    println( element + "\" of type \"" + element.type + "\" left boundary \"" + parent + "\" at position " + transitPosition );
    // When added to put queue of the NetworkIO the element gets added to a list of leaving element;
  }
}

// OLDER SKETCH

/*class BoundaryHandler {
  Boundary parent;
  NetworkIO network;

  BoundaryHandler(Boundary boundary, NetworkIO) {
    this.parent = boundary;
    this.network = network;
  }
    
  void send(destination, transitPosition, Element elem){
    JSON transitObj = JSON.createObject();
    transitObj.setString("type", "linear");
    transitObj.setFloat(transitPosition);
    JSON message = JSON.createObject();
    message.setJSON("element", elem.to_json);
    message.setString("destination", destination);
    message.setJSON("transit", transitObj);
    network.queue(message);
  }
  
}*/
