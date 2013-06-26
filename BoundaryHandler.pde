class BoundaryHandler {
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
  
}

