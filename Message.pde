class Message {
  
  Element element;
  NetAddress destination;
  NetAddress returnAddress;
  float transitPosition;

  Message(){
  }
  
  Message(String OscMessage) {
    JSONObject JSONMessage = JSONObject.parse(OscMessage);
    destination = new NetAddress(JSONMessage.getString("destination"), JSONMessage.getInt("destinationPort"));
    returnAddress = new NetAddress(JSONMessage.getString("returnAddress"), JSONMessage.getInt("returnPort"));
    setDestination(destination);
    setReturnAddress(returnAddress);
    setTransitPosition(JSONMessage.getFloat("transitPosition"));
    
    if(JSONMessage.getJSONObject("element").getString("type").equals("Atom")) {
      Atom atom = new Atom(JSONMessage.getJSONObject("element"));
      setElement((Element) atom);
    }
    
    if(JSONMessage.getJSONObject("element").getString("type").equals("Flux")) {
      Flux flux = new Flux(JSONMessage.getJSONObject("element"));
      setElement((Element) flux);
    }
    
    println("The OscMessage is corrupt, or the message class does not how to handle it.");
  }
  
  void setElement(Element element){
    this.element = element;
  } 

  void setDestination(NetAddress dest){
    this.destination = dest;
  }

  void setReturnAddress(NetAddress returnAddress){
    this.returnAddress = returnAddress;
  }

  void setTransitPosition(float transPos){
    this.transitPosition = transPos;
  }

  JSONObject toJSON(){
    JSONObject jsonMessage = new JSONObject();
    jsonMessage.setJSONObject("element", element.toJSON());
    jsonMessage.setString("destination", destination.address());
    jsonMessage.setString("returnAddress", returnAddress.address());
    jsonMessage.setFloat("transitPosition", transitPosition);
    
    return jsonMessage;
  }
  
  String serialize(){
    return toJSON().toString();
  }

}
