package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class EnemyHit extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public var bulletId_:uint;
      
      public var targetId_:int;
      
      public var kill_:Boolean;
      
      public function EnemyHit(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         param1.writeByte(this.bulletId_);
         param1.writeInt(this.targetId_);
         param1.writeBoolean(this.kill_);
      }
      
      override public function toString() : String
      {
         return formatToString("ENEMYHIT","time_","bulletId_","targetId_","kill_");
      }
   }
}
