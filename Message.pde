class Message {
  
  Element element;
  String destination;
  String returnAddress;
  TransitPosition float;

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

  JSON toJSON(){
    JSON jsonMessage = JSON.createObject();
    jsonMessage.setJSON("element", element.toJSON());
    jsonMessage.setString("destination", destination);
    jsonMessage.setString("returnAddress", returnAddress);
    jsonMessage.setFloat("transitPosition", transitPosition);
    
    return jsonMessage;
  }

}
