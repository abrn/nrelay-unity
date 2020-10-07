package kabam.rotmg.messaging.impl.data
{
   import com.company.assembleegameclient.util.FreeList;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ObjectStatusData
   {
       
      
      public var objectId_:int;
      
      public var pos_:WorldPosData;
      
      public var stats_:Vector.<StatData>;
      
      public function ObjectStatusData()
      {
         this.pos_ = new WorldPosData();
         this.stats_ = new Vector.<StatData>();
         super();
      }
      
      public function parseFromInput(param1:IDataInput) : void
      {
         var _loc4_:* = 0;
         this.objectId_ = CompressedInt.Read(param1);
         this.pos_.parseFromInput(param1);
         var _loc3_:uint = this.stats_.length;
         var _loc2_:int = CompressedInt.Read(param1);
         _loc4_ = uint(_loc2_);
         while(_loc4_ < _loc3_)
         {
            FreeList.deleteObject(this.stats_[_loc4_]);
            _loc4_++;
         }
         this.stats_.length = Math.min(_loc2_,this.stats_.length);
         while(this.stats_.length < _loc2_)
         {
            this.stats_.push(FreeList.newObject(StatData) as StatData);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.stats_[_loc4_].parseFromInput(param1);
            _loc4_++;
         }
      }
      
      public function writeToOutput(param1:IDataOutput) : void
      {
         var _loc3_:int = 0;
         param1.writeInt(this.objectId_);
         this.pos_.writeToOutput(param1);
         param1.writeShort(this.stats_.length);
         var _loc2_:uint = this.stats_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.stats_[_loc3_].writeToOutput(param1);
            _loc3_++;
         }
      }
      
      public function toString() : String
      {
         return "objectId_: " + this.objectId_ + " pos_: " + this.pos_ + " stats_: " + this.stats_;
      }
   }
}
