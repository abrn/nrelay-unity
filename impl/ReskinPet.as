package kabam.rotmg.messaging.impl
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
   
   public class ReskinPet extends OutgoingMessage
   {
       
      
      public var petInstanceId:int;
      
      public var pickedNewPetType:int;
      
      public var item:SlotObjectData;
      
      public function ReskinPet(param1:uint, param2:Function)
      {
         item = new SlotObjectData();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.petInstanceId);
         param1.writeInt(this.pickedNewPetType);
         this.item.writeToOutput(param1);
      }
      
      override public function toString() : String
      {
         return formatToString("ENTER_ARENA","petInstanceId","pickedNewPetType");
      }
   }
}
