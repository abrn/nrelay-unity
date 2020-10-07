package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class EvolvedPetMessage extends IncomingMessage
   {
       
      
      public var petID:int;
      
      public var initialSkin:int;
      
      public var finalSkin:int;
      
      public function EvolvedPetMessage(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.petID = param1.readInt();
         this.initialSkin = param1.readInt();
         this.finalSkin = param1.readInt();
      }
   }
}
