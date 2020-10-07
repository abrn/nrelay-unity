package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class KeyInfoRequest extends OutgoingMessage
   {
       
      
      public var itemType_:int;
      
      public function KeyInfoRequest(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.itemType_);
      }
      
      override public function toString() : String
      {
         return formatToString("ITEMTYPE","itemType_");
      }
   }
}
