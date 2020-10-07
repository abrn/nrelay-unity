package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class ResetDailyQuests extends OutgoingMessage
   {
       
      
      public function ResetDailyQuests(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
      }
   }
}
