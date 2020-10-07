package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class ClientStat extends IncomingMessage
   {
       
      
      public var name_:String;
      
      public var value_:int;
      
      public function ClientStat(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.name_ = param1.readUTF();
         this.value_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("CLIENTSTAT","name_","value_");
      }
   }
}
