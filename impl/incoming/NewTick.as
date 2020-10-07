package kabam.rotmg.messaging.impl.incoming
{
   import com.company.assembleegameclient.util.FreeList;
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.ObjectStatusData;
   
   public class NewTick extends IncomingMessage
   {
       
      
      public var tickId_:int;
      
      public var tickTime_:int;
      
      public var serverRealTimeMS_:uint;
      
      public var serverLastRTTMS_:uint;
      
      public var statuses_:Vector.<ObjectStatusData>;
      
      public function NewTick(param1:uint, param2:Function)
      {
         this.statuses_ = new Vector.<ObjectStatusData>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc4_:* = 0;
         this.tickId_ = param1.readInt();
         this.tickTime_ = param1.readInt();
         this.serverRealTimeMS_ = param1.readUnsignedInt();
         this.serverLastRTTMS_ = param1.readUnsignedShort();
         var _loc2_:int = param1.readShort();
         var _loc3_:uint = this.statuses_.length;
         _loc4_ = uint(_loc2_);
         while(_loc4_ < _loc3_)
         {
            FreeList.deleteObject(this.statuses_[_loc4_]);
            _loc4_++;
         }
         this.statuses_.length = Math.min(_loc2_,_loc3_);
         while(this.statuses_.length < _loc2_)
         {
            this.statuses_.push(FreeList.newObject(ObjectStatusData) as ObjectStatusData);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.statuses_[_loc4_].parseFromInput(param1);
            _loc4_++;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("NEW_TICK","tickId_","tickTime_","serverRealTimeMS_","serverLastRTTMS_","statuses_");
      }
   }
}
