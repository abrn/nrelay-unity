package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class ChangePetSkin extends OutgoingMessage
   {
       
      
      public var petId:int;
      
      public var skinType:int;
      
      public var currency:int;
      
      public function ChangePetSkin(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.petId);
         param1.writeInt(this.skinType);
         param1.writeInt(this.currency);
      }
      
      override public function toString() : String
      {
         return formatToString("PET_CHANGE_SKIN_MSG","petId","skinType");
      }
   }
}
