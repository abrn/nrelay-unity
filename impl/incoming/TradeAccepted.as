package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class TradeAccepted extends IncomingMessage
   {
       
      
      public var myOffer_:Vector.<Boolean>;
      
      public var yourOffer_:Vector.<Boolean>;
      
      public function TradeAccepted(param1:uint, param2:Function)
      {
         this.myOffer_ = new Vector.<Boolean>();
         this.yourOffer_ = new Vector.<Boolean>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc2_:int = 0;
         this.myOffer_.length = 0;
         var _loc3_:int = param1.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.myOffer_.push(param1.readBoolean());
            _loc2_++;
         }
         this.yourOffer_.length = 0;
         _loc3_ = param1.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.yourOffer_.push(param1.readBoolean());
            _loc2_++;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("TRADEACCEPTED","myOffer_","yourOffer_");
      }
   }
}
