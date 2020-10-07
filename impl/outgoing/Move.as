package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.MoveRecord;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class Move extends OutgoingMessage
   {
       
      
      public var tickId_:int;
      
      public var time_:int;
      
      public var serverRealTimeMSofLastNewTick_:uint;
      
      public var newPosition_:WorldPosData;
      
      public var records_:Vector.<MoveRecord>;
      
      public function Move(param1:uint, param2:Function)
      {
         this.newPosition_ = new WorldPosData();
         this.records_ = new Vector.<MoveRecord>();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         var _loc3_:int = 0;
         param1.writeInt(this.tickId_);
         param1.writeInt(this.time_);
         param1.writeUnsignedInt(this.serverRealTimeMSofLastNewTick_);
         this.newPosition_.writeToOutput(param1);
         var _loc2_:uint = this.records_.length;
         param1.writeShort(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.records_[_loc3_].writeToOutput(param1);
            _loc3_++;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("MOVE","tickId_","time_","serverRealTimeMSofLastNewTick_","newPosition_","records_");
      }
   }
}
