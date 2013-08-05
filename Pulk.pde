class Pulk extends Element {

  Vec2D pos;
  Vec2D vel;

  Pulk (Vec2D position) {
    type = "Pulk";
    pos = position;
    vel = new Vec2D(1, 0);
  }

  void reactWith(Element element) {
    if(element.type.equals("Pulk")) reactWithPulk((Pulk) element);
    //if(element.type.equals("Mook")) reactWithMook((Mook) element);
    if(element.type.equals("Ropa")) reactWithRopa((Ropa) element);
  }

  void act() {
    pos.addSelf(vel);
  }

  void reactWithPulk(Pulk pulk) {
    float distance = pulk.pos.distanceTo(pos);
    if(!pulk.vel.isZeroVector()) {
      pulk.vel.scaleSelf( pulk.collapseFunction( distance ) );
    }
    if(!this.vel.isZeroVector()) {
      this.vel.scaleSelf( this.collapseFunction( distance ) );
    }
  }
  
  void reactWithMook(Mook mook) {
    float velMag = vel.magnitude();
    vel.addSelf( mook.pos.sub(pos).normalize().scale( mook.force ) );
    vel.normalizeTo(velMag);
    
  }
    
  void reactWithRopa(Ropa ropa) {
    vel = ropa.brownianNoise().scale( vel.magnitude() );
  }

  float collapseFunction(float x) {
    // Base on the Gompertz function ( a sigmoid function )
    float e = (float) Math.E;
    float a = 2.8; // y displacement;
    float b = 0.8;   // growth rate, is negative.
    return pow( e, -pow( e, -(x-a)*b )); 
  }
}
