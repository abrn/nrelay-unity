package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class QuestObjId extends IncomingMessage
   {
       
      
      public var objectId_:int;
      
      public function QuestObjId(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.objectId_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("QUESTOBJID","objectId_");
      }
   }
}
