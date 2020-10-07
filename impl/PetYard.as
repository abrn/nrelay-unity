package kabam.rotmg.messaging.impl
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   
   public class PetYard extends IncomingMessage
   {
       
      
      public var type:int;
      
      public function PetYard(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.type = param1.readInt();
      }
   }
}
