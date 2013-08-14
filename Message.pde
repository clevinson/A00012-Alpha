class Message {
  
  Element element;
  NetAddress destination;
  NetAddress source;
  float transitPosition;

  Message(){
  }
  
  Message(String OscMessage) {
    JSONObject JSONMessage = JSONObject.parse(OscMessage);
    destination = new NetAddress(JSONMessage.getString("destination"), JSONMessage.getInt("destinationPort"));
    source = new NetAddress(JSONMessage.getString("source"), JSONMessage.getInt("sourcePort"));
    setDestination(destination);
    setSource(source);
    setTransitPosition(JSONMessage.getFloat("transitPosition"));
    
    if(JSONMessage.getJSONObject("element").getString("type").equals("Atom")) {
      Atom atom = new Atom(JSONMessage.getJSONObject("element"));
      setElement((Element) atom);
    } else if(JSONMessage.getJSONObject("element").getString("type").equals("Flux")) {
      Flux flux = new Flux(JSONMessage.getJSONObject("element"));
      setElement((Element) flux);
    } else {
      println("The OscMessage is corrupt, or the message class does not how to handle it.");
    }
  }
  
  void setElement(Element element){
    this.element = element;
  } 

  void setDestination(NetAddress dest){
    this.destination = dest;
  }

  void setSource(NetAddress source){
    this.source = source;
  }

  void setTransitPosition(float transPos){
    this.transitPosition = transPos;
  }

  JSONObject toJSON(){
    JSONObject jsonMessage = new JSONObject();
    jsonMessage.setJSONObject("element", element.toJSON());
    jsonMessage.setString("destination", destination.address());
    jsonMessage.setInt("destinationPort", destination.port());
    jsonMessage.setString("source", source.address());
    jsonMessage.setInt("sourcePort", source.port());
    jsonMessage.setFloat("transitPosition", transitPosition);
    
    return jsonMessage;
  }
  
  String serialize(){
    return toJSON().toString();
  }

}
