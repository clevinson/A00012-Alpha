class NetworkIO{
  
  ArrayList<JSONObject> outGoing;

  String myAddress;
  
  NetworkIO(){
    
  }
  
  void queue(Message message){

  }
  
  
}
/*
class NetworkIO {
  OscP5 oscP5;

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
