class NetworkIO{
  
  ArrayList<JSONObject> outGoing;
  Cell cell;
  
  String myAddress;
  
  NetworkIO(){
    
  }
  
  NetworkIO(Cell cell){
    this.cell = cell;
  }
  
  void queue(Message message){

  }
  
  Message OscToMessage(JSONObject OscMessage) {
    Message message = new Message();
    message.setDestination(OscMessage.getString("destination"));
    message.setReturnAddress(OscMessage.getString("returnAddress"));
    message.setTransitPosition(OscMessage.getFloat("transitPosition"));
    
    if(OscMessage.getJSONObject("element").getString("type").equals("Atom")) {
      Atom atom = new Atom(OscMessage.getJSONObject("element"));
      message.setElement((Element) atom);
      return message;
    }
    if(OscMessage.getJSONObject("element").getString("type").equals("Flux")) {
      Flux flux = new Flux(OscMessage.getJSONObject("element"));
      message.setElement((Element) flux);
      return message;
    }
    println("Recieved unknown element");
    return null;
  }
}

/*
class NetworkIO {
  OscP5 oscP5;
  ArrayList boundaries;

  NetworkIO() {
    oscP5 = new OscP5(this,12000);
  }
  
  void send(OscMessage message, NetAddress myRemoteLocation){
    oscP5.send(message, myRemoteLocation);
  }
  
void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
}
*/
