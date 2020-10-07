package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class QueueInformation extends IncomingMessage
   {
       
      
      public var currentPosition_:uint;
      
      public var maxPosition_:uint;
      
      public function QueueInformation(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.currentPosition_ = param1.readUnsignedShort();
         this.maxPosition_ = param1.readUnsignedShort();
      }
      
      override public function toString() : String
      {
         return formatToString("UNKNOWNJOIN","currentPosition_","maxPosition_");
      }
   }
}
