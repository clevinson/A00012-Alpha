class BoundaryHandler {
  
  Boundary parent;
  NetworkIO network;

  BoundaryHandler(Boundary Parent) {
    parent = Parent;
  }
  
  void sendDebug(Element element, float transitPosition) {
    cell.repotDepature(element);
    print( "Element \"" );
    println( element + "\" of type \"" + element.type + "\" left boundary \"" + parent + "\" at position " + transitPosition );
    // When added to put queue of the NetworkIO the element gets added to a list of leaving element;
  }
  
  void send(String destination, float transitPosition, Element element){
    Message message = new Message();

    message.setDestination(destination);
    message.setTransitPosition(transitPosition);
    message.setElement(element);
    message.setReturnAddress(network.myAddress);
    network.queue(message);
  }
  
  void receive(Message message){
     //message.element;
    //message.transitPosition; 
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
    

  
}*/
