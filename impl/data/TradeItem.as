package kabam.rotmg.messaging.impl.data
{
   import flash.utils.IDataInput;
   
   public class TradeItem
   {
       
      
      public var item_:int;
      
      public var slotType_:int;
      
      public var tradeable_:Boolean;
      
      public var included_:Boolean;
      
      public function TradeItem()
      {
         super();
      }
      
      public function parseFromInput(param1:IDataInput) : void
      {
         this.item_ = param1.readInt();
         this.slotType_ = param1.readInt();
         this.tradeable_ = param1.readBoolean();
         this.included_ = param1.readBoolean();
      }
      
      public function toString() : String
      {
         return "item: " + this.item_ + " slotType: " + this.slotType_ + " tradeable: " + this.tradeable_ + " included:" + this.included_;
      }
   }
}
