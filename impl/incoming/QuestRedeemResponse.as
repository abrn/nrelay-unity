package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class QuestRedeemResponse extends IncomingMessage
   {
       
      
      public var ok:Boolean;
      
      public var message:String;
      
      public function QuestRedeemResponse(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.ok = param1.readBoolean();
         this.message = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("QUESTREDEEMRESPONSE","ok","message");
      }
   }
}
