package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class GuildResult extends IncomingMessage
   {
       
      
      public var success_:Boolean;
      
      public var lineBuilderJSON:String;
      
      public function GuildResult(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.success_ = param1.readBoolean();
         this.lineBuilderJSON = param1.readUTF();
      }
      
      override public function toString() : String
      {
         return formatToString("CREATEGUILDRESULT","success_","lineBuilderJSON");
      }
   }
}
