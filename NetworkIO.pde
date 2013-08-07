import java.util.Queue;
import java.util.LinkedList;
import oscP5.*;
import netP5.*;

class NetworkIO{
  
  Queue<Message> outQueue;
  Cell cell;
  OscP5 oscP5;

  
  NetAddress myAddress;
  
  NetworkIO(){
    
  }
  
  NetworkIO(Cell cell){
    this.cell = cell;
    oscP5 = new OscP5(this,12000);
    myAddress =  new NetAddress("127.0.0.1",12000);
    outQueue = new LinkedList<Message>();
  }
  
  void toOutQueue(Message message){
    outQueue.offer(message);
  }
 
  void tick(){
    Message outMessage = outQueue.poll();
    if( outMessage != null){
      send(outMessage);
    }
  }
  
  void oscEvent(OscMessage theOscMessage) {
    print("### received an osc message.");
    print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());
    println(" val: "+theOscMessage.get(0));
  }
  
  void oscEventTry1(OscMessage theOscMessage) {
    
  }

  void send(Message message){
    NetAddress destination;
    OscMessage oscMessage = new OscMessage("/test");
    oscMessage.add(message.serialize());
    oscP5.send(oscMessage, myAddress);
  }
}
