package kabam.rotmg.messaging.impl.incoming.pets
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   
   public class DeletePetMessage extends IncomingMessage
   {
       
      
      public var petID:int;
      
      public function DeletePetMessage(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.petID = param1.readInt();
      }
   }
}
