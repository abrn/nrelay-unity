package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class CheckCredits extends OutgoingMessage
   {
       
      
      public function CheckCredits(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
      }
      
      override public function toString() : String
      {
         return formatToString("CHECKCREDITS");
      }
   }
}
