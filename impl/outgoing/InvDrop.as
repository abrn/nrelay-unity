package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   
   public class InvDrop extends OutgoingMessage
   {
       
      
      public var slotObject_:SlotObjectData;
      
      public function InvDrop(param1:uint, param2:Function)
      {
         this.slotObject_ = new SlotObjectData();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         this.slotObject_.writeToOutput(param1);
      }
      
      override public function toString() : String
      {
         return formatToString("INVDROP","slotObject_");
      }
   }
}
