package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class PlayerHit extends OutgoingMessage
   {
       
      
      public var bulletId_:uint;
      
      public var objectId_:int;
      
      public function PlayerHit(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeByte(this.bulletId_);
         param1.writeInt(this.objectId_);
      }
      
      override public function toString() : String
      {
         return formatToString("PLAYERHIT","bulletId_","objectId_");
      }
   }
}
