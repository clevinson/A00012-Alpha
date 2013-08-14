class BoundaryHandler {

  Boundary parent;
  NetworkIO network;

  BoundaryHandler(Boundary Parent) {
    this.parent = Parent;
    network = networkIO;
  }

  void send(NetAddress destination, Element element, float transitPosition) {
    Message message = new Message();
    message.setDestination(destination);
    message.setTransitPosition(transitPosition);
    message.setElement(element);
    message.setSource(network.myAddress);
    network.toOutQueue(message);
    cell.reportDepature(element);
  }

  void receive(Message message) {  // Must be debuged
    if (message.element.type.equals("Atom")) {
      Atom atom = (Atom) message.element;
      atom.pos = parent.getPosition(message.transitPosition);
      atom.vel = parent.getNormalAtTheta(message.transitPosition).normalizeTo(atom.vel.magnitude());
      atom.pos.addSelf(vel); 
    }
    if (message.element.type.equals("Flux")) {
      Flux flux = (Flux) message.element;
      flux.pos = parent.getPosition(message.transitPosition);
      flux.vel = parent.getNormalAtTheta(message.transitPosition).normalizeTo(flux.vel.magnitude());
      flux.pos.addSelf(flux.vel);   
    }
    cell.addElement(message.element);
  }
}
