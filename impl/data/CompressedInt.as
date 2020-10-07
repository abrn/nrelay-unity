package kabam.rotmg.messaging.impl.data
{
   import flash.utils.IDataInput;
   
   public class CompressedInt
   {
       
      
      public function CompressedInt()
      {
         super();
      }
      
      public static function Read(param1:IDataInput) : int
      {
         var _loc5_:* = 0;
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:* = (_loc2_ & 64) != 0;
         var _loc4_:int = 6;
         _loc5_ = _loc2_ & 63;
         while(_loc2_ & 128)
         {
            _loc2_ = param1.readUnsignedByte();
            _loc5_ = _loc5_ | (_loc2_ & 127) << _loc4_;
            _loc4_ = _loc4_ + 7;
         }
         if(_loc3_)
         {
            _loc5_ = int(-_loc5_);
         }
         return _loc5_;
      }
   }
}
