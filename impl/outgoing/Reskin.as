package kabam.rotmg.messaging.impl.outgoing
{
   import com.company.assembleegameclient.objects.Player;
   import flash.utils.IDataOutput;
   
   public class Reskin extends OutgoingMessage
   {
       
      
      public var skinID:int;
      
      public var player:Player;
      
      public function Reskin(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.skinID);
      }
      
      override public function consume() : void
      {
         super.consume();
         this.player = null;
      }
      
      override public function toString() : String
      {
         return formatToString("RESKIN","skinID");
      }
   }
}
