class Message {
  
  Element element;
  String destination;
  String returnAddress;
  float transitPosition;

  Message(){
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

}
