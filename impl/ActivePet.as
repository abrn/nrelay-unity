package kabam.rotmg.messaging.impl
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   
   public class ActivePet extends IncomingMessage
   {
       
      
      public var instanceID:int;
      
      public function ActivePet(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.instanceID = param1.readInt();
      }
   }
}
