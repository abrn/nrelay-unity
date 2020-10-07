package kabam.rotmg.messaging.impl.incoming
{
   import com.company.assembleegameclient.util.FreeList;
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.CompressedInt;
   import kabam.rotmg.messaging.impl.data.GroundTileData;
   import kabam.rotmg.messaging.impl.data.ObjectData;
   
   public class Update extends IncomingMessage
   {
       
      
      public var tiles_:Vector.<GroundTileData>;
      
      public var newObjs_:Vector.<ObjectData>;
      
      public var drops_:Vector.<int>;
      
      public function Update(param1:uint, param2:Function)
      {
         this.tiles_ = new Vector.<GroundTileData>();
         this.newObjs_ = new Vector.<ObjectData>();
         this.drops_ = new Vector.<int>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc4_:* = 0;
         var _loc2_:int = CompressedInt.Read(param1);
         var _loc3_:uint = this.tiles_.length;
         _loc4_ = uint(_loc2_);
         while(_loc4_ < _loc3_)
         {
            FreeList.deleteObject(this.tiles_[_loc4_]);
            _loc4_++;
         }
         this.tiles_.length = Math.min(_loc2_,_loc3_);
         while(this.tiles_.length < _loc2_)
         {
            this.tiles_.push(FreeList.newObject(GroundTileData) as GroundTileData);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.tiles_[_loc4_].parseFromInput(param1);
            _loc4_++;
         }
         this.newObjs_.length = 0;
         _loc2_ = CompressedInt.Read(param1);
         _loc3_ = this.newObjs_.length;
         _loc4_ = uint(_loc2_);
         while(_loc4_ < _loc3_)
         {
            FreeList.deleteObject(this.newObjs_[_loc4_]);
            _loc4_++;
         }
         this.newObjs_.length = Math.min(_loc2_,_loc3_);
         while(this.newObjs_.length < _loc2_)
         {
            this.newObjs_.push(FreeList.newObject(ObjectData) as ObjectData);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.newObjs_[_loc4_].parseFromInput(param1);
            _loc4_++;
         }
         this.drops_.length = 0;
         _loc2_ = CompressedInt.Read(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.drops_.push(CompressedInt.Read(param1));
            _loc4_++;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("UPDATE","tiles_","newObjs_","drops_");
      }
   }
}
