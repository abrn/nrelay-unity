package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class AcceptTrade extends OutgoingMessage
   {
       
      
      public var myOffer_:Vector.<Boolean>;
      
      public var yourOffer_:Vector.<Boolean>;
      
      public function AcceptTrade(param1:uint, param2:Function)
      {
         this.myOffer_ = new Vector.<Boolean>();
         this.yourOffer_ = new Vector.<Boolean>();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeShort(this.myOffer_.length);
         var _loc2_:int = 0;
         while(_loc2_ < this.myOffer_.length)
         {
            param1.writeBoolean(this.myOffer_[_loc2_]);
            _loc2_++;
         }
         param1.writeShort(this.yourOffer_.length);
         _loc2_ = 0;
         while(_loc2_ < this.yourOffer_.length)
         {
            param1.writeBoolean(this.yourOffer_[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("ACCEPTTRADE","myOffer_","yourOffer_");
      }
   }
}
