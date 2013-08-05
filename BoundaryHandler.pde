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

  void send(String destination, float transitPosition, Element element) {
    Message message = new Message();
    message.setDestination(destination);
    message.setTransitPosition(transitPosition);
    message.setElement(element);
    message.setReturnAddress(network.myAddress);
    network.queue(message);
  }

  void receive(Message message) {  // Must be debuged
    if (message.element.type.equals("Atom")) {
      Atom atom = (Atom) message.element;
      atom.pos = parent.linearToWorldPosition(message.transitPosition);
      atom.vel.set(atom.pos.getInverted().normalizeTo(atom.vel.magnitude()));  // Temporary Velocity handling
      atom.pos.add(atom.vel.getNormalizedTo(parent.thickness*2));
    }
    if (message.element.type.equals("Flux")) {
      Flux flux = (Flux) message.element;
      flux.pos = parent.linearToWorldPosition(message.transitPosition);
    }

    network.cell.addElement(message.element);
  }
}

