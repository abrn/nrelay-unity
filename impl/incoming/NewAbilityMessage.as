package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   import kabam.lib.net.impl.Message;
   
   public class NewAbilityMessage extends Message
   {
       
      
      public var type:int;
      
      public function NewAbilityMessage(param1:uint, param2:Function = null)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.type = param1.readInt();
      }
   }
}
