package kabam.rotmg.messaging.impl.incoming.arena
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   
   public class ImminentArenaWave extends IncomingMessage
   {
       
      
      public var currentRuntime:int;
      
      public function ImminentArenaWave(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.currentRuntime = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("IMMINENTARENAWAVE","currentRuntime");
      }
   }
}
