package kabam.rotmg.messaging.impl.incoming.pets
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   
   public class HatchPetMessage extends IncomingMessage
   {
       
      
      public var petName:String;
      
      public var petSkin:int;
      
      public var itemType:int;
      
      public function HatchPetMessage(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.petName = param1.readUTF();
         this.petSkin = param1.readInt();
         this.itemType = param1.readInt();
      }
   }
}
