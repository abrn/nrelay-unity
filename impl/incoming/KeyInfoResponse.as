package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class KeyInfoResponse extends IncomingMessage
   {
       
      
      public var name:String;
      
      public var description:String;
      
      public var creator:String;
      
      public function KeyInfoResponse(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.name = param1.readUTF();
         this.description = param1.readUTF();
         this.creator = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("KEYINFORESPONSE","name","description","creator");
      }
   }
}
