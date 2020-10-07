package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class GroundDamage extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public var position_:WorldPosData;
      
      public function GroundDamage(param1:uint, param2:Function)
      {
         this.position_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         this.position_.writeToOutput(param1);
      }
      
      override public function toString() : String
      {
         return formatToString("GROUNDDAMAGE","time_","position_");
      }
   }
}
