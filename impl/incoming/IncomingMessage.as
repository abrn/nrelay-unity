package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataOutput;
   import kabam.lib.net.impl.Message;
   
   public class IncomingMessage extends Message
   {
       
      
      public function IncomingMessage(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public final function writeToOutput(param1:IDataOutput) : void
      {
         throw new Error("Client should not send " + id + " messages");
      }
   }
}
