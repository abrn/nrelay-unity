package kabam.rotmg.messaging.impl.data
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class SlotObjectData
   {
       
      
      public var objectId_:int;
      
      public var slotId_:int;
      
      public var objectType_:int;
      
      public function SlotObjectData()
      {
         super();
      }
      
      public function parseFromInput(param1:IDataInput) : void
      {
         this.objectId_ = param1.readInt();
         this.slotId_ = param1.readUnsignedByte();
         this.objectType_ = param1.readInt();
      }
      
      public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.objectId_);
         param1.writeByte(this.slotId_);
         param1.writeInt(this.objectType_);
      }
      
      public function toString() : String
      {
         return "objectId_: " + this.objectId_ + " slotId_: " + this.slotId_ + " objectType_: " + this.objectType_;
      }
   }
}
