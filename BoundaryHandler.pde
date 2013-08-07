class BoundaryHandler {

  Boundary parent;
  NetworkIO network;

  BoundaryHandler(Boundary Parent) {
    this.parent = Parent;
    network = networkIO;
  }

  void sendDebug(Element element, float transitPosition) {
    cell.repotDepature(element);
    print( "Element \"" );
    println( element + "\" of type \"" + element.type + "\" left boundary \"" + parent + "\" at position " + transitPosition );
    // When added to put queue of the NetworkIO the element gets added to a list of leaving element;
  }

  void send(NetAddress destination, Element element, float transitPosition) {
    Message message = new Message();
    message.setDestination(destination);
    message.setTransitPosition(transitPosition);
    message.setElement(element);
    message.setReturnAddress(network.myAddress);
    network.toOutQueue(message);
  }

  void receive(Message message) {  // Must be debuged
    if (message.element.type.equals("Atom")) {
      Atom atom = (Atom) message.element;
      
      //atom.vel.set( tan(
      
      cell.elements.add(atom);
    }
    if (message.element.type.equals("Flux")) {
      Flux flux = (Flux) message.element;
      cell.elements.add(flux);
    }

    network.cell.addElement(message.element);
  }
}
