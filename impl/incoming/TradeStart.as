package kabam.rotmg.messaging.impl.incoming
{
   import com.company.assembleegameclient.util.FreeList;
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.TradeItem;
   
   public class TradeStart extends IncomingMessage
   {
       
      
      public var myItems_:Vector.<TradeItem>;
      
      public var yourName_:String;
      
      public var yourItems_:Vector.<TradeItem>;
      
      public var partnerObjectId_:int;
      
      public function TradeStart(param1:uint, param2:Function)
      {
         this.myItems_ = new Vector.<TradeItem>();
         this.yourItems_ = new Vector.<TradeItem>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc3_:* = 0;
         var _loc2_:int = param1.readShort();
         _loc3_ = _loc2_;
         while(_loc3_ < this.myItems_.length)
         {
            FreeList.deleteObject(this.myItems_[_loc3_]);
            _loc3_++;
         }
         this.myItems_.length = Math.min(_loc2_,this.myItems_.length);
         while(this.myItems_.length < _loc2_)
         {
            this.myItems_.push(FreeList.newObject(TradeItem) as TradeItem);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.myItems_[_loc3_].parseFromInput(param1);
            _loc3_++;
         }
         this.yourName_ = param1.readUTF();
         _loc2_ = param1.readShort();
         _loc3_ = _loc2_;
         while(_loc3_ < this.yourItems_.length)
         {
            FreeList.deleteObject(this.yourItems_[_loc3_]);
            _loc3_++;
         }
         this.yourItems_.length = Math.min(_loc2_,this.yourItems_.length);
         while(this.yourItems_.length < _loc2_)
         {
            this.yourItems_.push(FreeList.newObject(TradeItem) as TradeItem);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.yourItems_[_loc3_].parseFromInput(param1);
            _loc3_++;
         }
         partnerObjectId_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("TRADESTART","myItems_","yourName_","yourItems_");
      }
   }
}
