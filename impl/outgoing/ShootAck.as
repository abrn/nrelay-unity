package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class ShootAck extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public function ShootAck(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
      }
      
      override public function toString() : String
      {
         return formatToString("SHOOTACK","time_");
      }
   }
}
