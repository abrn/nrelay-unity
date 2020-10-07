package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class InvResult extends IncomingMessage
   {
       
      
      public var result_:int;
      
      public function InvResult(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.result_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("INVRESULT","result_");
      }
   }
}
