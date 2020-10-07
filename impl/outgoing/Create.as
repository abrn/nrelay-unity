package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class Create extends OutgoingMessage
   {
       
      
      public var classType:int;
      
      public var skinType:int;
      
      public var isChallenger:Boolean;
      
      public function Create(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeShort(this.classType);
         param1.writeShort(this.skinType);
         param1.writeBoolean(this.isChallenger);
      }
      
      override public function toString() : String
      {
         return formatToString("CREATE","classType","skinType","isChallenger");
      }
   }
}
