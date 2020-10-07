package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class UseItem extends OutgoingMessage
   {
       
      
      public var time_:int;
      
      public var slotObject_:SlotObjectData;
      
      public var itemUsePos_:WorldPosData;
      
      public var useType_:int;
      
      public function UseItem(param1:uint, param2:Function)
      {
         this.slotObject_ = new SlotObjectData();
         this.itemUsePos_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         this.slotObject_.writeToOutput(param1);
         this.itemUsePos_.writeToOutput(param1);
         param1.writeByte(this.useType_);
      }
      
      override public function toString() : String
      {
         return formatToString("USEITEM","slotObject_","itemUsePos_","useType_");
      }
   }
}
