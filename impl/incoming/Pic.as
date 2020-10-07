package kabam.rotmg.messaging.impl.incoming
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class Pic extends IncomingMessage
   {
       
      
      public var bitmapData_:BitmapData = null;
      
      public function Pic(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,_loc2_ * _loc3_ * 4);
         this.bitmapData_ = new BitmapData(_loc2_,_loc3_,true,0);
         this.bitmapData_.setPixels(this.bitmapData_.rect,_loc4_);
      }
      
      override public function toString() : String
      {
         return formatToString("PIC","bitmapData_");
      }
   }
}
