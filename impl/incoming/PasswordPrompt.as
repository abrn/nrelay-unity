package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class PasswordPrompt extends IncomingMessage
   {
       
      
      public var cleanPasswordStatus:int;
      
      public function PasswordPrompt(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.cleanPasswordStatus = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("PASSWORDPROMPT","cleanPasswordStatus");
      }
   }
}
