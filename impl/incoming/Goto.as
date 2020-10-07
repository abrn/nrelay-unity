package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class Goto extends IncomingMessage
   {
       
      
      public var objectId_:int;
      
      public var pos_:WorldPosData;
      
      public function Goto(param1:uint, param2:Function)
      {
         this.pos_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.objectId_ = param1.readInt();
         this.pos_.parseFromInput(param1);
      }
      
      override public function toString() : String
      {
         return formatToString("GOTO","objectId_","pos_");
      }
   }
}
