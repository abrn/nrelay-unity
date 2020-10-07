package kabam.rotmg.messaging.impl.outgoing.arena
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
   
   public class QuestRedeem extends OutgoingMessage
   {
       
      
      public var questID:String;
      
      public var slots:Vector.<SlotObjectData>;
      
      public var item:int;
      
      public function QuestRedeem(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         var _loc2_:* = null;
         param1.writeUTF(this.questID);
         param1.writeInt(this.item);
         param1.writeShort(this.slots.length);
         var _loc4_:int = 0;
         var _loc3_:* = this.slots;
         var _loc6_:int = 0;
         var _loc5_:* = this.slots;
         for each(_loc2_ in this.slots)
         {
            _loc2_.writeToOutput(param1);
         }
      }
   }
}
