package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class TradeRequested extends IncomingMessage
   {
       
      
      public var name_:String;
      
      public function TradeRequested(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.name_ = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("TRADEREQUESTED","name_");
      }
   }
}
