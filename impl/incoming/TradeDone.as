package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class TradeDone extends IncomingMessage
   {
      
      public static const TRADE_SUCCESSFUL:int = 0;
      
      public static const PLAYER_CANCELED:int = 1;
       
      
      public var code_:int;
      
      public var description_:String;
      
      public function TradeDone(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.code_ = param1.readInt();
         this.description_ = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("TRADEDONE","code_","description_");
      }
   }
}
