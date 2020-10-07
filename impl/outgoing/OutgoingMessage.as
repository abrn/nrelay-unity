package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataInput;
   import kabam.lib.net.impl.Message;
   
   public class OutgoingMessage extends Message
   {
       
      
      public function OutgoingMessage(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public final function parseFromInput(param1:IDataInput) : void
      {
         throw new Error("Client should not receive " + id + " messages");
      }
   }
}
