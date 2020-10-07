package kabam.rotmg.messaging.impl
{
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
   
   public class PetUpgradeRequest extends OutgoingMessage
   {
      
      public static const UPGRADE_YARD_TYPE:int = 1;
      
      public static const FEED_PET_TYPE:int = 2;
      
      public static const FUSE_PET_TYPE:int = 3;
      
      public static const GOLD_PAYMENT_TYPE:int = 0;
      
      public static const FAME_PAYMENT_TYPE:int = 1;
       
      
      public var petTransType:int;
      
      public var PIDOne:int;
      
      public var PIDTwo:int;
      
      public var objectId:int;
      
      public var slotsObject:Vector.<SlotObjectData>;
      
      public var paymentTransType:int;
      
      public function PetUpgradeRequest(param1:uint, param2:Function)
      {
         slotsObject = new Vector.<SlotObjectData>();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeByte(this.petTransType);
         param1.writeInt(this.PIDOne);
         param1.writeInt(this.PIDTwo);
         param1.writeInt(this.objectId);
         param1.writeByte(this.paymentTransType);
         param1.writeShort(this.slotsObject.length);
         var _loc4_:int = 0;
         var _loc3_:* = this.slotsObject;
         for each(var _loc2_ in this.slotsObject)
         {
            _loc2_.writeToOutput(param1);
         }
      }
   }
}
