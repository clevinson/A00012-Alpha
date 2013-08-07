class Message {
  
  Element element;
  String destination;
  String returnAddress;
  float transitPosition;

  Message(){
  }
  
  Message(String OscMessage) {
    JSONObject JSONMessage = JSONObject.parse(OscMessage);
    setDestination(JSONMessage.getString("destination"));
    setReturnAddress(JSONMessage.getString("returnAddress"));
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

  void setDestination(String dest){
    this.destination = dest;
  }

  void setReturnAddress(String returnAddress){
    this.returnAddress = returnAddress;
  }

  void setTransitPosition(float transPos){
    this.transitPosition = transPos;
  }

  JSONObject toJSON(){
    JSONObject jsonMessage = new JSONObject();
    jsonMessage.setJSONObject("element", element.toJSON());
    jsonMessage.setString("destination", destination);
    jsonMessage.setString("returnAddress", returnAddress);
    jsonMessage.setFloat("transitPosition", transitPosition);
    
    return jsonMessage;
  }
  
  void fromJSON(JSONObject string) {
  }
}
