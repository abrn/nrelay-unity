package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class NewCharacterInformation extends IncomingMessage
   {
       
      
      public var charXml_:String;
      
      public function NewCharacterInformation(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.charXml_ = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("NEW_CHARACTER_INFORMATION","charXml_");
      }
   }
}
