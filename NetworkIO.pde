import java.util.Queue;
import java.util.LinkedList;
import oscP5.*;
import netP5.*;

class NetworkIO{

  Queue<Message> outQueue;
  Queue<Message> inQueue;
  Cell cell;
  OscP5 oscP5;
  BoundaryHandler boundaryHandler;


  NetAddress myAddress;

  NetworkIO(){
    oscP5 = new OscP5(this,12000);
    myAddress =  new NetAddress("127.0.0.1",12000);
    outQueue = new LinkedList<Message>();
    inQueue = new LinkedList<Message>();
  }

  void setCell(Cell cell){
    this.cell = cell;
    boundaryHandler = cell.boundaries.get(0).handler;
  }

  void toOutQueue(Message message){
    outQueue.offer(message);
  }

  void toInQueue(Message message){
    inQueue.offer(message);
  }

  void tick(){
    Message outMessage = outQueue.poll();
    if( outMessage != null){
      send(outMessage);
    }

    Message inMessage = inQueue.poll();
    if( inMessage != null){
      boundaryHandler.receive(inMessage);
    }

  }
/*
  void oscEvent(OscMessage theOscMessage) {
    print("### received an osc message.");
    print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());
    println(" val: "+theOscMessage.get(0));
  }
*/

  void oscEvent(OscMessage theOscMessage) {
    println("recieved message");
    if(theOscMessage.checkAddrPattern("/test")){
      if(theOscMessage.checkTypetag("s")){
        println(theOscMessage.get(0).stringValue());
        toInQueue(new Message(theOscMessage.get(0).stringValue()));
      }else{
        println("[ERROR] Received unknown typetag: " + theOscMessage.typetag() + " for OSC message " + theOscMessage.addrPattern());
      }
    }else{
      println("[ERROR] Received unknown OSC message with address pattern: " + theOscMessage.addrPattern());
    }
  }

  void send(Message message){
    NetAddress destination = message.destination;
    OscMessage oscMessage = new OscMessage("/test");
    oscMessage.add(message.serialize());
    oscP5.send(oscMessage, destination);
  }
}
