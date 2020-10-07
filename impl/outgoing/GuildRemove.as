package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class GuildRemove extends OutgoingMessage
   {
       
      
      public var name_:String;
      
      public function GuildRemove(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeUTF(this.name_);
      }
      
      override public function toString() : String
      {
         return formatToString("GUILDREMOVE","name_");
      }
   }
}
