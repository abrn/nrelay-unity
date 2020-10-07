package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class InvSwap extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public var position_:WorldPosData;
      
      public var slotObject1_:SlotObjectData;
      
      public var slotObject2_:SlotObjectData;
      
      public function InvSwap(param1:uint, param2:Function)
      {
         this.position_ = new WorldPosData();
         this.slotObject1_ = new SlotObjectData();
         this.slotObject2_ = new SlotObjectData();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         this.position_.writeToOutput(param1);
         this.slotObject1_.writeToOutput(param1);
         this.slotObject2_.writeToOutput(param1);
      }
      
      override public function toString() : String
      {
         return formatToString("INVSWAP","time_","position_","slotObject1_","slotObject2_");
      }
   }
}
