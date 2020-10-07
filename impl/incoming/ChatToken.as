package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class ChatToken extends IncomingMessage
   {
       
      
      public var token_:String;
      
      public var host_:String;
      
      public var port_:int;
      
      public function ChatToken(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.token_ = param1.readUTF();
         this.host_ = param1.readUTF();
         this.port_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("CHAT_TOKEN","token_","host_","port_");
      }
   }
}
