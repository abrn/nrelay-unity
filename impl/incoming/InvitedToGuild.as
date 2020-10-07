package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class InvitedToGuild extends IncomingMessage
   {
       
      
      public var name_:String;
      
      public var guildName_:String;
      
      public function InvitedToGuild(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.name_ = param1.readUTF();
         this.guildName_ = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("INVITEDTOGUILD","name_","guildName_");
      }
   }
}
