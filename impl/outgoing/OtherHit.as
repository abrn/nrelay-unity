package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class OtherHit extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public var bulletId_:uint;
      
      public var objectId_:int;
      
      public var targetId_:int;
      
      public function OtherHit(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         param1.writeByte(this.bulletId_);
         param1.writeInt(this.objectId_);
         param1.writeInt(this.targetId_);
      }
      
      override public function toString() : String
      {
         return formatToString("OTHERHIT","time_","bulletId_","objectId_","targetId_");
      }
   }
}
