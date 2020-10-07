package kabam.rotmg.messaging.impl.outgoing
{
   import flash.utils.IDataOutput;
   
   public class EditAccountList extends OutgoingMessage
   {
       
      
      public var accountListId_:int;
      
      public var add_:Boolean;
      
      public var objectId_:int;
      
      public function EditAccountList(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.accountListId_);
         param1.writeBoolean(this.add_);
         param1.writeInt(this.objectId_);
      }
      
      override public function toString() : String
      {
         return formatToString("EDITACCOUNTLIST","accountListId_","add_","objectId_");
      }
   }
}
