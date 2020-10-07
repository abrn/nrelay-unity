package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class UnlockInformation extends IncomingMessage
   {
       
      
      public var unlockType_:int;
      
      public function UnlockInformation(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         unlockType_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("UNKNOWN0","unlockType_");
      }
   }
}
