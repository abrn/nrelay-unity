package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class PlayerText extends OutgoingMessage
   {
       
      
      public var text_:String;
      
      public function PlayerText(param1:uint, param2:Function)
      {
         this.text_ = new String();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeUTF(this.text_);
      }
      
      override public function toString() : String
      {
         return formatToString("PLAYERTEXT","text_");
      }
   }
}
