package kabam.rotmg.messaging.impl
{
   class OutstandingBuy
   {
       
      
      private var id_:String;
      
      private var price_:int;
      
      private var currency_:int;
      
      private var converted_:Boolean;
      
      function OutstandingBuy(param1:String, param2:int, param3:int, param4:Boolean)
      {
         super();
         this.id_ = param1;
         this.price_ = param2;
         this.currency_ = param3;
         this.converted_ = param4;
      }
      
      public function record() : void
      {
         var _loc1_:* = this.currency_;
      }
   }
}
