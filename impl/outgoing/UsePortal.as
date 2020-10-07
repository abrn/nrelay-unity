package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class UsePortal extends OutgoingMessage
   {
       
      
      public var objectId_:int;
      
      public function UsePortal(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.objectId_);
      }
      
      override public function toString() : String
      {
         return formatToString("USEPORTAL","objectId_");
      }
   }
}
